//
//  ViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Bond
import Alamofire

class UserGeneratorViewModel {
    
    private var fetchUseCase: FetchUseCase
    private var saveUseCase: SaveUseCase
    private var deleteUseCase: DeleteUseCase
    
    private var router: Router
    
    private(set) var observableUser = Observable<User?>(nil)
    private(set) var observableError = Observable<AFError?>(nil)
    
    init(generateUseCase: FetchUseCase, saveUseCase: SaveUseCase, deleteUseCase: DeleteUseCase, router: Router) {
        self.fetchUseCase = generateUseCase
        self.saveUseCase = saveUseCase
        self.deleteUseCase = deleteUseCase
        self.router = router
    }
    
    func executeSaveUseCase() {
        guard let user = observableUser.value else {
            return
        }
        saveUseCase.execute(user: user)
    }
    
    func showDetail() {
        router.showDetail(user: observableUser.value!, method: .present)
    }
    
    func executeGenerateUseCase() {
        fetchUseCase.execute { result in
            switch result {
                case .success(let user):
                    self.observableUser.value = user.results.first
                case .failure(let error):
                    self.observableError.value = error
            }
        }
    }
    
    func executeDeleteUseCase() {
        guard let user = observableUser.value else {
            return
        }
        deleteUseCase.execute(user: user)
    }
}
