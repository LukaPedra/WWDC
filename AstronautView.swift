//
//  AstronautView.swift
//  WWDC
//
//  Created by Lucca Rocha on 08/04/23.
//

import SwiftUI

struct AstronautView: View {
    @State var positionX = 250
    @State var Alpha = 0.0
    var body: some View {
        GeometryReader{ geometry in
            Image("astronaut")/*
                               .resizable()
                               .scaledToFit()
                               .frame(width: 400)
                               .offset(x: CGFloat(positionX))
                               .opacity(Alpha)
                               .animation(Animation.easeInOut(duration: 1))
                               .onAppear{
                               positionX -= 300
                               Alpha += 1
                               }*/
                .resizable()
                .scaledToFit()
                .opacity(Alpha)
                .offset(x: CGFloat(positionX))
                .frame(width: 400)
                .onAppear{
					withAnimation (.easeInOut(duration: 3.0)){
                        Alpha += 1
                        positionX -= 300
                    }
                }
                .offset(x: CGFloat(positionX))
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautView()
    }
}
