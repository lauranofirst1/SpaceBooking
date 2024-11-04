import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/mylogin/mysignin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/booking/main_booking.dart';
import 'components/myreservation/main_MyReservation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

late SharedPreferences prefs;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();
  
  // 앱 시작
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    
    
    return ScreenUtilInit(
      designSize: const Size(380, 780),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Firebase 인증 상태 변경을 감지하여 화면을 결정
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User? user = snapshot.data;
                return user == null ? SignInPage() : MyHomePage(title: 'appTitle', user: user);
              }
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    MentRoomBooking(),
    Myreservation(),
  ];

  @override
  void initState() {
    super.initState();
    // 사용자가 인증된 후 MyHomePage로 접근할 때 데이터베이스에 쓰기
    _writeToDatabase();
  }

  // 데이터베이스에 쓰기 함수
  void _writeToDatabase() async {
    FirebaseDatabase realtimeDatabase = FirebaseDatabase.instance;
    try {
      await realtimeDatabase.ref().child("test").set({
        "testId": 123,
      });
      print("Data written to database successfully.");
    } catch (error) {
      print("Database write error: $error");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listTileTextStyle = TextStyle(
      color: Color.fromARGB(174, 255, 255, 255),
      fontSize: 15.sp,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      letterSpacing: 2,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu,
                  color: Color.fromARGB(145, 255, 255, 255), size: 30),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              padding: EdgeInsets.all(20.0.sp),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black.withOpacity(0.7),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
                backgroundColor: Color.fromARGB(106, 255, 255, 255),
              ),
              accountName: Text(
                'User',
                style: TextStyle(
                  color: Color.fromARGB(106, 255, 255, 255),
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
              accountEmail: Text(
                widget.user.email ?? 'No email',
                style: TextStyle(
                  color: Color.fromARGB(174, 255, 255, 255),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.only()),
            ),
            ListTile(
              title: Text(
                'Mentoring Room Booking',
                style: listTileTextStyle,
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            const Divider(color: Color.fromARGB(76, 255, 255, 255)),
            ListTile(
              title: Text(
                'My Reservation Status',
                style: listTileTextStyle,
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            const Divider(color: Color.fromARGB(76, 255, 255, 255)),
            SizedBox(height: 300),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Divider(color: Color.fromARGB(137, 255, 255, 255)),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(
                      'Logout',
                      style: listTileTextStyle,
                    ),
                    onTap: () async {
                      await _signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("로그아웃 중 오류가 발생했습니다."),
        ),
      );
    }
  }
}
