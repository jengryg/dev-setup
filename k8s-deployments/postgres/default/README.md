# Deployment via Helm on K8s

This deployment requires manual initialization of the secretmap containing the following key-value pairs for the
postgres server.

````properties
# postgres-default-secretmap
POSTGRES_DB=<default database name>
POSTGRES_USER=<initial user name>
POSTGRES_PASSWORD=<initial user password>
````

You can initialize an empty secretmap via cli and then edit it to add the data containing the secrets.

````shell
kubectl -n postgres create secret generic postgres-default-secretmap
kubectl -n postgres edit secret postgres-default-secretmap
````

Add the following yaml attribute on the root level (or edit if it already exists).
The values must be base64 encoded with padding. Ensure that you are not encoding any prepended or appended whitespace
characters around the secret value.

````yaml
data:
  POSTGRES_DB: "<base64 encoded with padding>"
  POSTGRES_USER: "<base64 encoded with padding>"
  POSTGRES_PASSWORD: "<base64 encoded with padding>"
````