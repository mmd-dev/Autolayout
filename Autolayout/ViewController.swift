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
    }
    
    @IBAction func login() {
        loggedInUser = User.login(login: loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
}

