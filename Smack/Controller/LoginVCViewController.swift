//
//  LoginVCViewController.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 11/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     setUpView()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var passwordTxt: UITextField!
    
   
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }else{
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    func setUpView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
    }

}
