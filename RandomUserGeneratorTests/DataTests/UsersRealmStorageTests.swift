//
//  UsersRealmStorageTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 11/30/20.
//

@testable import RandomUserGenerator
import XCTest
import RealmSwift

class UsersRealmStorageTests: XCTestCase {

    private var stubRealm: Realm!
    private var sut: UsersRealmStorage!
    private var config = Realm.Configuration.defaultConfiguration

    override func setUp() {
        config.inMemoryIdentifier = UUID().uuidString
        stubRealm = try! Realm(configuration: config)
        sut = UsersRealmStorage(realm: stubRealm)
    }

    func testSaveUser() {
        let expectedUser = User()
        expectedUser.email = "expected@expected.com"
        sut.save(user: expectedUser)
        XCTAssertEqual(stubRealm.objects(User.self).first?.email, expectedUser.email, "The entry was not added")
    }

    func testRemoveUser() {
        let user = User()
        sut.save(user: user)
        sut.delete(user: user)
        XCTAssertEqual(stubRealm.objects(User.self).count, 0, "The entry was not deleted")
    }

    func testFetchUsers() {
        let expectedUsers = [User(), User(), User(), User(), User()]
        
        // The result of the test that checks the save method should not affect the test that checks the fetch
        // Therefore, you cannot use the prepared sut object
        // We use the Realm file with the prepared data to be independent of the save method
        
        expectedUsers.forEach { expectedUser in
            expectedUser.uuid = UUID().uuidString
            try! stubRealm.write {
                stubRealm.add(expectedUser)
            }
        }
        
        let array = sut.fetch()
        XCTAssertEqual(expectedUsers.count, array.count, "The fetched objects do not match the saved ones")
    }

    override func tearDown() {
        stubRealm = nil
        sut = nil
    }
}
