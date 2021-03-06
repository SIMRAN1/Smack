//
//  SignUpVC.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 12/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor:UIColor?
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var smackProfileIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor=UIColor.lightGray
            }
       //     dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_UNWIND_SEGUE, sender: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var createaccountpressed: UIButton!
    
    @IBAction func crezteAccount(_ sender: UIButton) {
        spinner.isHidden=false
        spinner.startAnimating()
        guard let name = username.text , username.text != "" else { return }
        guard let email1 = email.text , email.text != "" else { return }
        guard let pass = password.text , password.text != "" else { return }
        
        AuthService.instance.registerUser(email: email1, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email1, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email1, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden=true
                                self.spinner.stopAnimating()
                                //print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: TO_UNWIND_SEGUE, sender: nil)
                                  NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func chooseAvatar(_ sender: UIButton) {
        performSegue(withIdentifier:"toCreateAvatar" , sender: nil)
    }
    
    @IBAction func GenerateBackgroundColor(_ sender: UIButton) {
        let r = CGFloat(arc4random_uniform(255))/255
         let g = CGFloat(arc4random_uniform(255))/255
         let b = CGFloat(arc4random_uniform(255))/255
        bgColor = UIColor(red: r,green: g,blue: b,alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor=self.bgColor
        }
    }
    func setupView(){
        spinner.isHidden=true
        username.attributedPlaceholder = NSAttributedString(string: "username",attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        email.attributedPlaceholder = NSAttributedString(string: "email",attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        password.attributedPlaceholder = NSAttributedString(string: "passsword",attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        let tap = UITapGestureRecognizer(target: self,action: #selector(SignUpVC.handleTap))
        view.addGestureRecognizer(tap)
}
    @objc func handleTap(){
        view.endEditing(true)
    }
}
