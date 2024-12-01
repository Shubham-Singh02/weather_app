import 'package:flutter/material.dart';


class ForecastHours extends StatelessWidget {

  final String time;
  final String temp;
  final IconData icon;
  const ForecastHours({super.key,
  required this.time,
  required this.temp,
  required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child:  Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(time,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ) ,
                          ),
                      
                          const SizedBox(
                            height: 8,
                          ),
                      
                          Icon(icon,
                          size: 32 ,
                          color: Colors.amber[200],
                          ),
                      
                         const  SizedBox(
                            height: 8,
                          ),
                      
                          Text(temp,
                          style: const TextStyle(
                            fontSize: 14,
                          ),),
                      
                          const SizedBox(
                            height: 8,
                          )
                      
                      
                      
                        ],
                      ),
                    ),
                  );
            
  }
}