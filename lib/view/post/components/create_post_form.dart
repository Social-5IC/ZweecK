import 'dart:convert';
import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/view/global_components/forms/image_picker.dart';
import 'package:zweeck/view/global_components/forms/switch.dart';
import 'package:zweeck/view/global_components/forms/text_field.dart';

class CreatePostForm extends StatefulWidget {
  final Future<Failure?> Function(
    String image,
    String description,
    List<String> tags,
    String? link,
  ) onSubmit;

  const CreatePostForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  bool _withLink = false;
  final _linkController = TextEditingController();
  XFile? _image;

  // form validators
  String? descriptionValidator(String? description) {
    if (description == null || description.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? tagsValidator(String? tags) {
    if (tags == null || tags.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? linkValidator(String? link) {
    if (link == null || link.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // submit callback
  submit() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) return;
      String description = _descriptionController.value.text;
      List<String> tags = _tagsController.value.text.split(",")
        ..forEach((element) {
          element.trim();
        });
      String? link = _withLink ? _descriptionController.value.text : null;
      String encodedImage = base64Encode(await _image!.readAsBytes());

      Failure? result = await widget.onSubmit(
        encodedImage,
        description,
        tags,
        link,
      );

      _descriptionController.clear();
      _tagsController.clear();
      _withLink = false;
      _linkController.clear();
      _image = null;

      if (result is Failure) {
        // to improve: submit error management
        log(result.message);
      } else {
        ExpandableController.of(context)!.toggle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Create a new post",
                style: TextStyle(fontSize: 14),
              ),
            ),
            FormTextField(
              controller: _descriptionController,
              validator: descriptionValidator,
              placeholder: "Description",
            ),
            FormTextField(
              controller: _tagsController,
              validator: tagsValidator,
              placeholder: "Tags",
            ),
            FormImagePicker(
              imageName: _image?.name,
              placeholder: "Pick an image",
              onPicked: (newImage) {
                _image = newImage;
              },
            ),
            FormSwitch(
              value: _withLink,
              placeholder: "Add link?",
              onChanged: (value) {
                setState(() {
                  _withLink = value;
                });
              },
            ),
            if (_withLink)
              FormTextField(
                controller: _linkController,
                validator: linkValidator,
                placeholder: "Link",
              ),
            ElevatedButton(
              onPressed: submit,
              child: const Text("Create "),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
