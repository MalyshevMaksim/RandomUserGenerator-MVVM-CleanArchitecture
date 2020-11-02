//
//  UseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import Foundation
import Alamofire

protocol GenerateUseCase {
    func execute(completionUser: @escaping (Result<User, AFError>) -> (), completionPicture: @escaping (UIImage?) -> ())
}

class GenerateUserInteractor: GenerateUseCase {
    private var usersRepository: UsersRepository
    private var picturesRepository: PicturesRepository
    
    init(usersRepository: UsersRepository, picturesRepository: PicturesRepository) {
        self.usersRepository = usersRepository
        self.picturesRepository = picturesRepository
    }
    
    func execute(completionUser: @escaping (Result<User, AFError>) -> (), completionPicture: @escaping (UIImage?) -> ()) {
        usersRepository.fetch { user, error in
            guard let user = user else {
                completionUser(.failure(error!))
                return
            }
            completionUser(.success(user))
            self.executePicture(user: user, completion: completionPicture)
        }
    }
    
    private func executePicture(user: User, completion: @escaping (UIImage?) -> ()) {
        picturesRepository.fetch(for: user) { image in
            guard let picture = image else {
                completion(nil)
                return
            }
            completion(picture)
        }
    }
}
