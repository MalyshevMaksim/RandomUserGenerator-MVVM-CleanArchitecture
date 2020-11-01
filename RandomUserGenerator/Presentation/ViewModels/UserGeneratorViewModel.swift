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
    private var generateUseCase: GenerateUseCase
    
    private(set) var generatedUser = Observable<User?>(nil)
    private(set) var generatedPicture = Observable<UIImage?>(nil)
    private(set) var generatedError = Observable<AFError?>(nil)
    
    init(useCase: GenerateUseCase) {
        self.generateUseCase = useCase
    }
    
    func executeUseCase() {
        generateUseCase.executeUser { result in
            switch result {
                case .success(let user):
                    self.generatedUser.value = user
                    self.executePicture(for: user)
                case .failure(let error):
                    self.generatedError.value = error
            }
        }
    }
    
    private func executePicture(for user: User) {
        generateUseCase.executePicture(user: user) { result in
            switch result {
                case .success(let user):
                    self.generatedPicture.value = user
                case .failure(let error):
                    self.generatedError.value = error
            }
        }
    }
}
