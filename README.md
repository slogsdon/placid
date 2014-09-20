# Placid
[![Build Status](https://img.shields.io/travis/slogsdon/placid.svg)](https://travis-ci.org/slogsdon/placid)
[![Coverage Status](https://img.shields.io/coveralls/slogsdon/placid.svg)](https://coveralls.io/r/slogsdon/placid)
[![Hex.pm Version](http://img.shields.io/hexpm/v/placid.svg)](https://hex.pm/packages/placid)


A REST toolkit for building highly-scalable and fault-tolerant HTTP APIs with Elixir.

- [Configuration](#configuration)
- [Routing](#routing)
- [Handlers](#handlers)
- [CORS](#cors)
- [Request Parsing](#request-parsing)
- [Rendering](#rendering)
- [Internationalization](#internationalization)
- [TODO](#todo)

## Configuration

### HTTP

#### Options

- `port` - Port to listen for HTTP requests.

### HTTPS

By default, connecting to a Placid-based API will require all requests to be made over HTTPS, responding to HTTP requests with a `403 Forbidden`. If desired, the `https_only` option may be set allow HTTP requests to be served by your application. Take a look at the [kitchen sink example](https://github.com/slogsdon/placid/blob/master/examples/kitchensink/config/config.exs#L12) to see this in action.

#### Options

- `certfile` - Path to the certificate file.
- `keyfile` - Path to the certificate key file.
- `otp_app` - If present, `certfile` and `keyfile` can be relative paths with respect to `otp_app`'s `priv` directory.
- `port` - Port to listen for HTTPS requests.

> Note: Create a self-signed certificate for easy testing.
>
> ```
> # Generate a keyfile
> $ openssl genrsa -out key.pem 2048
>
> # Create a CSR
> $ openssl req -new -key key.pem -out request.pem
>
> # Generate a certfile that expires in $NUM_DAYS
> $ openssl x509 -req -days $NUM_DAYS -in request.pem -signkey key.pem -out cert.pem
> ```

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

Extra routes will need to be added for `*.json`, `*.xml`, etc. requests for optionally specifying desired content type without the use of the `Accepts` header. These should match parsing/rendering abilities of Placid.

Should required/optional params be gathered for matching purposes? Only return a matched route when all required params are present?

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
                  message: "A valid page_id is required." }
        {i, _} ->
          Queries.Page.get i
      end

    render conn, result
  end

  @doc """
  Create a new page
  """
  def create(conn, args) do
    render conn, Queries.Page.create(args), status: :created
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

## CORS

Should have an option to respect Cross-origin resource sharing (CORS) when desired.

Main response headers:

- `Access-Control-Allow-Origin`: *|[list of allowed hosts]
- `Access-Control-Allow-Credentials`: true (or ignore header)
- `Access-Control-Allow-Methods`: [list of allowed methods]
- `Access-Control-Allow-Headers`: [list of allowed beyond simple]
    - `Cache-Control`
    - `Content-Language`
    - `Content-Type`
    - `Expires`
    - `Last-Modified`
    - `Pragma`
- `Access-Control-Max-Age`: [# of seconds]

Should check over the [HTML5 Rocks CORS flowchart](http://www.html5rocks.com/static/images/cors_server_flowchart.png) as much as possible.

Is `JSON-P` still a thing? Should it be supported? What happens with non-`GET` requests?

## Request Parsing

Parsing request bodies from their content type to Elixir terms allows the handler actions to easily use that data in responding to the client. There should be one parser for each supported response content type, with an additional parser for form encoded data.

Current Parsers:

- JSON - Encoded into standard map
- XML - Encoded into a list of maps, each containing a representation of XML nodes from the request body
- WWW-Encoded and Multipart form data - Encoded into a standard map

## Rendering

Render layer serializes/encodes data based on the requested content type unless overridden for whatever reason in the response stack.

Rendering engine behavior:

```elixir
defmodule Placid.Response.Rendering.Engine do
  use Behaviour

  @type data :: Keyword | Map | List

  defcallback serialize(data, type, subtype) :: { :ok, binary } | :next
end

defmodule Placid.Response.Rendering.JSON do
  @behaviour Placid.Response.Rendering.Engine

  @types ["application", "text"]

  def serialize(data, type, "json") when type in @types do
    { :ok, data |> Poison.encode!(string: true) }
  end
  def serialize(_, _, _), do: :next
end
```

## Internationalization

I18n should always be considered when producing an API.

[Linguist](https://github.com/chrismccord/linguist) is already a part of the project's dependencies. Need to think of ways to make translations seemless as possible, similar to rendering.

## TODO

- [ ] Respects HTTP specifications ([7230](http://tools.ietf.org/pdf/rfc7230.pdf),
    [7231](http://tools.ietf.org/pdf/rfc7231.pdf),
    [7232](http://tools.ietf.org/pdf/rfc7232.pdf),
    [7233](http://tools.ietf.org/pdf/rfc7233.pdf),
    [7234](http://tools.ietf.org/pdf/rfc7234.pdf),
    [7235](http://tools.ietf.org/pdf/rfc7235.pdf))
- [ ] Compatibility with web frameworks via umbrella projects.
    - [ ] Would be nice to offer tight integration when available, e.g. `Phoenix.Topic` notifications
- [ ] Foundations
    - [X] Prefer TLS. Require clients to use TLS when enabled in server
    - [ ] Version with `Accept` header. Fallback to URL versioning
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
