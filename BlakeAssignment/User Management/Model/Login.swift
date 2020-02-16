//
//  Login.swift
//  BlakeAssignment
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

enum Login
{
	enum LoginUser
	{
		struct Request : Codable
		{
			var username : String
			var password : String
			
		}
		
		struct Response
		{
			var user : User
		}
		
		struct ViewModel
		{
			//TODO : Add any properties the views would need in order to display the information
		}
	}
	
	enum ParentLoginChild
	{
		struct Request : Codable
		{
			var parentID:String
			var childID : String
			var authToken : String
			
			enum CodingKeys : String,CodingKey
			{
				case parentID = "parent_id"
				case childID = "student_id"
				case authToken = "auth_token"
			}
		}
		
		struct Response
		{
			var child : Child
		}
		
		struct ViewModel
		{
			//TODO : Add any properties the views would need in order to display the information
		}
	}
}
