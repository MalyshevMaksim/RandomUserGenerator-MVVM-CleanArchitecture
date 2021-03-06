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
    
    override func setUp() {
        repositoryMock = UsersRepositoryMock()
        repositoryMock.fetchedUsers = nil
        sut = DeleteInteractor(repository: repositoryMock)
    }
    
    func testDeleteUserMethodWasCalled() {
        let dummy = User()
        sut.execute(user: dummy)
        XCTAssertEqual(repositoryMock.isUserDeleted, true)
    }
    
    override func tearDown() {
        repositoryMock = nil
        sut = nil
    }
}
