#!/bin/bash
docker run -dit -p 80:80 -p 3306:3306 -v www:/var/www magento2