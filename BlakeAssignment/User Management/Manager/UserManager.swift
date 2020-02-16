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
	var accessToken : String? {get}
	var loggedInParent : Parent? {get}
	var loggedInChild : Child {get}
	
	func login(request:Login.LoginUser.Request,_ completionHandler:@escaping (_ result:Result<User,Error>)->Void)
	func loginChild(havingID childID:String, forParentHavingID parentID:String,accessToken : String, _ completionHandler: @escaping (_ result:Result<Child,Error>)->Void)
}
