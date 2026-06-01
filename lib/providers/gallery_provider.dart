import 'package:flutter/foundation.dart';
import '../models/photo.dart';
import '../services/picsum_service.dart';

enum GalleryStatus { initial, loading, loaded, error }

class GalleryProvider extends ChangeNotifier {
  final PicsumService _service = PicsumService();

  List<Photo> _photos = [];
  GalleryStatus _status = GalleryStatus.initial;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  List<Photo> get photos => _photos;
  GalleryStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isFetchingMore => _isFetchingMore;

  Future<void> loadPhotos() async {
    if (_status == GalleryStatus.loading) return;
    _status = GalleryStatus.loading;
    _currentPage = 1;
    _photos = [];
    _hasMore = true;
    notifyListeners();

    try {
      final newPhotos = await _service.fetchPhotos(page: _currentPage);
      _photos = newPhotos;
      _hasMore = newPhotos.length == 30;
      _status = GalleryStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = GalleryStatus.error;
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isFetchingMore || !_hasMore) return;
    _isFetchingMore = true;
    notifyListeners();
    try {
      _currentPage++;
      final newPhotos = await _service.fetchPhotos(page: _currentPage);
      _photos = [..._photos, ...newPhotos];
      _hasMore = newPhotos.length == 30;
    } catch (e) {
      _currentPage--;
      _errorMessage = e.toString();
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => loadPhotos();
}
