import 'package:miu/services/base/config.dart';
import 'package:miu/services/friend/friend_service.dart';
import 'package:flutter/material.dart';

class FriendButton extends StatelessWidget {
  final bool isFriend;
  final String userId;

  const FriendButton({
    Key? key,
    required this.isFriend,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFriend) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'Arkadaşsınız',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () async {
          try {
            await FriendService(Config()).sendFriendRequest(userId);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Arkadaşlık isteği gönderildi')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bir hata oluştu')),
            );
          }
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Arkadaş Olarak Ekle'),
      );
    }
  }
}
