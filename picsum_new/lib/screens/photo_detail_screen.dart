import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../models/photo.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;
  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'photo_\${photo.id}',
              child: CachedNetworkImage(
                imageUrl: photo.imageUrl(
                    w: size.width.toInt(), h: size.height.toInt()),
                fit: BoxFit.contain,
                width: double.infinity,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: const Color(0xFF1E1E2E),
                  highlightColor: const Color(0xFF2D2D3F),
                  child: Container(color: const Color(0xFF1E1E2E)),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.broken_image_outlined,
                      color: Colors.white24, size: 64),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
            decoration: const BoxDecoration(
              color: Color(0xFF0D0D14),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('PHOTOGRAPHER',
                    style: GoogleFonts.spaceMono(
                      fontSize: 10, color: const Color(0xFFB388FF),
                      letterSpacing: 3, fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 6),
                Text(photo.author,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22, color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10, runSpacing: 8,
                  children: [
                    _MetaChip(label: 'ID #\${photo.id}', icon: Icons.tag_rounded),
                    _MetaChip(
                        label: '\${photo.width} × \${photo.height}',
                        icon: Icons.aspect_ratio_rounded),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _MetaChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFB388FF)),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.spaceMono(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
}
