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
    
    private var generatedUser: User? {
        didSet { observableUser.value = generatedUser }
    }
    
    private var generatedPicture: UIImage? {
        didSet { observablePicture.value = generatedPicture }
    }
    
    private var generatedError: AFError? {
        didSet { observableError.value = generatedError }
    }
    
    private(set) var observableUser: Observable<User?>
    private(set) var observablePicture: Observable<UIImage?>
    private(set) var observableError: Observable<AFError?>
    
    init(generateUseCase: FetchUseCase, saveUseCase: SaveUseCase) {
        self.generateUseCase = generateUseCase
        self.saveUseCase = saveUseCase
        
        observableUser = Observable<User?>(generatedUser)
        observablePicture = Observable<UIImage?>(generatedPicture)
        observableError = Observable<AFError?>(generatedError)
    }
    
    func executeSaveUseCase() {
        guard let user = generatedUser, let picture = generatedPicture else {
            return
        }
        saveUseCase.execute(for: user, with: picture)
    }
    
    func executeGenerateUseCase() {
        generateUseCase.execute { result in
            self.userResultHandler(result: result)
        } completionPicture: { picture in
            self.pictureResultHandler(picture: picture)
        }
    }
    
    private func userResultHandler(result: Result<UserList, AFError>) {
        switch result {
            case .success(let user):
                self.generatedUser = user.results.first
            case .failure(let error):
                self.generatedError = error
        }
    }
    
    private func pictureResultHandler(picture: UIImage?) {
        guard let picture = picture else {
            self.generatedPicture = nil
            return
        }
        self.generatedPicture = picture
    }
}
