//
//  SavedUserViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import Alamofire
import Bond
import RealmSwift

class SavedUserViewModel {
    
    private var router: Router
    
    private var fetchUseCase: FetchUseCase
    private var searchUseCase: SearchUseCase
    private var deleteUseCase: DeleteUseCase
    
    private var fetchedUsers = [User]()
    
    private(set) var observableError = Observable<AFError?>(nil)
    private(set) var observableUsers = MutableObservableArray<User>([])
    
    init(fetchUseCase: FetchUseCase, searchUseCase: SearchUseCase, deleteUseCase: DeleteUseCase, router: Router) {
        self.searchUseCase = searchUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
        
        self.router = router
        executeFetchUseCase()
    }
    
    func showDetail(for indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        router.showDetail(user: user, method: .push)
    }
    
    func executeSearchUseCase(searchText: String?) {
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
    
    func executeFetchUseCase() {
        fetchUseCase.execute { result in
            switch result {
                case .success(let users):
                    self.fetchedUsers = Array(users.results)
                    self.observableUsers.insert(contentsOf: self.fetchedUsers, at: 0)
                case .failure(let error):
                    self.observableError.value = error
            }
        }
    }
    
    func executeRemoveUseCase(indexPath: IndexPath) {
        let user = observableUsers.array[indexPath.row]
        deleteUseCase.execute(user: user)
        observableUsers.remove(at: indexPath.row)
    }
}
