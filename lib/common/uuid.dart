import 'package:uuid/uuid.dart';

class UuidService {
  static Uuid _uuid = Uuid();

  static String v4() {
    return _uuid.v4();
  }

  UuidService(_);
}
