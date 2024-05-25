import 'package:flutter/material.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/core/widgets/profile_list.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.asset(
                        AssetsPath.assetsIcons + AssetsListName.images[1],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).primaryColor),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Guest", style: Theme.of(context).textTheme.headlineSmall),
              Text("user app", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),

              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Profile prefrences",
                  icon: Icons.account_circle,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Delivery prefrences",
                  icon: Icons.delivery_dining,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Change location",
                  icon: Icons.settings,
                  onPress: () {}),
              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "terms & conditions",
                  icon: Icons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                title: "About us",
                icon: Icons.developer_mode_rounded,
                endIcon: false,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Made With ❤️ By # Tashil",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            const Text(
                              "Rate our app",
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () async => {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: const Text(
                                      "Email us",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
