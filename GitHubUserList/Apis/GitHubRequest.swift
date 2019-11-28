//
//  GitHubRequest.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubRequest: Request {}

extension GitHubRequest {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
}

extension GitHubRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 200..<300:
            return object
        default:
            throw NSError(domain: "Something Wrong", code: urlResponse.statusCode, userInfo: nil)
        }
    }
}

extension GitHubRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
