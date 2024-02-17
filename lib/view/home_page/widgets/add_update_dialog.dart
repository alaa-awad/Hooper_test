import 'package:flutter/material.dart';
import '../../../controller/email_bloc/email_bloc.dart';
import '../../../model/email_model.dart';

class AddUpdateDialog extends StatefulWidget {
  int id;
  Email? email;
  EmailBloc emailBloc;
  AddUpdateDialog(this.email, {required this.id,required this.emailBloc, super.key});
  @override
  _AddUpdateDialogState createState() => _AddUpdateDialogState();
}

class _AddUpdateDialogState extends State<AddUpdateDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  //EmailBloc emailBloc = EmailBloc(Dio());

  @override
  void initState() {
    if (widget.email != null) {
      _titleController.text = widget.email!.title;
      _emailController.text = widget.email!.email;
      _descriptionController.text = widget.email!.description;
      _imageUrlController.text = widget.email!.imgLink;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.email == null
          ? const Text('Add Email')
          : const Text('Update Email'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            // Implement save functionality here
            // For example, you can access the entered values like this:
            String title = _titleController.text;
            String email = _emailController.text;
            String description = _descriptionController.text;
            String imageUrl = _imageUrlController.text;

            if (widget.email == null) {
              await widget.emailBloc.postData({
                "id": widget.id + 1,
                "title": title,
                "description": description,
                "img_link": imageUrl,
                "email": email,
              });
            }
            else {
              print("widget.email!.id, ${widget.email!.id}");
              await widget.emailBloc.updateData(
                  widget.email!.id,
                  {
                "id": widget.email!.id,
                "title": title,
                "description": description,
                "img_link": imageUrl,
                "email": email,
              });
            }
            // await emailBloc.getData();

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
