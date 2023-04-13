//
//  MonitorView.swift
//  WWDC
//
//  Created by Lucca Rocha on 09/04/23.
//

import SwiftUI

struct MonitorView: View {
    @State var yposition = -300.0
    @State var alpha = 0.0
    @State var ShowText = false
    var body: some View {
        Image("Screen")
            .resizable()
            .scaledToFill()
            .offset(x: -22.0,y: CGFloat(yposition))
            .opacity(alpha)
            .animation(.easeIn(duration: 3), value: yposition)
            .animation(.easeIn(duration: 3), value: alpha)
            .overlay{
                if (ShowText == true){
                    IntroTextView()
        
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    // your code here
                    ShowText = true
                }
                yposition += 300
                alpha += 1
            }
    }
}

struct MonitorView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorView()
    }
}
