import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_translate/services/services.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  bool textScanning = false;
  bool _isReadOnly = true;

  final picker = ImagePicker();
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    TranslateService.input = '';
    super.dispose();
  }

  Future getImage(ImageSource imageSource) async {
    try {
      final image = await picker.pickImage(source: imageSource);

      if (image != null) {
        textScanning = true;
        _image = File(image.path);
        setState(() {});
        getRecognisedText(image);
      }
    } catch (e) {
      textScanning = false;
      _image = null;
      setState(() {});
      _textEditingController.text = 'Error occued while scanning';
    }
  }

  Widget showImage() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: const Color(0xFFd0CECE),
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        child: _image == null
            ? Center(child: Text('No image selected.'))
            : Image.file(File(_image!.path)),
      ),
    );
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer =
        GoogleMlKit.vision.textRecognizer(script: getTextRecognitionScript());

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    _textEditingController.text = '';

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        _textEditingController.text = _textEditingController.text + line.text;
      }
    }

    try {
      TranslateService.input = _textEditingController.text;
      var translatedText = await TranslateService.translate(context);

      _textEditingController.text = translatedText.text;
      textScanning = false;
      _isReadOnly = false;
      setState(() {});
    } catch (e) {
      textScanning = false;
      _isReadOnly = true;
      _textEditingController.text = 'Scanning Error...';
      setState(() {});
    }
  }

  dynamic getTextRecognitionScript() {
    dynamic textRecognitionScript;

    switch (context.read<ProviderService>().selectedValue1) {
      case '한국어':
        textRecognitionScript = TextRecognitionScript.korean;
        break;
      case '일본어':
        textRecognitionScript = TextRecognitionScript.japanese;
        break;
      case '중국어(간체)':
        textRecognitionScript = TextRecognitionScript.chinese;
        break;
      case '중국어(번체)':
        textRecognitionScript = TextRecognitionScript.chinese;
        break;
      case '스페인어':
        textRecognitionScript = TextRecognitionScript.latin;
        break;
      case '힌디어':
        textRecognitionScript = TextRecognitionScript.devanagiri;
        break;
    }

    return textRecognitionScript;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: const Color(0xFFFF4F3F9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(context.read<ProviderService>().selectedValue1),
                  Icon(Icons.forward_rounded),
                  Text(context.read<ProviderService>().selectedValue2),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: textScanning == false
                  ? showImage()
                  : CircularProgressIndicator(),
            ),
            Container(
              height: 100.0,
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                focusNode: _focusNode,
                controller: _textEditingController,
                readOnly: _textEditingController.text == ''
                    ? _isReadOnly
                    : _isReadOnly,
                expands: true,
                maxLines: null,
                onChanged: (value) {
                  if (_textEditingController.text == '') {
                    FocusScope.of(context).unfocus();
                    _isReadOnly = true;
                  }
                },
                style: TextStyle(
                  letterSpacing: 1.0,
                ),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  isDense: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _textEditingController.text));
                    },
                    icon: Icon(
                      Icons.copy_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 35.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () => getImage(ImageSource.camera),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: IconButton(
                        icon: Icon(Icons.wallpaper),
                        onPressed: () => getImage(ImageSource.gallery),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
