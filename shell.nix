let
  pkgs = import ./nix/pkgs {
    config = { 
        allowUnfree = true; 
        allowBroken = true;
        permittedInsecurePackages = [
         "openssl-1.0.2u"
       ];
    };
  };

  spark-nt = with pkgs; (
    spark.overrideAttrs (
      old:
        rec {
          version = "3.1.1";
          src = fetchurl {
            url = "https://mirror.serverion.com/apache/spark/spark-3.1.1/spark-3.1.1-bin-without-hadoop.tgz"; # "http://apache.40b.nl/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz"; #"https://mirror.koddos.net/apache/spark/spark-3.1.1/spark-3.1.1-bin-without-hadoop-scala-2.12.tgz";
            sha256 = "1x3263b2jxs5yx8bkng2k84y6w51c7k364l0gjdfd4v904kza5id"; # "0001fqqr8vfbr92n1l1zbahwlpa1m2v4gs5nyg4whii3py9f44cz";
          };
        }
    )
  );
in

pkgs.mkShell {
  
  name = "dev-shell";
  buildInputs = with pkgs;
    [
      procps
      bash
      curl
      jdk11
      protobuf # for spark
      python38Packages.pyspark # to have spark shell
    ];
  src = null;

  shellHook = ''
    export JAVA_HOME=${pkgs.jdk11}
    export PYSPARK_PYTHON=python3
    export SPARK_LOCAL_DIRS=./tmp/spark
    export SPARK_HOME=${spark-nt}/lib/spark-2.4.3-bin-without-hadoop
    export SPARK_MASTER_HOST=localhost
    export SPARK_LOG_DIR=./spark-logs
    export SPARK_PID_DIR=./spark-pids

    export PATH="${pkgs.procps}/bin:$PATH" # trying to resolve the ps issue in running Spark scripts.  
  '';

}
