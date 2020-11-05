//
//  SavedUserViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/4/20.
//

import Foundation
import Alamofire
import Bond

class SavedUserViewModel {
    private var fetchUseCase: FetchUseCase
    
    private(set) var observableUsers = MutableObservableArray<User>([])
    private(set) var observablePictures = MutableObservableArray<UIImage>([])
    private(set) var observableError = Observable<AFError?>(nil)
    
    init(fetchUseCase: FetchUseCase) {
        self.fetchUseCase = fetchUseCase
    }
    
    func executeFetchUseCase() {
        fetchUseCase.execute { result in
            self.userResultHandler(result: result)
        } completionPicture: { pictures in
            self.observablePictures.insert(contentsOf: pictures!, at: 0)
        }
    }
    
    private func userResultHandler(result: Result<UserList, AFError>) {
        switch result {
            case .success(let users):
                observableUsers.removeAll()
                observableUsers.insert(contentsOf: Array(users.results), at: 0)
            case .failure(let error):
                observableError.value = error
        }
    }
}
