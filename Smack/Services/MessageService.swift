//
//  MessageService.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 29/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    static let instance = MessageService()
    var channels = [Channel]()
    var selectedChannel: Channel?
    func findAllChannel(completion: @escaping completionHandler){
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do{
                if let json = try JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, Id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name:NOTIF_CHANNELS_LOADED,object: nil)
                    completion(true)
                }
                
                }catch{
                    print("exception")
                }
                
            } else {
                completion(false)
                print("abc")
                print(response.result.error as Any)
            }
        }
        
    }
    func clearChannels(){
        channels.removeAll()
    }
}
