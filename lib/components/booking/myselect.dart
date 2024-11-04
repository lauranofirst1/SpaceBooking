import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/main.dart';


mixin Myfun {
  var tmptm = [[], [], [], [], [], [], [], [], [], []];
  String? selectedRoom; // 선택된 방 (하나만 선택)
  var isCheck = false; //활성화

  ElevatedButton makingbutton(BuildContext context, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(113, 255, 255, 255),
        surfaceTintColor: const Color.fromARGB(0, 255, 255, 255),
        minimumSize: const Size(140, 30),
      ),
      onPressed: () async {
        if (text == "Select") {
          if (selectedRoom != null && selectedRoom!.isNotEmpty) {
            await prefs.setString('myroom', selectedRoom!);
          }

          String tmpmytimes = tmptm.toString();
          await prefs.setString('mytimes', tmpmytimes);
          // Filter out empty lists and convert tmptm to a List<String> format
          Navigator.of(context).pop();
          
          


        } else if (text == "Cancel") {
          Navigator.of(context).pop();
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: const Color.fromARGB(188, 0, 0, 0).withOpacity(0.62),
          fontSize: 12.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: 2.sp,
        ),
      ),
    );
  }

  Positioned makeroom(double rl, double rt, double width, double height,
      String roomnum, int id) {
    return Positioned(
        left: rl.sp,
        top: rt.sp,
        child: Builder(
            builder: (context) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(113, 255, 255, 255),
                    surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color.fromARGB(77, 0, 0, 0),
                      width: 3.0,
                    ),
                    minimumSize: Size(width.w, height.h),
                    maximumSize: Size(width.w, height.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ///

                    modalsheet(context, roomnum, id);
                    selectedRoom = roomnum; // 방 선택
                    print("Selected room: $selectedRoom");
                  },
                  child: Text(
                    roomnum,
                    style: TextStyle(
                      color: const Color.fromARGB(122, 255, 255, 255)
                          .withOpacity(0.62),
                      fontSize: 11.sp,
                      fontFamily: 'Inter',
                      letterSpacing: 0.sp,
                    ),
                  ),
                )));
  }

  void modalsheet(BuildContext context, String roomnum, int id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter update) => Container(
            width: 347.w,
            height: 700.h,
            child: Stack(
              children: [
                Positioned(
                  left: 18.sp,
                  right: 18.sp,
                  top: 82.sp,
                  child: Container(
                    width: 293.w,
                    height: 700.h,
                    child: Stack(
                      children: [
                        timeselect(0, 330, 140, 40, '17:00', update, id),
                        timeselect(150, 330, 140, 40, '18:00', update, id),
                        timeselect(0, 250, 140, 40, '15:00', update, id),
                        timeselect(150, 250, 140, 40, '16:00', update, id),
                        timeselect(0, 170, 140, 40, '13:00', update, id),
                        timeselect(150, 170, 140, 40, '14:00', update, id),
                        timeselect(0, 90, 140, 40, '11:00', update, id),
                        timeselect(150, 90, 140, 40, '12:00', update, id),
                        timeselect(0, 10, 140, 40, '09:00', update, id),
                        timeselect(150, 10, 140, 40, '10:00', update, id),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15.sp,
                  top: 9.sp,
                  child: Container(
                    width: 316.w,
                    height: 2000.h,
                    child: Stack(
                      children: [
                        makeline(0, 72),
                        writemessage('Select Appointment Time', 7, 12, 16),
                        makeline(0, 500),
                        writemessage('Room ' + roomnum, 7, 40, 13),
                        writemessage(
                            'Each person can book up to 3 hours. \nPlease select your desired time slot and click the button below.',
                            7,
                            515,
                            10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 1150.sp), // 스크린에 맞게 조정된 높이
                            makingbutton(context, "Select"),
                            SizedBox(width: 20.sp), // 스크린에 맞게 조정된 너비
                            makingbutton(context, "Cancel"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      barrierColor: const Color.fromARGB(40, 255, 255, 255).withOpacity(0.5),
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(172, 0, 0, 0),
    );
  }

  Positioned writemessage(
      String text, double left, double top, double fontSize) {
    return Positioned(
      left: left.sp,
      top: top.sp,
      child: SizedBox(
        width: 300.w,
        height: 50.h,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: fontSize.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 1.60.sp,
          ),
        ),
      ),
    );
  }

  Positioned makeline(double left, double top) {
    return Positioned(
      left: left.sp,
      top: top.sp,
      child: Container(
        width: 316.w,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.h,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color.fromARGB(160, 255, 255, 255).withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Positioned timeselect(double left, double top, double width, double height,
      String ttext, StateSetter update, int id) {
    return Positioned(
      left: left.sp,
      top: top.sp,
      child: TextButton(
        onPressed: () {
          
          
          update(() {
            if (tmptm[id].contains(ttext)) {
              tmptm[id].remove(ttext);
            } else if (tmptm[id].length < 3) {
              tmptm[id].add(ttext);
            }
            print(tmptm[id]);
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          surfaceTintColor: const Color.fromARGB(0, 132, 107, 107),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          side: const BorderSide(
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0,
          ),
          minimumSize: Size(width.w, height.h),
        ),
        child: Text(
          ttext,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: tmptm[id].contains(ttext)
                ? const Color.fromARGB(210, 244, 59, 46)
                : Colors.white.withOpacity(0.5799999833106995),
            fontSize: 40.sp,
            fontFamily: 'Literata',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 4.sp,
          ),
        ),
      ),
    );
  }
}
