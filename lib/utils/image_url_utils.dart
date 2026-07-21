

import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/app_url.dart';

/// Builds absolute image URLs from API values (filename, path, or full URL).
class ImageUrlResolver {
  ImageUrlResolver._();

  static String? _cdnBaseUrl;

  /// Call after app settings load ([CDN_IMAGE_URL] from API).
  static void setCdnBaseUrl(String? url) {
    final trimmed = url?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return;
    }
    _cdnBaseUrl = trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }

  static String resolve(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return '';

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    if (value.startsWith('//')) {
      return 'https:$value';
    }

    if (value.startsWith('/')) {
      final base = _trimTrailingSlash(AppUrl.assetUrl);
      return '$base$value';
    }

    if (value.contains('/')) {
      return '${_cdnRoot()}$value';
    }

    final userdb = SessionController.user.userdb?.trim();
    if (userdb != null && userdb.isNotEmpty) {
      return '${_cdnRoot()}$userdb/images/$value';
    }

    final assetBase = _trimTrailingSlash(AppUrl.assetUrl);
    return '$assetBase/sys_images/$value';
  }

  static String _cdnRoot() {
    if (_cdnBaseUrl != null && _cdnBaseUrl!.isNotEmpty) {
      return _cdnBaseUrl!;
    }
    // Matches URLs returned by production APIs when CDN_IMAGE_URL is not loaded yet.
    return 'https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/';
  }

  static String _trimTrailingSlash(String value) {
    return value.endsWith('/') ? value.substring(0, value.length - 1) : value;
  }
}
