import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/firebase_options.dart';
import 'core/routing/app_router.dart';
import 'mobile_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  //final prefs = await SharedPreferences.getInstance();
  //final showHome = prefs.getBool("showHome") ?? false;
  runApp(ProviderScope(
    child: MobileTask(
      appRouter: AppRouter(),
    ),
  ));
}
