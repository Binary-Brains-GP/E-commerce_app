import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialmediaOptions extends StatelessWidget {
  const SocialmediaOptions({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                thickness: 1,
                indent: 20,
                endIndent: 10,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
                endIndent: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(EdgeInsets.all(15)),
                side: const WidgetStatePropertyAll(
                  BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 211, 211, 211),
                  ),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text(
                    'Sign Up with Google',
                    style: TextStyle(color: Colors.black87, fontSize: 18.sp),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 24, 119, 242)),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(15)),
                side: const WidgetStatePropertyAll(
                  BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 211, 211, 211),
                  ),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text(
                    'Sign Up with Facebook',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
