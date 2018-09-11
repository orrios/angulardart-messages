import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'message_list_service.dart';

import '../message.dart';

@Component(
  selector: 'message-list',
  styleUrls: ['message_list_component.css'],
  templateUrl: 'message_list_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
    NgZone
  ],
  providers: [const ClassProvider(MessageListService)],
)
class MessageListComponent implements OnInit {
  final MessageListService messageListService;

  List<Message> items = [];
  String newMessage = '';

  MessageListComponent(this.messageListService);

  @override
  Future<Null> ngOnInit() async {
    List<Message> messages = await messageListService.getMessageList();
    items = messages;
  }

  void add() {
    items.insert(0, Message(0, newMessage, 'local'));
    messageListService.add(newMessage).then(
      (m) {
        items[0] = m;
      }
    );
    if (items.length > 5) {
      items.removeAt(items.length - 1);
    }
    newMessage = '';
  }
}
