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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        guard let emailid = email.text , email.text != "" else { return }
        guard let pass = password.text , password.text != "" else { return }
        
        AuthService.instance.registerUser(email: emailid, password: pass) { (success) in
            if success {
                print("registered user!")
            }
        }
        
        
    }
    
}
