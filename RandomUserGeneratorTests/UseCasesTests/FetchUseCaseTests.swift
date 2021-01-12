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
    
    func testFetchUsersExecuteIsSuccessful() {
        let usersStub = [User(), User()]
        let result = getExecuteResutl(usersStub: usersStub)
        verifyExecute(result, expectedUsers: usersStub, expectedError: nil)
    }
    
    func testFetchUsersExecuteIsFailure() {
        let result = getExecuteResutl(usersStub: nil)
        let expectedError = NSError.makeError(withMessage: "foo")
        verifyExecute(result, expectedUsers: nil, expectedError: expectedError)
    }
    
    private func verifyExecute(_ result: (users: [User]?, error: NSError?), expectedUsers: [User]?, expectedError: NSError?) {
        XCTAssertEqual(result.users, expectedUsers)
        XCTAssertEqual(result.error, expectedError)
    }
    
    private func getExecuteResutl(usersStub: [User]?) -> (users: [User]?, error: NSError?) {
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
        return (users, error)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
    }
}
