//
//  User.swift
//  BlakeAssignment
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation


enum User : Codable
{
	func encode(to encoder: Encoder) throws {
		//TODO : Implement logic to encode a User value so it can be encoded in order to save it to UserDefaults/Keychain.
	}
	
	case parent(Parent)
	case child(Child)
	case unknown
	
	enum CodingKeys : String, CodingKey
	{
		case type
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		guard let type = try? container.decode(UserType.self,forKey:.type) else
		{
			self = .unknown
			return
		}
		let objectContainer = try decoder.singleValueContainer()
		switch type {
		case .parent:
			let parent = try objectContainer.decode(Parent.self)
			self = .parent(parent)
		case .child:
			let child = try objectContainer.decode(Child.self)
			self = .child(child)
		case .unknown:
			self = .unknown
		}
	}
	
}

struct Parent : Codable
{
	var userID : String
	var username:String
	var type : UserType
	var authToken : String
	var studentIDs : [String]
	
	enum CodingKeys:String,CodingKey {
		case userID = "user_id"
		case username
		case type
		case authToken = "auth_token"
		case studentIDs = "student_ids"
	}
}

struct Child : Codable
{
	var userID : String
	var username:String
	var type : UserType
	var authToken : String
	var parentID : String
	
	enum CodingKeys:String,CodingKey {
		case userID = "user_id"
		case username
		case type
		case authToken = "auth_token"
		case parentID = "parent_id"
	}
}

enum UserType : String, Codable
{
	case parent
	case child
	case unknown
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let type = try container.decode(String.self)
		self = UserType(rawValue: type) ?? .unknown
	}
	
}
