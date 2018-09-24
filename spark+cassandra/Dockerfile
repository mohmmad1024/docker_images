FROM jupyter/all-spark-notebook

USER root
#wget is not frendlly with mevan
#RUN wget https://dl.bintray.com/spark-packages/maven/datastax/spark-cassandra-connector/2.3.1-s_2.11/:spark-cassandra-connector-2.3.1-s_2.11.jar -O $SPARK_HOME/jars/cassandra.jar

RUN apt-get update && apt-get install -y iputils-ping && apt-get clean
RUN pip install cassandra-driver

ADD spark/jars/ $SPARK_HOME/jars/
RUN $SPARK_HOME/bin/pyspark --packages com.datastax.spark:spark-cassandra-connector_2.11:2.3.2
#RUN $SPARK_HOME/bin/pyspark --packages com.databricks:spark-csv_2.10:1.3.0
RUN $SPARK_HOME/bin/pyspark --packages com.databricks:spark-csv_2.11:1.3.0
#ADD spark/<cassandra jar file> $SPARK_HOME/jars/
