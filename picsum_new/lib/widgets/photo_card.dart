import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/photo.dart';
import '../screens/photo_detail_screen.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  const PhotoCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, animation, __) => PhotoDetailScreen(photo: photo),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      child: Hero(
        tag: 'photo_\${photo.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: photo.imageUrl(w: 600, h: 450),
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: const Color(0xFF1E1E2E),
                  highlightColor: const Color(0xFF2D2D3F),
                  child: Container(color: const Color(0xFF1E1E2E)),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFF1E1E2E),
                  child: const Icon(Icons.broken_image_outlined,
                      color: Colors.white24, size: 32),
                ),
              ),
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xCC000000), Colors.transparent],
                    ),
                  ),
                  child: Text(
                    photo.author,
                    style: const TextStyle(
                      color: Colors.white, fontSize: 12,
                      fontWeight: FontWeight.w500, letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
