using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;

namespace HelloHttp;

public class Function : IHttpFunction
{
  private readonly ILogger _logger;

  public Function(ILogger<Function> logger) =>
    _logger = logger;

    public async Task HandleAsync(HttpContext context)
    {
      HttpRequest request = context.Request;
      // Check URL parameters for "name" field
      // "world" is the default value
      string name = ((string) request.Query["name"]) ?? "world";

      // If there's a body, parse it as JSON and check for "name" field.
      using TextReader reader = new StreamReader(request.Body);
      string text = await reader.ReadToEndAsync();
      if (text.Length > 0)
      {
        try
        {
          JsonElement json = JsonSerializer.Deserialize<JsonElement>(text);
          if (json.TryGetProperty("name", out JsonElement nameElement) &&
            nameElement.ValueKind == JsonValueKind.String)
          {
            name = nameElement.GetString();
          }
        }
        catch (JsonException parseException)
        {
          _logger.LogError(parseException, "Error parsing JSON request");
        }
      }

      await context.Response.WriteAsync($"Hello {name}!");
    }
}
