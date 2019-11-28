//
//  SessionExtension.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/27.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import RxSwift
import APIKit

extension Session: ReactiveCompatible {}

extension Reactive where Base: Session {
    
    func response<T: Request>(_ request: T) -> Observable<T.Response> {
        
        return Observable<T.Response>.create { [weak base] observer -> Disposable in
            
            let task = base?.send(request) { result in
                
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create {task?.cancel()}
        }
        
    }
    
}
