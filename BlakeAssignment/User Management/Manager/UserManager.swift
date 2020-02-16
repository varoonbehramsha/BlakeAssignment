//
//  UserManager.swift
//  BlakeAssignment
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

protocol UserManagerProtocol {
	var loggedInUsers:[User] {get}
	var authToken : String? {get}
	var loggedInParent : Parent? {get}
	var loggedInChild : Child? {get}
	
	func login(request:Login.LoginUser.Request,_ completionHandler:@escaping (_ result:Result<User,Error>)->Void)
	func loginChild(havingID childID:String, forParentHavingID parentID:String, _ completionHandler: @escaping (_ result:Result<Child,Error>)->Void)
	func logoutParent()
	func logoutChild()
}

enum UserManagementError : Error
{
	case authTokenMissing
}

class UserManager : UserManagerProtocol
{
	
	private var userService : UserServiceProtocol
	
	init(userService:UserServiceProtocol) {
		self.userService = userService
	}
	var loggedInUsers: [User]
	{
		return self.userService.getUsers()
	}
	
	var authToken: String?
	{
		//Assumption : When both parent and child are logged in use the child's authToken or else use the parent's authToken
		
		if let child = self.loggedInChild
		{
			return child.authToken
		}
		
		if let parent = self.loggedInParent
		{
			return parent.authToken
		}
		
		return nil
	}
	
	var loggedInParent: Parent?
	{
		guard self.loggedInUsers.count != 0 else
		{
			return nil
		}
		
		for user in self.loggedInUsers
		{
			if let parent = user.parent()
			{
				return parent
			}
		}
		
		return nil

	}
	
	var loggedInChild: Child?
	{
		guard self.loggedInUsers.count != 0 else
		{
			return nil
		}
		
		for user in self.loggedInUsers
		{
			if let child = user.child()
			{
				return child
			}
		}
		
		return nil
	}
	
	func login(request: Login.LoginUser.Request, _ completionHandler: @escaping (Result<User, Error>) -> Void) {
		self.userService.login(request: request) { (result) in
			switch result
			{
			case .success(let user):
				//Save logged in user
				self.userService.saveUser(user: user)
			case .failure:
				break
			}
			completionHandler(result)
		}
	}
	
	func loginChild(havingID childID: String, forParentHavingID parentID: String, _ completionHandler: @escaping (Result<Child, Error>) -> Void) {
		
		guard self.authToken != nil else
		{
			completionHandler(Result.failure(UserManagementError.authTokenMissing))
			return
		}
		
		self.userService.loginChild(havingID: childID, forParentHavingID: parentID, authToken: self.authToken!) { (result) in
			completionHandler(result)
		}
	}
	
	func logoutParent()
	{
		if let loggedInParent = self.loggedInParent
		{
			self.userService.removeUser(user: User.parent(loggedInParent))
		}
	}
	
	func logoutChild()
	{
		if let loggedInChild = self.loggedInChild
		{
			self.userService.removeUser(user: User.child(loggedInChild))
		}
	}
	
}
