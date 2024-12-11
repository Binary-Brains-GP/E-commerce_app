import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/auth_provider.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';
import 'package:mobileproject/features/home/ui/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var userID = '';
  var _obsecureText = true;
  var authError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() async {
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
          .signUp(_emailController, _passwordController);
      userID = ref.read(authProvider);
      setState(() {
        authError = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('showHome', true);
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full name',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(
            height: 3.h,
          ),
          AppTextField(
            controller: _fullNameController,
            hintText: "Enter your full name",
            isSecuredField: false,
            usePrefixIcon: false,
            errorOccurance: authError,
            useSuffixIcon: false,
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
            'Email',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(
            height: 3.h,
          ),
          AppTextField(
            controller: _emailController,
            hintText: "Enter your email address",
            isSecuredField: false,
            usePrefixIcon: false,
            errorOccurance: authError,
            keyboardType: TextInputType.emailAddress,
            useSuffixIcon: false,
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
            controller: _passwordController,
            hintText: "Enter your password",
            isSecuredField: true,
            obscureText: _obsecureText,
            suffixIconHidden: Icons.visibility_outlined,
            suffixIconVisible: Icons.visibility_off_outlined,
            usePrefixIcon: false,
            errorOccurance: authError,
            useSuffixIcon: false,
            onLockIconPressed: () {
              setState(() {
                _obsecureText = !_obsecureText;
              });
            },
            validator: (val) {
              if (val == "") {
                return "";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          AppTextBtn(
            buttonText: "Sign Up",
            textStyle: MyTextStyle.font18WhiteSemiBold,
            onPressed: _onSignUp,
            buttonWidth: double.maxFinite,
          ),
        ],
      ),
    );
  }
}
