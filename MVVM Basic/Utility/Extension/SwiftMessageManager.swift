//
//  SwiftMessageManager.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/14/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation

import Foundation
import SwiftMessages
import RxCocoa
import RxSwift

class SwiftMessageManager {
    // Share instance
    static let shared = SwiftMessageManager()
    // Seperate SwiftMessage instance to display multiple message at same time
    let successSwiftMessage = SwiftMessages()
    let timeSwiftMessage = SwiftMessages()
    let freeCastSwiftMessage = SwiftMessages()
    let commonMessageInstant = SwiftMessages()

    //let toastSwifMessage = SwiftMessages()
    let reviewSwifMessage = SwiftMessages()
    
    let premiumSwiftMessage = SwiftMessages()
    let approachViewMessage = SwiftMessages()
    
    var sharedConfig: SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
//        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.preferredStatusBarStyle = .lightContent
        return config
    }
}


// MARK: - Message notify
extension SwiftMessageManager {
    func showMessage(messageType type: Theme, withTitle title: String = "", message: String, completion: (() -> Void)? = nil, duration: SwiftMessages.Duration = .seconds(seconds: 4)) {
        var config = sharedConfig
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(type)
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        view.configureDropShadow()
        config.duration = duration
        config.eventListeners = [{ event in
            switch event {
            case .didHide:
                completion?()
            default:
                break
            }
            }]
        commonMessageInstant.show(config: config, view: view)
    }
    
    func showMessage(messageType type: Theme, withTitle title: String = "", message: String, completion: (() -> Void)? = nil, duration: SwiftMessages.Duration = .seconds(seconds: 4), config: SwiftMessages.Config) {
        var config = config
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(type)
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        view.configureDropShadow()
        config.duration = duration
        config.eventListeners = [{ event in
            switch event {
            case .didHide:
                completion?()
            default:
                break
            }
            }]
        commonMessageInstant.show(config: config, view: view)
    }

    
    func quickSuccessMessageCenter(message: String) {
        
    }
    
    func showNoInternetConnection() {
        let viewID = "no-internet-connection"
        let currentView = SwiftMessages.current(id: viewID)
        // Guard message currently is not shown
        guard currentView == nil else { return }
        var config = SwiftMessages.Config()
        config.dimMode = .none
        config.presentationStyle = .top
//        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureTheme(.error)
        view.configureContent(body: "Error connection")
        view.id = viewID
        SwiftMessages.sharedInstance.show(config: config, view: view)
    }
    
    func hideNoInternetConnection() {
        SwiftMessages.hide(id: "no-internet-connection")
    }
    
//    func showSuccess(completion: (() -> Void)? = nil) {
//        var config = sharedConfig
//        config.presentationStyle = .center
//        config.interactiveHide = false
//        config.dimMode = .color(color: UIColor.clear, interactive: false)
//        config.duration = .seconds(seconds: 1)
//        config.eventListeners = [{ event in
//            switch event {
//            case .didHide:
//                completion?()
//            default:
//                break
//            }
//            }]
//        let successView: SuccessView = try! SwiftMessages.viewFromNib()
//        successSwiftMessage.show(config: config, view: successView)
//    }
    
    
    /// show credit card registration popup
//    func showCreditCardRegistration() {
//        var config = sharedConfig
//        config.presentationStyle = .center
//        config.interactiveHide = false
//        config.dimMode = .gray(interactive: true)
//        let view: SuccessView = try! SwiftMessages.viewFromNib()
//        SwiftMessages.sharedInstance.show(config: config, view: view)
//    }
    
    
//    func showInputPassword() {
//        var config = sharedConfig
//        config.presentationStyle = .center
//        config.interactiveHide = true
//        config.dimMode = .gray(interactive: true)
//        let view: InputPasswordView = try! SwiftMessages.viewFromNib()
//
//        SwiftMessages.sharedInstance.show(config: config, view: view)
//    }
    
}
