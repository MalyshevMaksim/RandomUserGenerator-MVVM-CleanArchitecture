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

    private var realm: Realm!
    private var sut: UsersRealmStorage!
    private var config = Realm.Configuration.defaultConfiguration
    private var stubUsers: [User]!

    override func setUp() {
        config.inMemoryIdentifier = UUID().uuidString
        realm = try! Realm(configuration: config)
        sut = UsersRealmStorage(realm: realm)
        
        stubUsers = [User(), User(), User()]
        
        stubUsers.forEach { stubUser in
            stubUser.uuid = UUID().uuidString
            try! realm.write {
                realm.add(stubUser)
            }
        }
    }

    func testNumberOfUsersIncreasingAfterSave() {
        let newUser = User()
        let initialUserCount = realm.objects(User.self).count
        
        sut.save(user: newUser)
    
        XCTAssertEqual(realm.objects(User.self).count, initialUserCount + 1)
    }

    func testNumberOfUsersDecreasesAfterDelete() {
        let users = realm.objects(User.self)
        let initialUserCount = users.count
        
        sut.delete(user: users.first!)
        
        XCTAssertEqual(realm.objects(User.self).count, initialUserCount - 1)
    }

    func testFetchedUsersCountEqualityWithExpectedCount() {
        let expectedUsersCount = realm.objects(User.self).count
        let fetchedUsers = sut.fetch()
        XCTAssertEqual(expectedUsersCount, fetchedUsers.count)
    }

    override func tearDown() {
        realm = nil
        sut = nil
        stubUsers = nil
    }
}
