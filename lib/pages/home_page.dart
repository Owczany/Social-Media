import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/helpers/spacers.dart';
import 'package:social_media/pages/profile_page.dart';
import 'package:social_media/pages/settings_page.dart';
import 'package:social_media/theme/theme_manager.dart';
import 'package:social_media/utils/drawer.dart';
import 'package:social_media/utils/menu_tile.dart';
import 'package:social_media/utils/text_fields.dart';
import 'package:social_media/utils/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void singOut() {
    FirebaseAuth.instance.signOut();
  }

  // post message method
  void postMessage() {
    // only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      // store in firebase
      FirebaseFirestore.instance.collection('User Posts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
      setState(() {
        textController.clear();
      });
    }
  }

  // navigate to profile page
  void goToProfilePage() {
    // pop the menu drawer
    Navigator.of(context).pop();
    // go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToSettingsPage() {
    // pop the menu drawer
    Navigator.of(context).pop();
    // go to settings page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'The Wall',
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Change theme mode button
          PopupMenuButton(
            icon: Theme.of(context).brightness == Brightness.dark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'light',
                child: MyMenuTile(icon: Icons.light_mode, title: 'Light Mode'),
              ),
              PopupMenuItem(
                value: 'dark',
                child: MyMenuTile(icon: Icons.dark_mode, title: 'Dark Mode'),
              ),
              PopupMenuItem(
                value: 'system',
                child: MyMenuTile(icon: Icons.settings, title: 'System Mode'),
              ),
            ],
            onSelected: (String? newValue) {
              setState(() {
                themeManager.toggleThemes(newValue);
              });
            },
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSettingsTap: goToSettingsPage,
        onSingOut: singOut,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // the wall
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User Posts')
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  // textfield
                  Expanded(
                    flex: 9,
                    child: MyTextField(
                        controller: textController,
                        hintText: 'Write something on the wall ...',
                        obscureText: false),
                  ),
                  // post button
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up_outlined),
                    ),
                  ),
                ],
              ),
            ),

            // logged as 'user email'
            Center(
              child: Text('Logged in as: ${currentUser.email}'),
            ),
            verticalSpacer(20),
          ],
        ),
      ),
    );
  }
}
