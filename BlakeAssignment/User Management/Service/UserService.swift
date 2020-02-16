//
//  UserService.swift
//  BlakeAssignment
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

protocol UserServiceProtocol
{
	func login(request:Login.LoginUser.Request,_ completionHandler : @escaping (_ result:Result<User,Error>)->Void)
	func loginChild(havingID childID:String, forParentHavingID parentID:String,authToken : String, _ completionHandler: @escaping (_ result:Result<Child,Error>)->Void)
	func saveUser(user:User)
	func removeUser(user:User)
	func getUsers()->[User]
}
