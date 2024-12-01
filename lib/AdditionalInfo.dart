import 'package:flutter/material.dart';


class AdditionalInfo extends StatelessWidget {

  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
     children: [
      Icon(icon,
      color: Colors.white60,
      size: 32,),
             
             
      const SizedBox(
       height: 10,
      ),
             
       Text(label,
       style: const TextStyle(
         fontSize: 18,
       ),),
             
       Text(value,
       style: const TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.bold,
             ),
       )
             
             
     ],
                        );
  }
}

