#!/bin/bash
# Remove when exist
docker rm magento2

# Run Container
docker run -dit --privileged --restart=always \
--name magento2 \
-p 80:80 \
-p 3306:3306 \
magento2