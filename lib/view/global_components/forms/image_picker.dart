import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormImagePicker extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final String? imageName;
  final String placeholder;
  final void Function(XFile newImage) onPicked;

  FormImagePicker({
    Key? key,
    required this.imageName,
    required this.placeholder,
    required this.onPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(placeholder),
        subtitle: imageName != null ? Text(imageName!) : Container(),
        trailing: IconButton(
          onPressed: () async {
            XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              onPicked(image);
            }
          },
          icon: const Icon(Icons.image),
        ));
  }
}
