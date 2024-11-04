import 'package:either_dart/either.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';
import 'package:minimal_app/modules/home/domain/usecases/home_usecases.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _homeUseCase = locator<HomeUseCase>();

  List<ClientEntity> _clients = [];
  Failure? _failure;

  List<ClientEntity> get clients => _clients;
  Failure? get failure => _failure;
  final int _itemsPerPage = 5;
  int _currentPage = 0;
  bool _hasMoreItems = true;
  bool get hasMoreItems => _hasMoreItems;

  Future<void> runStartupLogic() async {
    if (!hasMoreItems) return;
    setBusy(true);

    Either<Failure, List<ClientEntity>> either =
        await _homeUseCase.getClients();
    either.fold(
      (Failure failure) {
        setBusy(false);
        _failure = failure;
        rebuildUi();
      },
      (List<ClientEntity> clients) {
        setBusy(false);
        int startIndex = _currentPage * _itemsPerPage;
        int endIndex = startIndex + _itemsPerPage;
        if (endIndex > clients.length) {
          endIndex = clients.length;
          _hasMoreItems = false;
        }
        _clients.addAll(clients.sublist(startIndex, endIndex));
        _currentPage++;
        rebuildUi();
      },
    );
  }

  Future<void> createClient(ClientEntity newClient) async {
    Either<Failure, ClientEntity> either =
        await _homeUseCase.createClient(newClient);

    either.fold(
      (Failure failure) {
        _failure = failure;
        rebuildUi();
      },
      (ClientEntity client) {
        if (client.id != null) {
          _currentPage = 0;
          _hasMoreItems = true;
          _clients = [];
          runStartupLogic();
        }
      },
    );
  }

  Future<void> editClient(ClientEntity editClient) async {
    Either<Failure, bool> either = await _homeUseCase.editClient(editClient);
    either.fold(
      (Failure failure) {
        _failure = failure;
        rebuildUi();
      },
      (bool success) {
        if (success) {
          _currentPage = 0;
          _hasMoreItems = true;
          _clients = [];
          runStartupLogic();
        }
      },
    );
  }

  void onPageChanged() {
    if (!hasMoreItems) return;
    runStartupLogic();
  }

  Future<void> deleteClient(String id) async {
    Either<Failure, bool> either = await _homeUseCase.deleteClient(id);
    either.fold(
      (Failure failure) {
        _failure = failure;
        rebuildUi();
      },
      (bool success) {
        if (success) {
          _currentPage = 0;
          _hasMoreItems = true;
          _clients = [];
          runStartupLogic();
        }
      },
    );
  }

  Future<void> search(String? search) async {
    setBusy(true);
    if (search == '') {
      // emit(state.copyWith(
      //   pokemons: state.oldPoke,
      //   isLoading: false,
      // ));
      _currentPage = 0;
      _hasMoreItems = true;
      _clients = [];
      runStartupLogic();
    } else {
      final filter = _clients
          .where(
            (element) => ((element.firstname ?? '') + (element.lastname ?? ''))
                .toLowerCase()
                .contains(search?.toLowerCase() ?? ''),
          )
          .toList();
      _clients = filter;
      setBusy(false);
    }
  }
}
