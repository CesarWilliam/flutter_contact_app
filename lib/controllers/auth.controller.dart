import 'package:local_auth/local_auth.dart';

class AuthController {
  final _auth = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async { // checar se está disponível
    try {
      bool isAvailable = await _auth.canCheckBiometrics; // checa se a biometria está disponível no device
      return isAvailable;
    } 
    catch(ex) {
      print(ex);
      return false;
    }
  }

  Future _getListOfBiometricTypes() async { // carregar biometrias
    try {
      await _auth.getAvailableBiometrics(); // método que carrega um banner na tela e carrega os tipos de biometria do device 
    }
    catch(ex) {
      print(ex);
    }
  }

  Future<bool> _authenticateUser() async { // autenticar usuário
    try {
      bool isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Autentique-se para prosseguir",
        useErrorDialogs: true, // se vai exibir erro
        stickyAuth: true // se vai permanecer o item na tela até o user autenticar ou não
      );

      return isAuthenticated;
    }
    catch(ex) {
      print(ex);
      return false; 
    }
  }

  Future<bool> authenticate() async {
    if (await _isBiometricAvailable()) { // se biometria está disponivel
      await _getListOfBiometricTypes(); // carrega a lista de biometrias
      return await _authenticateUser(); // autentica
    }

    return false;
  }
}