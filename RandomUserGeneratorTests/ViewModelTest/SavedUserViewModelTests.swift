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
    
    func testUserDeleteSuccess() {
        let sut = makeSUT(usersStub: [User()])
        
        sut.fetchAll()
        let usersCountBeforeRemove = sut.observableUsers.count
        sut.remove(from: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(repostoryMock.isUserDeleted)
        XCTAssertEqual(sut.observableUsers.count, usersCountBeforeRemove - 1)
    }
    
    func testSearchSuccessful() {
        let userStub = User()
        userStub.name?.first = "foo"
        userStub.name?.last = "bar"
        let sut = makeSUT(usersStub: [userStub])
        
        sut.fetchAll()
        sut.search(with: "foo")
        
        XCTAssertEqual(sut.observableUsers.array.first, userStub)
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
