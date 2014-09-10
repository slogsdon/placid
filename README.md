# Placid
[![Build Status](https://img.shields.io/travis/slogsdon/placid.svg)](https://travis-ci.org/slogsdon/placid)
[![Coverage Status](https://img.shields.io/coveralls/slogsdon/placid.svg)](https://coveralls.io/r/slogsdon/placid)

A REST toolkit for building highly-scalable and fault-tolerant HTTP APIs with Elixir.

- [Routing](#routing)
- [Handlers](#handlers)
- [Request Parsing](#request-parsing)
- [Rendering](#rendering)
- [TODO](#todo)

## Routing

```elixir
defmodule Router do
  use Placid.Router

  # Define one of the versions of the API
  # with a simple version number "1"
  # or following semver "1.0.0"
  # or date of release "2014-09-06"
  version "1" do 
    # Define your routes here
    get  "/",               Handlers.V1.Pages, :index
    get  "/pages",          Handlers.V1.Pages, :create
    post "/pages",          Handlers.V1.Pages, :create
    put  "/pages/:page_id" when id == 1,
                            Handlers.V1.Pages, :update_only_one
    get  "/pages/:page_id", Handlers.V1.Pages, :show
    
    # Auto-create a full set of routes for resources
    #
    resource :users,        Handlers.V1.User, arg: :user_id
    #
    # Generates:
    #
    # get     "/users",           Handlers.V1.User, :index
    # post    "/users",           Handlers.V1.User, :create
    # get     "/users/:user_id",  Handlers.V1.User, :show
    # put     "/users/:user_id",  Handlers.V1.User, :update
    # patch   "/users/:user_id",  Handlers.V1.User, :patch
    # delete  "/users/:user_id",  Handlers.V1.User, :delete
    #
    # options "/users",           "HEAD,GET,POST"
    # options "/users/:_user_id", "HEAD,GET,PUT,PATCH,DELETE"
  end

  # An updated version of the AP
  version "2" do 
    get  "/",               Handlers.V2.Pages,  :index
    post "/pages",          Handlers.V2.Pages,  :create
    get  "/pages/:page_id", Handlers.V2.Pages,  :show
    put  "/pages/:page_id", Handlers.V2.Pages,  :update

    raw :trace, "/trace",   Handlers.V2.Tracer, :trace
    
    resource :users,        Handlers.V2.User
    resource :groups,       Handlers.V2.Group
  end
end
```

`get/3`, `post/3`, `put/3`, `patch/3`, `delete/3`, `options/2`, and `any/3` are already built-in as described. `resource` exists but will need modifications to create everything as noted.

`raw/4` allows for using custom HTTP methods, allowing your application to be HTTP spec compliant.

`version/2` will need to be created outright. Will allow requests to contained endpoints when version exists in either `Accepts` header or URL (which ever is defined in app config).

Extra routes will need to be added for `*.json`, `*.xml`, etc. requests for optionally specifying desired content type without the use of the `Accepts` header.

## Handlers

```elixir
defmodule Handlers.V2.Pages do
  use Placid.Handler

  @doc """
  List all available pages
  """
  def index(conn, []) do
    # Somehow get our content
    pages = Queries.Page.all
    render conn, pages
  end

  @doc """
  Show an individual page
  """
  def show(conn, args) do
    result = case Integer.parse args["page_id"] do
        :error -> 
          %Error{ id: "no_page_id",
                  message: "A valid page_id is requried." }
        {i, _} ->
          Queries.Page.get i
      end

    render conn, result
  end

  @doc """
  Create a new page
  """
  def create(conn, args) do
    render conn, Queries.Page.create args, status: :created
  end

  @doc """
  Update an individual page
  """
  def update(conn, args) do
    result = case Integer.parse args["page_id"] do
        :error -> 
          %Error{ id: "no_page_id",
                  message: "A valid page_id is requried." }
        {i, _} ->
          Queries.Page.update i, args
      end

    render conn, result
  end
end
```

Actions in handler modules are responsible for handling a request once it has been routed. These actions typically generate a response, whether that be an error, a result, or a result set, so that it can be rendered to the client with the correct content type further up the stack.

## Request Parsing

Parsing request bodies from their content type to Elixir terms allows the handler actions to easily use that data in responding to the client. There should be one parser for each supported response content type, with an additional parser for form encoded data.

Current Parsers:

- JSON - Encoded into standard map
- XML - Encoded into a list of maps, each containing a representation of XML nodes from the request body

## Rendering

Render layer serializes/encodes data based on the requested content type unless overridden for whatever reason in the response stack.

## TODO

- [ ] Compatibility with web frameworks via umbrella projects.
  - [ ] Would be nice to offer tight integration when available, e.g. `Phoenix.Topic` notifications
- [ ] Respects HTTP specifications ([7230](http://tools.ietf.org/pdf/rfc7230.pdf), 
  [7231](http://tools.ietf.org/pdf/rfc7231.pdf),
  [7232](http://tools.ietf.org/pdf/rfc7232.pdf), 
  [7233](http://tools.ietf.org/pdf/rfc7233.pdf), 
  [7234](http://tools.ietf.org/pdf/rfc7234.pdf), 
  [7235](http://tools.ietf.org/pdf/rfc7235.pdf))
- [ ] Foundations ([link](https://github.com/interagent/http-api-design#foundations))
  - [ ] Require TLS ([link](https://github.com/interagent/http-api-design#require-tls))
  - [ ] Version with Accepts header ([link](https://github.com/interagent/http-api-design#version-with-accepts-header))
  - [ ] Support caching with Etags ([link](https://github.com/interagent/http-api-design#support-caching-with-etags))
  - [ ] Trace requests with Request-Ids ([link](https://github.com/interagent/http-api-design#trace-requests-with-request-ids))
  - [ ] Paginate with ranges ([link](https://github.com/interagent/http-api-design#paginate-with-ranges))
- [ ] Requests ([link](https://github.com/interagent/http-api-design#requests))
  - [ ] Return appropriate status codes ([link](https://github.com/interagent/http-api-design#return-appropriate-status-codes))
  - [ ] Provide full resources where available ([link](https://github.com/interagent/http-api-design#provide-full-resources-where-available))
  - [ ] Accept serialized JSON in request bodies ([link](https://github.com/interagent/http-api-design#accept-serialized-json-in-request-bodies))
  - [ ] Use consistent path formats ([link](https://github.com/interagent/http-api-design#use-consistent-path-formats))
  - [ ] Downcase paths and attributes ([link](https://github.com/interagent/http-api-design#downcase-paths-and-attributes))
  - [ ] Support non-id dereferencing for convenience ([link](https://github.com/interagent/http-api-design#support-non-id-dereferencing-for-convenience))
  - [ ] Minimize path nesting ([link](https://github.com/interagent/http-api-design#minimize-path-nesting))
- [ ] Responses ([link](https://github.com/interagent/http-api-design#responses))
  - [ ] Provide resource (UU)IDs ([link](https://github.com/interagent/http-api-design#provide-resource-uuids))
  - [ ] Provide standard timestamps ([link](https://github.com/interagent/http-api-design#provide-standard-timestamps))
  - [ ] Use UTC times formatted in ISO8601 ([link](https://github.com/interagent/http-api-design#use-utc-times-formatted-in-iso8601))
  - [ ] Nest foreign key relations ([link](https://github.com/interagent/http-api-design#nest-foreign-key-relations))
  - [ ] Generate structured errors ([link](https://github.com/interagent/http-api-design#generate-structured-errors))
  - [ ] Show rate limit status ([link](https://github.com/interagent/http-api-design#show-rate-limit-status))
  - [ ] Keep JSON minified in all responses ([link](https://github.com/interagent/http-api-design#keep-json-minified-in-all-responses))
- [ ] Artifacts ([link](https://github.com/interagent/http-api-design#artifacts))
  - [ ] Provide machine-readable JSON schema ([link](https://github.com/interagent/http-api-design#provide-machine-readable-json-schema))
  - [ ] Provide human-readable docs ([link](https://github.com/interagent/http-api-design#provide-human-readable-docs))
  - [ ] Provide executable examples ([link](https://github.com/interagent/http-api-design#provide-executable-examples))
  - [ ] Describe stability ([link](https://github.com/interagent/http-api-design#describe-stability))
  
This list comes primarily from the [HTTP API Design Guide](https://github.com/interagent/http-api-design) by [**@interagent**](/interagent) and [friends](https://github.com/interagent/http-api-design/graphs/contributors) but will be updated to fit the needs of the project.

## License

Placid is released under the MIT License.

See [LICENSE](https://github.com/slogsdon/placid/blob/master/LICENSE) for details.
