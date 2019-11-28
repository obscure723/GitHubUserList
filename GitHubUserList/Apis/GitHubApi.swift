//
//  GitHubApi.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import APIKit

final class GitHubApi {
    
    struct SearchUserRequest: GitHubRequest {
        
        let page: Int
        
        let method: HTTPMethod = .get
        var path: String = "/users"
        
        init(page: Int) {
            self.page = page
        }
        
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [GitHubUser] {
            
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            
            let response = try JSONDecoder().decode(GitHubUserResponse.self, from: data)
            return response.users
            
        }
        
    }
    
    struct SearchUserDetailRequest: GitHubRequest {
        
        let username: String
        
        let method: HTTPMethod = .get
        var path: String {
            return "/users/\(username)"
        }
        
        init(username: String) {
            self.username = username
        }
        
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> GitHubUserDetailResponse {
            
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            
            let response = try JSONDecoder().decode(GitHubUserDetailResponse.self, from: data)
            return response
            
        }
        
    }
    
}


