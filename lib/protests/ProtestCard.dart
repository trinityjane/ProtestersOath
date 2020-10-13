import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:link/link.dart';
import 'package:protestersoath/protests/ProtestModel.dart';

Widget ProtestCard(BuildContext context, ProtestModel protest) {
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
        (protest.summary == '')
            ? ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title:
                    // Text(protest.title),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(protest.title, style: TextStyle(fontSize: 20)),
                    Align(
                        alignment: Alignment.bottomRight,
                        child:
                            Text(protest.date, style: TextStyle(fontSize: 10))),
                  ],
                ),
                isThreeLine: false,
              )
            : ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title:
                    // Text(protest.title),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(protest.title, style: TextStyle(fontSize: 20)),
                    Align(
                        alignment: Alignment.bottomRight,
                        child:
                            Text(protest.date, style: TextStyle(fontSize: 10))),
                  ],
                ),
                subtitle: Text(
                  protest.summary,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.8)),
                ),
                isThreeLine: true,
              ),
        // Date of the protest

        // The protest
        (protest.body != '')
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 10, top: 0, bottom: 5),
                child: protest.isHTML
                    ? Html(data: protest.body)
                    : Text(
                        protest.body,
                        style: TextStyle(
                            fontSize: 15, color: Colors.black.withOpacity(0.8)),
                      ),
              )
            : Container(),

        // Credits

        // link to the protest.
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3, right: 10),
              child: Link(
                child: Text(protest.referenceURL, style: TextStyle(fontSize: 10)),
                url: protest.referenceURL,
                onError: _showErrorSnackBar,
              ),
            )),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 20, right: 10),
            child: Text(
              'Photo: ' + protest.credit,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    ),
  );
}
