import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/models/User.dart';
import 'package:my_app/models/message.dart';
import 'package:my_app/service/django_service.dart';
import 'package:my_app/utils/KUtils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Contact extends StatefulWidget {

  WebSocketChannel webSocketChannel;
  Stream<dynamic> stream;

  Contact({super.key, required this.webSocketChannel, required this.stream});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();
  ScrollController _scrollController = ScrollController();
  int idUser = 0;

  Future<void> _openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("image file : ${image.path}");
      setState(() {
        _image = File(image.path);
        // _messages.add("Image envoyée");
      });
      await APIService.uploadImage(_image!, idUser);
    }
  }

  Future<void> _pickDocument() async {
    setState(() {
      // _messages.add("Document envoyé");
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      var user = await Kutils.getUserLogin();
      Map<String, dynamic> map = {
        "page": "contact",
        "init": 0,
        "user": user.toJson(),
        "message":_controller.text
      };
      widget.webSocketChannel.sink.add(jsonEncode(map));
      setState(() {
        // _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF094FC6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.image,
                  color: Color(0xFF094FC6),
                ),
              ),
              title: const Text('Galerie photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF094FC6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Color(0xFF094FC6),
                ),
              ),
              title: const Text('Appareil photo'),
              onTap: () {
                Navigator.pop(context);
                _openCamera();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF094FC6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.file_present,
                  color: Color(0xFF094FC6),
                ),
              ),
              title: const Text('Document'),
              onTap: () {
                Navigator.pop(context);
                _pickDocument();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});  // Pour forcer la mise à jour de l'UI quand le texte change
    });
    widget.stream.listen(onMessageReceivedWebsocket);

    Kutils.getUserLogin().then((value) {
      setState(() {
        idUser = value.id!;
      });
      Map<String, dynamic> map = {
        "page": "contact",
        "init": 1,
        "user": value.toJson(),
      };
      widget.webSocketChannel.sink.add(jsonEncode(map));
      print("id user : ${value.id!}");
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onMessageReceivedWebsocket(dynamic event){
    if( !mounted ) return;


    Map<String, dynamic> map = jsonDecode(event);
    print(map['data']);
    setState(() {
      _messages.clear();
    });
    for (var message in map['data']) {
      Message ms = Message.fromJson(message);
      print(ms.image);
      setState(() {
        _messages.add(ms);
      });
    }
    // Fait défiler automatiquement vers le bas
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Position la plus basse
      duration: const Duration(milliseconds: 300),      // Durée du défilement
      curve: Curves.easeOut,                      // Animation du défilement
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF094FC6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/security.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'En ligne',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(15),
                //reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: const Duration(milliseconds: 300),
                    child: Align(
                      alignment: ((_messages[index].sender == idUser) && (_messages[index].is_sent_by_user == true))
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? const Color(0xFF094FC6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: Text(
                          _messages[index].message,
                          style: TextStyle(
                            color: ((_messages[index].sender == idUser) && (_messages[index].is_sent_by_user == true))  ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      color: Colors.grey[600],
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      color: Colors.grey[600],
                      onPressed: _showAttachmentOptions,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF094FC6),
                            Color(0xFF0A3A8B),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF094FC6).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            if (_controller.text.isNotEmpty) {
                              _sendMessage();
                            } else {
                              // TODO: Implémenter l'enregistrement vocal
                            }
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              _controller.text.isEmpty ? Icons.mic : Icons.send,
                              key: ValueKey<bool>(_controller.text.isEmpty),
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
