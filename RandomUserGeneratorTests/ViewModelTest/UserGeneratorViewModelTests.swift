//
//  UserGeneratorViewModelTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 1/23/21.
//

@testable import RandomUserGenerator
import XCTest
import SwinjectAutoregistration
import Swinject

class UserGeneratorViewModelTests: XCTestCase {

    private let container = Container()
    private var repostoryMock: UsersRepositoryMock!
    
    override func setUp() {
        container.autoregister(UsersRepositoryMock.self, initializer: UsersRepositoryMock.init)
        container.autoregister(FetchUserInteractor.self, argument: UsersRepositoryMock.self, initializer: FetchUserInteractor.init)
        container.autoregister(SaveUserInteractor.self, argument: UsersRepositoryMock.self, initializer: SaveUserInteractor.init)
        container.autoregister(DeleteInteractor.self, argument: UsersRepositoryMock.self, initializer: DeleteInteractor.init)
        
        container.register(UserGeneratorViewModel.self) { r in
            let repository = r.resolve(UsersRepositoryMock.self)!
            self.repostoryMock = repository
            let fetched = r.resolve(FetchUserInteractor.self, argument: repository)!
            let save = r.resolve(SaveUserInteractor.self, argument: repository)!
            let delete = r.resolve(DeleteInteractor.self, argument: repository)!
            return UserGeneratorViewModel(generateUseCase: fetched, saveUseCase: save, deleteUseCase: delete, router: Router())
        }
    }
    
    func testUserFecthedFailure() {
        let sut = makeSUT(userStub: nil)
        
        sut.generateUser()
        
        XCTAssertNotNil(sut.observableError.value)
        XCTAssertNil(sut.observableUser.value)
    }
    
    func testUserFetchedSuccess() {
        let sut = makeSUT(userStub: [User()])
    
        sut.generateUser()
        
        XCTAssertEqual(repostoryMock.fetchedUsers?.first, sut.observableUser.value)
        XCTAssertNil(sut.observableError.value)
    }
    
    func testUserSaveWasCalledWhenSaveCurrentUserIsSuccess() {
        let sut = makeSUT(userStub: [User()])
        
        sut.generateUser()
        sut.saveCurrentUser()
        
        XCTAssertTrue(repostoryMock.isUserSaved)
    }
    
    func testUserSaveNotCalledWhenSaveCurrentUserIsFailure() {
        let sut = makeSUT(userStub: nil)
        sut.saveCurrentUser()
        XCTAssertFalse(repostoryMock.isUserSaved)
    }
    
    func testUserDeleteWasCalledWhenRemoveSuccess() {
        let sut = makeSUT(userStub: [User()])
        
        sut.generateUser()
        sut.removeCurrentUser()
        
        XCTAssertTrue(repostoryMock.isUserDeleted)
    }
    
    func testUserDeleteNotCalledWhenRemoveFailure() {
        let sut = makeSUT(userStub: nil)
        sut.removeCurrentUser()
        XCTAssertFalse(repostoryMock.isUserDeleted)
    }
    
    func testSaveNotificationWasSend() {
        let notificationExpectation = XCTNSNotificationExpectation(name: .didUserSave)
        let sut = makeSUT(userStub: [User()])
        
        sut.generateUser()
        sut.saveCurrentUser()
        
        wait(for: [notificationExpectation], timeout: 2)
    }
    
    func testDeleteNotificationWasSend() {
        let notificationExpectation = XCTNSNotificationExpectation(name: .didUserRemove)
        let sut = makeSUT(userStub: [User()])
    
        sut.generateUser()
        sut.removeCurrentUser()
        
        wait(for: [notificationExpectation], timeout: 2)
    }
    
    private func makeSUT(userStub: [User]?) -> UserGeneratorViewModel {
        let viewModel = container.resolve(UserGeneratorViewModel.self)!
        repostoryMock.fetchedUsers = userStub
        return viewModel
    }
    
    override func tearDown() {
        container.removeAll()
        repostoryMock = nil
    }
}
