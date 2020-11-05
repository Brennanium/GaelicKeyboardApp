//
//  KeyboardViewController.swift
//  GaelicKeyboard
//
//  Created by Brennanium on 3/25/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    //@IBOutlet var nextKeyboardButton: UIButton!
    
    var environment: KeyboardStore!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
        //view.heightAnchor.constraint(lessThanOrEqualToConstant: KeyboardSize().height).isActive = true
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.primaryLanguage = "gd"
        
        environment = KeyboardStore(self, keyboardSizeList: KeyboardSizeList())
        
        // Perform custom UI setup here
        let rootView = KeyboardView().environmentObject(environment)
        //let child = UIHostingController(rootView: KeyboardKeyButton(height: KeyboardSize()))
        let SwiftUIView = UIHostingController(rootView: rootView)
        //that's wrong, it must be true to make flexible constraints work
        //child.translatesAutoresizingMaskIntoConstraints = false
        SwiftUIView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        SwiftUIView.view.backgroundColor = UIColor(white: 0, alpha: 0.001)
        SwiftUIView.view.tag = 5
        view.addSubview(SwiftUIView.view)
        addChild(SwiftUIView)
        
        
        /*
        NSLayoutConstraint.activate([
            child.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        */
        
        /*
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        */
    }
    
    override func viewWillLayoutSubviews() {
        //self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            environment.darkMode = true
        } else {
            environment.darkMode = false
        }
        
        environment.sizes = KeyboardSizeList()
        /*
        var textColor: UIColor

        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: []) */
    }
    
    func isPortait() -> Bool {
        let bounds = UIScreen.main.bounds
        return bounds.size.height > bounds.size.width
    }
    
    func KeyboardSize() -> CGSize {
        let bounds = UIScreen.main.bounds
        let deviceHeight = bounds.size.height > bounds.size.width ? bounds.size.height : bounds.size.width
        
        var height: CGFloat
        var width: CGFloat
        
        switch deviceHeight {
        //case 568.0:
            //iPhone 5s, SE
        case 667.0:
            //iPhone 6s, 7, 8
            height = 216
            width = 375
        case 736.0:
            //iPhone 6s+, 7+, 8+
            height = 226
            width = 414
        case 812.0:
            //iPhone X, XS, 11 Pro
            height = 215
            width = 375
        case 896.0:
            //iPhone XR, XS Max, 11, 11 Pro Max
            height = 225
            width = 414
        case 1024:
            //iPad, Mini, Air
            height = 215
            width = 375
        case 1112:
            //iPad Pro 10.5
            height = 215
            width = 375
        default:
            height = 215
            width = 375
        }
        
        return CGSize(width: width, height: height)
    }
    
    func KeyboardSizeList() -> SizeList {
        let bounds = UIScreen.main.bounds
        let deviceHeight = bounds.size.height > bounds.size.width ? bounds.size.height : bounds.size.width
        
        var height: CGFloat
        var width: CGFloat
        var horizontalPadding: CGFloat = 4.0
        var topPadding: CGFloat = 8.0
        var bottomPadding: CGFloat = 4.0
        
        switch deviceHeight {
        //case 568.0:
            //iPhone 5s, SE
        case 667.0:
            //iPhone 6s, 7, 8
            height = 216
            width = 375
            bottomPadding = 5.0
        case 736.0:
            //iPhone 6s+, 7+, 8+
            height = 226
            width = 414
            bottomPadding = 5.0
        case 812.0:
            //iPhone X, XS, 11 Pro
            height = 215
            width = 375
            horizontalPadding = 3.0
        case 896.0:
            //iPhone XR, XS Max, 11, 11 Pro Max
            height = 225
            width = 414
            topPadding = 9.0
        case 1024:
            //iPad, Mini, Air
            height = 215
            width = 375
        case 1112:
            //iPad Pro 10.5
            height = 215
            width = 375
        default:
            height = 215
            width = 375
        }
        
        return SizeList(keyboardSize: CGSize(width: width, height: height),
                        horizontalPadding: horizontalPadding,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding)
    }
}

