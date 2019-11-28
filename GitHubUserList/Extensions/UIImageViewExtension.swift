//
//  UIImageViewExtension.swift
//  GitHubUserList
//
//  Created by yonekan on 2019/11/28.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageAsynchronously(url: String, defaultUIImage: UIImage? = nil) -> Void {

        let url = URL(string: url)
        
        if url == nil {
            self.image = defaultUIImage
            return
        }

        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                    } else {
                        self.image = defaultUIImage
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.image = defaultUIImage
                }
            }
        }
    }
}
