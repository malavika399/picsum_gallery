# Picsum Gallery

A beautiful Flutter image gallery app that fetches and displays photos from the [Lorem Picsum](https://picsum.photos/) API.

## Features

- Masonry staggered 2-column grid layout
- Infinite scroll with automatic pagination
- Hero animations (grid → detail transition)
- Full detail view with author, ID, and dimensions
- Shimmer loading placeholders
- Cached network images
- Error state with retry
- Dark space-themed UI with purple accents

## Architecture

| Layer | Technology |
|---|---|
| State management | Provider (ChangeNotifier) |
| HTTP | http package |
| Image caching | cached_network_image |
| Grid layout | flutter_staggered_grid_view |
| Fonts | google_fonts (Space Mono + Playfair Display) |

## Project Structure

```
lib/
├── main.dart
├── models/photo.dart
├── services/picsum_service.dart
├── providers/gallery_provider.dart
├── screens/
│   ├── gallery_screen.dart
│   └── photo_detail_screen.dart
└── widgets/photo_card.dart
```

## Getting Started

```bash
git clone https://github.com/malavika399/picsum_gallery.git
cd picsum_gallery
flutter pub get
flutter run
```

Requires Flutter SDK >= 3.10.0

## API

```
GET https://picsum.photos/v2/list?page=1&limit=30
```

Images displayed via:
```
https://picsum.photos/id/{id}/{width}/{height}
```
