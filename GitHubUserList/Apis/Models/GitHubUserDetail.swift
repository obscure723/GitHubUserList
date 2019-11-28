//
//  GitHubUserDetail.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation

struct GitHubUserDetailResponse: Decodable {
    let login: String
    let id: Int
    let name: String
    let siteAdmin: Bool
    let avatarUrl: String
    let bio: String?
    let blog: String?
    let location: String?
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case name
        case siteAdmin = "site_admin"
        case avatarUrl = "avatar_url"
        case bio
        case blog
        case location
    }
}
