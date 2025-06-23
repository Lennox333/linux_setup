#!/bin/bash

if ((RANDOM % 2)); then
  fastfetch
else
  fastfetch_ascii.sh
fi
