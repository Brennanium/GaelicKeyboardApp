//
//  ContentView.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/25/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var environment: KeyboardStore
    
    @State var testText: String = ""
    
    var body: some View {
        VStack {
            KeyboardKeyButton(height: 215)
            Text("Hello, World!  Your string is: \"\(testText)\"")
            
            HStack {
                TextField("test text", text: $testText)
            }.padding()
            //GlobeKeyButtonView()
            ZStack{
                HStack(spacing: 0.0){
                    Rectangle().foregroundColor(Color.white)
                    Rectangle().foregroundColor(Color.black)
                }
                Rectangle()
                    .foregroundColor(Color(red: 57/255, green: 57/255, blue: 57/255, opacity:0.75))
                    .frame(width: 150, height: 90)
                    .offset(y: -150)
                Rectangle()
                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity:0.30))
                    .frame(width: 70, height: 50)
                    .offset(y: -170)
                Rectangle()
                .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255, opacity:0.4))
                .frame(width: 70, height: 50)
                .offset(y: -130)
                
                
            }
        }.background(Color.black)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(KeyboardStore(KeyboardViewController(), keyboardSize: CGSize(width: 414, height: 225)))
            .environment(\.colorScheme, .dark)
            //.environment(, /*@START_MENU_TOKEN@*/.extraExtraLarge/*@END_MENU_TOKEN@*/)
    }
}
#endif
