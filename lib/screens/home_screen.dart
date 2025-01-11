import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/search_prev_screen.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/show_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Show>> futureTrendingShows;
  late Future<List<Show>> futurePopularShows;

  @override
  void initState() {
    super.initState();
    futureTrendingShows = fetchTrendShows().then((data) {
      return data.map((show) => Show.fromJson(show)).toList();
    });
    futurePopularShows = fetchPopularShows().then((data) {
      return data.map((show) => Show.fromJson(show)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            floating: false,
            pinned: false,
            centerTitle: true,
            title: const Text(
              'SHOWS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Show>>(
              future: futureTrendingShows,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No trending shows available', style: TextStyle(color: Colors.white)));
                }
                List<Show> trendingShows = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Trending Now',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 300, // Keep the height for a prominent display
                        aspectRatio: 16 / 9, // Aspect ratio for better layout control
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        enlargeCenterPage: true,
                        viewportFraction: 0.9, // Increased to make the images wider
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      itemCount: trendingShows.length,
                      itemBuilder: (context, index, realIndex) {
                        final show = trendingShows[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPrevScreen(url: show.links),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                show.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(Icons.tv, color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Show>>(
              future: futurePopularShows,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No popular shows available', style: TextStyle(color: Colors.white)));
                }
                List<Show> popularShows = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Popular on Shows',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: popularShows.length,
                      itemBuilder: (context, index) {
                        final show = popularShows[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPrevScreen(url: show.links),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShowCard(show: show),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
