import 'dart:math';
import 'package:flutter/material.dart';

class AppConstant {
  static final List<Map<String, dynamic>> defaultQues = [
    {
      "title": "Most Popular",
      "question": [
        {
          "icon": Icons.ac_unit,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length)],
          "ques": "What is an alkane, alkene, and alkyne?"
        },
        {
          "icon": Icons.emoji_emotions_rounded,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain SN1 and SN2 reactions with examples."
        },
        {
          "icon": Icons.computer,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is Markovnikov's rule in addition reactions?"
        },
        {
          "icon": Icons.cloud,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are functional groups in organic chemistry?"
        },
        {
          "icon": Icons.label,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain resonance structures with an example."
        },
        {
          "icon": Icons.games_sharp,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the difference between electrophiles and nucleophiles?"
        },
        {
          "icon": Icons.terrain,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain the mechanism of E1 and E2 elimination reactions."
        },
        {
          "icon": Icons.nature_outlined,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are the types of isomerism in organic compounds?"
        }
      ]
    },
    {
      "title": "Trending",
      "question": [
        {
          "icon": Icons.question_mark,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are the common oxidation reactions of alcohols?"
        },
        {
          "icon": Icons.swap_horizontal_circle_outlined,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain nucleophilic aromatic substitution (NAS)."
        },
        {
          "icon": Icons.equalizer_rounded,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the difference between kinetic and thermodynamic control in reactions?"
        },
      ]
    },
    {
      "title": "Advanced",
      "question": [
        {
          "icon": Icons.trending_up_rounded,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Describe the mechanism of the aldol condensation."
        },
        {
          "icon": Icons.align_horizontal_center_outlined,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the significance of stereochemistry in drug design?"
        },
        {
          "icon": Icons.video_collection_outlined,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain the difference between SN1, SN2, E1, and E2 reactions."
        },
        {
          "icon": Icons.monetization_on_outlined,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are carbocations and why are they important in organic reactions?"
        },
      ]
    }
  ];
}