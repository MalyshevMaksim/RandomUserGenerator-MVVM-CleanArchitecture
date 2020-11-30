//
//  SavedUserViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import Bond
import RealmSwift

protocol SavedUserViewModelProtocol {
    func search(with searchText: String?)
    func fetchAll()
    func remove(from indexPath: IndexPath)
    func showDetail(for indexPath: IndexPath)
}

class SavedUserViewModel: SavedUserViewModelProtocol {
    
    private var fetchUseCase: FetchUseCase
    private var searchUseCase: SearchUseCase
    private var deleteUseCase: DeleteUseCase
    
    private var router: Router
    private var fetchedUsers = [User]()
    
    private(set) var observableError = Observable<NSError?>(nil)
    private(set) var observableUsers = MutableObservableArray<User>([])
    
    init(fetchUseCase: FetchUseCase, searchUseCase: SearchUseCase, deleteUseCase: DeleteUseCase, router: Router) {
        self.searchUseCase = searchUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
        self.router = router
        fetchAll()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNotify(_:)), name: .didUserSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeNotify(_:)), name: .didUserRemove, object: nil)
    }
    
    func showDetail(for indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        router.showDetail(user: user, method: .push)
    }
    
    func search(with searchText: String?) {
        guard let searchQuery = searchText, searchQuery != "" else {
            if fetchedUsers.count == observableUsers.count {
                return
            }
            observableUsers.removeAll()
            observableUsers.insert(contentsOf: fetchedUsers, at: 0)
            return
        }
        searchUseCase.execute(users: fetchedUsers, searchQuery: searchQuery) { users in
            self.observableUsers.removeAll()
            self.observableUsers.insert(contentsOf: users, at: 0)
        }
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
    
    func remove(from indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        deleteUseCase.execute(user: user)
        observableUsers.remove(at: indexPath.row)
    }
}

extension SavedUserViewModel {
    
    @objc func addNotify(_ notification: Notification) {
        guard let user: User = notification.userInfo?["User"] as? User else {
            return
        }
        observableUsers.append(user)
    }
    
    @objc func removeNotify(_ notification: Notification) {
        guard let user: User = notification.userInfo?["User"] as? User, let index = observableUsers.array.firstIndex(of: user)  else {
            return
        }
        observableUsers.remove(at: index)
    }
}
