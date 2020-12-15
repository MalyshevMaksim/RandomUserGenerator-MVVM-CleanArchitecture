//
//  ViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Bond

protocol UserGeneratorViewModelInput {
    
    func generateUser()
    func saveCurrentUser()
    func removeCurrentUser()
    func showDetail()
}

protocol UserGeneratorViewModelOutput {
    
    var observableUser: Observable<User?> { get set }
    var observableError: Observable<NSError?> { get set }
}

class UserGeneratorViewModel: UserGeneratorViewModelInput, UserGeneratorViewModelOutput {
    
    private var fetchUseCase: FetchAllUserInteractorInput
    private var saveUseCase: SaveUserInteractorInput
    private var deleteUseCase: DeleteUserInteractorInput
    private var router: Router
    
    var observableUser = Observable<User?>(nil)
    var observableError = Observable<NSError?>(nil)
    
    init(generateUseCase: FetchAllUserInteractorInput, saveUseCase: SaveUserInteractorInput, deleteUseCase: DeleteUserInteractorInput, router: Router) {
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
