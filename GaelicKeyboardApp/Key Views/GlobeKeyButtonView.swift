//
//  GlobeKey.swift
//  GaelicKeyboardApp
//
//  Created by Brennanium on 4/3/20.
//  Copyright © 2020 Brennanium. All rights reserved.
//

import UIKit
import SwiftUI


struct GlobeKeyButtonView: View {
    @EnvironmentObject var environment: KeyboardStore
    
    var body: some View {
        GlobeKeyButton()
            .clipShape(RoundedRectangle(cornerRadius: 4))//.frame(maxWidth: 50, maxHeight: 65)
            .frame(maxWidth: environment.sizes.standardKeySize.height, maxHeight: environment.sizes.standardKeySize.height)
    }
    
}

struct GlobeKeyButton: UIViewRepresentable {
    //init(number: Binding<Int>) {
        //self.binding = number
    //}
    @EnvironmentObject var environment: KeyboardStore
    
    func makeUIView(context: Context) -> UIButton {
        
        let customButton = UIButton(type: .custom)
        customButton.tintColor = UIColor.label
        customButton.adjustsImageWhenHighlighted = false
        customButton.setBackgroundColor(UIColor(white: 180/255, alpha: 0.195), forState: .normal)
        customButton.setBackgroundColor(UIColor(white: 1, alpha: 0.3), forState: .highlighted)
        
        customButton.layer.cornerRadius = 4
        customButton.imageView?.layer.cornerRadius = 4
        customButton.clipsToBounds = false
        
        
        
        
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        customButton.setImage(UIImage(systemName: "globe", withConfiguration: config), for: .normal)
        
        customButton.addTarget(self, action: #selector(environment.keyboardView.handleInputModeList(from:with:)), for: .allEvents)
        return customButton
    }

    func updateUIView(_ view: UIButton, context: Context) {
        /*
        //shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0.25
        view.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: view.bounds.height + 1), cornerRadius: view.layer.cornerRadius).cgPath */
        //view.currentPreferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .bold)
    }
}

struct GlobeKey_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GlobeKeyButtonView()
        }.frame(width: 100, height: 70)
            .background(Color.black)
            .environment(\.colorScheme, .dark)
    }
}



extension UIButton {
    /*
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(white: 1, alpha: 0.3) : UIColor(white: 180/255, alpha: 0.195)
        }
    }*/
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
          color.setFill()
          UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
    }
}
