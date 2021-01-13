//
//  SearchUseCase.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/8/20.
//

protocol SearchUserInteractorInput {
    func execute(users: [User], searchQuery: String, completion: @escaping ([User]) -> ())
}

class SearchUserInteractor: SearchUserInteractorInput {
  
    func execute(users: [User], searchQuery: String, completion: @escaping ([User]) -> ()) {
        let users = users.filter { user in
            return (user.name?.fullName.contains(searchQuery))!
        }
        completion(users)
    }
}