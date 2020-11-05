//
//  KeyboardStore.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 4/3/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI



class KeyboardStore: ObservableObject {
    enum KeyListType {
        case letter, symbol1, symbol2
    }
    @Published var listType: KeyListType = .letter
    
    @Published var keyboardView: KeyboardViewController
    
    @Published var isUpperCase: Bool = true
    @Published var capsLock: Bool = false
    
    @Published var sizes: SizeList
    @Published var darkMode: Bool = true
    
    
    init(_ UIKitKeyboardView: KeyboardViewController, keyboardSize: CGSize){
        self.keyboardView = UIKitKeyboardView
        self.sizes = SizeList(keyboardSize: keyboardSize,
                              horizontalPadding: 4,
                              topPadding: 8,
                              bottomPadding: 4)
    }
    init(_ UIKitKeyboardView: KeyboardViewController, keyboardSizeList: SizeList){
        self.keyboardView = UIKitKeyboardView
        self.sizes = keyboardSizeList
    }
    init(_ UIKitKeyboardView: KeyboardViewController, keyboardSize: CGSize, horizontalPadding: CGFloat, topPadding: CGFloat, bottomPadding: CGFloat){
        self.keyboardView = UIKitKeyboardView
        self.sizes = SizeList(keyboardSize: keyboardSize,
                              horizontalPadding: horizontalPadding,
                              topPadding: topPadding,
                              bottomPadding: bottomPadding)
    }
}


struct SizeList {
    var keyboardSize: CGSize
    
    var horizontalPadding: CGFloat
    var topPadding: CGFloat
    var bottomPadding: CGFloat
    
    var keyboardHeight: CGFloat {
        keyboardSize.height
    }
    var keyboardWidth: CGFloat {
        keyboardSize.width
    }
    
    var standardKeySize: CGSize {
        var max = 0;
        for row in letterKeyList {
            if row.count > max {
                max = row.count
            }
        }
        return CGSize(width:  ceil((keyboardSize.width)/CGFloat(max)) - 6.0,
               height: ceil(keyboardSize.height/4.0) - 12.0)
    }
    
    var standardKeyHeight: CGFloat {
        standardKeySize.height
    }
    var standardKeyWidth: CGFloat {
        standardKeySize.width
    }
}



let letterKeyList: [[KeyData]] = [
   [KeyData(character: "q", type: .letter),
    KeyData(character: "w", type: .letter),
    KeyData(character: "e", type: .letter),
    KeyData(character: "r", type: .letter),
    KeyData(character: "t", type: .letter),
    KeyData(character: "y", type: .letter),
    KeyData(character: "u", type: .letter),
    KeyData(character: "i", type: .letter),
    KeyData(character: "o", type: .letter),
    KeyData(character: "p", type: .letter)],
   
   [KeyData(character: "a", type: .letter),
    KeyData(character: "s", type: .letter),
    KeyData(character: "d", type: .letter),
    KeyData(character: "f", type: .letter),
    KeyData(character: "g", type: .letter),
    KeyData(character: "h", type: .letter),
    KeyData(character: "j", type: .letter),
    KeyData(character: "k", type: .letter),
    KeyData(character: "l", type: .letter),
    KeyData(character: "\u{0300}", type: .letter)
    ],
   
   [KeyData(character: "z", type: .letter),
    KeyData(character: "x", type: .letter),
    KeyData(character: "c", type: .letter),
    KeyData(character: "v", type: .letter),
    KeyData(character: "b", type: .letter),
    KeyData(character: "n", type: .letter),
    KeyData(character: "m", type: .letter)],
]

let symbol1KeyList: [[KeyData]] = [
   [KeyData(character: "1", type: .symbol),
    KeyData(character: "2", type: .symbol),
    KeyData(character: "3", type: .symbol),
    KeyData(character: "4", type: .symbol),
    KeyData(character: "5", type: .symbol),
    KeyData(character: "6", type: .symbol),
    KeyData(character: "7", type: .symbol),
    KeyData(character: "8", type: .symbol),
    KeyData(character: "9", type: .symbol),
    KeyData(character: "0", type: .symbol)],
   
   [KeyData(character: "-", type: .symbol),
    KeyData(character: "/", type: .symbol),
    KeyData(character: ":", type: .symbol),
    KeyData(character: ";", type: .symbol),
    KeyData(character: "(", type: .symbol),
    KeyData(character: ")", type: .symbol),
    KeyData(character: "$", type: .symbol),
    KeyData(character: "&", type: .symbol),
    KeyData(character: "@", type: .symbol),
    KeyData(character: "\"", type: .symbol)],
   
   [KeyData(character: ".", type: .largeSymbol),
    KeyData(character: ",", type: .largeSymbol),
    KeyData(character: "?", type: .largeSymbol),
    KeyData(character: "!", type: .largeSymbol),
    KeyData(character: "\'", type: .largeSymbol)]
]

let symbol2KeyList: [[KeyData]] = [
   [KeyData(character: "[", type: .symbol),
    KeyData(character: "]", type: .symbol),
    KeyData(character: "{", type: .symbol),
    KeyData(character: "}", type: .symbol),
    KeyData(character: "#", type: .symbol),
    KeyData(character: "%", type: .symbol),
    KeyData(character: "^", type: .symbol),
    KeyData(character: "*", type: .symbol),
    KeyData(character: "+", type: .symbol),
    KeyData(character: "=", type: .symbol)],
   
   [KeyData(character: "_", type: .symbol),
    KeyData(character: "\\", type: .symbol),
    KeyData(character: "|", type: .symbol),
    KeyData(character: "~", type: .symbol),
    KeyData(character: "<", type: .symbol),
    KeyData(character: ">", type: .symbol),
    KeyData(character: "€", type: .symbol),
    KeyData(character: "£", type: .symbol),
    KeyData(character: "¥", type: .symbol),
    KeyData(character: "•", type: .symbol)],
   
   [KeyData(character: ".", type: .largeSymbol),
    KeyData(character: ",", type: .largeSymbol),
    KeyData(character: "?", type: .largeSymbol),
    KeyData(character: "!", type: .largeSymbol),
    KeyData(character: "\'", type: .largeSymbol)]
]
