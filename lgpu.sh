#!/bin/bash
 gpu="i915 nvidia"
 for i in ${gpu}; do
   lshw -C video | grep -qE '$i' && echo true || echo false
 done
