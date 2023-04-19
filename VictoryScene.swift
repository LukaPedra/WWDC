//
//  VictoryScene.swift
//  Resource Rush
//
//  Created by Lucca Rocha on 19/04/23.
//
//
import Foundation
import SpriteKit

class VictoryScene: SKScene {
	override func didMove(to view: SKView) {
		// Create the "You lose..." label
		let label = "Congratulations! You have successfully saved Earth's resources for the time being. \nThanks to your efforts, we can ensure a brighter future for our planet. Keep up the \ngood work! I hope I can count on you in a future mission..."
		let lines = label.components(separatedBy: "\n")
		let startX = frame.midX
		let startY = frame.midY + 100
		for (index, line) in lines.enumerated() {
			let node = SKLabelNode(text: line)
			node.fontSize = 30
			node.fontName = "Helvetica"
			node.fontColor = .white
			node.zPosition = 1
			node.position = CGPoint(x: startX, y: startY - CGFloat(index * 60))
			addChild(node)
		}
		let astronaut = SKSpriteNode(imageNamed: "astronaut")
		astronaut.size = CGSize(width: 300, height: 350)
		astronaut.position = CGPoint(x: frame.maxX - 100, y: frame.minY + 150)
		addChild(astronaut)
		
		let stars = SKEmitterNode(fileNamed: "StarField")!
		stars.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
		stars.zPosition = -1
		stars.advanceSimulationTime(60)
		stars.zPosition = 0
		addChild(stars)
		
		let button = SKSpriteNode(imageNamed: "Button")
		button.position = CGPoint(x: frame.midX, y: frame.midY - 200)
		button.name = "Button"
		button.size = CGSize(width: 150, height: 80)
		button.zPosition = 1
		let text = SKLabelNode(text: "Play Again?")
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

