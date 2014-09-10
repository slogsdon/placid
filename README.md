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

Extra routes will need to be added for `*.json`, `*.xml`, etc. requests for optionally specifying desired content type without the use of the `Accepts` header. These should match parsing/rendering abailities of Placid.

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

Rendering engine behavior:

```elixir
defmodule Placid.Response.Rendering.Engine do
  use Behaviour

  @type data :: any

  @callback serialize(data) :: binary
  defcallback serialize(data)
end

defmodule Placid.Response.Rendering.JSON do
  @behaviour Placid.Response.Rendering.Engine

  def serialize(data), do: Poison.encode!(data, string: true)
end
```

## TODO

- [ ] Compatibility with web frameworks via umbrella projects.
  - [ ] Would be nice to offer tight integration when available, e.g. `Phoenix.Topic` notifications
- [ ] Respects HTTP specifications ([7230](http://tools.ietf.org/pdf/rfc7230.pdf), 
  [7231](http://tools.ietf.org/pdf/rfc7231.pdf),
  [7232](http://tools.ietf.org/pdf/rfc7232.pdf), 
  [7233](http://tools.ietf.org/pdf/rfc7233.pdf), 
  [7234](http://tools.ietf.org/pdf/rfc7234.pdf), 
  [7235](http://tools.ietf.org/pdf/rfc7235.pdf))
- [ ] Foundations
  - [ ] Prefer TLS. Require clients to use TLS when enabled in server
  - [ ] Version with `Accepts` header. Fallback to URL versioning
  - [ ] Support caching with `Etags`
  - [ ] Trace requests with Request-Ids
  - [ ] Paginate with ranges. Mostly lies on end-developer, but we should provide facility to easily set headers
- [ ] Requests
  - [ ] Return appropriate status codes. Mostly lies on end-developer, but we should return them when appropriate
  - [ ] Provide full resources where available
  - [X] Accept serialized JSON/XML in request bodies
  - [ ] Downcase paths and attributes
  - [X] Support non-id dereferencing for convenience. No type checking occurs on parameters
  - [ ] Minimize path nesting. Mostly lies on end-developer, but we should ensure generated route paths are as simple as posisble
- [ ] Responses
  - [ ] Provide resource (UU)IDs
  - [ ] Provide standard timestamps
  - [ ] Use UTC times formatted in ISO8601
  - [ ] Nest foreign key relations
  - [ ] Generate structured errors
  - [ ] Show rate limit status
  - [ ] Keep JSON minified in all responses
- [ ] Artifacts
  - [ ] Provide machine-readable JSON schema
  - [ ] Provide human-readable docs
  - [ ] Provide executable examples
  - [ ] Describe stability
  
This list comes primarily from the [HTTP API Design Guide](https://github.com/interagent/http-api-design) by [**@interagent**](https://github.com/interagent) and [friends](https://github.com/interagent/http-api-design/graphs/contributors) but will be updated to fit the needs of the project.

## License

Placid is released under the MIT License.

See [LICENSE](https://github.com/slogsdon/placid/blob/master/LICENSE) for details.
