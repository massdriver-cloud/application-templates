# Azure Function App Fizzbuzz Example

Deploys a starter app to help get you familiar with working with infrastructure in Massdriver. The application is a basic fizzbuzz solver written in NodeJS. The application accepts `POST` requests with the payload.

```json
{
    "query": {{ number_to_test }} 
}
```

## Resources

* Azure Function App - Runs the fizzbuzz solver
* Azure Virtual Network - Creates a virtual network for the function app to run in

## Alarms

The template comes with a latency alarm configured for the function app out of the box. The alarm will alert when the average latency of the function app exceeds 1000ms, which can be configurable by selecting the **Custom** monitoring mode.

## Pulling the image

```bash
docker pull massdrivercloud/fizzbuzzapi:azurefunctions
```

## Running the image

```bash
docker run -p 8080:80 -it massdrivercloud/fizzbuzzapi:azurefunctions
```

## Testing the image

```bash
curl -X POST -H 'content-type: application/json' localhost:8080/api/httptrigger -d '{"query": 5}'
```