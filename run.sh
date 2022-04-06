#!/bin/bash
docker run -d --privileged \
--name magento \
-p 80:80 \
-p 3306:3306 \
magento2

docker logs magento -f 