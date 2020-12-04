//
//  DeleteUseCaseTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import XCTest

class DeleteUseCaseTests: XCTestCase {

    private var repositoryMock: UsersRepositoryMock!
    private var sut: DeleteInteractor!
    private var usersStub: [User]!
    
    override func setUp() {
        usersStub = [User(), User(), User()]
        repositoryMock = UsersRepositoryMock(usersStub: usersStub)
        sut = DeleteInteractor(repository: repositoryMock)
    }
    
    func testDeleteExecute() {
        let deletedUser = usersStub.first
        sut.execute(user: deletedUser!)
        XCTAssertEqual(repositoryMock.users?.count, usersStub.count - 1)
    }
    
    override func tearDown() {
        repositoryMock = nil
        sut = nil
    }
}
