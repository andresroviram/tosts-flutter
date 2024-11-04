import 'package:flutter/material.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';
import 'package:minimal_app/ui/components/add_or_edit_client_modal.dart';

class ClientCard extends StatelessWidget {
  final ClientEntity client;

  final Function(ClientEntity)? onEdit;
  final Function(String)? onDelete;

  const ClientCard({
    super.key,
    required this.client,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          leading: CircleAvatar(
            radius: 24,
            child: Text(client.firstname?[0] ?? ''),
          ),
          title: Text(
            '${client.firstname} ${client.lastname}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(client.email ?? ''),
          trailing: PopupMenuButton<String>(
            offset: const Offset(-5, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onSelected: (String value) {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddOrEditClientModal(
                      isEditing: true,
                      id: client.id.toString(),
                      firstname: client.firstname,
                      lastName: client.lastname,
                      email: client.email,
                      address: client.address,
                      onEdit: (editClient) {
                        onEdit?.call(editClient);
                      },
                    );
                  },
                );
              }
              if (value == 'delet') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('You want to delete this client'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDelete?.call(client.id ?? '');
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Edit', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delet',
                  child: Row(
                    children: [
                      Icon(Icons.close, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Delet', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ];
            },
            color: Colors.black,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
