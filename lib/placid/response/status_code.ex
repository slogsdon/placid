defmodule Placid.Response.StatusCode do
  @moduledoc """
  Helper data for dealing with HTTP status codes.

  Remember the name of a status code but need the numeric code for your 
  endpoint? Or maybe you're getting a response back from a third-party and
  want to translate that `418` to a human-readable for for your end-users?

  You've come to the right place.
  """

  defstruct code: 0, reason: ""

  @type t :: %Placid.Response.StatusCode{
    code:   100..999,
    reason: binary
  }

  @doc """
  Translates a given integer or atom into a status code.

  Returns `200 OK` for unknown entities.

  ## Arguments

  * `status` - `Integer` | `Atom`

  ## Returns

  `Placid.Response.StatusCode`

  ## Examples
      
      iex> Placid.Response.StatusCode.find 200
      %Placid.Response.StatusCode{code: 200, reason: "OK"}

      iex> Placid.Response.StatusCode.find :forbidden
      %Placid.Response.StatusCode{code: 403, reason: "Forbidden"}

      iex> Placid.Response.StatusCode.find 418
      %Placid.Response.StatusCode{code: 418, reason: "I'm a teapot"}

      iex> Placid.Response.StatusCode.find nil
      %Placid.Response.StatusCode{code: 200, reason: "OK"}
  """
  @spec find(any) :: Placid.Response.StatusCode.t
  def find(status) do
    struct(Placid.Response.StatusCode, do_find(status))
  end

  codes = [
    # This means that the server has received the request headers, and that the 
    # client should proceed to send the request body (in the case of a request for 
    # which a body needs to be sent; for example, a POST request). If the request 
    # body is large, sending it to a server when a request has already been rejected 
    # based upon inappropriate headers is inefficient. To have a server check if the 
    # request could be accepted based on the request's headers alone, a client must 
    # send Expect: 100-continue as a header in its initial request and check if a 
    # 100 Continue status code is received in response before continuing (or receive 
    # 417 Expectation Failed and not continue).
    { 100, :continue, "Continue", false },

    # This means the requester has asked the server to switch protocols and the 
    # server is acknowledging that it will do so.
    { 101, :switching_protocols, "Switching Protocols", false },

    # As a WebDAV request may contain many sub-requests involving file operations, 
    # it may take a long time to complete the request. This code indicates that the 
    # server has received and is processing the request, but no response is 
    # available yet. This prevents the client from timing out and assuming the 
    # request was lost.
    { 102, :processing, "Processing", false },

    # Standard response for successful HTTP requests. The actual response will 
    # depend on the request method used. In a GET request, the response will contain 
    # an entity corresponding to the requested resource. In a POST request the 
    # response will contain an entity describing or containing the result of the 
    # action.
    { 200, :ok, "OK", false },

    # The request has been fulfilled and resulted in a new resource being created.
    { 201, :created, "Created", false },

    # The request has been accepted for processing, but the processing has not been 
    # completed. The request might or might not eventually be acted upon, as it 
    # might be disallowed when processing actually takes place.
    { 202, :accepted, "Accepted", false },

    # The server successfully processed the request, but is returning information 
    # that may be from another source.
    { 203, :non_authoritative_information, "Non-Authoritative Information", false },

    # The server successfully processed the request, but is not returning any 
    # content. Usually used as a response to a successful delete request.
    { 204, :no_content, "No Content", false },

    # The server successfully processed the request, but is not returning any 
    # content. Unlike a 204 response, this response requires that the requester 
    # reset the document view.
    { 205, :reset_content, "Reset Content", false },

    # The server is delivering only part of the resource (byte serving) due to a 
    # range header sent by the client. The range header is used by tools like wget 
    # to enable resuming of interrupted downloads, or split a download into multiple 
    # simultaneous streams.
    { 206, :partial_content, "Partial Content", false },

    # The message body that follows is an XML message and can contain a number of 
    # separate response codes, depending on how many sub-requests were made.
    { 207, :multi_status, "Multi-Status", false },

    # The members of a DAV binding have already been enumerated in a previous reply 
    # to this request, and are not being included again.
    { 208, :already_reported, "Already Reported", false },

    # The server has fulfilled a GET request for the resource, and the response is a 
    # representation of the result of one or more instance-manipulations applied to 
    # the current instance.
    { 226, :im_used, "IM Used", false },

    # Indicates multiple options for the resource that the client may follow. It, 
    # for instance, could be used to present different format options for video, 
    # list files with different extensions, or word sense disambiguation.
    { 300, :multiple_choices, "Multiple Choices", false },

    # This and all future requests should be directed to the given URI.
    { 301, :moved_permanently, "Moved Permanently", false },

    # This is an example of industry practice contradicting the standard. The 
    # HTTP/1.0 specification (RFC 1945) required the client to perform a temporary 
    # redirect (the original describing phrase was "Moved Temporarily"), but popular 
    # browsers implemented 302 with the functionality of a 303 See Other. Therefore, 
    # HTTP/1.1 added status codes 303 and 307 to distinguish between the two 
    # behaviours. However, some Web applications and frameworks use the 302 status 
    # code as if it were the 303.
    { 302, :found, "Found", false },

    # The response to the request can be found under another URI using a GET method. 
    # When received in response to a POST (or PUT/DELETE), it should be assumed that 
    # the server has received the data and the redirect should be issued with a 
    # separate GET message.
    { 303, :see_other, "See Other", false },

    # Indicates that the resource has not been modified since the version specified 
    # by the request headers If-Modified-Since or If-Match. This means that there is 
    # no need to retransmit the resource, since the client still has a 
    # previously-downloaded copy.
    { 304, :not_modified, "Not Modified", false },

    # The requested resource is only available through a proxy, whose address is 
    # provided in the response. Many HTTP clients (such as Mozilla and Internet 
    # Explorer) do not correctly handle responses with this status code, primarily 
    # for security reasons.
    { 305, :use_proxy, "Use Proxy", false },

    # No longer used. Originally meant "Subsequent requests should use the specified 
    # proxy."
    { 306, :switch_proxy, "Switch Proxy", false },

    # In this case, the request should be repeated with another URI; however, future 
    # requests should still use the original URI. In contrast to how 302 was 
    # historically implemented, the request method is not allowed to be changed when 
    # reissuing the original request. For instance, a POST request should be 
    # repeated using another POST request.
    { 307, :temporary_redirect, "Temporary Redirect", false },

    # The request, and all future requests should be repeated using another URI. 307 
    # and 308 (as proposed) parallel the behaviours of 302 and 301, but do not allow 
    # the HTTP method to change. So, for example, submitting a form to a permanently 
    # redirected resource may continue smoothly.
    { 308, :permanent_redirect, "Permanent Redirect", false },

    # The request cannot be fulfilled due to bad syntax.
    { 400, :bad_request, "Bad Request", false },

    # Similar to 403 Forbidden, but specifically for use when authentication is 
    # required and has failed or has not yet been provided. The response must 
    # include a WWW-Authenticate header field containing a challenge applicable to 
    # the requested resource. See Basic access authentication and Digest access 
    # authentication.
    { 401, :unauthorized, "Unauthorized", false },

    # Reserved for future use. The original intention was that this code might be 
    # used as part of some form of digital cash or micropayment scheme, but that has 
    # not happened, and this code is not usually used. YouTube uses this status if a 
    # particular IP address has made excessive requests, and requires the person to 
    # enter a CAPTCHA.
    { 402, :payment_required, "Payment Required", false },

    # The request was a valid request, but the server is refusing to respond to it. 
    # Unlike a 401 Unauthorized response, authenticating will make no difference.
    { 403, :forbidden, "Forbidden", false },

    # The requested resource could not be found but may be available again in the 
    # future. Subsequent requests by the client are permissible.
    { 404, :not_found, "Not Found", false },

    # A request was made of a resource using a request method not supported by that 
    # resource; for example, using GET on a form which requires data to be presented 
    # via POST, or using PUT on a read-only resource.
    { 405, :method_not_allowed, "Method Not Allowed", false },

    # The requested resource is only capable of generating content not acceptable 
    # according to the Accept headers sent in the request.
    { 406, :not_acceptable, "Not Acceptable", false },

    # The client must first authenticate itself with the proxy.
    { 407, :proxy_authentication_required, "Proxy Authentication Required", false },

    # The server timed out waiting for the request. According to HTTP 
    # specifications: "The client did not produce a request within the time that the 
    # server was prepared to wait. The client MAY repeat the request without 
    # modifications at any later time."
    { 408, :request_timeout, "Request Timeout", false },

    # Indicates that the request could not be processed because of conflict in the 
    # request, such as an edit conflict in the case of multiple updates.
    { 409, :conflict, "Conflict", false },

    # Indicates that the resource requested is no longer available and will not be 
    # available again. This should be used when a resource has been intentionally 
    # removed and the resource should be purged. Upon receiving a 410 status code, 
    # the client should not request the resource again in the future. Clients such 
    # as search engines should remove the resource from their indices.  Most use 
    # cases do not require clients and search engines to purge the resource, and a 
    # "404 Not Found" may be used instead.
    { 410, :gone, "Gone", false },

    # The request did not specify the length of its content, which is required by 
    # the requested resource.
    { 411, :length_required, "Length Required", false },

    # The server does not meet one of the preconditions that the requester put on 
    # the request.
    { 412, :precondition_failed, "Precondition Failed", false },

    # The request is larger than the server is willing or able to process.
    { 413, :request_entity_too_large, "Request Entity Too Large", false },

    # The URI provided was too long for the server to process. Often the result of 
    # too much data being encoded as a query-string of a GET request, in which case 
    # it should be converted to a POST request.
    { 414, :request_uri_too_long, "Request-URI Too Long", false },

    # The request entity has a media type which the server or resource does not 
    # support. For example, the client uploads an image as image/svg+xml, but the 
    # server requires that images use a different format.
    { 415, :unsupported_media_type, "Unsupported Media Type", false },

    # The client has asked for a portion of the file (byte serving), but the server 
    # cannot supply that portion. For example, if the client asked for a part of the 
    # file that lies beyond the end of the file.
    { 416, :requested_range_not_satisfiable, "Requested Range Not Satisfiable", false },

    # The server cannot meet the requirements of the Expect request-header field.
    { 417, :expectation_failed, "Expectation Failed", false },

    # This code was defined in 1998 as one of the traditional IETF April Fools' 
    # jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not 
    # expected to be implemented by actual HTTP servers.
    { 418, :im_a_teapot, "I'm a teapot", false },

    # Not a part of the HTTP standard, 419 Authentication Timeout denotes that 
    # previously valid authentication has expired. It is used as an alternative to 
    # 401 Unauthorized in order to differentiate from otherwise authenticated 
    # clients being denied access to specific server resources.
    { 419, :authentication_timeout, "Authentication Timeout", false },

    # Not part of the HTTP standard, but defined by Spring in the HttpStatus class 
    # to be used when a method failed. This status code is deprecated by Spring.
    { 420, :method_failure, "Method Failure", false },

    # Not part of the HTTP standard, but returned by version 1 of the Twitter Search 
    # and Trends API when the client is being rate limited. Other services may wish 
    # to implement the 429 Too Many Requests response code instead.
    { 420, :enhance_your_calm, "Enhance Your Calm", true },

    # The request was well-formed but was unable to be followed due to semantic 
    # errors.
    { 422, :unprocessable_entity, "Unprocessable Entity", false },

    # The resource that is being accessed is locked.
    { 423, :locked, "Locked", false },

    # The request failed due to failure of a previous request (e.g., a PROPPATCH).
    { 424, :failed_dependency, "Failed Dependency", false },

    # The client should switch to a different protocol such as TLS/1.0.
    { 426, :upgrade_required, "Upgrade Required", false },

    # The origin server requires the request to be conditional. Intended to prevent 
    # "the 'lost update' problem, where a client GETs a resource's state, modifies 
    # it, and PUTs it back to the server, when meanwhile a third party has modified 
    # the state on the server, leading to a conflict."
    { 428, :precondition_required, "Precondition Required", false },

    # The user has sent too many requests in a given amount of time. Intended for 
    # use with rate limiting schemes.
    { 429, :too_many_requests, "Too Many Requests", false },

    # The server is unwilling to process the request because either an individual 
    # header field, or all the header fields collectively, are too large.
    { 431, :request_header_fields_too_large, "Request Header Fields Too Large", false },

    # A Microsoft extension. Indicates that your session has expired.
    { 440, :login_timeout, "Login Timeout", false },

    # Used in Nginx logs to indicate that the server has returned no information to 
    # the client and closed the connection (useful as a deterrent for malware).
    { 444, :no_response, "No Response", false },

    # A Microsoft extension. The request should be retried after performing the 
    # appropriate action. Often search-engines or custom applications will ignore 
    # required parameters. Where no default action is appropriate, the Aviongoo 
    # website sends a "HTTP/1.1 449 Retry with valid parameters: param1, param2, 
    # ..." response. The applications may choose to learn, or not.  
    { 449, :retry_with, "Retry With", false },

    # A Microsoft extension. This error is given when Windows Parental Controls are 
    # turned on and are blocking access to the given webpage.
    { 450, :blocked_by_windows_parentak_controls, "Blocked by Windows Parental Controls", false },

    # Defined in the internet draft "A New HTTP Status Code for Legally-restricted 
    # Resources". Intended to be used when resource access is denied for legal 
    # reasons, e.g. censorship or government-mandated blocked access. A reference to 
    # the 1953 dystopian novel Fahrenheit 451, where books are outlawed.
    { 451, :unavailable_for_legal_reasons, "Unavailable For Legal Reasons", false },

    # Used in Exchange ActiveSync if there either is a more efficient server to use 
    # or the server cannot access the users' mailbox. The client is supposed to 
    # re-run the HTTP Autodiscovery protocol to find a better suited server.
    { 451, :redirect, "Redirect", true },

    # Nginx internal code similar to 431 but it was introduced earlier in version 
    # 0.9.4 (on January 21, 2011).
    { 494, :request_header_too_large, "Request Header Too Large", false },

    # Nginx internal code used when SSL client certificate error occurred to 
    # distinguish it from 4XX in a log and an error page redirection.
    { 495, :cert_error, "Cert Error", false },

    # Nginx internal code used when client didn't provide certificate to distinguish 
    # it from 4XX in a log and an error page redirection.
    { 496, :no_cert, "No Cert", false },

    # Nginx internal code used for the plain HTTP requests that are sent to HTTPS 
    # port to distinguish it from 4XX in a log and an error page redirection.
    { 497, :http_to_https, "HTTP to HTTPS", false },

    # Returned by ArcGIS for Server. A code of 498 indicates an expired or otherwise 
    # invalid token.
    { 498, :token_invalid, "Token expired/invalid", false },

    # Used in Nginx logs to indicate when the connection has been closed by client 
    # while the server is still processing its request, making server unable to send 
    # a status code back.
    { 499, :client_closed_request, "Client Closed Request", false },

    # Returned by ArcGIS for Server. A code of 499 indicates that a token is 
    # required (if no token was submitted).
    { 499, :token_required, "Token required", true },

    # A generic error message, given when an unexpected condition was encountered 
    # and no more specific message is suitable.
    { 500, :internal_server_error, "Internal Server Error", false },

    # The server either does not recognize the request method, or it lacks the 
    # ability to fulfil the request. Usually this implies future availability (e.g., 
    # a new feature of a web-service API).
    { 501, :not_implemented, "Not Implemented", false },

    # The server was acting as a gateway or proxy and received an invalid response 
    # from the upstream server.
    { 502, :bad_gateway, "Bad Gateway", false },

    # The server is currently unavailable (because it is overloaded or down for 
    # maintenance). Generally, this is a temporary state.
    { 503, :service_unavailable, "Service Unavailable", false },

    # The server was acting as a gateway or proxy and did not receive a timely 
    # response from the upstream server.
    { 504, :gateway_timeout, "Gateway Timeout", false },

    # The server does not support the HTTP protocol version used in the request.
    { 505, :http_version_not_supported, "HTTP Version Not Supported", false },

    # Transparent content negotiation for the request results in a circular 
    # reference.
    { 506, :variant_also_negotiates, "Variant Also Negotiates", false },

    # The server is unable to store the representation needed to complete the 
    # request.
    { 507, :insufficient_storage, "Insufficient Storage", false },

    # The server detected an infinite loop while processing the request (sent in 
    # lieu of 208 Already Reported).
    { 508, :loop_detected, "Loop Detected", false },

    # This status code is not specified in any RFCs. Its use is unknown.
    { 509, :bandwidth_limit_exceeded, "Bandwidth Limit Exceeded", false },

    # Further extensions to the request are required for the server to fulfil it.
    { 510, :not_extended, "Not Extended", false },

    # The client needs to authenticate to gain network access. Intended for use by 
    # intercepting proxies used to control access to the network (e.g., "captive 
    # portals" used to require agreement to Terms of Service before granting full 
    # Internet access via a Wi-Fi hotspot).
    { 511, :network_authentication_required, "Network Authentication Required", false },

    # This status code is not specified in any RFCs, but is used by CloudFlare's 
    # reverse proxies to signal an "unknown connection issue between CloudFlare and 
    # the origin web server" to a client in front of the proxy.
    { 520, :origin_error, "Origin Error", false },

    # This status code is not specified in any RFCs, but is used by CloudFlare's 
    # reverse proxies to indicate that the origin webserver refused the connection.
    { 521, :web_server_is_down, "Web server is down", false },

    # This status code is not specified in any RFCs, but is used by CloudFlare's 
    # reverse proxies to signal that a server connection timed out.
    { 522, :connection_timed_out, "Connection timed out", false },

    # This status code is not specified in any RFCs, but is used by CloudFlare's 
    # reverse proxies to signal a resource that has been blocked by the 
    # administrator of the website or proxy itself.
    { 523, :proxy_declined_request, "Proxy Declined Request", false },

    # This status code is not specified in any RFCs, but is used by CloudFlare's 
    # reverse proxies to signal a network read timeout behind the proxy to a client 
    # in front of the proxy.
    { 524, :a_timeout_occured, "A timeout occurred", false },

    # This status code is not specified in any RFCs, but is used by Microsoft HTTP 
    # proxies to signal a network read timeout behind the proxy to a client in front 
    # of the proxy.
    { 598, :network_read_timeout_error, "Network read timeout error", false },

    # This status code is not specified in any RFCs, but is used by Microsoft HTTP 
    # proxies to signal a network connect timeout behind the proxy to a client in 
    # front of the proxy.
    { 599, :network_connect_timeout_error, "Network connect timeout error", false },
  ]

  for { code, atom, reason, skip_int } <- codes do
    defp do_find(unquote(atom)), do: %{code: unquote(code), reason: unquote(reason)}
    unless skip_int do
      defp do_find(unquote(code)), do: %{code: unquote(code), reason: unquote(reason)}
    end
  end
  defp do_find(_), do: %{ code: 200, reason: "OK" }
end