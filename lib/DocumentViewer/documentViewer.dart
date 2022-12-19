import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class viewDocument extends StatefulWidget {
  final String url;
  static final routeName = '/HomeScreen';
  // BuildContext context;
  viewDocument({required this.url});
  @override
  _viewDocument createState() => _viewDocument();
}

class _viewDocument extends State<viewDocument> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  viewDocument(String url, BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        // title: const Text('Syncfusion Flutter PDF Viewer'),
        // ! Book Mark Icon
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.bookmark,
        //       color: Colors.white,
        //       semanticLabel: 'Bookmark',
        //     ),
        //     onPressed: () {
        //       _pdfViewerKey.currentState?.openBookmarkView();
        //     },
        //   ),
        // ],
        // ),
        extendBodyBehindAppBar: true,
        // backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.teal[100],
          elevation: 0,
          // TODO Add name of document
          title: Text("DOCUMENT NAME"),
        ),
        body: SafeArea(
          child: SfPdfViewer.network(
            widget.url,
            key: _pdfViewerKey,
          ),
        ));
  }
}



// ! PdfTron Tryn
// Future viewDocument(String url, BuildContext context) async {
//   final snackbar = SnackBar(
//     content: Text("Loading the document...please wait"),
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackbar);
//   var disabledElements = [
//     Buttons.thumbnailsButton,
//     Buttons.userBookmarkListButton,
//     Buttons.userBookmarkListButton,
//     Buttons.shareButton,
//     Buttons.saveCopyButton,
//     Buttons.printButton,
//     Buttons.editPagesButton
//   ];
//   var config = Config();
//   config.disabledElements = disabledElements;
//   config.multiTabEnabled = false;
//   config.customHeaders = {'headerName': 'headerValue'};

//   await PdftronFlutter.openDocument(url);
// }


// ! Trying to download document
// void _requestDownload(String link) async {
//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;
//   final status = await Permission.storage.request();
//   if (status.isGranted) {
//     final externalDir = await getExternalStorageDirectory();
//     print('lkkkkkkkkkkkkkkkkkkkkkkkk');
//     print(externalDir!.path);
//     final id = await FlutterDownloader.enqueue(
//       url:
//           "https://firebasestorage.googleapis.com/v0/b/pict-pictira.appspot.com/o/Se%2FSem1%2FEnTc%2FELC%2FN%20B%20Patil%2FLinks%20for%20Unit%202%20ELC.pdf?alt=media&token=7ec6e722-611f-4cc7-b6f9-fdfb7e3fdd3b",
//       savedDir: externalDir.path,
//       fileName: "helloworld",
//       showNotification: false,
//       openFileFromNotification: false,
//     );
//   } else {
//     print("Permission deined");
//   }
// }
