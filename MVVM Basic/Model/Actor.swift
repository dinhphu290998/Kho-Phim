//
//  Actor.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation

struct Actor: Codable {
    var id: Int?
    var cast: [Cast]?
    var crew: [Crew]?
}

struct Cast: Codable {
    var cast_id: Int?
    var character: String?
    var credit_id: String?
    var gender: Int?
    var id: Int?
    var name: String?
    var order: Int?
    var profile_path: String?
}

struct Crew: Codable {
    var credit_id: String?
    var department: String?
    var gender: Int?
    var id: Int?
    var job: String?
    var name: String?
    var profile_path: String?
}

