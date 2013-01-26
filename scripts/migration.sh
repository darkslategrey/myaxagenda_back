#!/bin/bash
if [ $(locate  'sinatra/activerecord.rb' | grep -v '/home' | wc -l) -ne 1 ]
then
    echo "the more than one sinatra/activerecord.rb file. Exit!"
    exit 1
fi


file=$(locate  'sinatra/activerecord.rb')
grep jobenfance $file
if [ $? -eq 1 ] && ! [ -f .add_env_done ]
then
    echo "add jobenfance jobdependance as new env in $file"
    sed -i 's/\(development test production\)/jobenfance jobdependance \1/' $file
    touch .add_env_done
fi

action=$1 # migrate or rollback

for i in jobenfance jobdependance; do echo $i; RACK_ENV=$i rake db:my_${action};done
