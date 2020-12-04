//
//  SearchUseCaseTests.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/3/20.
//

@testable import RandomUserGenerator
import XCTest

class SearchUseCaseTests: XCTestCase {
    
    private var sut: SearchUserInteractor!
    private var usersStub: [User]!
    
    override func setUp() {
        sut = SearchUserInteractor()
        
        let user = User()
        user.name = UserName()
        user.name?.first = "foo"
        user.name?.last = "bar"
        usersStub = [user]
    }
    
    func testSearchResult() {
        var searchResults: [User]?
    
        sut.execute(users: usersStub, searchQuery: "foo") { users in
            searchResults = users
        }
        XCTAssertEqual(searchResults?.first?.name?.fullName, "foo bar")
    }
    
    override func tearDown() {
        sut = nil
        usersStub = nil
    }
}
