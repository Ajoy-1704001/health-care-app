import 'package:shared_value/shared_value.dart';

final SharedValue<int> user_id = SharedValue(
  value: 0, // initial value
  key: "user_id", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> rescue_number = SharedValue(
  value: "", // initial value
  key: "rescue_number", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> user_name = SharedValue(
  value: "", // initial value
  key: "user_name", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);
final SharedValue<String> user_image = SharedValue(
  value: "", // initial value
  key: "user_image", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);
