import 'package:encrypt/encrypt.dart' as encrypt;

class AESUtil {

  // Decrypt method using a fixed key
  String decryptData(String encryptedData, String securityKey) {
    final key = encrypt.Key.fromUtf8(securityKey.padRight(32, ' '));  // 32-byte key for AES-192
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));  // ECB mode (no IV)

    final decrypted = encrypter.decrypt64(encryptedData);
    return decrypted;
  }

  // Encrypt method using a fixed key
  String encryptData(String data, String securityKey) {
    final key = encrypt.Key.fromUtf8(securityKey.padRight(32, ' '));  // 32-byte key for AES-192
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));  // ECB mode (no IV)

    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;  // Return Base64 encoded result
  }

}
