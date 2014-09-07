# placid

A REST toolkit for building highly-scalable and fault-tolerant HTTP APIs with Elixir.

## TODO

- [ ] Compatibility with web frameworks via umbrella projects.
  - [ ] Would be nice to offer tight integration when available, e.g. `Phoenix.Topic` notifications
- [ ] Respects HTTP specifications ([7230](http://tools.ietf.org/pdf/rfc7230.pdf), 
  [7231](http://tools.ietf.org/pdf/rfc7231.pdf),
  [7232](http://tools.ietf.org/pdf/rfc7232.pdf), 
  [7233](http://tools.ietf.org/pdf/rfc7233.pdf), 
  [7234](http://tools.ietf.org/pdf/rfc7234.pdf), 
  [7235](http://tools.ietf.org/pdf/rfc7235.pdf))
- [ ] [Foundations](https://github.com/interagent/http-api-design#foundations)
  - [ ] [Require TLS](https://github.com/interagent/http-api-design#require-tls)
  - [ ] [Version with Accepts header](https://github.com/interagent/http-api-design#version-with-accepts-header)
  - [ ] [Support caching with Etags](https://github.com/interagent/http-api-design#support-caching-with-etags)
  - [ ] [Trace requests with Request-Ids](https://github.com/interagent/http-api-design#trace-requests-with-request-ids)
  - [ ] [Paginate with ranges](https://github.com/interagent/http-api-design#paginate-with-ranges)
- [ ] [Requests](https://github.com/interagent/http-api-design#requests)
  - [ ] [Return appropriate status codes](https://github.com/interagent/http-api-design#return-appropriate-status-codes)
  - [ ] [Provide full resources where available](https://github.com/interagent/http-api-design#provide-full-resources-where-available)
  - [ ] [Accept serialized JSON in request bodies](https://github.com/interagent/http-api-design#accept-serialized-json-in-request-bodies)
  - [ ] [Use consistent path formats](https://github.com/interagent/http-api-design#use-consistent-path-formats)
  - [ ] [Downcase paths and attributes](https://github.com/interagent/http-api-design#downcase-paths-and-attributes)
  - [ ] [Support non-id dereferencing for convenience](https://github.com/interagent/http-api-design#support-non-id-dereferencing-for-convenience)
  - [ ] [Minimize path nesting](https://github.com/interagent/http-api-design#minimize-path-nesting)
- [ ] [Responses](https://github.com/interagent/http-api-design#responses)
  - [ ] [Provide resource (UU)IDs](https://github.com/interagent/http-api-design#provide-resource-uuids)
  - [ ] [Provide standard timestamps](https://github.com/interagent/http-api-design#provide-standard-timestamps)
  - [ ] [Use UTC times formatted in ISO8601](https://github.com/interagent/http-api-design#use-utc-times-formatted-in-iso8601)
  - [ ] [Nest foreign key relations](https://github.com/interagent/http-api-design#nest-foreign-key-relations)
  - [ ] [Generate structured errors](https://github.com/interagent/http-api-design#generate-structured-errors)
  - [ ] [Show rate limit status](https://github.com/interagent/http-api-design#show-rate-limit-status)
  - [ ] [Keep JSON minified in all responses](https://github.com/interagent/http-api-design#keep-json-minified-in-all-responses)
- [ ] [Artifacts](https://github.com/interagent/http-api-design#artifacts)
  - [ ] [Provide machine-readable JSON schema](https://github.com/interagent/http-api-design#provide-machine-readable-json-schema)
  - [ ] [Provide human-readable docs](https://github.com/interagent/http-api-design#provide-human-readable-docs)
  - [ ] [Provide executable examples](https://github.com/interagent/http-api-design#provide-executable-examples)
  - [ ] [Describe stability](https://github.com/interagent/http-api-design#describe-stability)
  
This list comes primarily from the [HTTP API Design Guide](https://github.com/interagent/http-api-design) by @interagent and [friends](https://github.com/interagent/http-api-design/graphs/contributors) but will be updated to fit the needs of the project.