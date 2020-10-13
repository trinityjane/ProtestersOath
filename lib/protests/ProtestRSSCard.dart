import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:link/link.dart';
import 'package:protestersoath/stories/FeedModel.dart';

Widget ProtestRSSCard(BuildContext context, FeedModel protest, openFeed) {
  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('URL_PROBLEM'.tr()),
      ),
    );
  }

  return Card(
    clipBehavior: Clip.antiAlias,
    color: Colors.grey[400],
    child: Column(
      children: [
        protest.imageURL.startsWith("assets")
            ? Image.asset(protest.imageURL)
            : Image.network(protest.imageURL),
        // Title and Summary
        ListTile(
          leading: Icon(Icons.arrow_drop_down_circle),
          title: Text(protest.title, style: TextStyle(fontSize: 22)),
          // make this the date of the protest:
          subtitle: Text(protest.start, style: TextStyle(fontSize: 18)), //Text(story.summary, style: TextStyle(fontSize: 10)),
          isThreeLine: false,
          onTap: () => openFeed(protest.postURL),
        ),

        // The story
        (protest.body != '')
            ? Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 5),
          child: protest.isHTML
              ? Html(data: protest.body,
              style: {
                "body": Style(
                  fontSize: FontSize(18.0),
                  color: Colors.black.withOpacity(0.8),
                  // fontWeight: FontWeight.bold,
                ),
              })
              : Text(protest.body,style: TextStyle(
                fontSize: 15, color: Colors.black.withOpacity(0.8)),
          ),
        )
            : Container(),

        // Credits

        // link to the story.
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3, right: 10),
              child: Link(
                child: Text(protest.referenceURL,
                    style: TextStyle(decoration:TextDecoration.underline, fontSize: 20)),
                url: protest.referenceURL,
                onError: _showErrorSnackBar,
              ),
            )),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3, right: 10),
            child: Text(
              'Photo: ' + protest.credit,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 20, right: 10),
            child: Text(
              'Date: ' + protest.date,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    ),
  );
}
