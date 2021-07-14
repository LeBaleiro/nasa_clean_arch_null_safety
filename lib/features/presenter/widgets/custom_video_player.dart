import 'package:flutter/material.dart';

import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CustomVideoPlayer extends StatefulWidget {
  final SpaceMediaEntity spaceMedia;
  const CustomVideoPlayer(
    this.spaceMedia, {
    Key? key,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool get isYoutubeVideo => widget.spaceMedia.mediaUrl!.contains('youtube');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.spaceMedia.mediaUrl != null && isYoutubeVideo) _loadYoutubeVideo(widget.spaceMedia);
  }

  YoutubePlayerController? _youtubeController;

  void _loadYoutubeVideo(SpaceMediaEntity spaceMedia) {
    if (_youtubeController == null) {
      final videoId = _filterVideoId(spaceMedia.mediaUrl!);
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        params: YoutubePlayerParams(
          showControls: false,
          showFullscreenButton: true,
          autoPlay: true,
          mute: true,
          loop: true,
        ),
      );
    }
  }

  String _filterVideoId(String url) {
    final indexOfLastSlash = url.lastIndexOf('/');
    final indexOfComplement = url.indexOf('?');
    final containsComplement = indexOfComplement != -1;
    final videoId = containsComplement ? url.substring(indexOfLastSlash + 1, indexOfComplement) : url.substring(indexOfLastSlash);
    return videoId;
  }

  void _launchURL(String url) async {
    final canOpenLink = await canLaunch(url);
    if (canOpenLink) await launch(url);
  }

  @override
  void dispose() async {
    _youtubeController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: _youtubeController != null
          ? YoutubePlayerIFrame(
              controller: _youtubeController,
              aspectRatio: 16 / 9,
            )
          : !isYoutubeVideo
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sorry we can\'t play this video',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () => _launchURL(widget.spaceMedia.mediaUrl!),
                      child: Text(
                        'Open on browser >',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              : Container(),
    );
  }
}
