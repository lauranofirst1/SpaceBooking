import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _statusMessage = '';

  Future<void> _signUp() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        setState(() {
          _statusMessage = '인증 이메일이 발송되었습니다. 이메일을 확인해주세요.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _statusMessage = e.message ?? '회원가입 실패';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            // 배경을 꾸미는 추가적인 Container
            Positioned(
              left: 179.sp,
              top: 0.sp,
              child: Container(
                width: 430.w,
                height: 430.h,
                decoration: ShapeDecoration(
                  color: Color(0x7F6D6D6D),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 0.sp,
              top: 736.sp,
              child: Container(
                width: 300.w,
                height: 300.h,
                decoration: ShapeDecoration(
                  color: Color(0xCC6D6D6D),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 133.sp,
              top: 277.sp,
              child: Container(
                width: 147.w,
                height: 153.h,
                decoration: ShapeDecoration(
                  color: Color(0x7FC4C4C4),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 74.sp,
              top: 226.sp,
              child: Container(
                width: 59.w,
                height: 59.h,
                decoration: ShapeDecoration(
                  color: Color(0xFF6D6D6D),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 300.sp,
              top: 756.sp,
              child: Container(
                width: 59,
                height: 59,
                decoration: ShapeDecoration(
                  color: Color(0xFF6D6D6D),
                  shape: OvalBorder(),
                ),
              ),
            ),

            // 로그인 상자
            Positioned(
              left: 20.sp,
              right: 20.sp,
              top: 200.sp,
              child: mysignup(),
            ),
            Positioned(
              left: 17.sp,
              top: 522.sp,
              child: IconButton(
                iconSize: 40.sp,
                icon: Icon(Icons.arrow_back),
                color: Color.fromARGB(173, 255, 255, 255),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column mysignup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
               Text(
                'HALLYM UNIV',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.81),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Space Booking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.81),
                  fontSize: 35,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.81),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      fontSize: 16.sp,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      fontSize: 16.sp,
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(115, 0, 0, 0),
                  surfaceTintColor: Color.fromARGB(206, 255, 255, 255),
                  minimumSize: const Size(400, 40),
                ),
                onPressed: _signUp,
                child: Text("Sign Up",
                    style:
                        TextStyle(color: Color.fromARGB(196, 255, 255, 255))),
              ),
              Text(
                _statusMessage,
                style: TextStyle(color: const Color.fromARGB(255, 189, 44, 44)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
