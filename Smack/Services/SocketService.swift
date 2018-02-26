//
//  SocketService.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 26/02/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
    static let instance = SocketService()
    override init() {
        super.init()
    }
var socket :  SocketIOClient = SocketIOClient(manager: SocketManager(socketURL: URL.init(string: BASE_URLL)! ),nsp:"/swift")
  //  var sockett: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.XXX:3000")!)
  // let socket = SocketIOClient(socketURL: BASE_URL, config: [.nsp("/mynamespace")])
    //lazy var manager : SocketManager = SocketManager(socketURL: URL(string:BASE_URL)!)
   // let defaultNamespaceSocket = manager.defaultSocket
   // let socket = manager.socket(forNamespace: "/swift")
   // let defaultSocket = SocketIOClient(socketURL: BASE_URL)
   // let socket = SocketIOClient(socketURL: BASE_URL, config: [.nsp("/swift")])
   /* var manager : SocketManager{
       return SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
    }
    let socket = self.manager.defaultSocket*/
    //let manager = SocketManager(socketURL: URL.init(string: BASE_URL)! )
    /*let defaultSocket = SocketManager(socketURL: URL.init(string: BASE_URLL)! ).defaultSocket
    let socket = SocketManager(socketURL: URL.init(string: BASE_URLL)! ).socket(forNamespace: "/swift")*/
    
    func establishConnection() {
        socket.connect()
        print("connected")
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping completionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping completionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            print("hi\(channelName)")
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, Id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }

}
}
