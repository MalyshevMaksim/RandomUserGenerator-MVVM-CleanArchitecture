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
    private var savedUsersStub = [User(), User(), User(), User(), User()]
    private var sut: UsersRepository!
    
    override func setUp() {
        persistentStorageMock = UsersPersistentStorageMock(savedUsers: savedUsersStub)
        sut = UsersPersistentRepository(storage: persistentStorageMock)
    }
    
    func testSaveUser() {
        sut.save(user: User())
        XCTAssertEqual(persistentStorageMock.fetch().count, savedUsersStub.count + 1, "The entry was not added")
    }
    
    func testDeleteUser() {
        let user = savedUsersStub.first
        sut.delete(user: user!)
        XCTAssertNotEqual(persistentStorageMock.fetch().count, savedUsersStub.count, "The entry was not deleted")
    }
    
    func testFetchUserSuccessful() {
        var fetchedUser: [User] = []
        sut.fetch { users, error in fetchedUser = users ?? [] }
        XCTAssertEqual(persistentStorageMock.fetch().count, fetchedUser.count, "The fetched objects do not match the saved ones")
    }
    
    override func tearDown() {
        persistentStorageMock = nil
        sut = nil
    }
}
