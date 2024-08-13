import 'dart:convert';

import 'package:ai_app/Secrets.dart';
import 'package:http/http.dart'as http;

class Openaiservice{
  final List<Map<String ,String>> messages=[];
  Future<String>isArtPromptAPI(String prompt) async{
   try{
     final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
     headers: {
       'Content-Type' : 'application/json',
       'Authorization': 'Bearer $OpenAiApi',
     },
       body: jsonEncode(
        {
          "model": "gpt-4o-mini-2024-07-18",
          "messages": [
            {
              "role": "user",
              "content": "Does this Message want to generate an AI picture,image,art or anything similar?$prompt.Simply answer with yes or no"
            }
          ]
        }
       )

     );
     print(res.body);
     if(res.statusCode==200){
      String Content = jsonDecode(res.body)[
        'choices'
      ][0]['message']['content'];
      Content=Content.trim();
      switch(Content){
        case 'Yes':
        case 'yes':
          case 'Yes.':
        case 'yes.':
         final res = await DallEAPI(prompt);
         return res;

default:
  final res= await ChatGptApi(prompt);
  return res;

      }
     }
return 'No more Tokens';
   }
   catch(e){
return e.toString();
   }
  }
  Future<String>ChatGptApi(String prompt) async{
    messages.add({
      'role':'user',
      'content':'prompt',
    });
    try{
      final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type' : 'application/json',
            'Authorization': 'Bearer $OpenAiApi',
          },
          body: jsonEncode(
              {
                "model": "gpt-4o-mini-2024-07-18",
                "messages":messages,
              }
          )

      );
      print(res.body);
      if(res.statusCode==200){
        String Content = jsonDecode(res.body)[
        'choices'
        ][0]['message']['content'];
        Content=Content.trim();
        messages.add({
          'role':'assistant',
          'content':Content,
        });
        return Content;
      }
      return 'No more Tokens';
    }
    catch(e){
      return e.toString();
    }

  }
  Future<String>DallEAPI(String prompt) async{
return 'DallE';
  }

}