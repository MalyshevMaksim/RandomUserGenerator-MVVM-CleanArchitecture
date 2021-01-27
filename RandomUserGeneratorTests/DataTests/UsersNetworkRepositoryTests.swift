//
//  UsersNetworkRepositoryTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

@testable import RandomUserGenerator
import RealmSwift
import XCTest

class UsersNetworkRepositoryTests: XCTestCase {

    private var persistentStorageMock: UsersPersistentStorageMock!
    private var networkSerivceMock: NetworkServiceProtocol!
    private var sut: UsersRepository!
    
    override func setUp() {
        persistentStorageMock = UsersPersistentStorageMock()
        let networkService = AlamofireNetworkServiceMock()
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: networkService)
    }
    
    func testCompletedHandlerResultIsSuccess() {
        let userListStub = UserList()
        
        let stubData = try! JSONEncoder().encode(userListStub)
        let networkServiceMock = AlamofireNetworkServiceMock(data: stubData)
        networkServiceMock.url = URL.successUrl
        
        let result = getFetchResult(from: networkServiceMock)

        verifyFetchedExpected(result, expectedUsers: userListStub.toArray(), isErrorExpected: false)
    }
    
    func testCompletedHandlerResultWithInvalidDataIsFailure() {
        let networkServiceMock = AlamofireNetworkServiceMock(data: nil)
        networkServiceMock.url = URL.successUrl
        
        let result = getFetchResult(from: networkServiceMock)
        
        verifyFetchedExpected(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    func testCompletedHandlerResultWithInvalidURLIsFailure() {
        let networkServiceMock = AlamofireNetworkServiceMock()
        networkServiceMock.url = URL.failureUrl
        
        let result = getFetchResult(from: networkServiceMock)
        
        verifyFetchedExpected(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    private func verifyFetchedExpected(_ result: (users: [User]?, error: NSError?), expectedUsers: [User]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.users, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    private func getFetchResult(from networkServiceMock: NetworkServiceProtocol) -> (users: [User]?, error: NSError?) {
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: networkServiceMock)
        
        var users: [User]?
        var error: NSError?
        
        sut.fetch { responseUsers, responseError in
            error = responseError
            users = responseUsers
        }
        return (users, error)
    }
    
    func testSaveUserMethodWasCalled() {
        let dummy = User()
        sut.save(user: dummy)
        XCTAssertEqual(persistentStorageMock.isUserSaved, true)
    }
    
    func testDeleteUserMethodWasCalled() {
        let dummy = User()
        sut.delete(user: dummy)
        XCTAssertEqual(persistentStorageMock.isUserDeleted, true)
    }
    
    override func tearDown() {
        persistentStorageMock = nil
        networkSerivceMock = nil
        sut = nil
    }
}
