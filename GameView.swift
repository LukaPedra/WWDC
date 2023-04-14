//
//  GameView.swift
//  WWDC
//
//  Created by Lucca Rocha on 13/04/23.
//

import SwiftUI
import SpriteKit
import Foundation

class GameScene: SKScene{
    let area1 = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    let area2 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
    let area3 = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 100))
    let area4 = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 100))
    
    var resources: [SKSpriteNode] = []
    
    var meterNode = SKLabelNode(text: "Meter: 100")
    var meterValue = 100 {
        didSet {
            meterNode.text = "Meter: \(meterValue)"
        }
    }
    // Declare the resources
    let resource1 = SKSpriteNode(color: .cyan, size: CGSize(width: 50, height: 50))
    let resource2 = SKSpriteNode(color: .magenta, size: CGSize(width: 50, height: 50))
    let resource3 = SKSpriteNode(color: .orange, size: CGSize(width: 50, height: 50))
    let resource4 = SKSpriteNode(color: .purple, size: CGSize(width: 50, height: 50))
    
    var selectedNode: SKNode?
    var originalPosition: CGPoint?
    
    override func didMove(to view: SKView) {
        
        // Position the areas
        area1.position = CGPoint(x: 100, y: 100)
        area1.name = "blue"
        area2.position = CGPoint(x: 300, y: 100)
        area2.name = "red"
        area3.position = CGPoint(x: 100, y: 300)
        area3.name = "green"
        area4.position = CGPoint(x: 300, y: 300)
        area4.name = "yellow"
        
        // Add the areas to the scene
        addChild(area1)
        addChild(area2)
        addChild(area3)
        addChild(area4)
        
        // Create some resources
        let resource1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        let resource2 = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        let resource3 = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        let resource4 = SKSpriteNode(color: .yellow, size: CGSize(width: 50, height: 50))
        
        // Set up the resources
        resource1.position = CGPoint(x: frame.midX - 100, y: frame.midY)
        resource1.name = "resource"
        addChild(resource1)
        
        resource2.position = CGPoint(x: frame.midX - 50, y: frame.midY + 100)
        resource2.name = "resource"

        addChild(resource2)
        
        resource3.position = CGPoint(x: frame.midX + 50, y: frame.midY - 100)
        resource3.name = "resource"

        addChild(resource3)
        
        resource4.position = CGPoint(x: frame.midX + 100, y: frame.midY)
        resource4.name = "resource"

        addChild(resource4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let touchedNode = nodes(at: location).first
        
        if touchedNode?.name == "resource" {
            selectedNode = touchedNode
            originalPosition = touchedNode?.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let selectedNode = selectedNode else { return }
        
        let location = touch.location(in: self)
        selectedNode.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedNode = selectedNode else { return }
        
        if let originalPosition = originalPosition {
            if selectedNode.contains(area1.position) {
                // Check if the resource was dropped on the correct area
//                if selectedNode.color == area1.fillColor {
//                    // Correct match, do something...
//                }
                //if selectedNode.
            }
            
            // Repeat for area2, area3, and area4...
            
            // If the resource was not dropped on a correct area, return it to its original position
            selectedNode.run(SKAction.move(to: originalPosition, duration: 0.2))
        }
        
        self.selectedNode = nil
        self.originalPosition = nil
    }
    
    // Rest of your scene code goes here...
}

struct GameView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        // Create an SKView instance
        let skView = SKView(frame: UIScreen.main.bounds)
        
        // Present your SKScene
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        // Set the frame rate
        skView.preferredFramesPerSecond = 60
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.landscapeLeft)
            .ignoresSafeArea()
        
    }
}
