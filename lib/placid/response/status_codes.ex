defmodule Placid.Response.StatusCodes do
  alias Placid.Response.StatusCode

  @doc """
  Translates a given integer or atom into a status code.
  """
  def find(100), do: continue
  def find(:continue), do: continue
  def find(101), do: switching_protocols
  def find(:switching_protocols), do: switching_protocols
  def find(102), do: processing
  def find(:processing), do: processing
  def find(200), do: ok
  def find(:ok), do: ok
  def find(201), do: created
  def find(:created), do: created
  def find(202), do: accepted
  def find(:accepted), do: accepted
  def find(203), do: non_authoritative_information
  def find(:non_authoritative_information), do: non_authoritative_information
  def find(204), do: no_content
  def find(:no_content), do: no_content
  def find(205), do: reset_content
  def find(:reset_content), do: reset_content
  def find(206), do: partial_content
  def find(:partial_content), do: partial_content
  def find(207), do: multi_status
  def find(:multi_status), do: multi_status
  def find(208), do: already_reported
  def find(:already_reported), do: already_reported
  def find(226), do: im_used
  def find(:im_used), do: im_used
  def find(300), do: multiple_choices
  def find(:multiple_choices), do: multiple_choices
  def find(301), do: moved_permanently
  def find(:moved_permanently), do: moved_permanently
  def find(302), do: found
  def find(:found), do: found
  def find(303), do: see_other
  def find(:see_other), do: see_other
  def find(304), do: not_modified
  def find(:not_modified), do: not_modified
  def find(305), do: use_proxy
  def find(:use_proxy), do: use_proxy
  def find(306), do: switch_proxy
  def find(:switch_proxy), do: switch_proxy
  def find(307), do: temporary_redirect
  def find(:temporary_redirect), do: temporary_redirect
  def find(308), do: permanent_redirect
  def find(:permanent_redirect), do: permanent_redirect
  def find(400), do: bad_request
  def find(:bad_request), do: bad_request
  def find(401), do: unauthorized
  def find(:unauthorized), do: unauthorized
  def find(402), do: payment_required
  def find(:payment_required), do: payment_required
  def find(403), do: forbidden
  def find(:forbidden), do: forbidden
  def find(404), do: not_found
  def find(:not_found), do: not_found
  def find(405), do: method_not_allowed
  def find(:method_not_allowed), do: method_not_allowed
  def find(406), do: not_acceptable
  def find(:not_acceptable), do: not_acceptable
  def find(407), do: proxy_authentication_required
  def find(:proxy_authentication_required), do: proxy_authentication_required
  def find(408), do: request_timeout
  def find(:request_timeout), do: request_timeout
  def find(409), do: conflict
  def find(:conflict), do: conflict
  def find(410), do: gone
  def find(:gone), do: gone
  def find(411), do: length_required
  def find(:length_required), do: length_required
  def find(412), do: precondition_failed
  def find(:precondition_failed), do: precondition_failed
  def find(413), do: request_entity_too_large
  def find(:request_entity_too_large), do: request_entity_too_large
  def find(414), do: request_uri_too_long
  def find(:request_uri_too_long), do: request_uri_too_long
  def find(415), do: unsupported_media_type
  def find(:unsupported_media_type), do: unsupported_media_type
  def find(416), do: requested_range_not_satisfiable
  def find(:requested_range_not_satisfiable), do: requested_range_not_satisfiable
  def find(417), do: expectation_failed
  def find(:expectation_failed), do: expectation_failed
  def find(418), do: im_a_teapot
  def find(:im_a_teapot), do: im_a_teapot
  def find(419), do: authentication_timeout
  def find(:authentication_timeout), do: authentication_timeout
  def find(420), do: method_failure
  def find(:method_failure), do: method_failure
  def find(:enhance_your_calm), do: enhance_your_calm
  def find(422), do: unprocessable_entity
  def find(:unprocessable_entity), do: unprocessable_entity
  def find(423), do: locked
  def find(:locked), do: locked
  def find(424), do: failed_dependency
  def find(:failed_dependency), do: failed_dependency
  def find(426), do: upgrade_required
  def find(:upgrade_required), do: upgrade_required
  def find(428), do: precondition_required
  def find(:precondition_required), do: precondition_required
  def find(429), do: too_many_requests
  def find(:too_many_requests), do: too_many_requests
  def find(431), do: request_header_fields_too_large
  def find(:request_header_fields_too_large), do: request_header_fields_too_large
  def find(440), do: login_timeout
  def find(:login_timeout), do: login_timeout
  def find(444), do: no_response
  def find(:no_response), do: no_response
  def find(449), do: retry_with
  def find(:retry_with), do: retry_with
  def find(450), do: blocked_by_windows_parentak_controls
  def find(:blocked_by_windows_parentak_controls), do: blocked_by_windows_parentak_controls
  def find(451), do: unavailable_for_legal_reasons
  def find(:unavailable_for_legal_reasons), do: unavailable_for_legal_reasons
  def find(:redirect), do: redirect
  def find(494), do: request_header_too_large
  def find(:request_header_too_large), do: request_header_too_large
  def find(495), do: cert_error
  def find(:cert_error), do: cert_error
  def find(496), do: no_cert
  def find(:no_cert), do: no_cert
  def find(497), do: http_to_https
  def find(:http_to_https), do: http_to_https
  def find(498), do: token_invalid
  def find(:token_invalid), do: token_invalid
  def find(499), do: client_closed_request
  def find(:client_closed_request), do: client_closed_request
  def find(:token_required), do: token_required
  def find(500), do: internal_server_error
  def find(:internal_server_error), do: internal_server_error
  def find(501), do: not_implemented
  def find(:not_implemented), do: not_implemented
  def find(502), do: bad_gateway
  def find(:bad_gateway), do: bad_gateway
  def find(503), do: service_unavailable
  def find(:service_unavailable), do: service_unavailable
  def find(504), do: gateway_timeout
  def find(:gateway_timeout), do: gateway_timeout
  def find(505), do: http_version_not_supported
  def find(:http_version_not_supported), do: http_version_not_supported
  def find(506), do: variant_also_negotiates
  def find(:variant_also_negotiates), do: variant_also_negotiates
  def find(507), do: insufficient_storage
  def find(:insufficient_storage), do: insufficient_storage
  def find(508), do: loop_detected
  def find(:loop_detected), do: loop_detected
  def find(509), do: bandwidth_limit_exceeded
  def find(:bandwidth_limit_exceeded), do: bandwidth_limit_exceeded
  def find(510), do: not_extended
  def find(:not_extended), do: not_extended
  def find(511), do: network_authentication_required
  def find(:network_authentication_required), do: network_authentication_required
  def find(520), do: origin_error
  def find(:origin_error), do: origin_error
  def find(521), do: web_server_is_down
  def find(:web_server_is_down), do: web_server_is_down
  def find(522), do: connection_timed_out
  def find(:connection_timed_out), do: connection_timed_out
  def find(523), do: proxy_declined_request
  def find(:proxy_declined_request), do: proxy_declined_request
  def find(524), do: a_timeout_occured
  def find(:a_timeout_occured), do: a_timeout_occured
  def find(598), do: network_read_timeout_error
  def find(:network_read_timeout_error), do: network_read_timeout_error
  def find(599), do: network_connect_timeout_error
  def find(:network_connect_timeout_error), do: network_connect_timeout_error
  def find(_), do: ok

  @doc """
  This means that the server has received the request headers, and that the 
  client should proceed to send the request body (in the case of a request for 
  which a body needs to be sent; for example, a POST request). If the request 
  body is large, sending it to a server when a request has already been rejected 
  based upon inappropriate headers is inefficient. To have a server check if the 
  request could be accepted based on the request's headers alone, a client must 
  send Expect: 100-continue as a header in its initial request and check if a 
  100 Continue status code is received in response before continuing (or receive 
  417 Expectation Failed and not continue).
  """
  def continue do
    %StatusCode{code: 100, reason: "Continue"}
  end

  @doc """
  This means the requester has asked the server to switch protocols and the 
  server is acknowledging that it will do so.
  """
  def switching_protocols do
    %StatusCode{code: 101, reason: "Switching Protocols"}
  end

  @doc """
  As a WebDAV request may contain many sub-requests involving file operations, 
  it may take a long time to complete the request. This code indicates that the 
  server has received and is processing the request, but no response is 
  available yet. This prevents the client from timing out and assuming the 
  request was lost.
  """
  def processing do
    %StatusCode{code: 102, reason: "Processing"}
  end

  @doc """
  Standard response for successful HTTP requests. The actual response will 
  depend on the request method used. In a GET request, the response will contain 
  an entity corresponding to the requested resource. In a POST request the 
  response will contain an entity describing or containing the result of the 
  action.
  """
  def ok do
    %StatusCode{code: 200, reason: "OK"}
  end

  @doc """
  The request has been fulfilled and resulted in a new resource being created.
  """
  def created do
    %StatusCode{code: 201, reason: "Created"}
  end

  @doc """
  The request has been accepted for processing, but the processing has not been 
  completed. The request might or might not eventually be acted upon, as it 
  might be disallowed when processing actually takes place.
  """
  def accepted do
    %StatusCode{code: 202, reason: "Accepted"}
  end

  @doc """
  The server successfully processed the request, but is returning information 
  that may be from another source.
  """
  def non_authoritative_information do
    %StatusCode{code: 203, reason: "Non-Authoritative Information"}
  end

  @doc """
  The server successfully processed the request, but is not returning any 
  content. Usually used as a response to a successful delete request.
  """
  def no_content do
    %StatusCode{code: 204, reason: "No Content"}
  end

  @doc """
  The server successfully processed the request, but is not returning any 
  content. Unlike a 204 response, this response requires that the requester 
  reset the document view.
  """
  def reset_content do
    %StatusCode{code: 205, reason: "Reset Content"}
  end

  @doc """
  The server is delivering only part of the resource (byte serving) due to a 
  range header sent by the client. The range header is used by tools like wget 
  to enable resuming of interrupted downloads, or split a download into multiple 
  simultaneous streams.
  """
  def partial_content do
    %StatusCode{code: 206, reason: "Partial Content"}
  end

  @doc """
  The message body that follows is an XML message and can contain a number of 
  separate response codes, depending on how many sub-requests were made.
  """
  def multi_status do
    %StatusCode{code: 207, reason: "Multi-Status"}
  end

  @doc """
  The members of a DAV binding have already been enumerated in a previous reply 
  to this request, and are not being included again.
  """
  def already_reported do
    %StatusCode{code: 208, reason: "Already Reported"}
  end

  @doc """
  The server has fulfilled a GET request for the resource, and the response is a 
  representation of the result of one or more instance-manipulations applied to 
  the current instance.
  """
  def im_used do
    %StatusCode{code: 226, reason: "IM Used"}
  end

  @doc """
  Indicates multiple options for the resource that the client may follow. It, 
  for instance, could be used to present different format options for video, 
  list files with different extensions, or word sense disambiguation.
  """
  def multiple_choices do
    %StatusCode{code: 300, reason: "Multiple Choices"}
  end

  @doc """
  This and all future requests should be directed to the given URI.
  """
  def moved_permanently do
    %StatusCode{code: 301, reason: "Moved Permanently"}
  end

  @doc """
  This is an example of industry practice contradicting the standard. The 
  HTTP/1.0 specification (RFC 1945) required the client to perform a temporary 
  redirect (the original describing phrase was "Moved Temporarily"), but popular 
  browsers implemented 302 with the functionality of a 303 See Other. Therefore, 
  HTTP/1.1 added status codes 303 and 307 to distinguish between the two 
  behaviours. However, some Web applications and frameworks use the 302 status 
  code as if it were the 303.
  """
  def found do
    %StatusCode{code: 302, reason: "Found"}
  end

  @doc """
  The response to the request can be found under another URI using a GET method. 
  When received in response to a POST (or PUT/DELETE), it should be assumed that 
  the server has received the data and the redirect should be issued with a 
  separate GET message.
  """
  def see_other do
    %StatusCode{code: 303, reason: "See Other"}
  end

  @doc """
  Indicates that the resource has not been modified since the version specified 
  by the request headers If-Modified-Since or If-Match. This means that there is 
  no need to retransmit the resource, since the client still has a 
  previously-downloaded copy.
  """
  def not_modified do
    %StatusCode{code: 304, reason: "Not Modified"}
  end

  @doc """
  The requested resource is only available through a proxy, whose address is 
  provided in the response. Many HTTP clients (such as Mozilla and Internet 
  Explorer) do not correctly handle responses with this status code, primarily 
  for security reasons.
  """
  def use_proxy do
    %StatusCode{code: 305, reason: "Use Proxy"}
  end

  @doc """
  No longer used. Originally meant "Subsequent requests should use the specified 
  proxy."
  """
  def switch_proxy do
    %StatusCode{code: 306, reason: "Switch Proxy"}
  end

  @doc """
  In this case, the request should be repeated with another URI; however, future 
  requests should still use the original URI. In contrast to how 302 was 
  historically implemented, the request method is not allowed to be changed when 
  reissuing the original request. For instance, a POST request should be 
  repeated using another POST request.
  """
  def temporary_redirect do
    %StatusCode{code: 307, reason: "Temporary Redirect"}
  end

  @doc """
  The request, and all future requests should be repeated using another URI. 307 
  and 308 (as proposed) parallel the behaviours of 302 and 301, but do not allow 
  the HTTP method to change. So, for example, submitting a form to a permanently 
  redirected resource may continue smoothly.
  """
  def permanent_redirect do
    %StatusCode{code: 308, reason: "Permanent Redirect"}
  end

  @doc """
  The request cannot be fulfilled due to bad syntax.
  """
  def bad_request do
    %StatusCode{code: 400, reason: "Bad Request"}
  end

  @doc """
  Similar to 403 Forbidden, but specifically for use when authentication is 
  required and has failed or has not yet been provided. The response must 
  include a WWW-Authenticate header field containing a challenge applicable to 
  the requested resource. See Basic access authentication and Digest access 
  authentication.
  """
  def unauthorized do
    %StatusCode{code: 401, reason: "Unauthorized"}
  end

  @doc """
  Reserved for future use. The original intention was that this code might be 
  used as part of some form of digital cash or micropayment scheme, but that has 
  not happened, and this code is not usually used. YouTube uses this status if a 
  particular IP address has made excessive requests, and requires the person to 
  enter a CAPTCHA.
  """
  def payment_required do
    %StatusCode{code: 402, reason: "Payment Required"}
  end

  @doc """
  The request was a valid request, but the server is refusing to respond to it. 
  Unlike a 401 Unauthorized response, authenticating will make no difference.
  """
  def forbidden do
    %StatusCode{code: 403, reason: "Forbidden"}
  end

  @doc """
  The requested resource could not be found but may be available again in the 
  future. Subsequent requests by the client are permissible.
  """
  def not_found do
    %StatusCode{code: 404, reason: "Not Found"}
  end

  @doc """
  A request was made of a resource using a request method not supported by that 
  resource; for example, using GET on a form which requires data to be presented 
  via POST, or using PUT on a read-only resource.
  """
  def method_not_allowed do
    %StatusCode{code: 405, reason: "Method Not Allowed"}
  end

  @doc """
  The requested resource is only capable of generating content not acceptable 
  according to the Accept headers sent in the request.
  """
  def not_acceptable do
    %StatusCode{code: 406, reason: "Not Acceptable"}
  end

  @doc """
  The client must first authenticate itself with the proxy.
  """
  def proxy_authentication_required do
    %StatusCode{code: 407, reason: "Proxy Authentication Required"}
  end

  @doc """
  The server timed out waiting for the request. According to HTTP 
  specifications: "The client did not produce a request within the time that the 
  server was prepared to wait. The client MAY repeat the request without 
  modifications at any later time."
  """
  def request_timeout do
    %StatusCode{code: 408, reason: "Request Timeout"}
  end

  @doc """
  Indicates that the request could not be processed because of conflict in the 
  request, such as an edit conflict in the case of multiple updates.
  """
  def conflict do
    %StatusCode{code: 409, reason: "Conflict"}
  end

  @doc """
  Indicates that the resource requested is no longer available and will not be 
  available again. This should be used when a resource has been intentionally 
  removed and the resource should be purged. Upon receiving a 410 status code, 
  the client should not request the resource again in the future. Clients such 
  as search engines should remove the resource from their indices.  Most use 
  cases do not require clients and search engines to purge the resource, and a 
  "404 Not Found" may be used instead.
  """
  def gone do
    %StatusCode{code: 410, reason: "Gone"}
  end

  @doc """
  The request did not specify the length of its content, which is required by 
  the requested resource.
  """
  def length_required do
    %StatusCode{code: 411, reason: "Length Required"}
  end

  @doc """
  The server does not meet one of the preconditions that the requester put on 
  the request.
  """
  def precondition_failed do
    %StatusCode{code: 412, reason: "Precondition Failed"}
  end

  @doc """
  The request is larger than the server is willing or able to process.
  """
  def request_entity_too_large do
    %StatusCode{code: 413, reason: "Request Entity Too Large"}
  end

  @doc """
  The URI provided was too long for the server to process. Often the result of 
  too much data being encoded as a query-string of a GET request, in which case 
  it should be converted to a POST request.
  """
  def request_uri_too_long do
    %StatusCode{code: 414, reason: "Request-URI Too Long"}
  end

  @doc """
  The request entity has a media type which the server or resource does not 
  support. For example, the client uploads an image as image/svg+xml, but the 
  server requires that images use a different format.
  """
  def unsupported_media_type do
    %StatusCode{code: 415, reason: "Unsupported Media Type"}
  end

  @doc """
  The client has asked for a portion of the file (byte serving), but the server 
  cannot supply that portion. For example, if the client asked for a part of the 
  file that lies beyond the end of the file.
  """
  def requested_range_not_satisfiable do
    %StatusCode{code: 416, reason: "Requested Range Not Satisfiable"}
  end

  @doc """
  The server cannot meet the requirements of the Expect request-header field.
  """
  def expectation_failed do
    %StatusCode{code: 417, reason: "Expectation Failed"}
  end

  @doc """
  This code was defined in 1998 as one of the traditional IETF April Fools' 
  jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not 
  expected to be implemented by actual HTTP servers.
  """
  def im_a_teapot do
    %StatusCode{code: 418, reason: "I'm a teapot"}
  end

  @doc """
  Not a part of the HTTP standard, 419 Authentication Timeout denotes that 
  previously valid authentication has expired. It is used as an alternative to 
  401 Unauthorized in order to differentiate from otherwise authenticated 
  clients being denied access to specific server resources.
  """
  def authentication_timeout do
    %StatusCode{code: 419, reason: "Authentication Timeout"}
  end

  @doc """
  Not part of the HTTP standard, but defined by Spring in the HttpStatus class 
  to be used when a method failed. This status code is deprecated by Spring.
  """
  def method_failure do
    %StatusCode{code: 420, reason: "Method Failure"}
  end

  @doc """
  Not part of the HTTP standard, but returned by version 1 of the Twitter Search 
  and Trends API when the client is being rate limited. Other services may wish 
  to implement the 429 Too Many Requests response code instead.
  """
  def enhance_your_calm do
    %StatusCode{code: 420, reason: "Enhance Your Calm"}
  end

  @doc """
  The request was well-formed but was unable to be followed due to semantic 
  errors.
  """
  def unprocessable_entity do
    %StatusCode{code: 422, reason: "Unprocessable Entity"}
  end

  @doc """
  The resource that is being accessed is locked.
  """
  def locked do
    %StatusCode{code: 423, reason: "Locked"}
  end

  @doc """
  The request failed due to failure of a previous request (e.g., a PROPPATCH).
  """
  def failed_dependency do
    %StatusCode{code: 424, reason: "Failed Dependency"}
  end

  @doc """
  The client should switch to a different protocol such as TLS/1.0.
  """
  def upgrade_required do
    %StatusCode{code: 426, reason: "Upgrade Required"}
  end

  @doc """
  The origin server requires the request to be conditional. Intended to prevent 
  "the 'lost update' problem, where a client GETs a resource's state, modifies 
  it, and PUTs it back to the server, when meanwhile a third party has modified 
  the state on the server, leading to a conflict."
  """
  def precondition_required do
    %StatusCode{code: 428, reason: "Precondition Required"}
  end

  @doc """
  The user has sent too many requests in a given amount of time. Intended for 
  use with rate limiting schemes.
  """
  def too_many_requests do
    %StatusCode{code: 429, reason: "Too Many Requests"}
  end

  @doc """
  The server is unwilling to process the request because either an individual 
  header field, or all the header fields collectively, are too large.
  """
  def request_header_fields_too_large do
    %StatusCode{code: 431, reason: "Request Header Fields Too Large"}
  end

  @doc """
  A Microsoft extension. Indicates that your session has expired.
  """
  def login_timeout do
    %StatusCode{code: 440, reason: "Login Timeout"}
  end

  @doc """
  Used in Nginx logs to indicate that the server has returned no information to 
  the client and closed the connection (useful as a deterrent for malware).
  """
  def no_response do
    %StatusCode{code: 444, reason: "No Response"}
  end

  @doc """
  A Microsoft extension. The request should be retried after performing the 
  appropriate action. Often search-engines or custom applications will ignore 
  required parameters. Where no default action is appropriate, the Aviongoo 
  website sends a "HTTP/1.1 449 Retry with valid parameters: param1, param2, 
  ..." response. The applications may choose to learn, or not.
  """  
  def retry_with do
    %StatusCode{code: 449, reason: "Retry With"}
  end

  @doc """
  A Microsoft extension. This error is given when Windows Parental Controls are 
  turned on and are blocking access to the given webpage.
  """
  def blocked_by_windows_parentak_controls do
    %StatusCode{code: 450, reason: "Blocked by Windows Parental Controls"}
  end

  @doc """
  Defined in the internet draft "A New HTTP Status Code for Legally-restricted 
  Resources". Intended to be used when resource access is denied for legal 
  reasons, e.g. censorship or government-mandated blocked access. A reference to 
  the 1953 dystopian novel Fahrenheit 451, where books are outlawed.
  """
  def unavailable_for_legal_reasons do
    %StatusCode{code: 451, reason: "Unavailable For Legal Reasons"}
  end

  @doc """
  Used in Exchange ActiveSync if there either is a more efficient server to use 
  or the server cannot access the users' mailbox. The client is supposed to 
  re-run the HTTP Autodiscovery protocol to find a better suited server.
  """
  def redirect do
    %StatusCode{code: 451, reason: "Redirect"}
  end

  @doc """
  Nginx internal code similar to 431 but it was introduced earlier in version 
  0.9.4 (on January 21, 2011).ginal research?]
  """
  def request_header_too_large do
    %StatusCode{code: 494, reason: "Request Header Too Large"}
  end

  @doc """
  Nginx internal code used when SSL client certificate error occurred to 
  distinguish it from 4XX in a log and an error page redirection.
  """
  def cert_error do
    %StatusCode{code: 495, reason: "Cert Error"}
  end

  @doc """
  Nginx internal code used when client didn't provide certificate to distinguish 
  it from 4XX in a log and an error page redirection.
  """
  def no_cert do
    %StatusCode{code: 496, reason: "No Cert"}
  end

  @doc """
  Nginx internal code used for the plain HTTP requests that are sent to HTTPS 
  port to distinguish it from 4XX in a log and an error page redirection.
  """
  def http_to_https do
    %StatusCode{code: 497, reason: "HTTP to HTTPS"}
  end

  @doc """
  Returned by ArcGIS for Server. A code of 498 indicates an expired or otherwise 
  invalid token.
  """
  def token_invalid do
    %StatusCode{code: 498, reason: "Token expired/invalid"}
  end

  @doc """
  Used in Nginx logs to indicate when the connection has been closed by client 
  while the server is still processing its request, making server unable to send 
  a status code back.
  """
  def client_closed_request do
    %StatusCode{code: 499, reason: "Client Closed Request"}
  end

  @doc """
  Returned by ArcGIS for Server. A code of 499 indicates that a token is 
  required (if no token was submitted).
  """
  def token_required do
    %StatusCode{code: 499, reason: "Token required"}
  end

  @doc """
  A generic error message, given when an unexpected condition was encountered 
  and no more specific message is suitable.
  """
  def internal_server_error do
    %StatusCode{code: 500, reason: "Internal Server Error"}
  end

  @doc """
  The server either does not recognize the request method, or it lacks the 
  ability to fulfil the request. Usually this implies future availability (e.g., 
  a new feature of a web-service API).
  """
  def not_implemented do
    %StatusCode{code: 501, reason: "Not Implemented"}
  end

  @doc """
  The server was acting as a gateway or proxy and received an invalid response 
  from the upstream server.
  """
  def bad_gateway do
    %StatusCode{code: 502, reason: "Bad Gateway"}
  end

  @doc """
  The server is currently unavailable (because it is overloaded or down for 
  maintenance). Generally, this is a temporary state.
  """
  def service_unavailable do
    %StatusCode{code: 503, reason: "Service Unavailable"}
  end

  @doc """
  The server was acting as a gateway or proxy and did not receive a timely 
  response from the upstream server.
  """
  def gateway_timeout do
    %StatusCode{code: 504, reason: "Gateway Timeout"}
  end

  @doc """
  The server does not support the HTTP protocol version used in the request.
  """
  def http_version_not_supported do
    %StatusCode{code: 505, reason: "HTTP Version Not Supported"}
  end

  @doc """
  Transparent content negotiation for the request results in a circular 
  reference.
  """
  def variant_also_negotiates do
    %StatusCode{code: 506, reason: "Variant Also Negotiates"}
  end

  @doc """
  The server is unable to store the representation needed to complete the 
  request.
  """
  def insufficient_storage do
    %StatusCode{code: 507, reason: "Insufficient Storage"}
  end

  @doc """
  The server detected an infinite loop while processing the request (sent in 
  lieu of 208 Already Reported).
  """
  def loop_detected do
    %StatusCode{code: 508, reason: "Loop Detected"}
  end

  @doc """
  This status code is not specified in any RFCs. Its use is unknown.
  """
  def bandwidth_limit_exceeded do
    %StatusCode{code: 509, reason: "Bandwidth Limit Exceeded"}
  end

  @doc """
  Further extensions to the request are required for the server to fulfil it.
  """
  def not_extended do
    %StatusCode{code: 510, reason: "Not Extended"}
  end

  @doc """
  The client needs to authenticate to gain network access. Intended for use by 
  intercepting proxies used to control access to the network (e.g., "captive 
  portals" used to require agreement to Terms of Service before granting full 
  Internet access via a Wi-Fi hotspot).
  """
  def network_authentication_required do
    %StatusCode{code: 511, reason: "Network Authentication Required"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by CloudFlare's 
  reverse proxies to signal an "unknown connection issue between CloudFlare and 
  the origin web server" to a client in front of the proxy.
  """
  def origin_error do
    %StatusCode{code: 520, reason: "Origin Error"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by CloudFlare's 
  reverse proxies to indicate that the origin webserver refused the connection.
  """
  def web_server_is_down do
    %StatusCode{code: 521, reason: "Web server is down"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by CloudFlare's 
  reverse proxies to signal that a server connection timed out.
  """
  def connection_timed_out do
    %StatusCode{code: 522, reason: "Connection timed out"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by CloudFlare's 
  reverse proxies to signal a resource that has been blocked by the 
  administrator of the website or proxy itself.
  """
  def proxy_declined_request do
    %StatusCode{code: 523, reason: "Proxy Declined Request"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by CloudFlare's 
  reverse proxies to signal a network read timeout behind the proxy to a client 
  in front of the proxy.
  """
  def a_timeout_occured do
    %StatusCode{code: 524, reason: "A timeout occurred"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by Microsoft HTTP 
  proxies to signal a network read timeout behind the proxy to a client in front 
  of the proxy.
  """
  def network_read_timeout_error do
    %StatusCode{code: 598, reason: "Network read timeout error"}
  end

  @doc """
  This status code is not specified in any RFCs, but is used by Microsoft HTTP 
  proxies to signal a network connect timeout behind the proxy to a client in 
  front of the proxy.
  """
  def network_connect_timeout_error do
    %StatusCode{code: 599, reason: "Network connect timeout error"}
  end
end