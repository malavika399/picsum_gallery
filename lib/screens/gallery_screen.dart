import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/gallery_provider.dart';
import '../widgets/photo_card.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryProvider>().loadPhotos();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<GalleryProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0D0D14),
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'GALLERY',
                style: GoogleFonts.spaceMono(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: Colors.white, letterSpacing: 6,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A0533), Color(0xFF0D0D14)],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
                onPressed: () => context.read<GalleryProvider>().refresh(),
                tooltip: 'Refresh',
              ),
              const SizedBox(width: 8),
            ],
          ),
          Consumer<GalleryProvider>(
            builder: (context, provider, _) {
              if (provider.status == GalleryStatus.loading &&
                  provider.photos.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFB388FF)),
                  ),
                );
              }
              if (provider.status == GalleryStatus.error &&
                  provider.photos.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded,
                            color: Colors.white24, size: 64),
                        const SizedBox(height: 16),
                        Text('Failed to load images',
                            style: GoogleFonts.spaceMono(
                                color: Colors.white54, fontSize: 14)),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          onPressed: () =>
                              context.read<GalleryProvider>().loadPhotos(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFB388FF)),
                            foregroundColor: const Color(0xFFB388FF),
                          ),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childCount: provider.photos.length +
                      (provider.isFetchingMore ? 2 : 0),
                  itemBuilder: (context, index) {
                    if (index >= provider.photos.length) {
                      return AspectRatio(
                        aspectRatio: index.isEven ? 1.0 : 0.75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(color: const Color(0xFF1E1E2E)),
                        ),
                      );
                    }
                    final photo = provider.photos[index];
                    return AspectRatio(
                      aspectRatio: photo.aspectRatio.clamp(0.6, 1.8),
                      child: PhotoCard(photo: photo),
                    );
                  },
                ),
              );
            },
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}
