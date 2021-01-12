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
        let networkService = AlamofireNetworkService(url: URL.successUrl)
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: networkService)
    }
    
    func testCompletedHandlerResultIsSuccess() {
        let userStub = User()
        let stubData = try! JSONEncoder().encode(userStub)
        let networkServiceMock = AlamofireNetworkServiceMock(data: stubData, url: URL.successUrl)
        
        let result = getFetchResult(from: networkServiceMock)
        verifyFetchedExpected(result, expectedUsers: userStub, isErrorExpected: false)
    }
    
    func testCompletedHandlerResultWithInvalidDataIsFailure() {
        let networkServiceMock = AlamofireNetworkServiceMock(data: nil, url: URL.successUrl)
        let result = getFetchResult(from: networkServiceMock)
        verifyFetchedExpected(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    func testCompletedHandlerResultWithInvalidURLIsFailure() {
        let failureUrlStub = URL.failureUrl
        let networkServiceMock = AlamofireNetworkServiceMock(url: failureUrlStub)
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
    
    func testSaveUserMethodIsCalled() {
        let dummy = User()
        sut.save(user: dummy)
        XCTAssertEqual(persistentStorageMock.isUserSaved, true)
    }
    
    func testDeleteUserMethodIsCalled() {
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
