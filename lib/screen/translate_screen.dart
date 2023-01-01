import 'package:flutter/material.dart';
import 'package:quick_translate/model/model.dart';
import 'package:quick_translate/services/services.dart';
import 'screen.dart';

class TranslateScreen extends StatefulWidget {
  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  String writeText = '';
  bool isListening = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  void toggleRecoding() {
    SpeechTextRecognizer.toggleRecording(
      onResult: (text) {
        setState(() {
          _controller.text = text;
          TranslateService.input = _controller.text;
        });
      },
      onListening: (isListening) {
        setState(() {
          this.isListening = isListening;
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0.0,
          title: Row(
            children: [
              Text(
                'Quick ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
              Text(
                'Translate',
                style: TextStyle(
                  color: Color(0xFFFF865E),
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person_outline_sharp),
              iconSize: 30.0,
              color: Colors.black,
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<ProviderService>(
            builder: (context, providerData, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Quick \n translation',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Color(0xFFFEF9EF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          value: providerData.selectedValue1,
                          items: context
                              .read<ProviderService>()
                              .languages
                              .map((values) {
                            return DropdownMenuItem(
                              value: values,
                              child: Text(
                                values,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              providerData.selectedValue1 = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(focusNode),
                          child: Container(
                            height: 100.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFFEF9EF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.black,
                              cursorHeight: 28.0,
                              minLines: 1,
                              maxLines: 3,
                              maxLength: 1000,
                              textAlign: TextAlign.center,
                              focusNode: focusNode,
                              controller: _controller,
                              textInputAction: TextInputAction.done,
                              onChanged: (_) {
                                TranslateService.input = _controller.text;
                              },
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                              ),
                              decoration: InputDecoration(
                                hintText: '텍스트 입력',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    icon: Icon(
                      Icons.sync_alt,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Translate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () async {
                      if (TranslateService.input == '') {
                        writeText = '';
                      } else {
                        var translatedText =
                            await TranslateService.translate(context);
                        writeText = translatedText.text;
                      }

                      setState(() {});
                    },
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Color(0xFFFEF9EF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          value: providerData.selectedValue2,
                          items: context
                              .read<ProviderService>()
                              .languages
                              .map((values) {
                            return DropdownMenuItem(
                              value: values,
                              child: Text(
                                values,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              providerData.selectedValue2 = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 100.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFFEF9EF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            writeText,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomContainer(
                          height: 80.0,
                          width: 80.0,
                          iconSize: 35.0,
                          color: Color(0xFFA2D2FF),
                          icon: Icons.home_filled,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Home',
                        ),
                        CustomContainer(
                          height: 110.0,
                          width: 110.0,
                          iconSize: 45.0,
                          color: Color(0xFFFF865E),
                          icon: isListening ? Icons.stop : Icons.mic,
                          onPressed: toggleRecoding,
                          text: 'Speak',
                        ),
                        CustomContainer(
                          height: 80.0,
                          width: 80.0,
                          color: Color(0xFF9685FF),
                          icon: Icons.camera_alt_outlined,
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              writeText = '';
                            });

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CameraScreen();
                              },
                            ));
                          },
                          text: 'Camera',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
