import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/generated/i18n.dart';
import '../Services/NLU/BertQA/BertQaService.dart';

final recordNoteScaffoldKey = GlobalKey<ScaffoldState>();

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText _speech = SpeechToText();
  late final BertQAService bertQAService;

  bool _isListening = false;
  String _textSpeech = '';

  String? answer;

  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (!isFirstTime) {
      prefs.setBool('first_time', false);
      print('Not the first time here');
      return false;
    } else {
      prefs.setBool('first_time', false);
      Navigator.pushNamed(context, '/create-profile');
      return true;
    }
  }

  void onListen() async {
    if (!_isListening) {
      _textSpeech = "";
      getAnswer();
      bool available = await _speech.initialize(
        onStatus: (val) => {
          if (val == 'notListening') {print('onStatus: $val')}
        },
        onError: (val) => print('onError: $val'),
        debugLogging: true,
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _textSpeech = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
        // check to see if any text was transcribed
        if (_textSpeech != '' &&
            _textSpeech != 'Press the mic button to start') {
          // if it was, then save it as a note
          showConfirmDialog(context);
        }
      });
    }
  }

  void voiceHandler(Map<String, dynamic> inference) {
    if (inference['isUnderstood']) {
      if (inference['intent'] == 'startTranscription') {
        print('start recording');
        onListen();
      }
      if (inference['intent'] == 'searchNotes') {
        print('Searching notes');
        Navigator.pushNamed(context, '/view-notes');
      }
      if (inference['intent'] == 'searchDetails') {
        print('Searching for personal detail');
        Navigator.pushNamed(context, '/view-details');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Sorry, I did not understand'),
          backgroundColor: Colors.deepOrange,
          duration: const Duration(seconds: 1)));
    }
  }

  @override
  void initState() {
    super.initState();
    _isListening = false;
    _speech = SpeechToText();
    bertQAService = BertQAService();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isListening) {
    } else {}

    isFirstTime();

    return Scaffold(
      key: recordNoteScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 80,
          duration: Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: Container(
            width: 200.0,
            height: 200.0,
            child: new RawMaterialButton(
              shape: new CircleBorder(),
              elevation: 0.0,
              child: Column(children: [
                Image(
                  image: AssetImage("assets/images/mic.png"),
                  color: Color(0xFF33ACE3),
                  height: 100,
                  width: 100.82,
                ),
                Text(I18n.of(context)!.notesScreenName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))
              ]),
              onPressed: onListen,
            ),
          )),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 150),
            child: Text(
              _textSpeech,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/view-notes');
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text("The text note was saved successfully."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getAnswer() {
    setState(() {
      answer =
          bertQAService.answer("I have a toothache. I had an appointment with "
              "dentist on monday oct 5th at 9 am. My wife blood pressure is 138."
              " My blood pressure is 140 above.",
              "What is my blood presure?").first.text;
    });
  }
}
