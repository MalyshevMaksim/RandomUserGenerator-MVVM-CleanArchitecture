//
//  SavedUserViewModelTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 1/26/21.
//

@testable import RandomUserGenerator
import XCTest
import SwinjectAutoregistration
import Swinject

class SavedUserViewModelTests: XCTestCase {

    private let container = Container()
    private var repostoryMock: UsersRepositoryMock!
    
    override func setUp() {
        container.autoregister(UsersRepositoryMock.self, initializer: UsersRepositoryMock.init)
        container.autoregister(FetchUserInteractor.self, argument: UsersRepositoryMock.self, initializer: FetchUserInteractor.init)
        container.autoregister(DeleteInteractor.self, argument: UsersRepositoryMock.self, initializer: DeleteInteractor.init)
        
        container.register(SavedUserViewModel.self) { r in
            let repository = r.resolve(UsersRepositoryMock.self)!
            self.repostoryMock = repository
            let fetched = r.resolve(FetchUserInteractor.self, argument: repository)!
            let delete = r.resolve(DeleteInteractor.self, argument: repository)!
            return SavedUserViewModel(fetchUseCase: fetched, searchUseCase: SearchUserInteractor(), deleteUseCase: delete, router: Router())
        }
    }
    
    func testUserFecthedFailure() {
        let sut = makeSUT(usersStub: nil)
        
        sut.fetchAll()
        
        XCTAssertNotNil(sut.observableError.value)
        XCTAssertEqual(sut.observableUsers.array.count, 0)
    }
    
    func testUserFetchedSuccess() {
        let sut = makeSUT(usersStub: [User(), User(), User()])
        
        sut.fetchAll()
        
        XCTAssertEqual(sut.observableUsers.array, repostoryMock.fetchedUsers)
        XCTAssertNil(sut.observableError.value)
    }
    
    private func makeSUT(usersStub: [User]?) -> SavedUserViewModel {
        let viewModel = container.resolve(SavedUserViewModel.self)!
        repostoryMock.fetchedUsers = usersStub
        viewModel.observableError.value = nil
        return viewModel
    }
    
    override func tearDown() {
        container.removeAll()
        repostoryMock = nil
    }
}
