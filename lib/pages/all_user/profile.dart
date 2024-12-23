import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/components/general/my_textfield.dart';
import 'package:fyp/images/assets.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/functions/updateurl.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Logo show = Logo();
  final user = UserNow.usernow.user;
  final String fullname = UserNow.usernow.fullname;
  final String displayName = UserNow.usernow.user?.displayName ?? "";
  //final String password;
  final String phone = UserNow.usernow.phone;
  final String photoURL = UserNow.usernow.user?.photoURL ?? defProfile;
  final String address = UserNow.usernow.address.map((word) => (word)).join(", ");
  //text editing controller
  late TextEditingController dnameController;
  late TextEditingController fnameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late String src;
  late String dnameHT;
  late String fnameHT;
  late String phoneHT;
  late String addressHT;
  bool isEdit = false;
  final obj2 = MyCachednetworkimage();
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final load = Loading();
  final DownloadURL obj = DownloadURL(); //for url
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    dnameController.dispose();
    fnameController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  void initState() {
    super.initState();
    dnameController = TextEditingController();
    fnameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    inithinttext(displayName, fullname, phone, address);
    src = user?.photoURL ?? defProfile;
  }

  //to initialize hint text--------
  inithinttext(String dname, String fname, String phone, String address) {
    dnameHT = dname;
    fnameHT = fname;
    phoneHT = phone;
    addressHT = address;
  }
  //to initialize hint text--------

  //uppercase first letter-----------------------------------------
  String upperCase(String toEdit) {
    return toEdit[0].toUpperCase() + toEdit.substring(1).toLowerCase();
  }

  //uppercase first letter-----------------------------------------
  //untuk bahagian upload image-----------------------------------------------------
  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Photo Gallery',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
  //bahagian upload imej----------------------------------------------------------

  //enable save kalau ada changes in textcontroller atau imej je--------------------------------
  bool isSaveEnabled() {
    return !(dnameController.text == '' &&
        fnameController.text == '' &&
        phoneController.text == '' &&
        _image == null &&
        addressController.text == '');
  }
  //--------------------------------------------------------------------------------------------

  //confirm pop up kalau ada unsaved data---------------------------------------
  confirmPopUp(context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "Are you sure you want to exit? There is unsaved changes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel)),
            ],
          )
        ],
      ),
    );
  } //--------------------------------------------------------------------------

  void toPop() {
    if (!isSaveEnabled()) {
      Navigator.pop(context);
    } else {
      confirmPopUp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shopping>(
      builder: (context, shopping, child) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          toPop();
        },
        child: Scaffold(
          backgroundColor: const Color(0xffd1a271),
          appBar: AppBar(
            backgroundColor: const Color(0xffB67F5F),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                toPop();
              },
            ),
            title: const Center(
              child: Text(
                textAlign: TextAlign.center,
                "Profile",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width, //max width for current phone
            height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
            decoration: show.showLogo(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 30),
                          Visibility(
                            visible: isEdit,
                            child: MaterialButton(
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('Change Product Image')),
                              onPressed: showOptions,
                            ),
                          ),

                          Visibility(visible: isEdit, child: const SizedBox(height: 20)),

                          //image of user
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: _image == null
                                  //kalau belum pick show current
                                  ? obj2.showImage(src)
                                  //kalau dah pick show chosen image
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          //input file sendiri or use default image for now

                          Visibility(visible: isEdit, child: const SizedBox(height: 20)),

                          //button to remove picture chosen
                          Visibility(
                            visible: isEdit,
                            child: MaterialButton(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Remove Picture',
                                ),
                              ),
                              onPressed: _image == null
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: const Text(
                                            "Confirm delete profile picture?",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    load.loading(context);
                                                    src = defProfile;
                                                    await user?.updatePhotoURL(defProfile);
                                                    await FirebaseAuth.instance.currentUser?.reload().then((a) {
                                                      UserNow.usernow.user = _auth.getCurrentUser();
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    });
                                                  },
                                                  iconSize: 50,
                                                  color: Colors.green,
                                                  icon: const Icon(Icons.check_circle),
                                                ),
                                                IconButton(
                                                  iconSize: 50,
                                                  color: Colors.red,
                                                  onPressed: () => Navigator.pop(context),
                                                  icon: const Icon(Icons.cancel),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  : () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Display Name",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  //displayname
                  MyTextField(
                    maxLength: TextField.noMaxLength,
                    controller: dnameController,
                    labelText: dnameHT,
                    obscureText: false,
                    inputType: TextInputType.text,
                    caps: TextCapitalization.words,
                    isEnabled: isEdit,
                    hintText: dnameHT,
                    isShowhint: true,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Full Name",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  //fullname
                  MyTextField(
                    maxLength: TextField.noMaxLength,
                    controller: fnameController,
                    labelText: fnameHT,
                    obscureText: false,
                    inputType: TextInputType.text,
                    caps: TextCapitalization.words,
                    isEnabled: isEdit,
                    hintText: fnameHT,
                    isShowhint: true,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  //phone
                  MyTextField(
                    maxLength: 12,
                    controller: phoneController,
                    labelText: phoneHT,
                    obscureText: false,
                    inputType: TextInputType.number,
                    caps: TextCapitalization.none,
                    isEnabled: isEdit,
                    hintText: phoneHT,
                    isShowhint: true,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Address",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  //address
                  MyTextField(
                    maxLength: TextField.noMaxLength,
                    controller: addressController,
                    labelText: addressHT,
                    obscureText: false,
                    inputType: TextInputType.text,
                    caps: TextCapitalization.words,
                    isEnabled: isEdit,
                    hintText: addressHT,
                    isShowhint: true,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          if (!isEdit) {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          } else if (isSaveEnabled()) {
                            //save here
                            String newdname, newfname, newpnum, newadd;
                            List<String> words = [], names = [];
                            fnameController.text == ""
                                ? newfname = fullname
                                : {
                                    words = fnameController.text.trim().split(" "),
                                    newfname = words.map((word) => upperCase(word)).join(" "),
                                  };
                            await FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
                              for (var docSnapshot in querySnapshot.docs) {
                                names.add(docSnapshot.data()['fullname']);
                              }
                            }).then((value) {
                              if (names.where((name) => name == newfname).isNotEmpty && fnameController.text != "") {
                                scaffoldOBJ.scaffoldmessage("Name already exist", context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: const Text(
                                      "Save changes?",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            iconSize: 50,
                                            color: Colors.green,
                                            onPressed: () async {
                                              words.clear();
                                              dnameController.text == ""
                                                  ? newdname = displayName
                                                  : {
                                                      words = dnameController.text.trim().split(" "),
                                                      newdname = words.map((word) => upperCase(word)).join(" "),
                                                    };
                                              phoneController.text == "" ? newpnum = phone : newpnum = phoneController.text.trim();
                                              addressController.text == ""
                                                  ? newadd = address
                                                  : {
                                                      newadd = addressController.text.trim(),
                                                      context.read<Shopping>().updateDeliveryAddress(newadd),
                                                    };
                                              try {
                                                String imagePath = "${UserNow.usernow.user?.uid}/profilePic";
                                                // loading circle-------------------------
                                                load.loading(context);
                                                //--------------------------------------
                                                if (_image != null) {
                                                  try {
                                                    await FirebaseStorage.instance.ref().child(imagePath).delete();
                                                  } on FirebaseException catch (e) {
                                                    if (kDebugMode) {
                                                      print(e.toString());
                                                    }
                                                  }
                                                  await FirebaseStorage.instance
                                                      .ref()
                                                      .child(imagePath)
                                                      .putFile(_image!)
                                                      .then((onValue) async {
                                                    //get file url
                                                    await obj.downloadUrl(imagePath, context).then((url) async {
                                                      src = url;
                                                      try {
                                                        await user?.updateProfile(displayName: newdname, photoURL: src);
                                                        await FirebaseAuth.instance.currentUser?.reload();
                                                      } catch (e) {
                                                        if (kDebugMode) {
                                                          print(e.toString());
                                                        }
                                                      }
                                                      await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
                                                        "fullname": newfname,
                                                        "phone": newpnum,
                                                        "address": newadd,
                                                      }).then((onValue) {
                                                        Navigator.pop(context); //pop loading screen
                                                        Navigator.pop(context);
                                                        //pop save changes dialogue
                                                        scaffoldOBJ.scaffoldmessage("Data saved", context);
                                                        setState(() {
                                                          inithinttext(newdname, newfname, newpnum, newadd);
                                                          _image = null;
                                                          dnameController = TextEditingController();
                                                          fnameController = TextEditingController();
                                                          phoneController = TextEditingController();
                                                          addressController = TextEditingController();
                                                          isEdit = false;
                                                          UserNow.usernow.user = _auth.getCurrentUser();
                                                        });
                                                      });
                                                    });
                                                  });
                                                } else {
                                                  try {
                                                    await user?.updateDisplayName(newdname);
                                                    await FirebaseAuth.instance.currentUser?.reload();
                                                  } catch (e) {
                                                    if (kDebugMode) {
                                                      print(e.toString());
                                                    }
                                                  }
                                                  await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
                                                    "fullname": newfname,
                                                    "phone": newpnum,
                                                    "address": newadd,
                                                  }).then((onValue) {
                                                    Navigator.pop(context); //pop loading screen
                                                    Navigator.pop(context);
                                                    //pop save changes dialogue
                                                    scaffoldOBJ.scaffoldmessage("Data saved", context);
                                                    setState(() {
                                                      inithinttext(newdname, newfname, newpnum, newadd);
                                                      dnameController = TextEditingController();
                                                      fnameController = TextEditingController();
                                                      phoneController = TextEditingController();
                                                      addressController = TextEditingController();
                                                      isEdit = false;
                                                      UserNow.usernow.user = _auth.getCurrentUser();
                                                    });
                                                  });
                                                }
                                              } catch (e) {
                                                Navigator.pop(context);
                                                //pop loading circle when fail---------
                                                scaffoldOBJ.scaffoldmessage("Fail uploading", context);
                                                if (kDebugMode) {
                                                  print(e.toString());
                                                }
                                              }
                                            },
                                            icon: const Icon(Icons.check_circle),
                                          ),
                                          IconButton(
                                            iconSize: 50,
                                            color: Colors.red,
                                            onPressed: () => Navigator.pop(context),
                                            icon: const Icon(Icons.cancel),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                            });
                          } else {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              isEdit ? "Save Profile" : "Edit Profile",
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
