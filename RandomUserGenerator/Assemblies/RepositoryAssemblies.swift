//
//  RepositoryAssemblies.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 1/17/21.
//

import Swinject
import RealmSwift

class AlamofireNetworkRepostoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UsersNetworkRepository.self) { _  in
            let networkService = AlamofireNetworkService(url: URL(string: "https://randomuser.me/api/"))
            let realmStorage = UsersRealmStorage(realm: try! Realm())
            return UsersNetworkRepository(storage: realmStorage, networkService: networkService)
        }
    }
}

class PersistentRealmRepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UsersPersistentRepository.self) { _ in
            let realmStorage = UsersRealmStorage(realm: try! Realm())
            return UsersPersistentRepository(storage: realmStorage)
        }
    }
}
