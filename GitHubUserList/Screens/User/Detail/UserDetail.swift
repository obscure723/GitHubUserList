//
//  UserDetail.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import Action
import APIKit

protocol UserDetailViewModelInputs {

}

protocol UserDetailViewModelOutputs {

    var gitHubUser: GitHubUser { get }
}

protocol UserDetailViewModelType {
    var inputs: UserDetailViewModelInputs { get }
    var outputs: UserDetailViewModelOutputs { get }
}


final class UserDetailViewModel: UserDetailViewModelInputs, UserDetailViewModelOutputs, UserDetailViewModelType {
    
    var inputs: UserDetailViewModelInputs { return self }
    var outputs: UserDetailViewModelOutputs { return self }
    
    var gitHubUser: GitHubUser
    
    private let searchAction: Action<String, GitHubUser>
    
    init(gitHubUser: GitHubUser) {
        self.gitHubUser = gitHubUser
        
        self.searchAction = Action { username in
            return Session.shared.rx.response(GitHubApi.SearchUserDetailRequest(username: username))
        }
    }
    
}
