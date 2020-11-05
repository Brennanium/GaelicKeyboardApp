//
//  SwiftUITesting.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 3/30/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import SwiftUI

struct TestKeyView: View {
    var scaled: Bool = false
    //@Binding var highlighted: Int?
    //var i: Int
    var key: KeyData
    //@Binding var locationX: CGFloat

    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                //.frame(width: 100, height: 100)
                .foregroundColor(scaled ? Color.red : Color.gray)
                .cornerRadius(15.0)
                //.scaleEffect(scaled ? 1.5 : 1)

            VStack {
                Text("\(key.character)")
                    .frame(width: 80)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    
            }.padding([.top, .leading], 10)
        }.zIndex(scaled ? 2 : 1)
    }
}


struct DragAccrossKeyboardTestingView: View {
    @EnvironmentObject var data: TestKeyData

    @GestureState private var location: CGPoint = .zero
    //@State var locationX: CGFloat = 0.0
    @State private var highlighted: Int? = nil
    @State private var text: String = ""
    @State private var textBox: String = ""
    //@State private var geometryRect: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
    

    private var Content: some View {
        VStack {
            HStack {
                ForEach(0..<3) { i in
                    ZStack {
                        TestKeyView(scaled: self.highlighted == i, key: self.data.testKeyList[i])
                            //.background(self.rectReader(index: i))
                        GeometryReader { (geometry) -> AnyView in
                            if geometry.frame(in: .global).contains(self.location) {
                                DispatchQueue.main.async {
                                    self.highlighted = i
                                    self.text = self.data.testKeyList[i].character
                                }
                            }
                            return AnyView(Rectangle().fill(Color.clear))
                        }
                    }.frame(width: 100, height: 100)
                }
            }.zIndex((0..<3).contains(self.highlighted ?? -1) ? 2 : 1)
            

            HStack {
                ForEach(3..<6) { i in
                    ZStack {
                        TestKeyView(scaled: self.highlighted == i, key: self.data.testKeyList[i])
                            //.background(self.rectReader(index: i))
                        GeometryReader { (geometry) -> AnyView in
                            if geometry.frame(in: .global).contains(self.location) {
                                DispatchQueue.main.async {
                                    self.highlighted = i
                                    self.text = self.data.testKeyList[i].character
                                }
                            }
                            return AnyView(Rectangle().fill(Color.clear))
                        }
                    }.frame(width: 100, height: 100)
                }
            }
            .zIndex((3..<6).contains(self.highlighted ?? -1) ? 2 : 1)
        }
    }
    
    /*
    func rectReader(index: Int) -> some View {
        return GeometryReader { (geometry) -> AnyView in
            if geometry.frame(in: .global).contains(self.location) {
                DispatchQueue.main.async {
                    self.highlighted = index
                }
            }
            
            //testing
            self.geometryRect = geometry.frame(in: .global)
            self.index = index
            self.data.count += 1
            
            return AnyView(Rectangle().fill(Color.clear))
        }
    }*/

    var body: some View {
        VStack {
            VStack {
                Text("character: \(textBox)")
            }.padding(10)
                .foregroundColor(Color.blue)
                .background(Color.black)
                .frame(width: 350)
 
            Content
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($location) { (value, state, transaction) in
                    //self.locationX = value.location.x
                    state = value.location
                }.onEnded {_ in
                    self.textBox = self.text
                    self.highlighted = nil
                })
        }
    }
}

struct SwiftUITesting_Previews: PreviewProvider {
    static var previews: some View {
        DragAccrossKeyboardTestingView().environmentObject(TestKeyData())
    }
}

class TestKeyData: ObservableObject{
    @Published var count: Int = 0
    
    @Published var testKeyList: [KeyData] =
    [KeyData(character: "q", type: .letter),
     KeyData(character: "w", type: .letter),
     KeyData(character: "e", type: .letter),
     KeyData(character: "r", type: .letter),
     KeyData(character: "t", type: .letter),
     KeyData(character: "y", type: .letter),
     KeyData(character: "u", type: .letter),
     KeyData(character: "0", type: .letter)]
}
