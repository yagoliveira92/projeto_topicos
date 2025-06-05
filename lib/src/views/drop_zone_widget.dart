import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropZoneWidget extends StatefulWidget {
  DropZoneWidget({
    required this.onChangedStatus,
    required this.message,
    required this.uploadBytes,
    super.key,
  });

  Function(bool) onChangedStatus;
  String message;
  Function(Uint8List fileBytes, String fileName) uploadBytes;

  @override
  State<DropZoneWidget> createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) => DropzoneView(
    operation: DragOperation.copy,
    cursor: CursorType.grab,
    mime: ["application/sql"],
    onCreated: (ctrl) => controller = ctrl,
    onLoaded: () => print('Zone 1 loaded'),
    onError: (error) => print('Zone 1 error: $error'),
    onHover: () {
      widget.onChangedStatus(true);
    },
    onLeave: () {
      widget.onChangedStatus(false);
    },
    onDropFile: (file) async {
      widget.onChangedStatus(false);
      final bytes = await controller.getFileData(file);
      widget.uploadBytes(bytes, file.name);
    },
    onDropInvalid: (mime) => print('Zone 1 invalid MIME: $mime'),
  );
}
