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
    
    private(set) var observableUser = Observable<User?>(nil)
    private(set) var observablePicture = Observable<UIImage?>(nil)
    private(set) var observableError = Observable<AFError?>(nil)
    
    init(generateUseCase: FetchUseCase, saveUseCase: SaveUseCase) {
        self.generateUseCase = generateUseCase
        self.saveUseCase = saveUseCase
    }
    
    func executeSaveUseCase() {
        guard let user = observableUser.value, let picture = observablePicture.value else {
            return
        }
        saveUseCase.execute(for: user, with: picture)
    }
    
    func executeGenerateUseCase() {
        generateUseCase.execute { result in
            self.userResultHandler(result: result)
        } completionPicture: { picture in
            self.observablePicture.value = picture?.first
        }
    }
    
    private func userResultHandler(result: Result<UserList, AFError>) {
        switch result {
            case .success(let user):
                self.observableUser.value = user.results.first
            case .failure(let error):
                self.observableError.value = error
        }
    }
}
