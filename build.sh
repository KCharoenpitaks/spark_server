# -- Software Stack Version

SPARK_VERSION="3.0.0"
HADOOP_VERSION="2.7"
JUPYTERLAB_VERSION="2.1.5"

# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t cluster-base .
docker tag cluster-base megadarkparticle/cluster-base
docker push megadarkparticle/cluster-base

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile \
  -t spark-base .
docker tag spark-base megadarkparticle/spark-base
docker push megadarkparticle/spark-base

docker build \
  -f spark-master.Dockerfile \
  -t spark-master .
docker tag spark-master megadarkparticle/spark-master
docker push megadarkparticle/spark-master

docker build \
  -f spark-worker.Dockerfile \
  -t spark-worker .
docker tag spark-worker megadarkparticle/spark-worker
docker push megadarkparticle/spark-worker

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .
docker tag jupyterlab megadarkparticle/jupyterlab
docker push megadarkparticle/jupyterlab