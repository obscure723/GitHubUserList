//
//  NSObjectExtension.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
    
}
