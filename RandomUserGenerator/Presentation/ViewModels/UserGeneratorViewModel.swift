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
    private var useCase: GenerateUseCase
    private(set) var generatedUser = Observable<User>(User())
    private(set) var error: Observable<AFError>?
    
    init(useCase: GenerateUseCase) {
        self.useCase = useCase
    }
    
    func executeUseCase() {
        useCase.execute { result in
            switch result {
                case .success(let user):
                    self.generatedUser.value = user
                case .failure(let error):
                    self.error?.value = error
            }
        }
    }
}
