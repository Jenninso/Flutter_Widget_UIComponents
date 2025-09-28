import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modified - Flutter Widget UIComponents',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Image list (reused from the original sample)
  final List<Map<String, String>> images = [
    {
      'url': 'https://4kwallpapers.com/images/walls/thumbs_2t/13495.jpg',
      'title': 'Landscape'
    },
    {
      'url': 'https://wallpapercat.com/w/full/0/a/8/319915-3840x2160-desktop-4k-iron-man-background.jpg',
      'title': 'Iron Man'
    },
    {
      'url': 'https://c4.wallpaperflare.com/wallpaper/1022/408/961/tv-show-ben-10-ben-tennyson-wallpaper-preview.jpg',
      'title': 'Ben 10'
    },
    {
      'url': 'https://c4.wallpaperflare.com/wallpaper/724/879/773/prabhas-bahubali-part-2-wallpaper-preview.jpg',
      'title': 'Bahubali'
    },
  ];

  // Keep track of favorites (example interactive change)
  final Set<int> favourites = {};

  // MODIFIED: Added interaction - toggle favorite and shuffle
  void _toggleFavorite(int index) {
    setState(() {
      if (favourites.contains(index)) {
        favourites.remove(index);
      } else {
        favourites.add(index);
      }
    });
    final snack = SnackBar(
      content: Text(favourites.contains(index)
          ? 'Added to favorites'
          : 'Removed from favorites'),
      duration: Duration(milliseconds: 700),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void _shuffleImages() {
    setState(() {
      images.shuffle();
      favourites.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Image Cards (Modified)'),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            tooltip: 'Shuffle Images',
            onPressed: _shuffleImages,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Short description (MODIFIED: new UI element)
              Text(
                'Modified horizontal list with rounded cards, overlay labels, and favorite interaction',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 12),

              // MODIFIED: Horizontal scrollable card list with improved styling
              SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final item = images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: GestureDetector(
                        onTap: () => _toggleFavorite(index),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 220,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    item['url']!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Center(
                                          child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes != null
                                            ? progress.cumulativeBytesLoaded /
                                                (progress.expectedTotalBytes ?? 1)
                                            : null,
                                      ));
                                    },
                                    errorBuilder: (context, error, stack) =>
                                        Center(child: Icon(Icons.broken_image)),
                                  ),
                                  // Overlay gradient + title + favorite icon
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item['title']!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            favourites.contains(index)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: favourites.contains(index)
                                                ? Colors.redAccent
                                                : Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16),

              // MODIFIED: A simple Grid of thumbnails (extra UI component)
              Text('Thumbnails', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(images.length, (i) {
                    return GestureDetector(
                      onTap: () {
                        // Show a larger preview in a dialog
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(images[i]['url']!, fit: BoxFit.cover),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(images[i]['title']!),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          images[i]['url']!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stack) =>
                              Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shuffleImages,
        icon: Icon(Icons.shuffle),
        label: Text('Shuffle'),
      ),
    );
  }
}

/*
  Notes about modifications (for submission):
  - Converted the static Containers into a horizontally-scrollable Card list with rounded corners and elevation.
  - Added overlay gradient with title and favorite icon that toggles on tap.
  - Added a thumbnails GridView as an extra UI component that opens a preview dialog on tap.
  - Added a FloatingActionButton to shuffle images (interactive change).
  - Kept network images so no assets are required; code includes loading and error builders.
*/
