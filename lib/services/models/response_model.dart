//

import 'dart:convert';

ResponseMessage responseMessageFromJson(String str) =>
    ResponseMessage.fromJson(json.decode(str));

class ResponseMessage {
  ResponseMessage({
    required this.response,
  });

  String response;

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      ResponseMessage(
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Response": response,
      };
}
