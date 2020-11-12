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
    private var generateUseCase: FetchUseCase
    private var saveUseCase: SaveUseCase
    private var router: Router
    
    private(set) var observableUser = Observable<User?>(nil)
    private(set) var observableError = Observable<AFError?>(nil)
    
    init(generateUseCase: FetchUseCase, saveUseCase: SaveUseCase, router: Router) {
        self.generateUseCase = generateUseCase
        self.saveUseCase = saveUseCase
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
        generateUseCase.execute { result in
            switch result {
                case .success(let user):
                    self.observableUser.value = user.results.first
                case .failure(let error):
                    self.observableError.value = error
            }
        }
    }
}
