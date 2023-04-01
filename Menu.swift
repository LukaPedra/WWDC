//
//  File.swift
//  WWDC
//
//  Created by Lucca Rocha on 01/04/23.
//

import SpriteKit
import SwiftUI
import Foundation


class GameScene: SKScene{
    let earth = SKSpriteNode(imageNamed: "Earth")
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "StarField") {
            particles.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
            particles.zPosition = -1
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
        earth.name = "earth"
        earth.position.x = UIScreen.main.bounds.width/2
        earth.position.y = UIScreen.main.bounds.height/2
        earth.zPosition = 0
        earth.size.height = 200
        earth.size.width = 200

        
        addChild(earth)
    }
    
    
    
}

struct Stars: View{
    var gameScene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scene
    }
    
    var body: some View {
        ZStack{
            SpriteView(scene: gameScene)
        }.ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}
