//
//  DecodableDataParser.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import APIKit

struct DecodableDataParser: DataParser {
    
    var contentType: String? = "application/json"
    
    func parse(data: Data) throws -> Any {
        return data
    }
    
}
