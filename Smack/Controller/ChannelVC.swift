//
//  ChannelVC.swift
//  Smack
//
//  Created by Jonny B on 7/14/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profimg: CircleImage!
    @IBOutlet weak var loginnext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath)as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(Channel:channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
}
