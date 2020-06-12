import 'dart:io';
import 'dart:typed_data';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<int>> getImage(int tipo, int qualidade) async {
  List<int> photoBytes;
  File photo;

  try {
    if (tipo == 1) {
      photo = await ImagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: qualidade,
          maxHeight: 1280,
          maxWidth: 1280);
    } else {
      photo = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: qualidade,
          maxHeight: 1280,
          maxWidth: 1280);
    }
  } catch (e) {
    print(e);
  }

  try {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (!response.isEmpty && response.file != null) {
      photo = response.file;
      print('Erro ${response.exception.code} - ${response.exception.message}');
    }
  } catch (e) {
    print(e);
  }

  try {
    if (photo != null) {
      photoBytes = await photo.readAsBytes();

      if (tipo == 1) {
        var decodedImage = await decodeImageFromList(photoBytes);
        final exifData = await readExifFromBytes(photoBytes);
        if ((!exifData['Image Orientation'].printable.contains('Horizontal') &&
                (decodedImage.width > decodedImage.height)) ||
            (exifData['Image Orientation'].printable.contains('Horizontal') &&
                decodedImage.height > decodedImage.width)) {
          exifData.remove('Image Orientation');

          List<int> aux = await FlutterImageCompress.compressWithList(
              photoBytes,
              quality: qualidade,
              rotate: 90);
          if (aux.length > 0) {
            photoBytes = Uint8List.fromList(aux);
          }
        } else {
          List<int> aux = await FlutterImageCompress.compressWithList(
              photoBytes,
              quality: qualidade,
              rotate: 0);
          if (aux.length > 0) {
            photoBytes = Uint8List.fromList(aux);
          }
        }
      } else {
        List<int> aux = await FlutterImageCompress.compressWithList(photoBytes,
            quality: qualidade, rotate: 0);
        if (aux.length > 0) {
          photoBytes = Uint8List.fromList(aux);
        }
      }
    }
  } catch (e) {
    print(e);
  }

  return photoBytes;
}

Future<List<int>> rotateImage(List<int> image, int degress) async {
  try {
    List<int> aux = await FlutterImageCompress.compressWithList(image,
        quality: 100, rotate: degress, autoCorrectionAngle: false);
    //print(aux);
    return Uint8List.fromList(aux);
  } catch (e) {
    print(e);
  }
  return null;
}
