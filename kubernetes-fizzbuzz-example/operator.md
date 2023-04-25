# Kubernetes Fizzbuzz Example Application

Deploys a starter app to help get you familiar with working with infrastructure in Massdriver. The application is a basic fizzbuzz solver written in NodeJS and listens on port 3000. The application accepts `POST` requests on port `3000` with the payload

```json
{
    "query": {{ number_to_test }} 
}
```

## Resources

* Deployment - Kubernetes deployment which launches a pod running a fizzbuzz solver in NodeJS
* Service - Network access to the solver on port 3000 of the container.
* Ingress - Automatically adds path `/fizzbuzz` to nginx ingress using default the default loadbalacer dns and routes to the fizzbuzz service.

## Pulling the image

```bash
docker pull massdrivercloud/fizzbuzzapi:k8s
```

## Running the image

```bash
docker run --rm -i massdrivercloud/fizzbuzzapi:k8s
```

## Testing the image

```bash
curl -X POST -H 'content-type: application/json' localhost:3000/fizzbuzz -d '{"query": 5}'
```