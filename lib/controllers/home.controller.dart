import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:mobx/mobx.dart';
part 'home.controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  bool showSearch = false;

  @observable
  ObservableList<ContactModel> contacts = new ObservableList<ContactModel>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String term) async {
    final repository = new ContactRepository(); // instancia do repositório
    contacts = new ObservableList<ContactModel>(); // limpa os contatos
    var data = await repository.search(term); // busca os contatos
    contacts.addAll(data); // preenche a lista novamente
  }
}

// flutter packages pub run build_runner clean 
// flutter packages pub run build_runner build ==> comando para gerar o 'home.controller.g.dart'