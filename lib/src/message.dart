class Message {
  int id;
  String content, ip;

  Message(this.id, this.content, this.ip);

  factory Message.fromJson(Map<String, dynamic> message) =>
      Message(_toInt(message['id']), message['content'], message['ip']);
}

int _toInt(id) => id is int ? id : int.parse(id);
