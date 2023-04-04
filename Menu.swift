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
        node.position.y = UIScreen.main.bounds.height/2 //- 300
        node.zPosition = 0
        node.size.height = 300
        node.size.width = 300

        
        let planet = SKSpriteNode(imageNamed: "Planet")
      //  node.addChild(planet)
        print(String(planet.parent?.name ?? "No parent"))
        planet.name = "Planet"
        planet.position.x = 0
        planet.position.y = 0
        
        planet.size.height = node.frame.height
        planet.size.width = node.frame.width
//
        let shadow = SKSpriteNode(imageNamed: "Shadow")
        planet.addChild(shadow)
        shadow.name = "Shadow"
        shadow.position.x = 0
        shadow.position.y = 0
        shadow.zPosition = 2
        shadow.size.height = shadow.parent?.frame.height ?? 0
        shadow.size.width = shadow.parent?.frame.height ?? 0
        
        
        planet.addChild(Clouds)
        planet.zPosition = 1
//        Clouds.targetNode = planet
//        Clouds.zPosition = 1
        
        let cropNode = SKCropNode()
        
        let maskNode = SKShapeNode(circleOfRadius: planet.size.width/2.0 - 10)
        maskNode.fillColor = .white

        cropNode.maskNode = maskNode//SKSpriteNode(color: .white, size: planet.size)
        cropNode.position = CGPoint(x: 0, y: 0)
        cropNode.zPosition = 3
        cropNode.addChild(planet)

        node.addChild(cropNode)

        
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
        node.size.height = self.parent?.frame.height ?? 0
        node.size.width = self.parent?.frame.height ?? 0
        return node
    }()
    lazy var Clouds: SKEmitterNode = {/**/
        let node = SKEmitterNode(fileNamed: "Clouds")!
        let cropNode = SKCropNode()
        cropNode.setScale(0.5)
        
        
        node.name = "Clouds"
        node.position.x = 100
        node.position.y = 0
        node.zPosition = 2
        node.advanceSimulationTime(60)
        //node.setScale(0.6)
        
        cropNode.addChild(node)
        
 
        //let cropNode = SKSpriteNode(fileNamed: "enemy1")!
        cropNode.setScale(0.5)
        return node
    }()
//    lazy var Continents: SKEmitterNode = {
//        let node = SKEmitterNode(fileNamed: "Continents")
//        
//    }()
    
    //let earth = SKSpriteNode(imageNamed: "Earth")
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "StarField") {
            particles.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
            particles.zPosition = -1
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
        

        
        
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
