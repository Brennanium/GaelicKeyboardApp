//
//  KeyboardKeyButton.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/25/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

/*
struct Key: View {
    //let action: () -> ()
    var letter: String
    var fontSize: CGFloat
    var fontColor: Color
    var color: Color
    //var width: CGFloat
    var height: CGFloat
    
    init(letter: String, fontSize: CGFloat = 24, fontColor: Color = Color.white, color: Color = Color(red: 106.5/255, green: 106.5/255, blue: 106.5/255)/*, width: CGFloat = 32){*/, height: CGFloat = 42){
        self.letter = letter
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.color = color
        //self.width = width
        self.height = height
    }
    
    var body: some View {
        Button(action: {
            print("\(self.letter) was pressed!")
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 4.0)
                    .frame(/*maxWidth: self.width),*/ maxHeight: self.height)
                    .offset(y: 1.0)
                    .foregroundColor(Color(red: 26/255, green: 26/255, blue: 26/255))
                RoundedRectangle(cornerRadius: 4.0)
                    .frame(/*maxWidth: self.width),*/ maxHeight: self.height)
                    .foregroundColor(self.color)
                
                Text(letter)
                    .font(.system(size: self.fontSize))
                    .foregroundColor(self.fontColor)
            }
        }
        //.overlay(RoundedRectangle(cornerRadius: 4.0)
                    //.stroke(lineWidth: 1.0))
            //.shadow(color: Color.black.opacity(0.25), radius: 2, y: 1.0)
    }
}
 */

struct Key: View {
    enum KeyType {
        case letter, spacebar, returnKey, globe,
            numSwitcher, symbolSwitcher, shiftKey, backspace
    }
    //let action: () -> ()
    var letter: String
    var fontSize: CGFloat
    var fontColor: Color
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    init(letter: String, fontSize: CGFloat = 22, fontColor: Color = Color.white, color: Color = Color(red: 1, green: 1, blue: 1, opacity: 0.3), width: CGFloat? = .infinity, height: CGFloat = 42){
        self.letter = letter
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.color = color
        self.width = width ?? .infinity
        self.height = height
    }
    
    var body: some View {
        Button(action: {
            print("\(self.letter) was pressed!")
        }) {
            ZStack{
                /*RoundedRectangle(cornerRadius: 4.0)
                    .frame(maxWidth: self.width, maxHeight: self.height + 1)
                    .offset(y: 1.0)
                    .foregroundColor(Color.clear)//(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.4))*/
                RoundedRectangle(cornerRadius: 4.0)
                    .frame(maxWidth: self.width, maxHeight: self.height)
                    .foregroundColor(self.color)
                    //.shadow(color: Color(red: 26/255, green: 26/255, blue: 26/255), radius: 0, y: 1)
                    
                
                
                Text(letter)
                    .font(.system(size: self.fontSize))
                    .foregroundColor(self.fontColor)
            }
        }
        //.overlay(RoundedRectangle(cornerRadius: 4.0)
                    //.stroke(lineWidth: 1.0))
            //.shadow(color: Color.black.opacity(0.25), radius: 2, y: 1.0)
    }
}


struct KeyRow: View{
    let row: [String]
    var keyWidth: CGFloat
    var keyHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 6.0) {
            ForEach(self.row, id: \.self) { letter in
                Key(letter: letter, width: self.keyWidth, height: self.keyHeight)
            }
        }.frame(maxWidth: .infinity)
    }
    
    
}

struct KeyboardKeyButton: View {
    let data: [String: [String]] = [
        "FirstRow": ["Q","W","E","R","T","Y","U","I","O","P"],
        "SecondRow": ["A","S","D","F","G","H","J","K","L"],
        "ThirdRow": ["Z","X","C","V","B","N","M",]]
    
    var height: CGFloat
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack(spacing: 0.0){//(spacing: 12.0){
                    KeyRow(row: self.data["FirstRow"]!,
                           keyWidth: self.widthFromGeometryWidth(geometry.size.width),
                           keyHeight: self.heightFromGeometryHeight(geometry.size.height))
                    Spacer()
                    KeyRow(row: self.data["SecondRow"]!,
                           keyWidth: self.widthFromGeometryWidth(geometry.size.width),
                           keyHeight: self.heightFromGeometryHeight(geometry.size.height))
                    Spacer()
                    HStack {
                        Key(letter: "⇧", color: Color(red:255/255, green:255/255, blue:255/255, opacity: 0.8),
                            width: self.heightFromGeometryHeight(geometry.size.height),
                            height: self.heightFromGeometryHeight(geometry.size.height))
                        
                        Spacer()
                        KeyRow(row: self.data["ThirdRow"]!,
                               keyWidth: self.widthFromGeometryWidth(geometry.size.width),
                                keyHeight: self.heightFromGeometryHeight(geometry.size.height))
                        Spacer()
                        Key(letter: "⌫", color: Color(white: 180/255, opacity: 0.195),
                            width: self.heightFromGeometryHeight(geometry.size.height),
                            height: self.heightFromGeometryHeight(geometry.size.height))

                       
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 6.0) {
                        Key(letter: "123", fontSize: 18, color: Color(white: 180/255, opacity: 0.195), width: geometry.size.width * 0.25)
                        Key(letter: "space", fontSize: 16)
                        
                        Key(letter: "return", fontSize: 18, color:Color(white: 180/255, opacity: 0.195), width: geometry.size.width * 0.25)
                    }.frame(maxWidth: .infinity)
                    //.padding(5.0)
                }.padding(.top, 8.0)
                    .padding(.horizontal, 3.0)
                    .padding(.bottom, 3.0)
                    .background(Color.clear)//Color(.white).opacity(0.0001))//Color(red: 43/255, green: 43/255, blue: 43/255))
            }
        }.frame(maxHeight: self.height)
    }
    
    
    func widthFromGeometryWidth(_ geometryWidth: CGFloat) -> CGFloat{
        return ceil(geometryWidth/10) - 6.0
    }
    func heightFromGeometryHeight(_ geometryHeight: CGFloat) -> CGFloat{
        return ceil(geometryHeight/4.0) - 12.0
    }
}

/*
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}*/

#if DEBUG
struct KeyboardKeyButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0.0) {
            Spacer()
            HStack(alignment: .bottom) {
                VStack {
                    KeyboardKeyButton(height: 215)
                }//.background(Color.black)
            }.frame(maxHeight: 215)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 76)
                .foregroundColor(Color.red)
        }.background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
            .environment(\.colorScheme, .dark)
        
    }
}
#endif
