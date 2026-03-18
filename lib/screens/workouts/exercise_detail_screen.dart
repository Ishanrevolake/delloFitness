import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late List<Map<String, dynamic>> _sets;

  @override
  void initState() {
    super.initState();
    // Initialize sets based on exercise data
    _sets = List.generate(
      widget.exercise.sets,
      (index) => {
        'setNum': index + 1,
        'reps': widget.exercise.reps,
        'weight': widget.exercise.weight ?? 'Bodyweight',
        'isDone': false,
      },
    );
    _controller = YoutubePlayerController(
      initialVideoId: widget.exercise.videoId ?? 'v770X3mAn_8',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  late YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text(widget.exercise.name.toUpperCase(), 
          style: const TextStyle(letterSpacing: 1.5, fontSize: 14, fontWeight: FontWeight.w400)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVideoPlayer(),
                  const SizedBox(height: 24),
                  Text(widget.exercise.name, 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 8),
                  const Text(
                    'Keep shoulders loose and grip intact. Focus on the squeeze at the bottom of the movement.',
                    style: TextStyle(color: Color(0x8AFDFBD4), fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  ..._sets.map((set) => _buildSetCard(set)).toList(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    ));
  }

  Widget _buildVideoPlayer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFF66BB6A),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFF66BB6A),
          handleColor: Color(0xFF66BB6A),
        ),
      ),
    );
  }

  Widget _buildSetCard(Map<String, dynamic> setData) {
    final bool isDone = setData['isDone'];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFF66BB6A).withOpacity(0.05) : const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDone ? const Color(0xFF66BB6A).withOpacity(0.3) : Color(0xFFFDFBD4).withOpacity(0.05)
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('SET 0${setData['setNum']}', 
                style: TextStyle(
                  color: isDone ? const Color(0xFF66BB6A) : Color(0x3DFDFBD4), 
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  letterSpacing: 1,
                )),
              const Spacer(),
              Text('${setData['reps']} REPS', 
                style: const TextStyle(fontWeight: FontWeight.w400, color: Color(0xB3FDFBD4))),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0x1FFDFBD4)),
                ),
                child: Text(setData['weight'], 
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xB3FDFBD4))),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  setData['isDone'] = !setData['isDone'];
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: isDone ? Colors.transparent : const Color(0xFF66BB6A)),
                backgroundColor: isDone ? const Color(0xFF66BB6A) : Colors.transparent,
                foregroundColor: isDone ? Colors.white : const Color(0xFF66BB6A),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isDone ? 'COMPLETED' : 'MARK AS DONE', 
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    final allDone = _sets.every((s) => s['isDone']);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(top: BorderSide(color: Color(0xFFFDFBD4).withOpacity(0.05))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (allDone) {
              widget.exercise.isCompleted = true;
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: allDone ? const Color(0xFFDC143C) : Color(0x1AFDFBD4),
            foregroundColor: allDone ? Colors.white : Color(0x61FDFBD4),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('COMPLETE EXERCISE', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1)),
        ),
      ),
    );
  }
}
