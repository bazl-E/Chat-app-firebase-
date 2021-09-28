import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key? key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 10,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : Radius.circular(12),
                ),
              ),
              width: 140,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.white),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
      ],
      // overflow: Overflow.visible,
      clipBehavior: Clip.antiAlias,
    );
  }
}
