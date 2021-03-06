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
    func returnUIColor(components: String) -> UIColor{
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r,g,b,a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        guard  let rUnwrapped = r else {
            return defaultColor
        }
        guard  let gUnwrapped = g else {
            return defaultColor
        }
        guard  let bUnwrapped = b else {
            return defaultColor
        }
        guard  let aUnwrapped = a else {
            return defaultColor
        }
        let rfloat = CGFloat(rUnwrapped.doubleValue)
         let gfloat = CGFloat(gUnwrapped.doubleValue)
         let bfloat = CGFloat(bUnwrapped.doubleValue)
         let afloat = CGFloat(aUnwrapped.doubleValue)
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        return newUIColor
    }
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }

}
