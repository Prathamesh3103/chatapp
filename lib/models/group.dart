class Group {
  final String sendersId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final List<String> membersuid;
  final DateTime timeSent;

  Group({
    required this.sendersId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.membersuid,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'sendersId': sendersId,
      'name': name,
      'groupId': groupId,
      'lastmessage': lastMessage,
      'groupPic': groupPic,
      'membersuid': membersuid,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      sendersId: map['sendersId'] ?? '',
      name: map['name'] ?? '',
      groupId: map['groupId'] ?? '',
      lastMessage: map['lastmessage'] ?? '',
      groupPic: map['groupPic'] ?? '',
      membersuid: List<String>.from(map['membersuid']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
