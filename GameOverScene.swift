//
//  GameOverScene.swift
//  WWDC
//
//  Created by Lucca Rocha on 18/04/23.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    override func didMove(to view: SKView) {
        // Create the "You lose..." label
        let label = SKLabelNode(text: "You lose...")
        label.fontName = "Helvetica"
        label.fontSize = 40
        label.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 80)
        label.zPosition = 1
        addChild(label)
        
        let stars = SKEmitterNode(fileNamed: "StarField")!
        stars.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
        stars.zPosition = -1
        stars.advanceSimulationTime(60)
        stars.zPosition = 0
        addChild(stars)
        
        let button = SKSpriteNode(imageNamed: "Button")
        button.position = CGPoint(x: frame.midX, y: frame.midY - 70)
        button.name = "Button"
        button.size = CGSize(width: 150, height: 80)
        button.zPosition = 1
        let text = SKLabelNode(text: "Try Again?")
        text.fontColor = .white
        text.fontName = "Helvetica"
        text.fontSize = 20
        text.zPosition = 2
        button.addChild(text)
        addChild(button)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = nodes(at: location).first
        let gameScene = GameScene(size: self.size)
        if touchedNode?.name == "Button"{
            self.view?.presentScene(gameScene, transition: .fade(withDuration: 0.5))
        }
    }
}

