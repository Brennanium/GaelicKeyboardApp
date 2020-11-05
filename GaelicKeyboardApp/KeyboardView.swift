//
//  KeyboardView.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/29/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {
    
    
    @State var isToggled: Bool = false
    @EnvironmentObject var environment: KeyboardStore
    
    //@State var mockTextField : String = ""
    
    
    var spaceKey = KeyData(character: " ", label: "space", type: .spacebar)
    var shiftKey = KeyData(character: "⇧", type: .spacebar)
    var deleteKey = KeyData(character: "⌫", type: .spacebar)
    var returnKey = KeyData(character: "\n", label: "return", type: .returnKey)
    var numSwitcherKey = KeyData(character: "", label: "123", type: .numSwitcher)
    var symbolSwitcherKey = KeyData(character: "", label: "#+=", type: .symbolSwitcher)
    
    var body: some View {
        VStack {
            VStack {
                /*Text(mockTextField)
                if(!mockTextField.isEmpty){
                    Button("clear", action: {
                        self.mockTextField = ""
                    }).padding(10)
                }
                Button(action: {
                    self.environment.isUpperCase.toggle()
                }) {
                    Text("Toggle isUpperCase").foregroundColor(Color.white)
                }.padding(20)
                    .background(environment.isUpperCase ? Color.blue : Color.gray)
                    //.overlay(RoundedRectangle(cornerRadius: 10))
                */
                //keyboard
                VStack {
                    VStack {
                        //first row
                        KeyboardRowView(rowIndex: 0)
                        Spacer()
                        
                        //second row
                        HStack {
                            if keyList(1).count < 10 {
                                Spacer()
                            }
                            KeyboardRowView(rowIndex: 1)
                            if keyList(1).count < 10 {
                                Spacer()
                            }
                        }
                        Spacer()
                        
                        //shift - third row - delete
                        HStack() {
                            if environment.listType == .letter {
                                ShiftKeyView(key: shiftKey)
                            } else {
                                SymbolSwitcherKeyView(key: symbolSwitcherKey)
                            }
                            Spacer()
                            KeyboardRowView(/*mockTextField: self.$mockTextField, */rowIndex: 2)
                            Spacer()
                            DeleteKeyView(key: deleteKey)
                        }.frame(maxWidth: .infinity)
                        Spacer()
                        
                        //____ - space - return
                        HStack(spacing: 6.0){
                            HStack(spacing: 6.0) {
                                NumSwitcherKeyView(key: numSwitcherKey)
                                if environment.keyboardView.needsInputModeSwitchKey {
                                    GlobeKeyButtonView()
                                }
                            }//.frame(width: ceil((environment.sizes.keyboardSize.width)/4) - 6.0)
                            
                            KeyView(/*mockTextField: self.$mockTextField, */key: spaceKey)
                            
                            HStack(spacing: 6.0) {
                                //extra symbols if needed
                                ReturnKeyView(key: returnKey)
                            }.frame(width: ceil((environment.sizes.keyboardSize.width)/4) - 6.0)
                        }
                    }.padding(.top, environment.sizes.topPadding)
                        .padding(.horizontal, environment.sizes.horizontalPadding)
                        .padding(.bottom, environment.sizes.bottomPadding)
                }.frame(maxHeight: environment.sizes.keyboardHeight)
                    //.background(Color.black)
            }
        }/*.onAppear() {
            
        }*/
    }
    
    func keyList(_ rowIndex: Int) -> [KeyData] {
        switch environment.listType {
        case .symbol1:
            return symbol1KeyList[rowIndex]
        case .symbol2:
            return symbol2KeyList[rowIndex]
        default:
            return letterKeyList[rowIndex]
        }
    }
}


struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KeyboardView().environmentObject(KeyboardStore(KeyboardViewController(), keyboardSize: CGSize(width: 414, height: 225)))
            }.background(Color(white: 0.2))
            .environment(\.colorScheme, .dark)
    }
}


struct KeyboardRowView: View {
    @EnvironmentObject var environment: KeyboardStore
    
    let rowIndex: Int
    
    func keyList(_ rowIndex: Int) -> [KeyData] {
        switch environment.listType {
        case .symbol1:
            return symbol1KeyList[rowIndex]
        case .symbol2:
            return symbol2KeyList[rowIndex]
        default:
            return letterKeyList[rowIndex]
        }
    }
    
    var body: some View {
        HStack(spacing: 6.0) {
            ForEach(keyList(rowIndex), id: \.self) { key in
                KeyView(key: key)
            }
        }.frame(maxWidth: .infinity)
    }
}



