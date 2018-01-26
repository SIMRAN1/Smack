//
//  Constatnts.swift
//  Smack
//
//  Created by SIMRANPREET KAUR on 11/01/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
let TO_LOGIN = "tologin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_UNWIND_SEGUE = "UnwindSegue"
let LOGGED_IN_KEY = "loginstatus"
let TOKEN_KEY = "authtoken"
let USER_EMAIL = "useremail"
typealias  completionHandler = ( _ Success: Bool)->()//closure
//url
let BASE_URL = "https://chattymac.herokuapp.com/v1"
let REGISTER_URL = "\(BASE_URL)/account/register"
let LOGIN_URL = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

