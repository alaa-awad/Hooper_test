
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooper_alaa_awad_test/view/home_page/home_page.dart';

import '../../controller/email_bloc/email_bloc.dart';
import '../../model/email_model.dart';

class AddUpdateEmail extends StatefulWidget {

  int id;
  Email? email;

   AddUpdateEmail(this.email,{required this.id,Key? key}) : super(key: key);

  @override
  State<AddUpdateEmail> createState() => _AddUpdateEmailState();
}

class _AddUpdateEmailState extends State<AddUpdateEmail> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  EmailBloc emailBloc = EmailBloc(Dio());

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
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:widget.email == null
            ? const Text('Add Email')
            : const Text('Update Email') ,
      ),
      body: Column(
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
            ElevatedButton(
              onPressed: () async {
                // Implement save functionality here
                // For example, you can access the entered values like this:
                String title = _titleController.text;
                String email = _emailController.text;
                String description = _descriptionController.text;
                String imageUrl = _imageUrlController.text;

                if (widget.email == null) {
                  await emailBloc.postData({
                    "id": widget.id + 1,
                    "title": title,
                    "description": description,
                    "img_link": imageUrl,
                    "email": email,
                  });
                }
                else {
                  await emailBloc.updateData(
                      widget.email!.id,
                      {
                        "id": widget.email!.id,
                        "title": title,
                        "description": description,
                        "img_link": imageUrl,
                        "email": email,
                      });
                }
                 await emailBloc.getData();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomePage()));
              },
              child: const Text('Save'),
            ),

        ],
      ),
    );
  }
}
