#!/usr/bin/env bash


export timestamp=$(date +%Y%m%d_%H%M%S) && \
export volume_path=/jmeter && \
export jmeter_path=/jmeter && \

./apache-jmeter-${JMETER_VERSION}/bin/jmeter \
  -n  \
  -t ${jmeter_path}/script/test.jmx \
  -l ${jmeter_path}/tmp/result_${timestamp}.jtl \
  -j ${jmeter_path}/tmp/jmeter_${timestamp}.log
