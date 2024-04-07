import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'home page.dart';


class Otpscreen extends StatefulWidget {
   String verificationid;

  Otpscreen({super.key, required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50),
          Image(image: AssetImage("assets/SVG/img3.jpg"), height: 200),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text("OTP Verification", style: TextStyle(fontWeight: FontWeight.w800)),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.number,
              onSubmit: (code) {
                // Handle OTP submission
                _verifyOtp(code);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                // Verify OTP manually
                _verifyOtp(_otpController.text);
              },
              child: Text("Verify", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _verifyOtp(String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationid,
        smsCode: code,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (ex) {
      log(ex.toString());
      // Handle verification failure
      // Show error message or perform any action accordingly
    }
  }
}
