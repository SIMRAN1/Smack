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
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        SocketService.instance.getChannel { (success) in
            if success {
                print("ssss")
                self.tableView.reloadData()
            }else{
                print("nobita")
            }
        }
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.Id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
        

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
        tableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.Id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }

    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }

}
