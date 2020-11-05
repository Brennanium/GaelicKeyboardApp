//
//  ShiftKeyView.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/31/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct ShiftKeyView: View {
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
    
    
    //implement double tap cool down by myself
    var body: some View {
        if environment.capsLock || environment.isUpperCase {
            return AnyView(activeView)
        } else {
            return AnyView(notActiveView)
        }
    }
    
    var notActiveView: some View {
        ZStack{
            /*RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height + 1)
                .offset(y: 1.0)
                .foregroundColor(Color.clear)//(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.4))*/
            RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height)
                .foregroundColor(color)
                //.shadow(color: Color(red: 26/255, green: 26/255, blue: 26/255), radius: 0, y: 1)
                
            
            
            HStack {
                Image(systemName: "shift")
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
            }
        }.gesture(getDoubleTapAction())
            .gesture(getTapAction())
        
        //.gesture(self.getDoubleTapAction())
    }
    
    var activeView: some View {
        ZStack{
            /*RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height + 1)
                .offset(y: 1.0)
                .foregroundColor(Color.clear)//(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.4))*/
            RoundedRectangle(cornerRadius: 4.0)
                .frame(maxWidth: self.width, maxHeight: self.height)
                .foregroundColor(highlightColor)
                //.shadow(color: Color(red: 26/255, green: 26/255, blue: 26/255), radius: 0, y: 1)
                
            
            
            HStack {
                Image(systemName: environment.isUpperCase ? "shift.fill" : "capslock.fill")
                    .font(.system(size: 18))
                    .foregroundColor(Color.black)
            }
        }.gesture(self.getLongPressAction())
    }
    
    
    
    

    func getKeySize() -> CGSize {
        return CGSize(width: environment.sizes.standardKeySize.height, height: environment.sizes.standardKeySize.height)
    }
    
    func darkMode() -> Bool {
        /* environment.UIKitKeyboardView.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark */
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
            return Color(white: 1, opacity: 0.8)
        } else {
            return Color.white
        }
    
    }
    
    
    func getTapAction() -> some Gesture{
        let tapGesture: some Gesture =
        LongPressGesture(minimumDuration: 0.00001)
            .updating($isPressed) { value, state, transaction in
                state = true
                self.environment.isUpperCase = true
            }
            .onEnded { _ in
                self.environment.isUpperCase = true
            }
        return tapGesture
    }
    
    func getDoubleTapAction() -> some Gesture{
        let doubleTap: some Gesture =
        TapGesture(count: 2)
            //.simultaneously(with: getTapAction())
            .onEnded { _ in
                self.environment.capsLock = true
            }
        return doubleTap
    }
    
    func getLongPressAction() -> some Gesture{
        let longPress: some Gesture =
        TapGesture()//minimumDuration: 0.00001)
            .onEnded { _ in
                if self.environment.isUpperCase {
                    self.environment.isUpperCase = false
                }
                if self.environment.capsLock {
                    self.environment.capsLock = false
                }
            }
        return longPress
    }
}

struct ShiftKeyView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KeyboardView().environmentObject(KeyboardStore(KeyboardViewController(), keyboardSize: CGSize(width: 414, height: 225)))
        }.background(Color(white: 0.2))
    }
}
