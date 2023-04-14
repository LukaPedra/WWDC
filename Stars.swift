import SwiftUI
import SpriteKit

extension AnyTransition{
    static var moveAndFade: AnyTransition{
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct Stars: View{
    @State private var animationAmount: Double = 0.0
    @State var StartPressed: Bool = false
    @State var GameStarted: Bool = false
    var gameScene: SKScene {
        let scene = GameScene($StartPressed)
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scene
    }
    var body: some View {
        ZStack{
            if (GameStarted == false){
                SpriteView(scene: gameScene)
                if (StartPressed == true){
                    withAnimation {
                        Color.black
                            .animation(.easeIn)
                    }
                    
                    MonitorView(GameStarted: $GameStarted)
                    //TypeWriterView(finalText: "ausyaiuyyiaskulgfluashdulaldiualuisyduaildylIUYDLUSAydlDUYLDSusyiu")
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            AstronautView()
                            //.padding(.trailing,220)
                                .frame(width: 400,height: 400)
                            
                        }
                        
                    }
                    
                    
                }
            }
            else {
                GameView()
                    .onAppear{
                        StartPressed = false
                    }
            }
        }
        
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        //.forceor
    }
}
