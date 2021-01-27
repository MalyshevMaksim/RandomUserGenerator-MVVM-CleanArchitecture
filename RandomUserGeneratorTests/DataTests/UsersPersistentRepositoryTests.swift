//
//  UsersRealmRepositoryTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

@testable import RandomUserGenerator
import XCTest
import RealmSwift

class UsersPersistentRepositoryTests: XCTestCase {
    
    private var persistentStorageMock: UsersPersistentStorageMock!
    private var sut: UsersRepository!
    
    override func setUp() {
        persistentStorageMock = UsersPersistentStorageMock()
        sut = UsersPersistentRepository(storage: persistentStorageMock)
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
    
    func testFetchedUsersMethodWasCalled() {
        sut.fetch { users, error in }
        XCTAssertEqual(persistentStorageMock.isUsersFetched, true)
    }
    
    override func tearDown() {
        persistentStorageMock = nil
        sut = nil
    }
}
