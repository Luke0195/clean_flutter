import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/components/heading_line.dart';

class Welcome extends StatelessWidget{
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeadinLine1(text: 'Faça seu Login'),
                                  SizedBox(height: 8),
                                  Text(
                                    'Partice das enquetes mais nerds comunidade dev!',
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    '🚀 Faça login e vote agora!',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 12),
    ],);
    
  }

}