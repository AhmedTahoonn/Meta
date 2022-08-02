import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{

static late SharedPreferences sharedPreferences;
static init()async
{
  sharedPreferences=await SharedPreferences.getInstance();
}
static Future<bool> putData({
  required String key,
  required bool value,
})async
{

 return await sharedPreferences.setBool(key, value);
}

static dynamic getData({
  required String ?key,
})
{

  return  sharedPreferences.get(key!);
}

static Future<dynamic> saveData({
  required String key,
   dynamic value,
})async
{
  if(value is String) return await sharedPreferences.setString(key, value);
  if(value is int) return await sharedPreferences.setInt(key, value);
  if(value is bool) return await sharedPreferences.setBool(key, value);
  if(value is double) {
    await sharedPreferences.setDouble(key, value);
  } else {
    return null;
  }
}
static Future<dynamic> remove({
  required String key,
  dynamic value,
})async
{
  

  return await sharedPreferences.remove(key);
}

}