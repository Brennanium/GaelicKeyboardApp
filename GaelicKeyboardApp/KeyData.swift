//
//  SwiftUIView.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/29/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct KeyData: Hashable {
    //@EnvironmentObject static var environment: KeyboardStore
    static let darkMode = true//environment.UIKitKeyboardView.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark
    
    
    enum KeyType {
        case letter, spacebar, returnKey, globe,
            numSwitcher, symbolSwitcher, shiftKey,
            backspace, symbol, largeSymbol
    }

    let character: String
    let label: String
    let type: KeyType
    
    init(character: String, label: String? = nil, type: KeyType){
        self.character = character
        self.type = type
        self.label = label ?? character
    }
}


