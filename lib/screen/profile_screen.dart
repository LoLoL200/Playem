import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playem/main.dart';
import 'package:playem/utils/service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  String name = 'User';
  // Email
  final email = AuthService.currentUser?.email;
  String? _networkImageUrl; // Для URL из Firestore

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        name = data['name'] ?? 'User';
        _networkImageUrl = data['photoUrl'];
        _image = null; // Чтобы не показывать локальное фото, если есть url
      });
    }
  }

  // Get image
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Text('No image selected');
      }
    });
  }

  //Notification
  Future<void> _showToast(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepOrange,
      fontSize: 16,
    );
  }

  // sign out method
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => MainApp()));
  }

  //Upload Image to Firebase
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final ref = FirebaseStorage.instance.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Ошибка загрузки: $e");
      return null;
    }
  }

  // Save profile
  Future<void> saveProfileData({required String name, String? imageUrl}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Map<String, dynamic> data = {'name': name};
    if (imageUrl != null) {
      data['photoUrl'] = imageUrl;
    }

    print('Saving profile data: $data for user ${user.uid}');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));
  }

  // Rename user name method
  void rename() {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter a new name'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "New name"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                name = nameController.text;
              });
              await saveProfileData(name: name, imageUrl: null);
              Navigator.pop(context);
              _showToast("Name update!");
            },
            child: Text("Сохранить"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : (_networkImageUrl != null
                                ? NetworkImage(_networkImageUrl!)
                                : null)
                            as ImageProvider<Object>?,
                  child: (_image == null && _networkImageUrl == null)
                      ? const Icon(
                          Icons.person,
                          size: 64,
                          color: Colors.deepOrange,
                        )
                      : null,
                ),
              ),

              SizedBox(height: 30),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(35),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name: $name',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Email: $email',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 300),
                        ElevatedButton(
                          onPressed: () async {
                            if (_image != null) {
                              final imageUrl = await uploadImageToFirebase(
                                _image!,
                              );
                              if (imageUrl != null) {
                                await saveProfileData(
                                  name: name,
                                  imageUrl: imageUrl,
                                );
                                await loadProfileData();
                                _showToast("Photo update!!");
                                setState(() {
                                  _networkImageUrl =
                                      "$imageUrl?t=${DateTime.now().millisecondsSinceEpoch}";
                                  _image = null;
                                });
                              } else {
                                _showToast("Error download image");
                              }
                            } else {
                              _showToast("Please select an image firs");
                            }
                          },
                          child: Text('Save Photo'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: rename,
                          child: Text("Redact name"),
                        ),
                        ElevatedButton(
                          onPressed: () => _signOut(),
                          child: Text('Exit accaunt'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
