import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappChatDialer extends StatefulWidget {
  const WhatsappChatDialer({super.key});

  @override
  State<WhatsappChatDialer> createState() => _WhatsappChatDialerState();
}

class _WhatsappChatDialerState extends State<WhatsappChatDialer> {
  //VARIABLES

  String phoneNumber = "";

  String completedLink = "";

//FUNCTION TO LAUNCH WHATSAPP URL
  Future<void> launchWhatsapp({required url}) async {
    await launchUrl(url);
  }

  final TextEditingController _countryCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _countryCode.text = 27.toString();

    return Container(
      height: MediaQuery.of(context).size.height - 100,
//BACKGROUND COLOR
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Country Code",
            style: kTaskTextStyle.copyWith(color: Colors.white),
          ),

//COUNTRY CODE TEXTFIELD

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: kTaskTextStyle.copyWith(color: Colors.white),
                keyboardType: TextInputType.phone,
                controller: _countryCode,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                    prefix: Text("+", style: TextStyle(color: Colors.white)),
                    border: InputBorder.none),
                onChanged: (value) => _countryCode.text = value,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Phone Number",
              style: kTaskTextStyle.copyWith(color: Colors.white)),

//PHONE NUMBER TEXTFIELD

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: kTaskTextStyle.copyWith(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                    ),
                    border: InputBorder.none),
                onChanged: (value) => phoneNumber = value,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
//BUTTON TO LAUNCH URL

          RoundedButton(
              text: "Open Chat",
              onTap: () {
                completedLink =
                    "whatsapp://send/?phone=${_countryCode.text}$phoneNumber&text&type=phone_number";

//CONDITIONALS TO CHECK

//IF NO PHONE NUMBER IS INSERTED
                if (phoneNumber == "") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("You cannot leave the phone number empty.")));

//IF NO COUNTRY CODE IS INSERTED
                } else {
                  if (_countryCode.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("You cannot leave the country code empty.")));

//IF THERE IS A ZERO IN FRONT OF THE NUMBER
                  } else {
                    if (phoneNumber.substring(0, 1) == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please remove the '0' in front of your phone number!")));

//IF EVERYTHING ELSE RUNS FINE
                    } else {
                      var uri = Uri.parse(completedLink);
                      launchWhatsapp(url: uri);
                    }
                  }
                }
              })
        ],
      ),
    );
  }
}
