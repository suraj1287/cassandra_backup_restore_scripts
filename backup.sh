#!/bin/bash

nodetool clearsnapshot -t snapshot1 myapp
nodetool snapshot -t snapshot1 myapp
