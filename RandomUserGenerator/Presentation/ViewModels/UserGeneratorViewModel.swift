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
        generateUseCase.execute { result in
            self.userResultHandler(result: result)
        } completionPicture: { picture in
            self.pictureResultHandler(picture: picture)
        }
    }
    
    private func userResultHandler(result: Result<User, AFError>) {
        switch result {
            case .success(let user):
                self.generatedUser.value = user
            case .failure(let error):
                self.generatedError.value = error
        }
    }
    
    private func pictureResultHandler(picture: UIImage?) {
        guard let picture = picture else {
            self.generatedPicture.value = nil
            return
        }
        self.generatedPicture.value = picture
    }
}
