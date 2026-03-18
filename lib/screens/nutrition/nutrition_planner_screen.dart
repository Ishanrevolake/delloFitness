import 'package:flutter/material.dart';
import '../../services/mock_data_service.dart';
import 'meal_detail_screen.dart';
import 'dart:math' as math;

class NutritionPlannerScreen extends StatefulWidget {
  const NutritionPlannerScreen({super.key});

  @override
  State<NutritionPlannerScreen> createState() => _NutritionPlannerScreenState();
}

class _NutritionPlannerScreenState extends State<NutritionPlannerScreen> {
  final double _targetCalories = 2200;
  late int _waterGlasses;
  late int _veggieCount;
  late int _fruitCount;
  final int _waterTarget = 8;
  final int _veggieTarget = 5;
  final int _fruitTarget = 3;

  @override
  void initState() {
    super.initState();
    _waterGlasses = MockDataService.getStat('water');
    _veggieCount = MockDataService.getStat('veggies');
    _fruitCount = MockDataService.getStat('fruits');
  }

  void _updateStat(String key, int value) {
    setState(() {
      if (key == 'water') _waterGlasses = value;
      if (key == 'veggies') _veggieCount = value;
      if (key == 'fruits') _fruitCount = value;
      MockDataService.setStat(key, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('NUTRITION', 
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 13)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalorieOverview(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('DAILY MEALS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildVerticalMealList(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('SUGGESTED RECIPES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildRecipeList(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('DAILY TRACKERS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildTrackerCard('Hydration', 'Daily Target: $_waterTarget glasses', _waterGlasses, _waterTarget, Icons.local_drink_outlined, const Color(0xFF42A5F5), 'water'),
              const SizedBox(height: 12),
              _buildTrackerCard('Vegetables', 'Daily Target: $_veggieTarget servings', _veggieCount, _veggieTarget, Icons.eco_outlined, const Color(0xFF66BB6A), 'veggies'),
              const SizedBox(height: 12),
              _buildTrackerCard('Fruits', 'Daily Target: $_fruitTarget servings', _fruitCount, _fruitTarget, Icons.apple_outlined, const Color(0xFFFFA726), 'fruits'),
              const SizedBox(height: 24),
              _buildNutritionTip(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalorieOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('REMAINING', style: TextStyle(color: Colors.white24, fontSize: 9, letterSpacing: 1.5)),
                     const SizedBox(height: 2),
                     Text('${_targetCalories.toInt()}', 
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Colors.white)),
                     const Text('kcal', style: TextStyle(color: Colors.white12, fontSize: 12)),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: 0.65,
                      strokeWidth: 3,
                      backgroundColor: Colors.white.withOpacity(0.03),
                      color: const Color(0xFFCCFF00),
                    ),
                  ),
                  const Text('65%', style: TextStyle(fontSize: 12, color: Color(0xFFCCFF00))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroItem('Protein', '110/180g', 0.6, const Color(0xFFCCFF00)),
              _buildMacroItem('Carbs', '140/250g', 0.5, const Color(0xFF42A5F5)),
              _buildMacroItem('Fats', '45/70g', 0.6, const Color(0xFFFFA726)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, String val, double progress, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white24, fontSize: 9, letterSpacing: 0.5)),
          const SizedBox(height: 2),
          Text(val, style: const TextStyle(fontSize: 11, color: Colors.white60, fontWeight: FontWeight.w300)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(right: 8),
            height: 2,
            color: Colors.white.withOpacity(0.05),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(color: color.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalMealList() {
    return Column(
      children: [
        _buildMealCard('Breakfast', '0 kcal', Icons.wb_sunny_outlined, const Color(0xFFFFA726)),
        _buildMealCard('Lunch', '0 kcal', Icons.light_mode_outlined, const Color(0xFF66BB6A)),
        _buildMealCard('Snacks', '0 kcal', Icons.cookie_outlined, const Color(0xFFAB47BC)),
        _buildMealCard('Dinner', '0 kcal', Icons.nights_stay_outlined, const Color(0xFF42A5F5)),
      ],
    );
  }

  Widget _buildMealCard(String title, String kcal, IconData icon, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealDetailScreen(category: title)),
          );
        },
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accentColor, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
        subtitle: const Text('No meals added yet', style: TextStyle(color: Colors.white24, fontSize: 11)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(kcal, style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white54)),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.white10, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRecipeCard('Avocado Toast', '240 kcal', '12 min', 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop'),
          _buildRecipeCard('Quinoa Bowl', '350 kcal', '20 min', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=200&auto=format&fit=crop'),
          _buildRecipeCard('Berry Smoothie', '180 kcal', '5 min', 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?q=80&w=200&auto=format&fit=crop'),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, String kcal, String time, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 80, width: double.infinity, fit: BoxFit.cover, 
              errorBuilder: (c, e, s) => Container(height: 80, color: Colors.white.withOpacity(0.05))),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kcal, style: const TextStyle(color: Colors.white24, fontSize: 10)),
                    Text(time, style: const TextStyle(color: Colors.white24, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerCard(String title, String subtitle, int count, int target, IconData icon, Color color, String type) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.15), fontSize: 11)),
                ],
              ),
              Text('$count/$target', style: TextStyle(color: color.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w300)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(math.max(target, count), (index) {
                      final isFilled = index < count;
                      return GestureDetector(
                        onTap: () => _updateStat(type, index + 1),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            icon,
                            color: isFilled ? color.withOpacity(0.7) : Colors.white10,
                            size: 20,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.add_circle_outline, color: color.withOpacity(0.5), size: 24),
                onPressed: () => _updateStat(type, count + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFCCFF00).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.05)),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Color(0xFFCCFF00), size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Drinking 500ml of water before meals can boost metabolism by 30%.',
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
