import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CacheMemoryImageProvider extends ImageProvider<CacheMemoryImageProvider> {
  const CacheMemoryImageProvider(this.tag, this.img);
  final String tag;
  final Uint8List img;

  @override
  ImageStreamCompleter loadImage(final CacheMemoryImageProvider key, final ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(
        codec: _loadAsync(decode),
        scale: 1.0,
        debugLabel: tag,
        informationCollector: () sync* {
          yield ErrorDescription('Tag: $tag');
        },
      );

  Future<Codec> _loadAsync(final ImageDecoderCallback decode) async {
    final bytes = img;

    if (bytes.lengthInBytes == 0) {
      PaintingBinding.instance.imageCache.evict(this);
      throw StateError('$tag is empty and cannot be loaded as an image.');
    }
    final buffer = await ImmutableBuffer.fromUint8List(bytes);

    return decode(buffer);
  }

  @override
  Future<CacheMemoryImageProvider> obtainKey(final ImageConfiguration configuration) =>
      SynchronousFuture<CacheMemoryImageProvider>(this);

  @override
  bool operator ==(final Object other) {
    if (other.runtimeType != runtimeType) return false;

    return other is CacheMemoryImageProvider && other.tag == tag;
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() => '${objectRuntimeType(this, 'CacheImageProvider')}("$tag")';
}
