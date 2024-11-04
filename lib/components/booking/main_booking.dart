import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/components/booking/myselect.dart';
import 'package:intl/intl.dart';

class MentRoomBooking extends StatefulWidget {
  const MentRoomBooking({
    super.key,
  });

  @override
  State<MentRoomBooking> createState() => _MentRoomBookingState();
}

class _MentRoomBookingState extends State<MentRoomBooking> with Myfun {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.black), // 배경
      child: Stack(
        children: [
          circlebackground(),
          booking_button(context),
          Positioned(
            left: 14.sp,
            top: 95.sp,
            child: title(),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 14)));
      

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Positioned booking_button(BuildContext context) {
    return Positioned(
      left: 20.sp,
      top: 635.sp,
      child: Container(
        width: 345.w,
        height: 200.h,
        child: Column(
          children: [
            const Text(
              "   Please select a seat and press the button                   ",
              style: TextStyle(
                color: Color.fromARGB(193, 255, 255, 255),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: 2.0.h,
              width: 320.0.w,
              margin: EdgeInsets.all(5.sp),
              color: const Color.fromARGB(150, 255, 255, 255),
            ),

            const SizedBox(height: 7),
            mystatus(context),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton datebutton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectDate(context),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(320.sp, 33.sp),
          padding: EdgeInsets.all(3.sp), // 버튼의 패딩
          backgroundColor: Color.fromARGB(164, 255, 255, 255),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Text(
          _selectedDate == null
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
          style: TextStyle(
            color: Color.fromARGB(127, 0, 0, 0),
          )),
    );
  }

  Container mystatus(BuildContext context) {
    return Container(
      width: 340.sp,
      height: 100.sp,
      child: Stack(
        children: [
          Positioned(
            left: 160.sp,
            top: 10.sp,
            child: Text(
              '/',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 2,
              ),
            ),
          ),
          Positioned(
            left: 30.sp,
            top: 3.sp,
            child: Container(
              width: 296.sp,
              height: 41.sp,
              child: Stack(
                children: [
                  Positioned(
                    left: 155.sp,
                    top: 17.sp,
                    child: Text(
                      '11:00~13:00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.sp,
                        letterSpacing: 2.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180.sp,
                    top: 0.sp,
                    child: Text(
                      'selected time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.sp,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15.sp,
                    top: 17.sp,
                    child: Text(
                      '1011A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.sp,
                        letterSpacing: 2.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.sp,
                    top: 0.sp,
                    child: Text(
                      'selected room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.sp,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 11,
            child: datebutton(context),
          )
        ],
      ),
    );
  }

  Container title() {
    return Container(
      width: 300.w,
      height: 65.h,
      child: Stack(
        children: [
          Positioned(
            left: 9.sp,
            top: 50.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Currently in Use',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.sp,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 11.w,
                  height: 11.w,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCF4A4A),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  'Available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.sp,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 11.w,
                  height: 11.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFF313131),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 7.sp,
            top: 17.sp,
            child: Text(
              'Mentoring Room Booking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: 2.sp,
              ),
            ),
          ),
          Positioned(
            left: 9.sp,
            top: 0.sp,
            child: Text(
              'Reserve room',
              style: TextStyle(
                color: Colors.white.withOpacity(0.62),
                fontSize: 15.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: 1.50.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned circlebackground() {
    return Positioned(
      left: -49.sp,
      top: -134.sp,
      child: Container(
        // 동그라미 배경
        width: 522.w,
        height: 1099.h,
        child: Stack(
          children: [
            MakingCircle(0, 799, 300, 0xFF353333),
            MakingCircle(110, 188, 150, 0xFF6D6D6D),
            MakingCircle(319, 818, 60, 0xFF333232),
            MakingCircle(150, 0, 360, 0xFF353333),
            MakingCircle(150, 0, 360, 0xFF353333),
            Positioned(
              left: 67.sp,
              top: 310.sp,
              child: Container(
                height: 700.h,
                width: 350.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(93, 255, 255, 255), // 배경2
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: map(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned MakingCircle(double pleft, double ptop, double r, int c) {
    return Positioned(
      left: pleft.sp,
      top: ptop.sp,
      child: Container(
        width: r.w,
        height: r.h,
        decoration: ShapeDecoration(
          color: Color(c).withOpacity(0.4),
          shape: OvalBorder(),
        ),
      ),
    );
  }

  Container map() {
    return Container(
      width: 365.w,
      height: 719.h,
      child: Stack(
        children: [
          Positioned(
            left: 26.sp,
            top: 18.sp,
            child: Container(
              width: 298.w,
              height: 153.43.h,
              child: Stack(
                children: [
                  makeroom(0.0, 27.81, 74.50, 125.62, "4", 3),
                  makeroom(74.5, 27.81, 74.5, 83.11, "3", 2),
                  makeroom(149, 27.81, 74.5, 83.11, "2", 1),
                  makeroom(223.50, 27.81, 74.5, 125.62, "1", 0),
                  title1(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 26.sp,
            top: 180.sp,
            child: Container(
              width: 298.w,
              height: 270.72.h,
              child: Stack(
                children: [
                  makeroom(121.49, 28.80, 74.32, 66.29, "5", 4),
                  makeroom(121.49, 94.10, 74.32, 66.29, "6", 5),
                  makeroom(223.50, 28.74, 74.32, 66.29, "7", 6),
                  makeroom(223.50, 94.04, 74.32, 66.29, "8", 7),
                  makeroom(0, 28.80, 122.2, 131.59, "9", 8),
                  makeroom(122.15, 185.77, 175.85, 76.95, "10", 9),
                  title2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned title2() {
    return Positioned(
      left: 3.47.sp,
      top: 0.sp,
      child: SizedBox(
        width: 193.18.w,
        height: 22.25.h,
        child: Text(
          'SW스타트업 큐브',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6899999976158142),
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 2.10.sp,
          ),
        ),
      ),
    );
  }

  Positioned title1() {
    return Positioned(
      //title
      left: 3.47.sp,
      top: 0.sp,
      child: SizedBox(
        width: 193.18.w,
        height: 22.25.h,
        child: Text(
          'SW멘토링실',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6899999976158142),
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 2.10.sp,
          ),
        ),
      ),
    );
  }
}
