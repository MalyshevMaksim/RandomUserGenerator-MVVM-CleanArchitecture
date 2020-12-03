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
    private var savedUsersStub = [User(), User(), User(), User(), User()]
    private var networkSerivceMock: NetworkServiceProtocol!
    private var sut: UsersRepository!
    
    override func setUp() {
        persistentStorageMock = UsersPersistentStorageMock(savedUsers: savedUsersStub)
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: AlamofireNetworkServiceMock(url: URL.successUrl!))
    }
    
    func testResponseSuccessul() {
        let successfulNetworkStub = AlamofireNetworkServiceMock(url: URL.successUrl)
        successfulNetworkStub.data = try! JSONEncoder().encode(UserList())
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: successfulNetworkStub)
        
        var error: NSError?
        var users: [User]?
        
        sut.fetch { responseUsers, responseError in
            error = responseError
            users = responseUsers
        }
        XCTAssertEqual(error, nil)
        XCTAssertNotEqual(users, nil)
    }
    
    func testResponseFailure() {
        let successfulNetworkStub = AlamofireNetworkServiceMock(url: URL.successUrl)
        successfulNetworkStub.data = nil
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: successfulNetworkStub)
        
        var error: NSError?
        var users: [User]?
        
        sut.fetch { responseUsers, responseError in
            error = responseError
            users = responseUsers
        }
        XCTAssertNotEqual(error, nil)
        XCTAssertEqual(users, nil)
    }
    
    func testURLValidateFailure() {
        let failureNetworkStub = AlamofireNetworkServiceMock(url: URL.failureUrl)
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: failureNetworkStub)
        
        var error: NSError?
        var users: [User]?
        
        sut.fetch { responseUsers, responseError in
            error = responseError
            users = responseUsers
        }
        XCTAssertNotEqual(error, nil)
        XCTAssertEqual(users, nil)
    }
    
    func testSaveUser() {
        sut.save(user: User())
        XCTAssertEqual(persistentStorageMock.fetch().count, savedUsersStub.count + 1, "The entry was not added")
    }
    
    func testDeleteUser() {
        let user = savedUsersStub.first
        sut.delete(user: user!)
        XCTAssertEqual(persistentStorageMock.fetch().count, savedUsersStub.count - 1, "The entry was not deleted")
    }
    
    override func tearDown() {
        persistentStorageMock = nil
        networkSerivceMock = nil
        sut = nil
    }
}
