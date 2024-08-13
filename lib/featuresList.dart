import 'package:flutter/material.dart';
class Features extends StatelessWidget {
  final String Title;
  final String desc;
  final Color Colors;
  const Features({super.key,
  required this.Title,
    required this.desc,
    required this.Colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
      decoration: BoxDecoration(
        color: Colors,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Title,style: TextStyle(
              fontWeight: FontWeight.bold,
                  fontSize: 26,
              fontFamily: 'Cera Pro'
            ),
            ),
          ),

          Text(
            desc,style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'Cera Pro'
          ),
          ),
        ],
      ),
    );
  }
}
