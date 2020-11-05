//
//  KeyView.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/30/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct NumSwitcherKeyView: View {
    @EnvironmentObject var environment: KeyboardStore
    //@Environment (\.standardKeySize) var standardKeySize
    //@Environment (\.isUpperCase) var isUpperCase
    //@Binding var isUpperCase: Bool
    //@Binding var mockTextField: String
    
    @GestureState var isPressed: Bool = false
    
    var key: KeyData
    
    //let action: (() -> ())
    
    var color: Color {
        getKeyColor()
    }
    var highlightColor: Color {
        getKeyHighlightColor()
    }
    var height: CGFloat {
        getKeySize().height
    }
    var width: CGFloat {
        getKeySize().width
    }
    
    var body: some View {
        ZStack{
            /*RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height + 1)
                .offset(y: 1.0)
                .foregroundColor(Color.clear)//(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.4))*/
            RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height)
                .foregroundColor(isPressed ? highlightColor : color)
                //.shadow(color: Color(red: 26/255, green: 26/255, blue: 26/255), radius: 0, y: 1)
                
            
            
            HStack {
                Text(environment.listType != .letter ? "ABC" : "123")
                    .font(.system(size: key.character == key.label ? (environment.isUpperCase ? 22 : 26) : 16))
                    .fontWeight(key.character == key.label ? (environment.isUpperCase ? .regular : .light) : .regular)
                    .foregroundColor(Color.white)
                
            }
        }.gesture(
            LongPressGesture(minimumDuration: 0.00001)
                .updating($isPressed) { value, state, transaction in
                    state = value
                }
                .onEnded({_ in
                    self.defaultKeyAction()
                }
            )
        )
        
    }
    
    
    
    

    func getKeySize() -> CGSize {
        var width: CGFloat = ceil(environment.sizes.keyboardWidth/4.0) - 6.0
        if environment.keyboardView.needsInputModeSwitchKey {
            width = environment.sizes.standardKeyHeight
        }
        return CGSize(width: width, height: environment.sizes.standardKeyHeight)
    }
    
    func darkMode() -> Bool {
        //environment.UIKitKeyboardView.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark
        return true
    }
    
    func getKeyColor() -> Color {
        if darkMode() {
            return Color(white: 180/255, opacity: 0.195)
        } else {
            return Color.gray
        }
    }
    
    func getKeyHighlightColor() -> Color {
        if darkMode() {
            return Color(white: 1, opacity: 0.3)
        } else {
            return Color.white
        }
    }
    
    func defaultKeyAction() -> Void{
        if(environment.listType == .letter) {
            environment.listType = .symbol1
        } else {
            environment.listType = .letter
        }
    }
}

struct NumSwitcherKeyView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KeyboardView().environmentObject(KeyboardStore(KeyboardViewController(), keyboardSize: CGSize(width: 414, height: 225)))
        }.background(Color(white: 0.2))
    }
}

