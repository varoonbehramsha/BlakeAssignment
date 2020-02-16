//
//  Seeds.swift
//  BlakeAssignmentTests
//
//  Created by Varoon Behramsha on 16/2/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation
@testable import BlakeAssignment

struct Seeds
{
	struct Users
	{
		static var henry = User.parent(Parent(userID: "parent123", username: "henry", type: .parent, authToken: "xyz123", studentIDs: ["child123"]))
		static var sam = User.child(Child(userID: "child123", username: "sam", type: .child, authToken: "qwerty123", parentID: "parent123"))
	}
}
