//
//  ChannelVC.swift
//  Smack
//
//  Created by Jonny B on 7/14/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var profimg: CircleImage!
    @IBOutlet weak var loginnext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    @IBAction func loginbtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
           // performSegue(withIdentifier: TO_LOGIN, sender: nil)
            performSegue(withIdentifier:"tologin", sender: nil)
        }
        
    }
  @objc  func userDataDidChange(_notif: Notification){
    if AuthService.instance.isLoggedIn{
        loginnext.setTitle(UserDataService.instance.name, for: .normal)
        profimg.image=UIImage(named: UserDataService.instance.avatarName)
        profimg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    }else{
        loginnext.setTitle("Login", for: .normal)
        profimg.image=UIImage(named: "menuProfileIcon")
        profimg.backgroundColor = UIColor.clear
    }
        
    }
}
