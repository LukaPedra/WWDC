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
        label.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        label.zPosition = 1
        addChild(label)
        
        let stars = SKEmitterNode(fileNamed: "StarField")!
        stars.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
        stars.zPosition = -1
        stars.advanceSimulationTime(60)
        stars.zPosition = 0
        addChild(stars)
        
        let button = ButtonNode(imageNamed: "Button")
        button.position = CGPoint(x: frame.midX, y: frame.minY - 100)
    }
}
class ButtonNode: SKSpriteNode {
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 0.5 // dim the button when it's touched
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 1.0 // reset the button's alpha when touch ends
        if let touch = touches.first, let parent = parent {
            let touchLocation = touch.location(in: parent)
            if contains(touchLocation) {
                // button was tapped, handle action here
                
            }
        }
    }
}
