import 'package:chat_vibe/views/select_source_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff66ccfa),
        body: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.67,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff1052e5),
                        blurRadius: 20,
                        offset: Offset(0, 20),
                        spreadRadius: 3,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: [
                      Text(
                        "ChatVibe",
                        style: GoogleFonts.ubuntu(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff2b446d),
                        ),
                      ),
                      Text(
                        "Stay Connected, Feel the Vibe.",
                        style: GoogleFonts.ubuntu(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(-5, 10),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.15),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: const Icon(
                                  CupertinoIcons.chat_bubble_fill,
                                  size: 270,
                                  color: Colors.black, // Shadow base color
                                ),
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    const Color(0xff76e3ff),
                                    const Color(0xff2863e5),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: const Icon(
                                CupertinoIcons.chat_bubble_fill,
                                size: 270,
                                color: Colors.white,
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 5,
                              right: 0,
                              bottom: 20,
                              child: Icon(
                                CupertinoIcons.mail,
                                color: Colors.white,
                                size: 150,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: NeumorphicButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSourceUserScreen(),
                      ),
                    );
                  },
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(35),
                    ),
                    shadowDarkColor: Color(0xff1f58e7),
                    shadowDarkColorEmboss: Color(0xff1f58e7),
                    shadowLightColorEmboss: Color(0xff72dfff),
                    depth: 12,
                    intensity: 0.9,
                    surfaceIntensity: 0.2,
                    lightSource: LightSource.right,
                    color: const Color(0xFF71dcfc),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      "GETTING STARTED",
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2b446d).withOpacity(0.8),
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
