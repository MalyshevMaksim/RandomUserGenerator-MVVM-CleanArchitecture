//
//  FetchUseCaseTest.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import XCTest

class FetchUseCaseTest: XCTestCase {
    
    private var repositoryMock: UsersRepository!
    private var sut: FetchAllUserInteractor!
    
    func testExecuteSuccessful() {
        let usersStub = [User(), User(), User()]
        repositoryMock = UsersRepositoryMock(usersStub: usersStub)
        sut = FetchAllUserInteractor(repository: repositoryMock)
        
        var users: [User]?
        var error: NSError?
        
        sut.execute { result in
            switch result {
                case .success(let fetchedUsers):
                    users = fetchedUsers
                case .failure(let fetchedError):
                    error = fetchedError
            }
        }
        XCTAssertNotEqual(users, nil)
        XCTAssertEqual(error, nil)
    }
    
    func testExecuteFailure() {
        repositoryMock = UsersRepositoryMock(usersStub: nil)
        sut = FetchAllUserInteractor(repository: repositoryMock)
        
        var users: [User]?
        var error: NSError?
        
        sut.execute { result in
            switch result {
                case .success(let fetchedUsers):
                    users = fetchedUsers
                case .failure(let fetchedError):
                    error = fetchedError
            }
        }
        XCTAssertEqual(users, nil)
        XCTAssertNotEqual(error, nil)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
    }
}
