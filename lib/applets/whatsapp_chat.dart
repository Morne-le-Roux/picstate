import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappChatDialer extends StatefulWidget {
  const WhatsappChatDialer({super.key});

  @override
  State<WhatsappChatDialer> createState() => _WhatsappChatDialerState();
}

class _WhatsappChatDialerState extends State<WhatsappChatDialer> {
  //VARIABLES

  String phoneNumber = "";

  // String api = "https://wa.me/";
  String completedLink = "";

//FUNCTION TO LAUNCH WHATSAPP URL
  Future<void> launchWhatsapp({required url}) async {
    await launchUrl(url);
  }

  //whatsapp://send/?phone=27710908116&text&type=phone_number&app_absent=0 could not be loaded because:

  final TextEditingController _countryCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _countryCode.text = 27.toString();

    return Container(
//BACKGROUND COLOR
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Country Code"),

//COUNTRY CODE TEXTFIELD

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              elevation: 3,
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3,
                        //BORDER COLOR
                        color: Colors.amber),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: _countryCode,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.map_outlined),
                      prefix: Text("+"),
                      border: InputBorder.none),
                  onChanged: (value) => _countryCode.text = value,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Phone Number"),

//PHONE NUMBER TEXTFIELD

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3,
                        //BORDER COLOR
                        color: Colors.amber),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone_outlined),
                      border: InputBorder.none),
                  onChanged: (value) => phoneNumber = value,
                ),
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
