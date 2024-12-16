import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/auth_provider.dart';
import 'package:mobileproject/core/helpers/providers/privileges_provider.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';
import 'package:mobileproject/features/home/ui/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
  });
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var userID = "";
  var _obsecureText = true;
  var authError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      setState(() {
        authError = true;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please fill the fields'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
      return;
    }
    _formKey.currentState!.save();

    try {
      await ref
          .read(authProvider.notifier)
          .signIn(_emailController, _passwordController);
      userID = ref.read(authProvider);
      setState(() {
        authError = false;
      });
      await ref.watch(privilegesProvider.notifier).fetchUserData(userID);
    } on FirebaseAuthException catch (error) {
      setState(() {
        authError = true;
      });
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: Text(error.message ?? "Authintication error"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            );
          },
        );
      }
    }

    if (userID != '') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('showHome', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(
            height: 3.h,
          ),
          AppTextField(
            useSuffixIcon: false,
            controller: _emailController,
            hintText: "Enter your email address",
            usePrefixIcon: false,
            isSecuredField: false,
            errorOccurance: authError,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == "") {
                return "";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Password',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(
            height: 3.h,
          ),
          AppTextField(
            useSuffixIcon: false,
            controller: _passwordController,
            usePrefixIcon: false,
            obscureText: _obsecureText,
            hintText: "Enter your password",
            isSecuredField: true,
            onLockIconPressed: () {
              setState(() {
                _obsecureText = !_obsecureText;
              });
            },
            suffixIconVisible: Icons.visibility_off_outlined,
            suffixIconHidden: Icons.visibility_outlined,
            errorOccurance: authError,
            validator: (val) {
              if (val == "") {
                return "";
              }
              return null;
            },
          ),
          Row(
            children: [
              const Text(
                "Forgot your password ?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset your password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          AppTextBtn(
            buttonText: "Log In",
            textStyle: MyTextStyle.font18WhiteSemiBold,
            onPressed: _onLogin,
            buttonWidth: double.maxFinite,
          ),
        ],
      ),
    );
  }
}
