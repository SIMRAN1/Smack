//
//  AuthService.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 13/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        
        }
    }
    var authToken : String {
        get {

            

            if(defaults.value(forKey: TOKEN_KEY) as? String != nil)
            {

            return defaults.value(forKey: TOKEN_KEY) as! String
            }
            return "abc"
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
            
        }
    }
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
            
        }
    }
    func registerUser(email:String,password: String, completion: @escaping completionHandler)
    {let lowerCaseEmail = email.lowercased()
       
        let body: [String:Any] = [
            "email" : lowerCaseEmail,
            "password": password
            
        ]
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    func loginUser(email: String, password: String, completion: @escaping completionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do
                {
                let json = try JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
                }catch{
                    print("exception")
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
        func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping completionHandler) {
            
            let lowerCaseEmail = email.lowercased()
            
            let body: [String: Any] = [
                "name": name,
                "email": lowerCaseEmail,
                "avatarName": avatarName,
                "avatarColor": avatarColor
            ]
            
            let header = [
                "Authorization":"Bearer \(AuthService.instance.authToken)",
                "Content-Type": "application/json; charset=utf-8"
            ]
            
            Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {(response) in
                
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    
                    do
                    {let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    
                    UserDataService.instance.setUserData(id: id, avatarName: avatarName, avatarColor: color, name: name, email: email)
                    completion(true)
                    }catch
                    {
                        print("exception")
                    }
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        

    
        }
    func findUserByEmail(completion: @escaping completionHandler){
        
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do
                {let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    
                    UserDataService.instance.setUserData(id: id, avatarName: avatarName, avatarColor: color, name: name, email: email)
                    completion(true)
                }catch
                {
                    print("exception")
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
   
}

