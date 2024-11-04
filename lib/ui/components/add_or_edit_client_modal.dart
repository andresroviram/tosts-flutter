import 'package:custom_border/border.dart';
import 'package:flutter/material.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';

class AddOrEditClientModal extends StatefulWidget {
  const AddOrEditClientModal({
    super.key,
    this.isEditing = false,
    this.id,
    this.firstname,
    this.lastName,
    this.email,
    this.address,
    this.onSave,
    this.onEdit,
  });

  final bool isEditing;
  final String? id;
  final String? firstname;
  final String? lastName;
  final String? email;
  final String? address;
  final Function(ClientEntity)? onSave;
  final Function(ClientEntity)? onEdit;

  @override
  State<AddOrEditClientModal> createState() => _AddNewClientModalState();
}

class _AddNewClientModalState extends State<AddOrEditClientModal> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.isEditing ? widget.firstname : '');
    _lastNameController =
        TextEditingController(text: widget.isEditing ? widget.lastName : '');
    _emailController =
        TextEditingController(text: widget.isEditing ? widget.email : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                widget.isEditing ? 'Edit client' : 'Add new client',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: const Color(0xFFFDFDF9),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Lógica para subir imagen
                      },
                      child: CustomBorder(
                        color: Colors.yellow,
                        radius: const Radius.circular(100),
                        dashPattern: const [5, 10],
                        strokeCap: StrokeCap.square,
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: ColoredBox(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/mode-landscape.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Upload image',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            112,
                                            112,
                                            112,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'First name*',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last name*',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email address*',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.isEditing) {
                          widget.onEdit?.call(
                            ClientEntity(
                              id: widget.id.toString(),
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              email: _emailController.text,
                              address: widget.address,
                            ),
                          );
                        } else {
                          widget.onSave?.call(
                            ClientEntity(
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              email: _emailController.text,
                              address: "Buenos Aires, Argentina",
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('SAVE'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
