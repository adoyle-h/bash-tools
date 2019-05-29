#!/usr/bin/env bats

setup_fixture
load_module strict_has

@test "strict_has (not) command cat, while cat is existed" {
  run strict_has command cat
  assert_success
  assert_output true

  run strict_has not command cat
  assert_success
  assert_output false
}

@test "strict_has (not) command xxx, which not defined" {
  run strict_has command xxx
  assert_success
  assert_output false

  run strict_has not command xxx
  assert_success
  assert_output true
}

@test "strict_has (not) function bbb, which not defined" {
  run strict_has not function bbb
  assert_success
  assert_output true

  run strict_has function bbb
  assert_success
  assert_output false
}

@test "strict_has (not) function bbb, which has been defined" {
  bbb() { echo 1; }
  run strict_has not function bbb
  assert_success
  assert_output false

  run strict_has function bbb
  assert_success
  assert_output true
}

@test "strict_has (not) builtin true" {
  run strict_has builtin true
  assert_success
  assert_output true

  run strict_has not builtin true
  assert_success
  assert_output false
}

@test "strict_has (not) builtin xxx, which not defined" {
  run strict_has builtin xxx
  assert_success
  assert_output false

  run strict_has not builtin xxx
  assert_success
  assert_output true
}

@test "strict_has (not) keyword function" {
  run strict_has keyword function
  assert_success
  assert_output true

  run strict_has not keyword function
  assert_success
  assert_output false
}

@test "strict_has (not) keyword xxx, which not defined" {
  run strict_has keyword xxx
  assert_success
  assert_output false

  run strict_has not keyword xxx
  assert_success
  assert_output true
}

@test "strict_has (not) alias xxx, which not defined" {
  run strict_has alias xxx
  assert_success
  assert_output false

  run strict_has not alias xxx
  assert_success
  assert_output true
}

@test "strict_has (not) alias gti, which has been defined" {
  skip 'why the test is failed?'
  alias gti='git'
  result=$(strict_has alias gti)
  assert_equal "$result" true

  result=$(strict_has not alias gti)
  assert_equal "$result" false
}

@test "strict_has (not) the xxx, which not defined" {
  run strict_has the xxx
  assert_success
  assert_output false

  run strict_has not the xxx
  assert_success
  assert_output true
}

@test "strict_has (not) the ls, which is command" {
  run strict_has the ls
  assert_success
  assert_output true

  run strict_has not the ls
  assert_success
  assert_output false
}

@test "strict_has (not) the agti, which is alias" {
  skip 'why the test is failed?'
  alias agti='git'
  result=$(strict_has the agti)
  assert_equal "$result" true

  result=$(strict_has not the agti)
  assert_equal "$result" false
}

@test "strict_has (not) the function, which is keyword" {
  run strict_has the function
  assert_success
  assert_output true

  run strict_has not the function
  assert_success
  assert_output false
}

@test "strict_has (not) the type, which is builtin" {
  run strict_has the type
  assert_success
  assert_output true

  run strict_has not the type
  assert_success
  assert_output false
}

@test "strict_has (not) what type" {
  run strict_has what type
  assert_failure 2
  assert_output ''

  run strict_has not what type
  assert_failure 2
  assert_output ''
}

@test "result=\$(strict_has what type)" {
  foo() {
    if [[ $(strict_has what type) == true ]]; then
      echo 1
    else
      echo 2
    fi
    result=$()
  }
  run foo

  assert_success
  assert_output false
  # assert_equal "$result" '2'
}
