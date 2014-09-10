defmodule Placid.Response.StatusCodeTest do
  use ExUnit.Case, async: true
  alias Placid.Response.StatusCode

  test "Continue" do
    expected = %StatusCode{code: 100, reason: "Continue"}

    assert StatusCode.find(:continue) === expected
    assert StatusCode.find(100) === expected
  end

  test "Switching Protocols" do
    expected = %StatusCode{code: 101, reason: "Switching Protocols"}

    assert StatusCode.find(:switching_protocols) === expected
    assert StatusCode.find(101) === expected
  end

  test "Processing" do
    expected = %StatusCode{code: 102, reason: "Processing"}

    assert StatusCode.find(:processing) === expected
    assert StatusCode.find(102) === expected
  end

  test "OK" do
    expected = %StatusCode{code: 200, reason: "OK"}

    assert StatusCode.find(:ok) === expected
    assert StatusCode.find(200) === expected
  end

  test "Created" do
    expected = %StatusCode{code: 201, reason: "Created"}

    assert StatusCode.find(:created) === expected
    assert StatusCode.find(201) === expected
  end

  test "Accepted" do
    expected = %StatusCode{code: 202, reason: "Accepted"}

    assert StatusCode.find(:accepted) === expected
    assert StatusCode.find(202) === expected
  end

  test "Non-Authoritative Information" do
    expected = %StatusCode{code: 203, reason: "Non-Authoritative Information"}

    assert StatusCode.find(:non_authoritative_information) === expected
    assert StatusCode.find(203) === expected
  end

  test "No Content" do
    expected = %StatusCode{code: 204, reason: "No Content"}

    assert StatusCode.find(:no_content) === expected
    assert StatusCode.find(204) === expected
  end

  test "Reset Content" do
    expected = %StatusCode{code: 205, reason: "Reset Content"}

    assert StatusCode.find(:reset_content) === expected
    assert StatusCode.find(205) === expected
  end

  test "Partial Content" do
    expected = %StatusCode{code: 206, reason: "Partial Content"}

    assert StatusCode.find(:partial_content) === expected
    assert StatusCode.find(206) === expected
  end

  test "Multi-Status" do
    expected = %StatusCode{code: 207, reason: "Multi-Status"}

    assert StatusCode.find(:multi_status) === expected
    assert StatusCode.find(207) === expected
  end

  test "Already Reported" do
    expected = %StatusCode{code: 208, reason: "Already Reported"}

    assert StatusCode.find(:already_reported) === expected
    assert StatusCode.find(208) === expected
  end

  test "IM Used" do
    expected = %StatusCode{code: 226, reason: "IM Used"}

    assert StatusCode.find(:im_used) === expected
    assert StatusCode.find(226) === expected
  end

  test "Multiple Choices" do
    expected = %StatusCode{code: 300, reason: "Multiple Choices"}

    assert StatusCode.find(:multiple_choices) === expected
    assert StatusCode.find(300) === expected
  end

  test "Moved Permanently" do
    expected = %StatusCode{code: 301, reason: "Moved Permanently"}

    assert StatusCode.find(:moved_permanently) === expected
    assert StatusCode.find(301) === expected
  end

  test "Found" do
    expected = %StatusCode{code: 302, reason: "Found"}

    assert StatusCode.find(:found) === expected
    assert StatusCode.find(302) === expected
  end

  test "See Other" do
    expected = %StatusCode{code: 303, reason: "See Other"}

    assert StatusCode.find(:see_other) === expected
    assert StatusCode.find(303) === expected
  end

  test "Not Modified" do
    expected = %StatusCode{code: 304, reason: "Not Modified"}

    assert StatusCode.find(:not_modified) === expected
    assert StatusCode.find(304) === expected
  end

  test "Use Proxy" do
    expected = %StatusCode{code: 305, reason: "Use Proxy"}

    assert StatusCode.find(:use_proxy) === expected
    assert StatusCode.find(305) === expected
  end

  test "Switch Proxy" do
    expected = %StatusCode{code: 306, reason: "Switch Proxy"}

    assert StatusCode.find(:switch_proxy) === expected
    assert StatusCode.find(306) === expected
  end

  test "Temporary Redirect" do
    expected = %StatusCode{code: 307, reason: "Temporary Redirect"}

    assert StatusCode.find(:temporary_redirect) === expected
    assert StatusCode.find(307) === expected
  end

  test "Permanent Redirect" do
    expected = %StatusCode{code: 308, reason: "Permanent Redirect"}

    assert StatusCode.find(:permanent_redirect) === expected
    assert StatusCode.find(308) === expected
  end

  test "Bad Request" do
    expected = %StatusCode{code: 400, reason: "Bad Request"}

    assert StatusCode.find(:bad_request) === expected
    assert StatusCode.find(400) === expected
  end

  test "Unauthorized" do
    expected = %StatusCode{code: 401, reason: "Unauthorized"}

    assert StatusCode.find(:unauthorized) === expected
    assert StatusCode.find(401) === expected
  end

  test "Payment Required" do
    expected = %StatusCode{code: 402, reason: "Payment Required"}

    assert StatusCode.find(:payment_required) === expected
    assert StatusCode.find(402) === expected
  end

  test "Forbidden" do
    expected = %StatusCode{code: 403, reason: "Forbidden"}

    assert StatusCode.find(:forbidden) === expected
    assert StatusCode.find(403) === expected
  end

  test "Not Found" do
    expected = %StatusCode{code: 404, reason: "Not Found"}

    assert StatusCode.find(:not_found) === expected
    assert StatusCode.find(404) === expected
  end

  test "Method Not Allowed" do
    expected = %StatusCode{code: 405, reason: "Method Not Allowed"}

    assert StatusCode.find(:method_not_allowed) === expected
    assert StatusCode.find(405) === expected
  end

  test "Not Acceptable" do
    expected = %StatusCode{code: 406, reason: "Not Acceptable"}

    assert StatusCode.find(:not_acceptable) === expected
    assert StatusCode.find(406) === expected
  end

  test "Proxy Authentication Required" do
    expected = %StatusCode{code: 407, reason: "Proxy Authentication Required"}

    assert StatusCode.find(:proxy_authentication_required) === expected
    assert StatusCode.find(407) === expected
  end

  test "Request Timeout" do
    expected = %StatusCode{code: 408, reason: "Request Timeout"}

    assert StatusCode.find(:request_timeout) === expected
    assert StatusCode.find(408) === expected
  end

  test "Conflict" do
    expected = %StatusCode{code: 409, reason: "Conflict"}

    assert StatusCode.find(:conflict) === expected
    assert StatusCode.find(409) === expected
  end

  test "Gone" do
    expected = %StatusCode{code: 410, reason: "Gone"}

    assert StatusCode.find(:gone) === expected
    assert StatusCode.find(410) === expected
  end

  test "Length Required" do
    expected = %StatusCode{code: 411, reason: "Length Required"}

    assert StatusCode.find(:length_required) === expected
    assert StatusCode.find(411) === expected
  end

  test "Precondition Failed" do
    expected = %StatusCode{code: 412, reason: "Precondition Failed"}

    assert StatusCode.find(:precondition_failed) === expected
    assert StatusCode.find(412) === expected
  end

  test "Request Entity Too Large" do
    expected = %StatusCode{code: 413, reason: "Request Entity Too Large"}

    assert StatusCode.find(:request_entity_too_large) === expected
    assert StatusCode.find(413) === expected
  end

  test "Request-URI Too Long" do
    expected = %StatusCode{code: 414, reason: "Request-URI Too Long"}

    assert StatusCode.find(:request_uri_too_long) === expected
    assert StatusCode.find(414) === expected
  end

  test "Unsupported Media Type" do
    expected = %StatusCode{code: 415, reason: "Unsupported Media Type"}

    assert StatusCode.find(:unsupported_media_type) === expected
    assert StatusCode.find(415) === expected
  end

  test "Requested Range Not Satisfiable" do
    expected = %StatusCode{code: 416, reason: "Requested Range Not Satisfiable"}

    assert StatusCode.find(:requested_range_not_satisfiable) === expected
    assert StatusCode.find(416) === expected
  end

  test "Expectation Failed" do
    expected = %StatusCode{code: 417, reason: "Expectation Failed"}

    assert StatusCode.find(:expectation_failed) === expected
    assert StatusCode.find(417) === expected
  end

  test "I'm a teapot" do
    expected = %StatusCode{code: 418, reason: "I'm a teapot"}

    assert StatusCode.find(:im_a_teapot) === expected
    assert StatusCode.find(418) === expected
  end

  test "Authentication Timeout" do
    expected = %StatusCode{code: 419, reason: "Authentication Timeout"}

    assert StatusCode.find(:authentication_timeout) === expected
    assert StatusCode.find(419) === expected
  end

  test "Method Failure" do
    expected = %StatusCode{code: 420, reason: "Method Failure"}

    assert StatusCode.find(:method_failure) === expected
    assert StatusCode.find(420) === expected
  end

  test "Enhance Your Calm" do
    expected = %StatusCode{code: 420, reason: "Enhance Your Calm"}

    assert StatusCode.find(:enhance_your_calm) === expected
  end

  test "Unprocessable Entity" do
    expected = %StatusCode{code: 422, reason: "Unprocessable Entity"}

    assert StatusCode.find(:unprocessable_entity) === expected
    assert StatusCode.find(422) === expected
  end

  test "Locked" do
    expected = %StatusCode{code: 423, reason: "Locked"}

    assert StatusCode.find(:locked) === expected
    assert StatusCode.find(423) === expected
  end

  test "Failed Dependency" do
    expected = %StatusCode{code: 424, reason: "Failed Dependency"}

    assert StatusCode.find(:failed_dependency) === expected
    assert StatusCode.find(424) === expected
  end

  test "Upgrade Required" do
    expected = %StatusCode{code: 426, reason: "Upgrade Required"}

    assert StatusCode.find(:upgrade_required) === expected
    assert StatusCode.find(426) === expected
  end

  test "Precondition Required" do
    expected = %StatusCode{code: 428, reason: "Precondition Required"}

    assert StatusCode.find(:precondition_required) === expected
    assert StatusCode.find(428) === expected
  end

  test "Too Many Requests" do
    expected = %StatusCode{code: 429, reason: "Too Many Requests"}

    assert StatusCode.find(:too_many_requests) === expected
    assert StatusCode.find(429) === expected
  end

  test "Request Header Fields Too Large" do
    expected = %StatusCode{code: 431, reason: "Request Header Fields Too Large"}

    assert StatusCode.find(:request_header_fields_too_large) === expected
    assert StatusCode.find(431) === expected
  end

  test "Login Timeout" do
    expected = %StatusCode{code: 440, reason: "Login Timeout"}

    assert StatusCode.find(:login_timeout) === expected
    assert StatusCode.find(440) === expected
  end

  test "No Response" do
    expected = %StatusCode{code: 444, reason: "No Response"}

    assert StatusCode.find(:no_response) === expected
    assert StatusCode.find(444) === expected
  end

  test "Retry With" do
    expected = %StatusCode{code: 449, reason: "Retry With"}

    assert StatusCode.find(:retry_with) === expected
    assert StatusCode.find(449) === expected
  end

  test "Blocked by Windows Parental Controls" do
    expected = %StatusCode{code: 450, reason: "Blocked by Windows Parental Controls"}

    assert StatusCode.find(:blocked_by_windows_parentak_controls) === expected
    assert StatusCode.find(450) === expected
  end

  test "Unavailable For Legal Reasons" do
    expected = %StatusCode{code: 451, reason: "Unavailable For Legal Reasons"}

    assert StatusCode.find(:unavailable_for_legal_reasons) === expected
    assert StatusCode.find(451) === expected
  end

  test "Redirect" do
    expected = %StatusCode{code: 451, reason: "Redirect"}

    assert StatusCode.find(:redirect) === expected
  end

  test "Request Header Too Large" do
    expected = %StatusCode{code: 494, reason: "Request Header Too Large"}

    assert StatusCode.find(:request_header_too_large) === expected
    assert StatusCode.find(494) === expected
  end

  test "Cert Error" do
    expected = %StatusCode{code: 495, reason: "Cert Error"}

    assert StatusCode.find(:cert_error) === expected
    assert StatusCode.find(495) === expected
  end

  test "No Cert" do
    expected = %StatusCode{code: 496, reason: "No Cert"}

    assert StatusCode.find(:no_cert) === expected
    assert StatusCode.find(496) === expected
  end

  test "HTTP to HTTPS" do
    expected = %StatusCode{code: 497, reason: "HTTP to HTTPS"}

    assert StatusCode.find(:http_to_https) === expected
    assert StatusCode.find(497) === expected
  end

  test "Token expired/invalid" do
    expected = %StatusCode{code: 498, reason: "Token expired/invalid"}

    assert StatusCode.find(:token_invalid) === expected
    assert StatusCode.find(498) === expected
  end

  test "Client Closed Request" do
    expected = %StatusCode{code: 499, reason: "Client Closed Request"}

    assert StatusCode.find(:client_closed_request) === expected
    assert StatusCode.find(499) === expected
  end

  test "Token required" do
    expected = %StatusCode{code: 499, reason: "Token required"}

    assert StatusCode.find(:token_required) === expected
  end

  test "Internal Server Error" do
    expected = %StatusCode{code: 500, reason: "Internal Server Error"}

    assert StatusCode.find(:internal_server_error) === expected
    assert StatusCode.find(500) === expected
  end

  test "Not Implemented" do
    expected = %StatusCode{code: 501, reason: "Not Implemented"}

    assert StatusCode.find(:not_implemented) === expected
    assert StatusCode.find(501) === expected
  end

  test "Bad Gateway" do
    expected = %StatusCode{code: 502, reason: "Bad Gateway"}

    assert StatusCode.find(:bad_gateway) === expected
    assert StatusCode.find(502) === expected
  end

  test "Service Unavailable" do
    expected = %StatusCode{code: 503, reason: "Service Unavailable"}

    assert StatusCode.find(:service_unavailable) === expected
    assert StatusCode.find(503) === expected
  end

  test "Gateway Timeout" do
    expected = %StatusCode{code: 504, reason: "Gateway Timeout"}

    assert StatusCode.find(:gateway_timeout) === expected
    assert StatusCode.find(504) === expected
  end

  test "HTTP Version Not Supported" do
    expected = %StatusCode{code: 505, reason: "HTTP Version Not Supported"}

    assert StatusCode.find(:http_version_not_supported) === expected
    assert StatusCode.find(505) === expected
  end

  test "Variant Also Negotiates" do
    expected = %StatusCode{code: 506, reason: "Variant Also Negotiates"}

    assert StatusCode.find(:variant_also_negotiates) === expected
    assert StatusCode.find(506) === expected
  end

  test "Insufficient Storage" do
    expected = %StatusCode{code: 507, reason: "Insufficient Storage"}

    assert StatusCode.find(:insufficient_storage) === expected
    assert StatusCode.find(507) === expected
  end

  test "Loop Detected" do
    expected = %StatusCode{code: 508, reason: "Loop Detected"}

    assert StatusCode.find(:loop_detected) === expected
    assert StatusCode.find(508) === expected
  end

  test "Bandwidth Limit Exceeded" do
    expected = %StatusCode{code: 509, reason: "Bandwidth Limit Exceeded"}

    assert StatusCode.find(:bandwidth_limit_exceeded) === expected
    assert StatusCode.find(509) === expected
  end

  test "Not Extended" do
    expected = %StatusCode{code: 510, reason: "Not Extended"}

    assert StatusCode.find(:not_extended) === expected
    assert StatusCode.find(510) === expected
  end

  test "Network Authentication Required" do
    expected = %StatusCode{code: 511, reason: "Network Authentication Required"}

    assert StatusCode.find(:network_authentication_required) === expected
    assert StatusCode.find(511) === expected
  end

  test "Origin Error" do
    expected = %StatusCode{code: 520, reason: "Origin Error"}

    assert StatusCode.find(:origin_error) === expected
    assert StatusCode.find(520) === expected
  end

  test "Web server is down" do
    expected = %StatusCode{code: 521, reason: "Web server is down"}

    assert StatusCode.find(:web_server_is_down) === expected
    assert StatusCode.find(521) === expected
  end

  test "Connection timed out" do
    expected = %StatusCode{code: 522, reason: "Connection timed out"}

    assert StatusCode.find(:connection_timed_out) === expected
    assert StatusCode.find(522) === expected
  end

  test "Proxy Declined Request" do
    expected = %StatusCode{code: 523, reason: "Proxy Declined Request"}

    assert StatusCode.find(:proxy_declined_request) === expected
    assert StatusCode.find(523) === expected
  end

  test "A timeout occurred" do
    expected = %StatusCode{code: 524, reason: "A timeout occurred"}

    assert StatusCode.find(:a_timeout_occured) === expected
    assert StatusCode.find(524) === expected
  end

  test "Network read timeout error" do
    expected = %StatusCode{code: 598, reason: "Network read timeout error"}

    assert StatusCode.find(:network_read_timeout_error) === expected
    assert StatusCode.find(598) === expected
  end

  test "Network connect timeout error" do
    expected = %StatusCode{code: 599, reason: "Network connect timeout error"}

    assert StatusCode.find(:network_connect_timeout_error) === expected
    assert StatusCode.find(599) === expected
  end

  test "unknown status codes return OK" do
    expected = %StatusCode{code: 200, reason: "OK"}

    assert StatusCode.find(:ok_but_why) === expected
    assert StatusCode.find(20000) === expected
    assert StatusCode.find(nil) === expected
  end
end