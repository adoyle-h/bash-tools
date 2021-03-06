#!/usr/bin/env bats

setup_fixture
test_prepare is_readable.s
load_module is_readable.s

@test "l.is_readable.s a normal file" {
  local temp=$(mktemp)
  run l.is_readable.s "$temp"
	assert_success
	assert_output true
}

@test "l.is_readable.s a executable file" {
  local temp=$(mktemp)
  chmod +x "$temp"
  run l.is_readable.s "$temp"
	assert_success
	assert_output true
}

@test "l.is_readable.s a directory" {
  local temp=$(mktemp -d)
  run l.is_readable.s "$temp"
	assert_success
  # interesting https://superuser.com/a/168583
	assert_output true
}

@test "l.is_readable.s unexist path" {
  run l.is_readable.s /not-exist
	assert_success
	assert_output false
}
