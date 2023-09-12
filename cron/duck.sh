#!/bin/bash

mkdir -p ~/duckdns/
echo url="https://www.duckdns.org/update?domains=mhrij&token=b5146f18-6c27-4dd1-8a36-c8878a3bade4&ip=" | curl -k -o ~/duckdns/duck.log -K -
