//
//  SaveUseCaseTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import XCTest

class SaveUseCaseTests: XCTestCase {

    private var repositoryMock: UsersRepositoryMock!
    private var sut: SaveUserInteractor!
    
    override func setUp() {
        repositoryMock = UsersRepositoryMock(usersStub: nil)
        sut = SaveUserInteractor(usersRepository: repositoryMock)
    }
    
    func testSaveUserMethodIsCalled() {
        let dummy = User()
        sut.execute(user: dummy)
        XCTAssertEqual(repositoryMock.isUserSaved, true)
    }
    
    override func tearDown() {
        repositoryMock = nil
        sut = nil
    }
}
