//
//  InjectViewModel.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 11/23/20.
//

import Swinject
import RealmSwift

class ViewModelInjector {
    private let containter = Container()
    
    init() {
        registerUserGeneratorViewModel()
        registerSavedUserViewModel()
    }
    
    func get<T>(type: T.Type, router: Router) -> T? {
        return containter.resolve(type, argument: router)
    }
    
    private func registerUserGeneratorViewModel() {
        
        containter.register(UserGeneratorViewModel.self) { (_, router: Router) in
            let persistentStorage = UsersRealmStorage(realm: try! Realm())
            let repository = UsersNetworkRepository(storage: persistentStorage, networkService: AlamofireNetworkService(url: URL(string: "https://randomuser.me/api/")))
            
            return UserGeneratorViewModel(generateUseCase: FetchAllUserInteractor(repository: repository), saveUseCase: SaveUserInteractor(usersRepository: repository), deleteUseCase: DeleteInteractor(repository: repository), router: router)
        }
    }
    
    private func registerSavedUserViewModel() {
    
        containter.register(SavedUserViewModel.self) { (_, router: Router) in
            let persistentStorage = UsersRealmStorage(realm: try! Realm())
            let repository = UsersPersistentRepository(storage: persistentStorage)
            
            return SavedUserViewModel(fetchUseCase: FetchAllUserInteractor(repository: repository), searchUseCase: SearchUserInteractor(), deleteUseCase: DeleteInteractor(repository: repository), router: router)
        }
    }
}
