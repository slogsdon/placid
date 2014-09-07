defmodule Placid.Response.StatusCodesTest do
  use ExUnit.Case, async: true
  alias Placid.Response.StatusCode
  alias Placid.Response.StatusCodes

  test "Continue" do
    expected = %StatusCode{code: 100, reason: "Continue"}

    assert StatusCodes.find(:continue) === expected
    assert StatusCodes.find(100) === expected
  end

  test "Switching Protocols" do
    expected = %StatusCode{code: 101, reason: "Switching Protocols"}

    assert StatusCodes.find(:switching_protocols) === expected
    assert StatusCodes.find(101) === expected
  end

  test "Processing" do
    expected = %StatusCode{code: 102, reason: "Processing"}

    assert StatusCodes.find(:processing) === expected
    assert StatusCodes.find(102) === expected
  end

  test "OK" do
    expected = %StatusCode{code: 200, reason: "OK"}

    assert StatusCodes.find(:ok) === expected
    assert StatusCodes.find(200) === expected
  end

  test "Created" do
    expected = %StatusCode{code: 201, reason: "Created"}

    assert StatusCodes.find(:created) === expected
    assert StatusCodes.find(201) === expected
  end

  test "Accepted" do
    expected = %StatusCode{code: 202, reason: "Accepted"}

    assert StatusCodes.find(:accepted) === expected
    assert StatusCodes.find(202) === expected
  end

  test "Non-Authoritative Information" do
    expected = %StatusCode{code: 203, reason: "Non-Authoritative Information"}

    assert StatusCodes.find(:non_authoritative_information) === expected
    assert StatusCodes.find(203) === expected
  end

  test "No Content" do
    expected = %StatusCode{code: 204, reason: "No Content"}

    assert StatusCodes.find(:no_content) === expected
    assert StatusCodes.find(204) === expected
  end

  test "Reset Content" do
    expected = %StatusCode{code: 205, reason: "Reset Content"}

    assert StatusCodes.find(:reset_content) === expected
    assert StatusCodes.find(205) === expected
  end

  test "Partial Content" do
    expected = %StatusCode{code: 206, reason: "Partial Content"}

    assert StatusCodes.find(:partial_content) === expected
    assert StatusCodes.find(206) === expected
  end

  test "Multi-Status" do
    expected = %StatusCode{code: 207, reason: "Multi-Status"}

    assert StatusCodes.find(:multi_status) === expected
    assert StatusCodes.find(207) === expected
  end

  test "Already Reported" do
    expected = %StatusCode{code: 208, reason: "Already Reported"}

    assert StatusCodes.find(:already_reported) === expected
    assert StatusCodes.find(208) === expected
  end

  test "IM Used" do
    expected = %StatusCode{code: 226, reason: "IM Used"}

    assert StatusCodes.find(:im_used) === expected
    assert StatusCodes.find(226) === expected
  end

  test "Multiple Choices" do
    expected = %StatusCode{code: 300, reason: "Multiple Choices"}

    assert StatusCodes.find(:multiple_choices) === expected
    assert StatusCodes.find(300) === expected
  end

  test "Moved Permanently" do
    expected = %StatusCode{code: 301, reason: "Moved Permanently"}

    assert StatusCodes.find(:moved_permanently) === expected
    assert StatusCodes.find(301) === expected
  end

  test "Found" do
    expected = %StatusCode{code: 302, reason: "Found"}

    assert StatusCodes.find(:found) === expected
    assert StatusCodes.find(302) === expected
  end

  test "See Other" do
    expected = %StatusCode{code: 303, reason: "See Other"}

    assert StatusCodes.find(:see_other) === expected
    assert StatusCodes.find(303) === expected
  end

  test "Not Modified" do
    expected = %StatusCode{code: 304, reason: "Not Modified"}

    assert StatusCodes.find(:not_modified) === expected
    assert StatusCodes.find(304) === expected
  end

  test "Use Proxy" do
    expected = %StatusCode{code: 305, reason: "Use Proxy"}

    assert StatusCodes.find(:use_proxy) === expected
    assert StatusCodes.find(305) === expected
  end

  test "Switch Proxy" do
    expected = %StatusCode{code: 306, reason: "Switch Proxy"}

    assert StatusCodes.find(:switch_proxy) === expected
    assert StatusCodes.find(306) === expected
  end

  test "Temporary Redirect" do
    expected = %StatusCode{code: 307, reason: "Temporary Redirect"}

    assert StatusCodes.find(:temporary_redirect) === expected
    assert StatusCodes.find(307) === expected
  end

  test "Permanent Redirect" do
    expected = %StatusCode{code: 308, reason: "Permanent Redirect"}

    assert StatusCodes.find(:permanent_redirect) === expected
    assert StatusCodes.find(308) === expected
  end

  test "Bad Request" do
    expected = %StatusCode{code: 400, reason: "Bad Request"}

    assert StatusCodes.find(:bad_request) === expected
    assert StatusCodes.find(400) === expected
  end

  test "Unauthorized" do
    expected = %StatusCode{code: 401, reason: "Unauthorized"}

    assert StatusCodes.find(:unauthorized) === expected
    assert StatusCodes.find(401) === expected
  end

  test "Payment Required" do
    expected = %StatusCode{code: 402, reason: "Payment Required"}

    assert StatusCodes.find(:payment_required) === expected
    assert StatusCodes.find(402) === expected
  end

  test "Forbidden" do
    expected = %StatusCode{code: 403, reason: "Forbidden"}

    assert StatusCodes.find(:forbidden) === expected
    assert StatusCodes.find(403) === expected
  end

  test "Not Found" do
    expected = %StatusCode{code: 404, reason: "Not Found"}

    assert StatusCodes.find(:not_found) === expected
    assert StatusCodes.find(404) === expected
  end

  test "Method Not Allowed" do
    expected = %StatusCode{code: 405, reason: "Method Not Allowed"}

    assert StatusCodes.find(:method_not_allowed) === expected
    assert StatusCodes.find(405) === expected
  end

  test "Not Acceptable" do
    expected = %StatusCode{code: 406, reason: "Not Acceptable"}

    assert StatusCodes.find(:not_acceptable) === expected
    assert StatusCodes.find(406) === expected
  end

  test "Proxy Authentication Required" do
    expected = %StatusCode{code: 407, reason: "Proxy Authentication Required"}

    assert StatusCodes.find(:proxy_authentication_required) === expected
    assert StatusCodes.find(407) === expected
  end

  test "Request Timeout" do
    expected = %StatusCode{code: 408, reason: "Request Timeout"}

    assert StatusCodes.find(:request_timeout) === expected
    assert StatusCodes.find(408) === expected
  end

  test "Conflict" do
    expected = %StatusCode{code: 409, reason: "Conflict"}

    assert StatusCodes.find(:conflict) === expected
    assert StatusCodes.find(409) === expected
  end

  test "Gone" do
    expected = %StatusCode{code: 410, reason: "Gone"}

    assert StatusCodes.find(:gone) === expected
    assert StatusCodes.find(410) === expected
  end

  test "Length Required" do
    expected = %StatusCode{code: 411, reason: "Length Required"}

    assert StatusCodes.find(:length_required) === expected
    assert StatusCodes.find(411) === expected
  end

  test "Precondition Failed" do
    expected = %StatusCode{code: 412, reason: "Precondition Failed"}

    assert StatusCodes.find(:precondition_failed) === expected
    assert StatusCodes.find(412) === expected
  end

  test "Request Entity Too Large" do
    expected = %StatusCode{code: 413, reason: "Request Entity Too Large"}

    assert StatusCodes.find(:request_entity_too_large) === expected
    assert StatusCodes.find(413) === expected
  end

  test "Request-URI Too Long" do
    expected = %StatusCode{code: 414, reason: "Request-URI Too Long"}

    assert StatusCodes.find(:request_uri_too_long) === expected
    assert StatusCodes.find(414) === expected
  end

  test "Unsupported Media Type" do
    expected = %StatusCode{code: 415, reason: "Unsupported Media Type"}

    assert StatusCodes.find(:unsupported_media_type) === expected
    assert StatusCodes.find(415) === expected
  end

  test "Requested Range Not Satisfiable" do
    expected = %StatusCode{code: 416, reason: "Requested Range Not Satisfiable"}

    assert StatusCodes.find(:requested_range_not_satisfiable) === expected
    assert StatusCodes.find(416) === expected
  end

  test "Expectation Failed" do
    expected = %StatusCode{code: 417, reason: "Expectation Failed"}

    assert StatusCodes.find(:expectation_failed) === expected
    assert StatusCodes.find(417) === expected
  end

  test "I'm a teapot" do
    expected = %StatusCode{code: 418, reason: "I'm a teapot"}

    assert StatusCodes.find(:im_a_teapot) === expected
    assert StatusCodes.find(418) === expected
  end

  test "Authentication Timeout" do
    expected = %StatusCode{code: 419, reason: "Authentication Timeout"}

    assert StatusCodes.find(:authentication_timeout) === expected
    assert StatusCodes.find(419) === expected
  end

  test "Method Failure" do
    expected = %StatusCode{code: 420, reason: "Method Failure"}

    assert StatusCodes.find(:method_failure) === expected
    assert StatusCodes.find(420) === expected
  end

  test "Enhance Your Calm" do
    expected = %StatusCode{code: 420, reason: "Enhance Your Calm"}

    assert StatusCodes.find(:enhance_your_calm) === expected
  end

  test "Unprocessable Entity" do
    expected = %StatusCode{code: 422, reason: "Unprocessable Entity"}

    assert StatusCodes.find(:unprocessable_entity) === expected
    assert StatusCodes.find(422) === expected
  end

  test "Locked" do
    expected = %StatusCode{code: 423, reason: "Locked"}

    assert StatusCodes.find(:locked) === expected
    assert StatusCodes.find(423) === expected
  end

  test "Failed Dependency" do
    expected = %StatusCode{code: 424, reason: "Failed Dependency"}

    assert StatusCodes.find(:failed_dependency) === expected
    assert StatusCodes.find(424) === expected
  end

  test "Upgrade Required" do
    expected = %StatusCode{code: 426, reason: "Upgrade Required"}

    assert StatusCodes.find(:upgrade_required) === expected
    assert StatusCodes.find(426) === expected
  end

  test "Precondition Required" do
    expected = %StatusCode{code: 428, reason: "Precondition Required"}

    assert StatusCodes.find(:precondition_required) === expected
    assert StatusCodes.find(428) === expected
  end

  test "Too Many Requests" do
    expected = %StatusCode{code: 429, reason: "Too Many Requests"}

    assert StatusCodes.find(:too_many_requests) === expected
    assert StatusCodes.find(429) === expected
  end

  test "Request Header Fields Too Large" do
    expected = %StatusCode{code: 431, reason: "Request Header Fields Too Large"}

    assert StatusCodes.find(:request_header_fields_too_large) === expected
    assert StatusCodes.find(431) === expected
  end

  test "Login Timeout" do
    expected = %StatusCode{code: 440, reason: "Login Timeout"}

    assert StatusCodes.find(:login_timeout) === expected
    assert StatusCodes.find(440) === expected
  end

  test "No Response" do
    expected = %StatusCode{code: 444, reason: "No Response"}

    assert StatusCodes.find(:no_response) === expected
    assert StatusCodes.find(444) === expected
  end

  test "Retry With" do
    expected = %StatusCode{code: 449, reason: "Retry With"}

    assert StatusCodes.find(:retry_with) === expected
    assert StatusCodes.find(449) === expected
  end

  test "Blocked by Windows Parental Controls" do
    expected = %StatusCode{code: 450, reason: "Blocked by Windows Parental Controls"}

    assert StatusCodes.find(:blocked_by_windows_parentak_controls) === expected
    assert StatusCodes.find(450) === expected
  end

  test "Unavailable For Legal Reasons" do
    expected = %StatusCode{code: 451, reason: "Unavailable For Legal Reasons"}

    assert StatusCodes.find(:unavailable_for_legal_reasons) === expected
    assert StatusCodes.find(451) === expected
  end

  test "Redirect" do
    expected = %StatusCode{code: 451, reason: "Redirect"}

    assert StatusCodes.find(:redirect) === expected
  end

  test "Request Header Too Large" do
    expected = %StatusCode{code: 494, reason: "Request Header Too Large"}

    assert StatusCodes.find(:request_header_too_large) === expected
    assert StatusCodes.find(494) === expected
  end

  test "Cert Error" do
    expected = %StatusCode{code: 495, reason: "Cert Error"}

    assert StatusCodes.find(:cert_error) === expected
    assert StatusCodes.find(495) === expected
  end

  test "No Cert" do
    expected = %StatusCode{code: 496, reason: "No Cert"}

    assert StatusCodes.find(:no_cert) === expected
    assert StatusCodes.find(496) === expected
  end

  test "HTTP to HTTPS" do
    expected = %StatusCode{code: 497, reason: "HTTP to HTTPS"}

    assert StatusCodes.find(:http_to_https) === expected
    assert StatusCodes.find(497) === expected
  end

  test "Token expired/invalid" do
    expected = %StatusCode{code: 498, reason: "Token expired/invalid"}

    assert StatusCodes.find(:token_invalid) === expected
    assert StatusCodes.find(498) === expected
  end

  test "Client Closed Request" do
    expected = %StatusCode{code: 499, reason: "Client Closed Request"}

    assert StatusCodes.find(:client_closed_request) === expected
    assert StatusCodes.find(499) === expected
  end

  test "Token required" do
    expected = %StatusCode{code: 499, reason: "Token required"}

    assert StatusCodes.find(:token_required) === expected
  end

  test "Internal Server Error" do
    expected = %StatusCode{code: 500, reason: "Internal Server Error"}

    assert StatusCodes.find(:internal_server_error) === expected
    assert StatusCodes.find(500) === expected
  end

  test "Not Implemented" do
    expected = %StatusCode{code: 501, reason: "Not Implemented"}

    assert StatusCodes.find(:not_implemented) === expected
    assert StatusCodes.find(501) === expected
  end

  test "Bad Gateway" do
    expected = %StatusCode{code: 502, reason: "Bad Gateway"}

    assert StatusCodes.find(:bad_gateway) === expected
    assert StatusCodes.find(502) === expected
  end

  test "Service Unavailable" do
    expected = %StatusCode{code: 503, reason: "Service Unavailable"}

    assert StatusCodes.find(:service_unavailable) === expected
    assert StatusCodes.find(503) === expected
  end

  test "Gateway Timeout" do
    expected = %StatusCode{code: 504, reason: "Gateway Timeout"}

    assert StatusCodes.find(:gateway_timeout) === expected
    assert StatusCodes.find(504) === expected
  end

  test "HTTP Version Not Supported" do
    expected = %StatusCode{code: 505, reason: "HTTP Version Not Supported"}

    assert StatusCodes.find(:http_version_not_supported) === expected
    assert StatusCodes.find(505) === expected
  end

  test "Variant Also Negotiates" do
    expected = %StatusCode{code: 506, reason: "Variant Also Negotiates"}

    assert StatusCodes.find(:variant_also_negotiates) === expected
    assert StatusCodes.find(506) === expected
  end

  test "Insufficient Storage" do
    expected = %StatusCode{code: 507, reason: "Insufficient Storage"}

    assert StatusCodes.find(:insufficient_storage) === expected
    assert StatusCodes.find(507) === expected
  end

  test "Loop Detected" do
    expected = %StatusCode{code: 508, reason: "Loop Detected"}

    assert StatusCodes.find(:loop_detected) === expected
    assert StatusCodes.find(508) === expected
  end

  test "Bandwidth Limit Exceeded" do
    expected = %StatusCode{code: 509, reason: "Bandwidth Limit Exceeded"}

    assert StatusCodes.find(:bandwidth_limit_exceeded) === expected
    assert StatusCodes.find(509) === expected
  end

  test "Not Extended" do
    expected = %StatusCode{code: 510, reason: "Not Extended"}

    assert StatusCodes.find(:not_extended) === expected
    assert StatusCodes.find(510) === expected
  end

  test "Network Authentication Required" do
    expected = %StatusCode{code: 511, reason: "Network Authentication Required"}

    assert StatusCodes.find(:network_authentication_required) === expected
    assert StatusCodes.find(511) === expected
  end

  test "Origin Error" do
    expected = %StatusCode{code: 520, reason: "Origin Error"}

    assert StatusCodes.find(:origin_error) === expected
    assert StatusCodes.find(520) === expected
  end

  test "Web server is down" do
    expected = %StatusCode{code: 521, reason: "Web server is down"}

    assert StatusCodes.find(:web_server_is_down) === expected
    assert StatusCodes.find(521) === expected
  end

  test "Connection timed out" do
    expected = %StatusCode{code: 522, reason: "Connection timed out"}

    assert StatusCodes.find(:connection_timed_out) === expected
    assert StatusCodes.find(522) === expected
  end

  test "Proxy Declined Request" do
    expected = %StatusCode{code: 523, reason: "Proxy Declined Request"}

    assert StatusCodes.find(:proxy_declined_request) === expected
    assert StatusCodes.find(523) === expected
  end

  test "A timeout occurred" do
    expected = %StatusCode{code: 524, reason: "A timeout occurred"}

    assert StatusCodes.find(:a_timeout_occured) === expected
    assert StatusCodes.find(524) === expected
  end

  test "Network read timeout error" do
    expected = %StatusCode{code: 598, reason: "Network read timeout error"}

    assert StatusCodes.find(:network_read_timeout_error) === expected
    assert StatusCodes.find(598) === expected
  end

  test "Network connect timeout error" do
    expected = %StatusCode{code: 599, reason: "Network connect timeout error"}

    assert StatusCodes.find(:network_connect_timeout_error) === expected
    assert StatusCodes.find(599) === expected
  end
end