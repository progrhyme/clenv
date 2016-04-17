#!/usr/bin/env bats

load test_helper

: "version_compare" && {
  @test "1 == 1" {
    version_compare 1 1 result
    (( $result == 0 ))
  }

  @test "2.0 > 1.0" {
    version_compare 2.0 1.0 result
    (( $result == 1 ))
  }

  @test "2.0 > 2" {
    version_compare 2.0 2 result
    (( $result == 1 ))
  }

  @test "2.0.0 < 2.0.1" {
    version_compare 2.0.0 2.0.1 result
    (( $result == -1 ))
  }

  @test "2.0.0 < 2.0.0-p321" {
    version_compare 2.0.0 2.0.0-p321 result
    (( $result == -1 ))
  }

  @test "2.0.0-p322 > 2.0.0-p321" {
    version_compare 2.0.0-p322 2.0.0-p321 result
    (( $result == 1 ))
  }
}
