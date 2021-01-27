//
//  FetchUseCaseTest.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import XCTest

class FetchUseCaseTest: XCTestCase {
    
    private var repositoryMock: UsersRepositoryMock!
    private var sut: FetchUserInteractor!
    
    override func setUp() {
        repositoryMock = UsersRepositoryMock()
        sut = FetchUserInteractor(repository: repositoryMock)
    }
    
    func testCompletedHandlerResultWithInvalidDataIsFailure() {
        let result = getExecuteResutl(usersStub: [User()])
        verifyExecute(result, expectedUsers: repositoryMock.fetchedUsers, isErrorExpected: false)
    }
    
    func testCompletedHandlerResultIsSuccess() {
        let result = getExecuteResutl(usersStub: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    private func verifyExecute(_ result: (users: [User]?, error: NSError?), expectedUsers: [User]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.users, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    private func getExecuteResutl(usersStub: [User]?) -> (users: [User]?, error: NSError?) {
        repositoryMock.fetchedUsers = usersStub
        
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
