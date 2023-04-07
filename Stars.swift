import SwiftUI
import SpriteKit

struct Stars: View{
    @State var StartPressed: Bool = false
    var gameScene: SKScene {
        let scene = GameScene($StartPressed)
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scene
    }
    var body: some View {
        ZStack{
            
            SpriteView(scene: gameScene)
            if (StartPressed == true){
                Text("teste")
                    .foregroundColor(.black)
                    .font(.largeTitle)
            }
        }.ignoresSafeArea()
        .preferredColorScheme(.dark)
        //.forceor
    }
}
