#!/usr/bin/env bats

setup_fixture
load_module last

@test "l.last a asd bcd d" {
  local a=(a asd bcd d)
  run l.last a
  assert_success
  assert_output d
}

@test "l.last a asd 'bcd d'" {
  local a=(a asd 'bcd d')
  run l.last a
  assert_success
  assert_output "bcd d"
}