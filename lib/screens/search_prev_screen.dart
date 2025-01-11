import 'package:flutter/material.dart';
import 'package:movie_app/models/search_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/elevated_box.dart';

class SearchPrevScreen extends StatefulWidget {
  final String url;

  const SearchPrevScreen({super.key, required this.url});

  @override
  State<SearchPrevScreen> createState() => _SearchPrevScreenState();
}

class _SearchPrevScreenState extends State<SearchPrevScreen> {
  late Future<Show> futureShow;

  @override
  void initState() {
    super.initState();
    futureShow = fetchShowDetails(widget.url);
  }

  Future<Show> fetchShowDetails(String url) async {
    final data = await searchPage(url);
    return Show.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Show>(
        future: futureShow,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No details available.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          final show = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (show.imageUrl.isNotEmpty)
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(show.imageUrl), fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (show.runtime != null || show.language != null || (show.genres.isNotEmpty))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (show.runtime != null) _DetailBox(label: 'Runtime', value: '${show.runtime} mins'),
                          if (show.language != null) _DetailBox(label: 'Language', value: show.language),
                          if (show.genres.isNotEmpty) _DetailBox(label: 'Genre', value: show.genres.join(', ')),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    show.summary,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailBox extends StatelessWidget {
  final String label;
  final String value;

  const _DetailBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
