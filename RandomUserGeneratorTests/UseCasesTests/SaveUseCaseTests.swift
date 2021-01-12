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
    private var usersStub: [User]!
    
    override func setUp() {
        usersStub = [User(), User(), User()]
        repositoryMock = UsersRepositoryMock(usersStub: usersStub)
        sut = SaveUserInteractor(usersRepository: repositoryMock)
    }
    
    func testNumberOfUsersIncreasingAfterExecute() {
        sut.execute(user: User())
        let initialUserCount = usersStub.count
        XCTAssertEqual(repositoryMock.users?.count, initialUserCount + 1)
    }
    
    override func tearDown() {
        repositoryMock = nil
        sut = nil
    }
}
