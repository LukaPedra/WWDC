//
//  TypewriterView.swift
//  WWDC
//
//  Created by Lucca Rocha on 10/04/23.
//

import SwiftUI

struct TypeWriterView: View {
    @State private var text: String = ""
    @State var aa: Int = 0
    var finalText: String = "Hello, World!"
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text(text)
                .foregroundColor(.white)
                .font(.largeTitle)
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .onAppear{
                    typeWriter()
                }
        }
    }
    
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                text.append(finalText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}


struct TypeWriterView_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterView()
    }
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
