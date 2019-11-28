//
//  UserDetailViewController.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var userIconLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var addressIconLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var blogIconLabel: UILabel!
    
    @IBOutlet weak var blogLabel: UILabel!
    
    private var viewModel: UserDetailViewModelType!
    
    static func make(with viewModel: UserDetailViewModel) -> UserDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! Self
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
}
