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
    lazy var earth: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Earth")
        node.name = "earth"
        node.position.x = UIScreen.main.bounds.width/2
        node.position.y = UIScreen.main.bounds.height/2 - 300
        node.zPosition = 0
        node.size.height = 800
        node.size.width = 800
        return node
    }()
    lazy var Atmosphere: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Atmosphere")
        node.name = "Atmosphere"
        node.position.x = UIScreen.main.bounds.width/2
        node.position.y = UIScreen.main.bounds.height/2 - 300
        node.zPosition = 0
        node.size.height = 800
        node.size.width = 800
        
        
        return node
    }()
    
    lazy var Planet: SKSpriteNode = {
        
        let node = SKSpriteNode(imageNamed: "Planet")
        print(String(parent?.name ?? "No parent"))
        node.name = "Planet"
        node.position.x = (parent?.position.x ?? 0)!
        node.position.y = (parent?.position.y ?? 0)!
        node.zPosition = 1
        node.size.height = self.frame.height
        node.size.width = self.frame.width
        return node
    }()
    
    lazy var Shadow: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Shadow")
        node.name = "Shadow"
        node.position.x = 0
        node.position.y = 0
        node.zPosition = 2
        node.size.height = self.frame.height
        node.size.width = self.frame.width
        return node
    }()
    
    //let earth = SKSpriteNode(imageNamed: "Earth")
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "StarField") {
            particles.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
            particles.zPosition = -1
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
        

        
        Atmosphere.addChild(Planet)
        addChild(Atmosphere)
        
        
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
