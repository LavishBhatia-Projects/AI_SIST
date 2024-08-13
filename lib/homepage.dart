import 'dart:ffi';
import 'dart:ui';

import 'package:ai_app/colors.dart';
import 'package:ai_app/featuresList.dart';
import 'package:ai_app/openAIservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String lastWords='';
  final speechTotext=SpeechToText();
  final Openaiservice openaiservice=Openaiservice();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechtoText();
  }
  Future<void> initSpeechtoText() async{
await speechTotext.initialize();
setState(() {

});

  }
  Future <void> startListening() async {
    await speechTotext.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future <void> stopListening() async {
    await speechTotext.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechTotext.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AI-SIST',style:GoogleFonts.archivo(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold
          )
        ) ,),
        leading: GestureDetector(
          onTap: (){},
          child: const Icon(
            Icons.menu
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top:4,),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle
                    ),
                  ),
                ),
                Container(
                  height: 135,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png')),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor
                      ,width:3,
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(16),bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),

              ),
              child: const Text(
                'Hello , Ask me anything that you want to ask',
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 25,
                  fontFamily: 'Cera Pro'
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 45),
              child: const Text('Here are few Features', style:
                TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cera Pro'
                )
              ),),
            SizedBox(height: 10,),
            Column(
              children: [
                Features(Title: 'Chat Gpt', Colors: Pallete.firstSuggestionBoxColor, desc: 'A smartes way to stay organised and informed with ChatGpt ',),
                Features(Title: 'DALL-E', desc: 'Get inspired and stay creative with your personal assistant powered by DALL-E', Colors: Pallete.secondSuggestionBoxColor),
                Features(Title: 'Smart Voice Assistant', desc: 'Get the best result out of AI with your own voice', Colors: Pallete.thirdSuggestionBoxColor),
              ],
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{

        if(await speechTotext.hasPermission && speechTotext.isNotListening){
         await startListening();
        }
        else if(speechTotext.isNotListening){
        final speech = await openaiservice.isArtPromptAPI(lastWords);
        print (speech);
          await stopListening();
        }
        else{
initSpeechtoText();
        }

      },
      child: Icon(Icons.mic),
      ),


    );
  }
}
