//
//  SavedUserViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import Bond

protocol SavedUserViewModelInput {
    
    func search(with searchText: String?)
    func fetchAll()
    func remove(from indexPath: IndexPath)
    func showDetail(for indexPath: IndexPath)
}

protocol SavedUserViewModelOutput {
    
    var observableError: Observable<NSError?> { get set }
    var observableUsers: MutableObservableArray<User> { get set }
}

class SavedUserViewModel: SavedUserViewModelInput, SavedUserViewModelOutput {
    
    private var fetchUseCase: FetchUserInteractorInput
    private var searchUseCase: SearchUserInteractorInput
    private var deleteUseCase: DeleteUserInteractorInput
    
    private var router: Router
    private var fetchedUsers = [User]()
    
    var observableError = Observable<NSError?>(nil)
    var observableUsers = MutableObservableArray<User>([])
    
    init(fetchUseCase: FetchUserInteractorInput, searchUseCase: SearchUserInteractorInput, deleteUseCase: DeleteUserInteractorInput, router: Router) {
        self.searchUseCase = searchUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
        self.router = router
        fetchAll()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNotify(_:)), name: .didUserSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeNotify(_:)), name: .didUserRemove, object: nil)
    }
    
    func fetchAll() {
        fetchUseCase.execute { result in
            switch result {
                case .success(let users):
                    self.fetchedUsers = users
                    self.observableUsers.insert(contentsOf: self.fetchedUsers, at: 0)
                case .failure(let error):
                    self.observableError.value = error
            }
        }
    }
    
    func search(with searchQuery: String?) {
        searchUseCase.execute(users: fetchedUsers, searchQuery: searchQuery) { users in
            guard users.count != self.observableUsers.count else {
                return
            }
            self.observableUsers.removeAll()
            self.observableUsers.insert(contentsOf: users, at: 0)
        }
    }
    
    func remove(from indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        let fetchedIndex = fetchedUsers.firstIndex(of: user)
        
        deleteUseCase.execute(user: user)
        fetchedUsers.remove(at: fetchedIndex!)
        observableUsers.remove(at: indexPath.row)
    }
    
    func showDetail(for indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        //router.showDetail(user: user, method: .push)
    }
}

extension SavedUserViewModel {
    
    @objc func addNotify(_ notification: Notification) {
        guard let user: User = notification.userInfo?["User"] as? User else {
            return
        }
        fetchedUsers.append(user)
        observableUsers.append(user)
    }
    
    @objc func removeNotify(_ notification: Notification) {
        guard let user: User = notification.userInfo?["User"] as? User, let index = observableUsers.array.firstIndex(of: user)  else {
            return
        }
        observableUsers.remove(at: index)
    }
}
