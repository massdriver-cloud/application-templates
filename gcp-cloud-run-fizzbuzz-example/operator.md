# Google Cloud Run Fizzbuzz Example

Deploys a starter app to help get you familiar with working with infrastructure in Massdriver. The application is a basic fizzbuzz solver written in NodeJS. The application accepts `POST` requests with the payload.

```json
{
    "query": {{ number_to_test }} 
}
```

## Resources

* Google Cloud Run - Runs the fizzbuzz solver
* Google Subnetwork - Creates a subnetwork for the fizzbuzz app to run in
* Google Global Network - Creates a global network for the subnetwork to run in

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