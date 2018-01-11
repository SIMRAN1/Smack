//
//  LoginVCViewController.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 11/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
}
