import 'package:flutter/material.dart';
import '../data/animal_data.dart';
import '../logic/fortune_calculator.dart';
import '../models/animal.dart';

class ResultScreen extends StatelessWidget {
  final DateTime birthday;

  const ResultScreen({super.key, required this.birthday});

  @override
  Widget build(BuildContext context) {
    // 動物キャラIDを計算
    final int? animalId = FortuneCalculator.calculateAnimalId(birthday);
    
    // IDに対応する動物データを検索
    Animal? animal;
    if (animalId != null) {
      try {
        animal = animalData.firstWhere((animal) => animal.id == animalId);
      } catch (e) {
        // 見つからなかった場合はnullのまま
        animal = null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: animal != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      animal.character,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '（${animal.name}）',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      animal.description,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: animal.keywords
                          .map((keyword) => Chip(label: Text(keyword)))
                          .toList(),
                    ),
                  ],
                )
              : const Text('診断結果が見つかりませんでした。'),
        ),
      ),
    );
  }
}
