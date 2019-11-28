//
//  UserListViewController.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FontAwesome_swift

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: UserListViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GitHubUser", bundle: nil), forCellReuseIdentifier: "cell")
        
        viewModel = UserListViewModel()
        
        indicatorView.hidesWhenStopped = true
        
        viewModel.outputs.gitHubUsers
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { tableView, row, gitHubUser in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GitHubUserCell
                cell.login.text = "\(gitHubUser.login)"
                cell.avatarImageView.loadImageAsynchronously(url: gitHubUser.avatarUrl)
                
                if gitHubUser.siteAdmin {
                    cell.siteAdmin.font = UIFont.fontAwesome(ofSize: 50, style: .solid)
                    cell.siteAdmin.text = String.fontAwesomeIcon(name: .award)
                }
                
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitHubUser.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let detailVC = UserDetailViewController.make(with: UserDetailViewModel(gitHubUser: $0))
                self?.present(detailVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: $0 ? 50 : 0, right: 0)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let ac = UIAlertController(title: "Error \($0)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(ac, animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom.asObservable()
            .bind(to: viewModel.inputs.reachedBottomTrigger)
            .disposed(by: disposeBag)
        
        viewModel.inputs.fetchTrigger.onNext(())
        
    }

}

