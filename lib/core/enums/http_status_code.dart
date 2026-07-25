import 'package:collection/collection.dart';

enum HttpStatusCode {
  /// 200 | Request is successful
  ok(200),

  /// 201 | Resource has been created
  created(201),

  /// 204 | Request is successful but no content to return
  noContent(204),

  /// 400 | Bad request due to client error
  badRequest(400),

  /// 401 | Authentication is required
  unauthorized(401),

  /// 403 | Server understands the request but refuses to authorize it
  forbidden(403),

  /// 404 | Requested resource could not be found
  notFound(404),

  /// 409 | Request conflicts with current state of the server
  conflict(409),

  /// 422 | Request is well-formed but unable to be processed
  unprocessableEntity(422),

  /// 429 | Too many requests in a given amount of time
  tooManyRequests(429),

  /// 500 | Internal server error
  internalServerError(500),

  /// 502 | Bad Gateway
  badGateway(502),

  /// 503 | Server is not ready to handle the request
  serviceUnavailable(503),

  /// 504 | Gateway timeout
  gatewayTimeout(504),
  unknown(0);

  final int code;

  const HttpStatusCode(this.code);

  static HttpStatusCode fromCode(int? code) {
    return HttpStatusCode.values.firstWhereOrNull(
          (element) => element.code == code,
        ) ??
        HttpStatusCode.unknown;
  }
}
