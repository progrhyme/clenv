#!/usr/bin/env bats

load test_helper

: "split_string" && {
  @test "Split by space" {
    split_string "foo bar  baz"
    [[ ${split_array[0]} = "foo" ]]
    [[ ${split_array[1]} = "bar" ]]
    [[ ${split_array[2]} = "baz" ]]
  }

  @test "Split by comma" {
    split_string "foo,bar,,baz" "," ret_array
    [[ ${ret_array[0]} = "foo" ]]
    [[ ${ret_array[1]} = "bar" ]]
    [[ ${ret_array[2]} = "baz" ]]
  }
}
