# This is a failed attempt to setup up a standalone Apache Spark cluster

## The error

```bash
$SPARK_HOME/sbin/start-master.sh
```

results in 

```
starting org.apache.spark.deploy.master.Master, logging to ./spark-logs/spark-zhen-org.apache.spark.deploy.master.Master-1-nt.out
/nix/store/9jxd8bj2wc97awlmv95nsjnm3qlxqx6j-spark-3.1.1/lib/spark-2.4.3-bin-without-hadoop/sbin/spark-daemon.sh: line 143: ps: command not found
```

## The question
Why the `ps: command not found` error?