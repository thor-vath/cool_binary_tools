#!/usr/bin/env bash

function usage() {
  echo "[*] Usage: ${0} infile outfile"
  echo "[*] infile: output of pe security powershell script"
  echo "[*] outfile: a file name format to store output"
  exit 1
}

if [ $# -ne 2 ]; then
  usage
else
  pe_security_output="${1}"
  output_file="${2}"
fi

function parse_aslr() {
  cat "${pe_security_output}" | grep -B 3 "ASLR             : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_aslr.txt"
}

function parse_dep() {
  cat "${pe_security_output}" | grep -B 4 "DEP              : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_dep.txt"
}

function parse_authenticode() {
  cat "${pe_security_output}" | grep -B 5 "Authenticode     : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_authenticode.txt"
}

function parse_strong_naming() {
  cat "${pe_security_output}" | grep -B 6 "StrongNaming     : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_strong_naming.txt"
}

function parse_safe_seh() {
  cat "${pe_security_output}" | grep -B 7 "SafeSEH          : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_safe_seh.txt"
}

function parse_control_flow_guard() {
  cat "${pe_security_output}" | grep -B 8 "ControlFlowGuard : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_control_flow_guard.txt"
}

function parse_high_entropy_va() {
  cat "${pe_security_output}" | grep -B 9 "HighentropyVA    : False" | grep "FileName" | cut -d':' -f2-99 > "${output_file}_high_entropy_va.txt"
}

parse_aslr
parse_dep
parse_authenticode
parse_strong_naming
parse_safe_seh
parse_control_flow_guard
parse_high_entropy_va
