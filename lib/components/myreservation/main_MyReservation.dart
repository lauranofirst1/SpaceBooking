import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp(MaterialApp(home: Myreservation()));
}

class Myreservation extends StatefulWidget {
  const Myreservation({super.key});

  @override
  State<Myreservation> createState() => _MyreservationState();
}

class _MyreservationState extends State<Myreservation> {
  List<String> _times = [];

  @override
  void initState() {
    super.initState();
    _loadTimes();
  }

  Future<void> _loadTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? getmyroom = prefs.getString('myroom');
    final String? gettmp_mytimes = prefs.getString('mytimes');

    if (getmyroom != null) {
      setState(() {
      });
    }

    if (gettmp_mytimes != null) {
      List<String> getmytimes = [];
      List<List<String>> parsedTimes = [];

      for (var inner in gettmp_mytimes.split('],[')) {
        inner = inner.replaceAll(RegExp(r'[\[\]]'), '');
        parsedTimes.add(inner.split(',').map((time) => time.trim()).toList());
      }

      for (var innerList in parsedTimes) {
        for (var time in innerList) {
          if (RegExp(r'^\d{2}:\d{2}$').hasMatch(time)) {
            getmytimes.add(time);
          }
        }
      }

      setState(() {
        _times = getmytimes;
      });
    }
  }

  Future<void> _removeTime(int index) async {
    setState(() {
      _times.removeAt(index);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String updatedTimes = _times.map((time) => '[$time]').join(',');
    await prefs.setString('mytimes', updatedTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(),
    );
  }

  Container background() {
    return Container(
      width: 400.w,
      height: 900.h,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 0, 0)),
      child: Stack(
        children: [
          Positioned(
            left: -49.sp,
            top: -104.sp,
            child: makecircle(),
          ),
          Positioned(
            left: 22.sp,
            top: 100.sp,
            child: Container(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reserve room',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.62),
                      fontSize: 15.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5.sp,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'My Reservation Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          makeline(25, 170),
          Positioned(
            left: -5,
            top: 178.sp,
            child: Container(
              width: 400.w,
              child: FutureBuilder<List<Widget>>(
                future: _buildList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!,
                    );
                  } else {
                    return Center(child: Text('No reservations found.'));
                  }
                },
              ),
            ),
          ),
          makeline(20, 705),
          Positioned(
            left: 22.sp,
            top: 715.sp,
            child: SizedBox(
              width: 338.w,
              child: Text(
                'Here is the list of your mentoring session reservations. If you wish to cancel, please click the X button.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned makeline(double left, double top) {
    return Positioned(
      left: left.sp,
      top: top.sp,
      child: Container(
        width: 335.w,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: Color.fromARGB(160, 255, 255, 255).withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Container makecircle() {
    return Container(
      width: 522.w,
      height: 1099.h,
      child: Stack(
        children: [
          Positioned(
            left: 150.sp,
            top: 0.sp,
            child: Container(
              width: 372.w,
              height: 352.h,
              decoration: ShapeDecoration(
                color: Color(0x7F6D6D6D),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 0.sp,
            top: 799.sp,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: ShapeDecoration(
                color: Color(0xFF353333),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 110.sp,
            top: 188.sp,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: ShapeDecoration(
                  color: Color(0xFF6D6D6D),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 319.sp,
            top: 818.sp,
            child: Container(
              width: 59.w,
              height: 59.h,
              decoration: ShapeDecoration(
                color: Color(0xFF333232),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makebox(String? roomnum, String date, String time, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(99, 255, 255, 255),
        borderRadius: BorderRadius.circular(25),
      ),
      width: 320.w,
      height: 65.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Room $roomnum",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.6.sp,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.53),
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.sp,
                ),
              ),
            ],
          ),
          SizedBox(width: 65,),
          Text(
            time,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 35.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.6.sp,
              height: 1.h,
            ),
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
            
            icon: Icon(Icons.delete, color: Color.fromARGB(74, 255, 255, 255)),
            onPressed: () {
              _removeTime(index);
            },
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _buildList() async {
    // SharedPreferences 인스턴스를 가져옴
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 저장된 데이터 가져오기
    final String? getmyroom = prefs.getString('myroom');
    final String? gettmp_mytimes = prefs.getString('mytimes');

    List<String> getmytimes = [];
    List<Widget> boxWidgets = [];

    // gettmp_mytimes가 null이 아닌 경우에만 처리
    if (gettmp_mytimes != null) {
      // 문자열을 파싱하여 2차원 배열로 변환
      List<List<String>> parsedTimes = [];

      // 문자열을 분할하여 2차원 리스트로 변환
      for (var inner in gettmp_mytimes.split('],[')) {
        inner = inner.replaceAll(RegExp(r'[\[\]]'), ''); // 괄호 제거
        parsedTimes.add(inner.split(',').map((time) => time.trim()).toList());
      }

      // 2차원 배열을 순회하여 시간 문자열을 추출
      for (var innerList in parsedTimes) {
        for (var time in innerList) {
          if (RegExp(r'^\d{2}:\d{2}$').hasMatch(time)) {
            // 00:00 형식인지 체크
            getmytimes.add(time);
          }
        }
      }
    }

    // 위젯 생성
    for (int i = 0; i < getmytimes.length; i++) {
      boxWidgets.add(makebox(getmyroom, "2023-06-05", getmytimes[i], i));
    }

    return boxWidgets;
  }
}
