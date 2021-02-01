import 'package:arm_chat/screens/chat_screen.dart';
import 'package:arm_chat/services/auth_service.dart';
import 'package:arm_chat/utils/constants.dart';
import 'package:arm_chat/widgets/alt_auth_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isBusy = false;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<String> _authAction(BuildContext context, bool isLogin) async {
    String message;
    bool result = false;
    if ((_emailController.text?.isEmpty ?? false) ||
        (_passwordController.text?.isEmpty ?? false)) {
      message = 'Email and / or password cannot be empty';
    } else {
      try {
        setState(() {
          _isBusy = true;
        });
        if (isLogin) {
          result = await context.read<AuthenticationService>().loginAsync(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
        } else {
          result = await context.read<AuthenticationService>().registerAsync(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
        }
        if (result) {
          setState(() {
            _isBusy = false;
          });
          Navigator.of(context)
              .pushNamedAndRemoveUntil(ChatScreen.id, (_) => false);
          return "Success";
        }
      } catch (e) {
        setState(() {
          _isBusy = false;
        });
        message = e.message;
      }
    }
    _showSnack(context, message);
    return "Failed";
  }

  void _showSnack(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message ?? 'An error occurred.'),
        backgroundColor: kPrimaryColor,
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: kAppPadding.copyWith(top: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          _isLogin ? 'Welcome' : 'Create an account',
                          style: kDefaultFontStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: bigFont,
                          ),
                        ),
                      ),
                    ),
                    kAppInputSpacingVertical,
                    TextFormField(
                      controller: _emailController,
                      style: kInputTextStyle.copyWith(color: kPrimaryColor),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'EMAIL',
                        labelText: 'EMAIL',
                      ),
                    ),
                    kAppInputSpacingVertical,
                    TextFormField(
                      controller: _passwordController,
                      style: kInputTextStyle.copyWith(color: kPrimaryColor),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'PASSWORD',
                        labelText: 'PASSWORD',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    kAppSpacingVertical,
                    TextButton(
                      onPressed: () async {
                        await _authAction(context, _isLogin);
                      },
                      child: _isBusy
                          ? CircularProgressIndicator(
                              backgroundColor: kPrimaryColor,
                            )
                          : Text(_isLogin ? 'Login' : 'Sign up'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AltAuthAction(
                        defaultStyle: kSmallTextStyle,
                        leadingText: _isLogin
                            ? 'Don\'t have an account? '
                            : 'Already have an account? ',
                        actionText: _isLogin ? 'Sign up' : 'Login',
                        actionStyle: kSmallTextStyle.copyWith(
                          color: kPrimaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
