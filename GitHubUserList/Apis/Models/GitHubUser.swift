//
//  GitHubUser.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation

struct GitHubUser: Decodable {
    
    let login: String
    let id: Int
    let siteAdmin: Bool
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case siteAdmin = "site_admin"
        case avatarUrl = "avatar_url"
    }
    
}

struct GitHubUserResponse: Decodable {
    let users: [GitHubUser]
}

extension GitHubUserResponse {
    init(from decoder: Decoder) throws {
        var users: [GitHubUser] = []
        var unkeyedContainer = try decoder.unkeyedContainer()
        while !unkeyedContainer.isAtEnd {
            let user = try unkeyedContainer.decode(GitHubUser.self)
            users.append(user)
        }
        self.init(users: users)
    }
}
