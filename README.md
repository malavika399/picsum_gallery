# Picsum Gallery

A beautiful Flutter image gallery app that fetches and displays photos from the [Lorem Picsum](https://picsum.photos/) API.

## Features

- Masonry staggered 2-column grid layout
- Infinite scroll with automatic pagination
- Hero animations (grid → detail transition)
- Full detail view with author, ID, and dimensions
- Shimmer loading placeholders
- Cached network images
- Pull-to-refresh
- Error state with retry
- Dark space-themed UI with purple accents

## Architecture

| Layer | Technology |
|---|---|
| State management | Provider (ChangeNotifier) |
| HTTP | http package |
| Image caching | cached_network_image |
| Grid layout | flutter_staggered_grid_view |
| Fonts | google_fonts |

## Getting Started

```bash
flutter pub get
flutter run
```

## API

```
GET https://picsum.photos/v2/list?page=1&limit=30
```

Images displayed via:
```
https://picsum.photos/id/{id}/{width}/{height}
```
