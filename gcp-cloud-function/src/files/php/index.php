<!-- https://github.com/GoogleCloudPlatform/php-docs-samples/tree/ef403b56764a1ecb4c6bea0b8c430cf088c54eb7/functions/helloworld_http -->

<?php
use Google\CloudFunctions\FunctionsFramework;
use Psr\Http\Message\ServerRequestInterface;

// Register the function with Functions Framework.
// This enables omitting the `FUNCTIONS_SIGNATURE_TYPE=http` environment
// variable when deploying. The `FUNCTION_TARGET` environment variable should
// match the first parameter.
FunctionsFramework::http('helloHttp', 'helloHttp');

function helloHttp(ServerRequestInterface $request): string
{
    $name = 'World';
    $body = $request->getBody()->getContents();
    if (!empty($body)) {
        $json = json_decode($body, true);
        if (json_last_error() != JSON_ERROR_NONE) {
            throw new RuntimeException(
                sprintf('Could not parse body: %s', json_last_error_msg())
            );
        }
        $name = $json['name'] ?? $name;
    }
    $queryString = $request->getQueryParams();
    $name = $queryString['name'] ?? $name;

    return sprintf('Hello, %s!', htmlspecialchars($name));
}
