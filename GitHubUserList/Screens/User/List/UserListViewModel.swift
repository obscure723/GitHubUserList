//
//  UserListViewModel.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import APIKit
import Action

protocol UserListViewModelInputs {
    
    var fetchTrigger: PublishSubject<Void> { get }
    
    var reachedBottomTrigger: PublishSubject<Void> { get }
    
}

protocol UserListViewModelOutputs {
    
    var gitHubUsers: Observable<[GitHubUser]> { get }
    
    var isLoading: Observable<Bool> { get }
    
    var error: Observable<NSError> { get }
}

protocol UserListViewModelType {
    
    var inputs: UserListViewModelInputs { get }
    var outputs: UserListViewModelOutputs { get }
    
}

final class UserListViewModel: UserListViewModelInputs, UserListViewModelOutputs, UserListViewModelType {
    
    var fetchTrigger = PublishSubject<Void>()
    
    var reachedBottomTrigger = PublishSubject<Void>()
    
    var gitHubUsers: Observable<[GitHubUser]>
    
    var isLoading: Observable<Bool>
    
    var error: Observable<NSError>
    
    var inputs: UserListViewModelInputs { return self }
    
    var outputs: UserListViewModelOutputs { return self }
    
    private let page = BehaviorRelay<Int>(value: 1)
    
    private let searchAction: Action<Int, [GitHubUser]>
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.searchAction = Action { page in
            return Session.shared.rx.response(GitHubApi.SearchUserRequest(page: page))
        }
        
        let response = BehaviorRelay<[GitHubUser]>(value: [])
        self.gitHubUsers = response.asObservable()
        
        self.isLoading = searchAction.executing.startWith(false)
        self.error = searchAction.errors.map {_ in NSError(domain: "Network Error", code: 0, userInfo: nil)}
        

        searchAction.elements
            .withLatestFrom(response) { ($0, $1) }
            .map { $0.1 + $0.0 }
            .bind(to: response)
            .disposed(by: disposeBag)

        searchAction.elements
            .withLatestFrom(page)
            .map { $0 + 1 }
            .bind(to: page)
            .disposed(by: disposeBag)
        
        fetchTrigger
            .withLatestFrom(page)
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
        
        reachedBottomTrigger
            .withLatestFrom(isLoading)
            .filter {!$0}
            .withLatestFrom(page)
            .filter {$0 < 5}
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
    }
}
