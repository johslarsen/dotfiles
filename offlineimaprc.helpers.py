#!/usr/bin/env python
import os
import subprocess

def pass_show(path):
    # assuming gpg-agent
    p = subprocess.Popen(["pass", "show", path], stdout=subprocess.PIPE, stderr=open("/dev/null", "w"))
    password = p.stdout.readline().decode("UTF-8").strip()
    return password
