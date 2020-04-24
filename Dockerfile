# docker build -t ybhutdocker/fibtest:1.0 .
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y build-essential
COPY . /fibtest/
WORKDIR /fibtest/

CMD [ "./runfibtest", "1" ]


### 100m quota; 1 core test
# kubectl run fibtest -i -t --rm --limits='cpu=100m' --image=ybhutdocker/fibtest:1.0 --image-pull-policy=Always --command -- ./runfibtest 1

# this results in output:

# Iterations Completed(K): 49  (expected: 50 +/- 1)
# CPU Usage (msecs) = 26 (test invalid unless this is much less than 500)
# Throttled time (msecs) = 167 (should be zero)
# Throttled for 1 periods (should be zero)
# Reported elapsed CFS periods = 18
# EXCESSIVE THROTTLING DETECTED


### 100m quota; multi-core test
# kubectl run fibtest -i -t --rm --limits='cpu=100m' --image=ybhutdocker/fibtest:1.0 --image-pull-policy=Always --command -- ./runfibtest

# this results in output:

# Iterations Completed(K): 395  (expected: 400 +/- 8)
# CPU Usage (msecs) = 76 (test invalid unless this is much less than 500)
# Throttled time (msecs) = 427 (should be zero)
# Throttled for 1 periods (should be zero)
# Reported elapsed CFS periods = 47
# EXCESSIVE THROTTLING DETECTED


### 200m quota; 1 core test
# kubectl run fibtest -i -t --rm --limits='cpu=200m' --image=ybhutdocker/fibtest:1.0 --image-pull-policy=Always --command -- ./runfibtest 1

# this results in output:

# Iterations Completed(K): 49  (expected: 50 +/- 1)
# CPU Usage (msecs) = 28 (test invalid unless this is much less than 500)
# Throttled time (msecs) = 84 (should be zero)
# Throttled for 1 periods (should be zero)
# Reported elapsed CFS periods = 18
# EXCESSIVE THROTTLING DETECTED


### 200m quota; multi-core test
# kubectl run fibtest -i -t --rm --limits='cpu=200m' --image=ybhutdocker/fibtest:1.0 --image-pull-policy=Always --command -- ./runfibtest

# this results in output:

# Iterations Completed(K): 389  (expected: 400 +/- 8)
# CPU Usage (msecs) = 73 (test invalid unless this is much less than 500)
# Throttled time (msecs) = 0 (should be zero)
# Throttled for 0 periods (should be zero)
# Reported elapsed CFS periods = 46
# CFS "low cpu usage with high throttling" bug NOT detected


### 500m quota; 1 core test
# kubectl run fibtest -i -t --rm --limits='cpu=500m' --image=ybhutdocker/fibtest:1.0 --image-pull-policy=Always --command -- ./runfibtest 1

# this results in output:

# Iterations Completed(K): 49  (expected: 50 +/- 1)
# CPU Usage (msecs) = 29 (test invalid unless this is much less than 500)
# Throttled time (msecs) = 0 (should be zero)
# Throttled for 0 periods (should be zero)
# Reported elapsed CFS periods = 19
# CFS "low cpu usage with high throttling" bug NOT detected
