import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> initFlutter() async {
    var dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }

  static bool isBoxOpened(String name) {
    return Hive.isBoxOpen(name);
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    try {
      if (isBoxOpened(boxName)) {
        return Hive.box<T>(boxName);
      } else {
        return await Hive.openBox<T>(boxName);
      }
    } catch (error) {
      throw ("Hive Service Error $error");
    }
  }

  static Future<List<T>> getList<T>(String boxName, String key) async {
    debugPrint("[Hive Service] GET $boxName , key: $key");
    final box = await openBox<dynamic>(boxName);
    try {
      final List<dynamic> result = await box.get(key);
      await box.close();
      return result.cast<T>();
    } catch (error) {
      debugPrint("Hive Service get List $error");
      return <T>[];
    }
  }

  static Future put(
    String boxName,
    String key,
    dynamic data, {
    bool isCloseBox = true,
  }) async {
    var box = await openBox<dynamic>(boxName);
    await box.put(key, data);
    if (isCloseBox) {
      await closeBox(box);
    }
  }

  static Future putList<T>(String boxName, String key, List<T> items) async {
    debugPrint("[Hive Service] PUT LIST $boxName , key: $key ${items.length}");
    final Box box = await openBox<dynamic>(boxName);
    try {
      await box.putAll({key: items});
      await box.close();
    } catch (error) {
      debugPrint("Hive Service Error $error");
    }
  }

  static Future closeBox<T>(Box<T> box) async {
    if (box.isOpen) {
      await box.close();
    }
  }
}
