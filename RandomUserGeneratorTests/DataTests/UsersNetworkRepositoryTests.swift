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
    private var sut: UsersRepository!
    
    override func setUp() {
        persistentStorageMock = UsersPersistentStorageMock(savedUsers: savedUsersStub)
        sut = UsersNetworkRepository(storage: persistentStorageMock, networkService: AlamofireNetworkService())
    }
    
    func testResponseSuccessful() {
        
    }
    
    func testResponseFailure() {
        
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
        sut = nil
    }
}
