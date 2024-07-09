require "functions_framework"

FunctionsFramework.http "hello_http" do |request|
  "Hello ruby in GCF 2nd gen!"
end
