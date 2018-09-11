import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart';
import 'package:angular/core.dart';
import '../message.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class MessageListService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _messagesUrl =
      'http://localhost:8888/messages'; // URL to web API
  final Client _http;

  MessageListService(this._http);

  List<String> mockMessageList = <String>['asdasd', 'dddd'];
  dynamic _extractData(Response resp) => json.decode(resp.body);

  Future<List<Message>> getMessageList() async {
    try {
      final response = await _http.get(_messagesUrl);
      final messages = (_extractData(response) as List)
          .map((value) => Message.fromJson(value))
          .toList();
      print(messages);
      return messages;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Message> add(String content) async {
    try {
      final response = await _http.post(_messagesUrl,
          body: json.encode({"content": content}),
          headers: {'content-type': 'application/json'});
      print(response.toString());
      final message = Message.fromJson(_extractData(response) as Map);
      print(message.content);
      return message;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }
}
