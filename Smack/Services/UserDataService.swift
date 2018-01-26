//
//  UserDataService.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 27/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
class UserDataService{
    static let instance = UserDataService()
    public private(set) var id=""
     public private(set) var avatarName=""
    public private(set) var avatarColor=""
    public private(set) var name=""
    public private(set) var email=""
    func setUserData(id: String,avatarName: String,avatarColor: String,name: String,email: String){
        self.id=id
        self.avatarName=avatarName
        self.avatarColor=avatarColor
        self.email=email
        self.name=name
    }
    func setAvatarName(avatarName: String){
        self.avatarName=avatarName
    }
}
