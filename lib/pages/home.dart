import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cache.dart';
import '../joke_card.dart';
import '../joke_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _JokeListPageState createState() => _JokeListPageState();
}

class _JokeListPageState extends State<HomePage> {
  final JokeService _jokeService = JokeService();
  final AppCache _cache = AppCache();
  final CardView _cardView = CardView();
  List<Map<String, dynamic>> _jokesRaw = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cache.initPrefs();
  }

  void getJokesData() {
    setState(() {
      _jokesRaw = _cache.getJokesData();
    });
  }

  Future<void> _fetchJokes() async {
    setState(() => _isLoading = true);
    try {
      _jokesRaw = await _jokeService.fetchJokesRaw();
      _cache.saveJokesData(_jokesRaw);
      setState(() => _isLoading = false);
    } catch (e) {
      getJokesData();
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade800],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/joke.svg',
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(
                        Colors.tealAccent, BlendMode.srcIn),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Discover programming jokes!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchJokes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  shadowColor: Colors.black54,
                  elevation: 5,
                ),
                child: const Text('I Need Jokes'),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Colors.tealAccent))
                    : _buildJokeList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJokeList() {
    if (_jokesRaw.isEmpty) {
      return const Center(
        child: Text(
          'No jokes fetched yet.',
          style: TextStyle(fontSize: 18, color: Colors.tealAccent),
        ),
      );
    }
    return ListView.builder(
      itemCount: _jokesRaw.length,
      itemBuilder: (context, index) {
        final jokeJson = _jokesRaw[index];
        return _cardView.cardView(jokeJson);
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Joke App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      backgroundColor: Colors.teal,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(0),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/left-arrow.svg',
            height: 30,
            width: 30,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(12),
            alignment: Alignment.center,
            width: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
