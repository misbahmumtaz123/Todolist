import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todolistt/generated/assets.dart';

import '../../AppComponent/bottomnavBar.dart';
import '../../AppComponent/custombutton.dart';
import '../../Constants/utils.dart';
import '../../Providers/authScreenProvider.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'WElCOME',
                style: GoogleFonts.dynaPuff(
                  textStyle: TextStyle(fontSize: 50,color: AppColors.PrimaryColor),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                Assets.imagesLoginlogo,
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 40),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) => PrimaryButton(
                  width: 300,
                  height: 50,
                  onPressed: () async {
                    try {
                      await authProvider.signInWithGoogle(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const BottomBar()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign-in failed')),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          Assets.imagesGoogle,
                          height: 30,
                          width: 30,
                        ),

                       SizedBox(width: 5),
                       Text(
                          AppText.ContinuewithGoogle,
                          style: TextStyles.h2height20,
                          textAlign: TextAlign.center,
                      ),
                    ],
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
