//
//  ViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Bond

class UserGeneratorViewModel {
    
    private var fetchUseCase: FetchUseCase
    private var saveUseCase: SaveUseCase
    private var deleteUseCase: DeleteUseCase
    
    private var router: Router
    
    private(set) var observableUser = Observable<User?>(nil)
    private(set) var observableError = Observable<NSError?>(nil)
    
    init(generateUseCase: FetchUseCase, saveUseCase: SaveUseCase, deleteUseCase: DeleteUseCase, router: Router) {
        self.fetchUseCase = generateUseCase
        self.saveUseCase = saveUseCase
        self.deleteUseCase = deleteUseCase
        self.router = router
    }
    
    func generateUser() {
        fetchUseCase.execute { result in
            switch result {
                case .success(let users):
                    self.observableUser.value = users.first
                case .failure(let error):
                    self.observableError.value = error
            }
        }
    }
    
    func saveCurrentUser() {
        guard let user = observableUser.value else {
            return
        }
        saveUseCase.execute(user: user)
        NotificationCenter.default.post(name: .didUserSave, object: nil, userInfo: ["User" : user])
    }
    
    func removeCurrentUser() {
        guard let user = observableUser.value else {
            return
        }
        deleteUseCase.execute(user: user)
        NotificationCenter.default.post(name: .didUserRemove, object: nil, userInfo: ["User" : user])
    }
    
    func showDetail() {
        guard let user = observableUser.value else {
            return
        }
        router.showDetail(user: user, method: .present)
    }
}
