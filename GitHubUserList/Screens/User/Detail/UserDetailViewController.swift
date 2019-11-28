//
//  UserDetailViewController.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import APIKit
import FontAwesome_swift

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var userIconLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var addressIconLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var blogIconLabel: UILabel!
    
    @IBOutlet weak var blogLabel: UILabel!
    
    private var username: String = ""
    
    static func make(with username: String) -> UserDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! Self
        view.username = username
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIcon()
        
        Session.send(GitHubApi.SearchUserDetailRequest(username: username)) { result in
            switch result {
            case .success(let response):
                self.imageView.loadImageAsynchronously(url: response.avatarUrl)
                self.loginLabel.text = response.login
                self.nameLabel.text = response.name
                self.locationLabel.text = response.location
                self.blogLabel.text = response.blog
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initIcon() {
        userIconLabel.font = UIFont.fontAwesome(ofSize: 50, style: .solid)
        userIconLabel.text = String.fontAwesomeIcon(name: .userTie)
        
        addressIconLabel.font = UIFont.fontAwesome(ofSize: 50, style: .solid)
        addressIconLabel.text = String.fontAwesomeIcon(name: .mapPin)
        
        blogIconLabel.font = UIFont.fontAwesome(ofSize: 50, style: .solid)
        blogIconLabel.text = String.fontAwesomeIcon(name: .blog)
    }
}
