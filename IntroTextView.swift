//
//  IntroTextView.swift
//  WWDC
//
//  Created by Lucca Rocha on 13/04/23.
//

import SwiftUI

struct IntroTextView: View {
    @Binding var GameStarted: Bool
    var TextArray: [String] = ["Ah o planeta bla bla bla","é usa vez de bla bla bla ","vamos lá!"]
    @State var index: Int = 0
    var body: some View {
        ZStack {
            Text(TextArray[index])
                .foregroundColor(.white)
                .font(.largeTitle)
                .frame(width: UIScreen.main.bounds.width * 0.8)
                
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background{
            //por algum motivo precisa disso sla pq
            Color.white.opacity(0.0001)
        }
        .onTapGesture {
            if (index < (TextArray.count) - 1){
                print(index)
                index += 1
            }
            else{
                GameStarted.toggle()
            }
            
        }
    }
}

//struct IntroTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroTextView()
//    }
//}
