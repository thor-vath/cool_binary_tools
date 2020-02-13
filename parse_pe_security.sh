#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  usage
else
  pe_security_output="${1}"
if

fucntion usage() {
  echo "[!] Script takes a file containing output of pe security powershell script. Exiting."
  exit 1
}

function parse_aslr() {
  cat "${pe_security_output}" | grep -B 3 "ASLR             : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_dep() {
  cat "${pe_security_output}" | grep -B 4 "DEP              : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_authenticode() {
  cat "${pe_security_output}" | grep -B 5 "Authenticode     : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_strong_naming() {
  cat "${pe_security_output}" | grep -B 6 "StrongNaming     : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_safe_seh() {
  cat "${pe_security_output}" | grep -B 7 "SafeSEH          : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_control_flow_guard() {
  cat "${pe_security_output}" | grep -B 8 "ControlFlowGuard : False" | grep "FileName" | cut -d':' -f2-99
}

function parse_high_entropy_va() {
  cat "${pe_security_output}" | grep -B 9 "HighentropyVA    : False" | grep "FileName" | cut -d':' -f2-99
}

parse_aslr
parse_dep
parse_authenticode
parse_strong_naming
parse_safe_seh
parse_control_flow_guard
parse_high_entropy_va

