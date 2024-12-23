import 'package:flutter/material.dart';

class SizePage extends StatefulWidget {
  const SizePage({super.key});

  @override
  State<SizePage> createState() => _SizePageState();
}

class _SizePageState extends State<SizePage> {
  late TextEditingController tobesized;
  late double sizeText;

  @override
  void initState() {
    super.initState();
    tobesized = TextEditingController();
    sizeText = 0;
  }

  @override
  void dispose() {
    super.dispose();
    tobesized.dispose();
    sizeText = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                cursorColor: Colors.black,
                enabled: true, //get this value
                controller: tobesized,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade400,
                  labelText: "Input word to find it's size",
                  floatingLabelStyle: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: tobesized.text == ""
                        ? () {}
                        : () {
                            final textSpan = TextSpan(
                              text: tobesized.text,
                              style: DefaultTextStyle.of(context).style,
                            );
                            final media = MediaQuery.of(context);
                            final tp = TextPainter(
                              text: textSpan,
                              textDirection: TextDirection.ltr,
                              textScaler: media.textScaler,
                            );
                            tp.layout();
                            setState(() {
                              sizeText = tp.size.width;
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Change"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(sizeText.toString())),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
