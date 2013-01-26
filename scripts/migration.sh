#!/bin/bash

action=$1 # migrate or rollback

for i in jobenfance jobdependance; do echo $i; RACK_ENV=$i rake db:$action;done
