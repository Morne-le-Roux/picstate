import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappChatDialer extends StatefulWidget {
  const WhatsappChatDialer({super.key});

  @override
  State<WhatsappChatDialer> createState() => _WhatsappChatDialerState();
}

class _WhatsappChatDialerState extends State<WhatsappChatDialer> {
  //VARIABLES
  String countryCode = "";
  String phoneNumber = "";
  String api = "https://wa.me/";
  String completedLink = "";

//FUNCTION TO LAUNCH WHATSAPP URL
  Future<void> launchWhatsapp({required url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  final TextEditingController _countryCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _countryCode.text = 27.toString();
    countryCode = _countryCode.text;
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
                        //BORDER COLOR
                        color: Colors.amber),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: _countryCode,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.map_outlined),
                      prefix: Text("+"),
                      border: InputBorder.none),
                  onChanged: (value) => countryCode = _countryCode.text,
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
                        //BORDER COLOR
                        color: Colors.amber),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
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

          GestureDetector(
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              elevation: 3,
              child: Container(
                height: 50,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Open Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

//ON TAP

            onTap: () {
              completedLink = "$api$countryCode$phoneNumber";

//CONDITIONALS TO CHECK

//IF NO PHONE NUMBER IS INSERTED
              if (phoneNumber == "") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("You cannot leave the phone number empty.")));

//IF NO COUNTRY CODE IS INSERTED
              } else {
                if (countryCode == "") {
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
            },
          ),
        ],
      ),
    );
  }
}
