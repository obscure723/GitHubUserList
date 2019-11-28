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
import RxSwift
import RxCocoa

protocol UserDetailViewModelInputs {

}

protocol UserDetailViewModelOutputs {

    var gitHubUserDetail: Observable<GitHubUserDetailResponse> { get }
}

protocol UserDetailViewModelType {
    var inputs: UserDetailViewModelInputs { get }
    var outputs: UserDetailViewModelOutputs { get }
}


final class UserDetailViewModel: UserDetailViewModelInputs, UserDetailViewModelOutputs, UserDetailViewModelType {
    
    var inputs: UserDetailViewModelInputs { return self }
    var outputs: UserDetailViewModelOutputs { return self }
    
    var gitHubUserDetail: Observable<GitHubUserDetailResponse>
    
    private let searchAction: Action<String, GitHubUserDetailResponse>
    
    init(username: String) {
        
        self.searchAction = Action { _ in
            return Session.shared.rx.response(GitHubApi.SearchUserDetailRequest(username: username))
        }
        
        let response = PublishRelay<GitHubUserDetailResponse>()
        self.gitHubUserDetail = response.asObservable()
    }
    
}
