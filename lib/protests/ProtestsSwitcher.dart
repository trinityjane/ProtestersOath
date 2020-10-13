import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:preferences/preference_service.dart';
import 'package:protestersoath/stories/rss_page.dart';

class ProtestsSwitcher extends StatelessWidget {
  ProtestsSwitcher();

  final protests = PrefService.getString('protests', ignoreCache: true);

  @override
  Widget build(BuildContext context) {
    return RSSReader(which: "Protests", title: 'PROTESTS'.tr());
  }
}
