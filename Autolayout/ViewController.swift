//
//  ViewController.swift
//  Autolayout
//
//  Created by yanyin on 17/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    var loggedInUser: User? { didSet{ updateUI() } }
    var secure = false { didSet { updateUI() } }
    //这里的secure除了初始值是非真，还表示每次调用secure时都运行updateUI？
    
    private func updateUI() {
        passwordField.isSecureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        //?:的用法是看高级运算符文档吗？
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = (loggedInUser?.image)!
    }
    
    @IBAction func login() {
        loggedInUser = User.login(login: loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    var image: UIImage? {
        get {
            return imageView.image!
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: constrainedView,
                        attribute: .height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
}

extension User {
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        } else {
            return UIImage(named: "unknown_user")
        }
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
    
}
