import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:meri_sadak/constants/app_strings.dart';

class EncryptionService {

  // Encrypts the plainText and returns base64 encoded ciphertext with IV
  String encrypt(String plainText) {
    final key = Key.fromUtf8(AppStrings.encryptKeyProd.padRight(32, ' '));
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

    // Generate a random IV for every encryption operation
    final iv = IV.fromLength(12); // AES-GCM requires 12-byte IV
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Return base64 encoded ciphertext and IV concatenated
    final encryptedWithIV = iv.bytes + encrypted.bytes;
    return base64.encode(encryptedWithIV);
  }

  // Decrypts the encryptedText (base64) and returns the decrypted plaintext
  String decrypt(String encryptedText) {
    final key = Key.fromUtf8(AppStrings.encryptKeyProd.padRight(32, ' '));
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

    // Decode base64 input
    final encryptedData = base64.decode(encryptedText);

    // Extract the IV and the ciphertext
    final iv = IV(encryptedData.sublist(0, 12)); // First 12 bytes are the IV for AES-GCM
    final cipherText = encryptedData.sublist(12); // The remaining bytes are the ciphertext

    // Decrypt using AES-GCM
    final decrypted = encrypter.decryptBytes(Encrypted(cipherText), iv: iv);

    // Return decrypted plaintext
    return utf8.decode(decrypted);
  }

}

