// ignore_for_file: use_build_context_synchronously, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import '../../Core/Custom_TextFormFealed.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool isNotVisable = true;
FirebaseAuth auth = FirebaseAuth.instance;
String? name = FirebaseAuth.instance.currentUser!.displayName;

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

//google signin
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("Gender", (route) => false);
  }

  //facebock signin

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

//---------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 40,
                          color: AppColors.text,
                          fontWeight: FontWeight.w600),
                    ),
                    const Gap(40),
                    //Email
                    CusomTextFormFeald(
                      mycontroller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PLease Enter Your Email';
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      lable: 'Email',
                      suffixIcon: null,
                    ),
                    const Gap(25),
                    //Pasword
                    CusomTextFormFeald(
                      mycontroller: password,
                      obscureText: isNotVisable,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PLease Enter Your Password';
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock,
                      lable: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isNotVisable = !isNotVisable;
                          });
                        },
                        icon: Icon((isNotVisable)
                            ? Icons.visibility_off
                            : Icons.remove_red_eye_rounded),
                        color: AppColors.text,
                      ),
                    ),
                    const Gap(5),
                    //Forget Password
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () async {
                          if (email.text == "") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "please enter your email first",
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ));
                            return;
                          }
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "we sent Reset password link to your email"),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "The email address is badly formatted \n make sure that email like xxx@xxx.xx"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ));
                            } else if (e.code == 'user-not-found') {
                              // ignore: avoid_print
                              print('No user found for that email.');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No user found for that email"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                        child: Text(
                          "Forget Password ?",
                          style: TextStyle(fontSize: 12, color: AppColors.text),
                        ),
                      ),
                    ),
                    const Gap(15),
                    //Login Buttom
                    Custom_Button(
                        text: 'Login',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              if (credential.user!.emailVerified) {
                                // Center(
                                //   child: Container(
                                //     child: AnimatedSplashScreen(splash: splash, nextScreen: Gender()),
                                //   ),
                                // );
                                Navigator.of(context)
                                    .pushReplacementNamed('Gender');
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("please verfiy your email ♥"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.blueAccent,
                                ));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                // ignore: avoid_print
                                print('No user found for that email.');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("No user found for that email"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ));
                              } else if (e.code == 'wrong-password') {
                                // ignore: avoid_print
                                print('Wrong password provided for that user.');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Wrong password provided for that user"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ));
                              } else if (e.code == 'invalid-email') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "The email address is badly formatted \n make sure that email like xxx@xxx.xx"),
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        }),
                    const Gap(40),
                    //Divider
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(color: AppColors.text),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or',
                            style:
                                TextStyle(color: AppColors.text, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: AppColors.text),
                        ),
                      ],
                    ),
                    const Gap(20),
                    // login with Google and facebook
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await signInWithGoogle();
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                            ),
                            child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('Images/Google.png'),
                                )),
                          ),
                        ),
                        const Gap(10),
                        InkWell(
                          onTap: () async {
                            await signInWithFacebook();
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                            ),
                            child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('Images/facebook.jpg'),
                                )),
                          ),
                        ),
                        // const Gap(10),
                        // InkWell(
                        //   onTap: () {},
                        //   child: SizedBox(
                        //     height: 65,
                        //     width: 65,
                        //     child: Lottie.asset(('Images/Gogle.json'))),
                        // ),
                      ],
                    ),
                    const Gap(20),
                    //Create Acc
                    Row(
                      children: [
                        Text('If you don\'t have account.',
                            style: TextStyle(
                                color: AppColors.text,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'Create one !',
                              style: TextStyle(
                                  color: AppColors.button,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*
void phoneauth () async{
  await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: '+44 7123 123 456',
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) async{
    try {
  String smsCode = 'xxxx';
  
  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  
  await auth.signInWithCredential(credential);
} on Exception catch (e) {
  
}
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);


}
*/