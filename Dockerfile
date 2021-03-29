FROM openjdk

# Install few utilities
RUN \
  apt-get update \
  && apt-get install -y --no-install-recommends software-properties-common \
  && apt-get -y install python-pip \
  && pip install awscli==1.10.45 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# JMeter version
ENV JMETER_VERSION=5.3

WORKDIR /jmeter

# Install JMeter
RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-"$JMETER_VERSION".tgz \
      && tar -xzf apache-jmeter-"$JMETER_VERSION".tgz \
      && rm apache-jmeter-"$JMETER_VERSION".tgz



# ADD all the plugins
#ADD jmeter-plugins/lib /jmeter/apache-jmeter-$JMETER_VERSION/lib

# ADD the sample test, keep all your jmx file in script folder
COPY script script

# If the jmx depends on csv data, put the csv files in the data folder
COPY data data

# Set JMeter Home
ENV JMETER_HOME /jmeter/apache-jmeter-"$JMETER_VERSION"

# Add JMeter to the Path
ENV PATH $JMETER_HOME/bin:"$PATH"

ENV TZ=Asia/Calcutta
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && echo "$TZ" > /etc/timez


COPY ./run.sh run.sh
COPY script/ script

RUN chmod +x run.sh

CMD ["/bin/bash", "run.sh"]


# nohup ./apache-jmeter-3.3/bin/jmeter -n -t "/<path to jmx file>/test.jmx" -l /<path to jmx file>/testresult.jtl
