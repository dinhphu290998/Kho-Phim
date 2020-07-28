//
//  Result.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/14/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import UIKit

struct Result: Codable {
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}
