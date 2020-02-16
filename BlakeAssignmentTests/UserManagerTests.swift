//
//  UserManagerTests.swift
//  BlakeAssignmentTests
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import XCTest
@testable import BlakeAssignment

class UserManagerTests: XCTestCase {
	
	// MARK: Subject under test
	
	var sut:UserManager!
	var userServiceSpy  = UserServiceSpy()
	
	// MARK: Test lifecycle

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		self.setupUserManager()
    }
	
	func setupUserManager()
	{
		sut = UserManager(userService: userServiceSpy)
	}

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
	//MARK: Test Doubles
	
	class UserServiceSpy : UserServiceProtocol
	{
		var loginWasCalled = false
		var loginChildWasCalled = false
		var saveUserWasCalled = false
		var removeUserWasCalled = false
		var getUsersWasCalled = false
		
		var users : [User] = []
		
		func login(request: Login.LoginUser.Request, _ completionHandler: @escaping (Result<User, Error>) -> Void) {
			self.loginWasCalled = true
			let parent = Parent(userID: "", username: "", type: .parent, authToken: "", studentIDs: [])
			let user = User.parent(parent)
			completionHandler(Result.success(user))
		}
		
		func loginChild(havingID childID: String, forParentHavingID parentID: String, authToken: String, _ completionHandler: @escaping (Result<Child, Error>) -> Void) {
			self.loginChildWasCalled = true
		}
		
		func saveUser(user: User) {
			self.saveUserWasCalled = true
		}
		
		func removeUser(user: User) {
			self.removeUserWasCalled = true
		}
		
		func getUsers() -> [User] {
			self.getUsersWasCalled = true
			return self.users
		}
		
	}
	

	
	//MARK: - Tests
	
	func testLogin_LoginAndSaveUserMethodsAreCalled()
	{
		//Given
		let expectation = self.expectation(description: "loginUser calls loginUser and saveUser of UserServiceProtocol ")
		let request = Login.LoginUser.Request(username: "test", password: "test")
		//When
		
		sut.login(request: request) { (result) in
			
			XCTAssertTrue(self.userServiceSpy.loginWasCalled)
			XCTAssertTrue(self.userServiceSpy.saveUserWasCalled)
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 5.0, handler: nil)
		
	}
	
	func testAuthToken_ParentAndChildLoggedIn_ReturnChildAuthToken()
	{
		//Given
		self.userServiceSpy.users = [Seeds.Users.henry,Seeds.Users.sam]
		
		//When
		let authTokenFromUserManager = sut.authToken
		let authTokenOfChild = Seeds.Users.sam.child()!.authToken
		//Then
		XCTAssertEqual(authTokenFromUserManager, authTokenOfChild)
	}
}
