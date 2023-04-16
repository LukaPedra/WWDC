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
    let timeAdded: Double = 1.5
    let area1 = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    let area2 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
    let area3 = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 100))
    let area4 = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 100))
    
    var timeLeft: TimeInterval = 10
    var timeLabel = SKLabelNode(text: "Time: 10")
    let meterHeight: CGFloat = 200 // height of the meter
    var meterBar: SKShapeNode? // the meter bar itself
    
    // Declare the resources
    let resource1 = SKSpriteNode(color: .cyan, size: CGSize(width: 50, height: 50))
    let resource2 = SKSpriteNode(color: .magenta, size: CGSize(width: 50, height: 50))
    let resource3 = SKSpriteNode(color: .orange, size: CGSize(width: 50, height: 50))
    let resource4 = SKSpriteNode(color: .purple, size: CGSize(width: 50, height: 50))
    
    var background = SKSpriteNode(imageNamed: "mapa.vazio")

    //let resources: [SKSpriteNode] = [resource1, resource2,resource3,resource4]
    
    var selectedNode: SKNode?
    var originalPosition: CGPoint?
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
                addChild(background)
        background.size = self.size
        // Position the areas
        area1.position = CGPoint(x: 215, y: 425)
        area1.name = "blue"
        area2.position = CGPoint(x: 371, y: 540)
        area2.name = "red"
        area3.position = CGPoint(x: 540, y: 401)
        area3.name = "green"
        area4.position = CGPoint(x: 827, y: 122)
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
        resource1.position = CGPoint(x: 60, y: 100)
        resource1.name = "resource.red"
        addChild(resource1)
        
        resource2.position = CGPoint(x: 80, y: 100)
        resource2.name = "resource.green"

        addChild(resource2)
        
        resource3.position = CGPoint(x: 100, y: 100)
        resource3.name = "resource.blue"
        addChild(resource3)
        
        resource4.position = CGPoint(x: 120, y: 100)
        resource4.name = "resource.yellow"

        addChild(resource4)
        
        // create the meter bar as a red rectangle
        let meterRect = CGRect(x: view.frame.width - 30, y: view.frame.height - meterHeight - 20, width: 20, height: meterHeight)
        meterBar = SKShapeNode(rect: meterRect, cornerRadius: 5)
        meterBar?.fillColor = SKColor.red
        meterBar?.position = CGPoint(x: view.frame.width - 30, y: view.frame.height/2 - 70)
        addChild(meterBar!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        print(touch.location(in: self))
        let location = touch.location(in: self)
        let touchedNode = nodes(at: location).first
        
        if touchedNode?.name?.prefix(8) == "resource" {
            selectedNode = touchedNode
            originalPosition = touchedNode?.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let selectedNode = selectedNode else { return }
        
        let location = touch.location(in: self)
        selectedNode.position = location
//        if selectedNode.contains(area1.position){
//            area1.scale(to: CGSize)
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedNode = selectedNode else { return }
        print("let go")
        
        if let originalPosition = originalPosition {
            if selectedNode.contains(area1.position) {
                print("at blue")
                if (selectedNode.name == "resource.blue"){
                    print("Blue on Blue")
                    timeLeft += timeAdded
                    //resource 3 = blue
                    let randomResource = [resource1,resource2,resource4].randomElement()!
                    randomResource.position = originalPosition
                    addChild(randomResource)
                    
                    selectedNode.removeFromParent()
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area2.position){
                if (selectedNode.name == "resource.red"){
                    print("Red on Red")
                    timeLeft += timeAdded
                    //resource1 = red
                    let randomResource = [resource2,resource3,resource4].randomElement()!
                    randomResource.position = originalPosition
                    addChild(randomResource)
                    
                    selectedNode.removeFromParent()
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area3.position){
                print("at green")
                if selectedNode.name == "resource.green" {
                    print("Green on Green")
                    timeLeft += timeAdded
                    //resource2 = green
                    let randomResource = [resource1,resource3,resource4].randomElement()!
                    randomResource.position = originalPosition
                    addChild(randomResource)
                    
                    selectedNode.removeFromParent()
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area4.position) {
                print("at yellow")
                if selectedNode.name == "resource.yellow" {
                    print("Yelow on yellow")
                    timeLeft += timeAdded
                    //resource4 = yellow
                    let randomResource = [resource2,resource3,resource1].randomElement()!
                    randomResource.position = originalPosition
                    addChild(randomResource)
                    
                    selectedNode.removeFromParent()
                } else {
                    timeLeft -= timeAdded
                }
            }
            
            // If the resource was not dropped on a correct area, return it to its original position
            selectedNode.run(SKAction.move(to: originalPosition, duration: 0.2))
        }
        
        self.selectedNode = nil
        self.originalPosition = nil
    }
    override func update(_ currentTime: TimeInterval) {
        if timeLeft > 0 {
            timeLeft -= 0.005
        }
        timeLabel.text =  "Time: \(Int(timeLeft))"
        
        let meterHeightLeft = max(0, CGFloat(timeLeft) / 10.0 * meterHeight)
        meterBar?.path = CGPath(rect: CGRect(x: 0, y: 0, width: 20, height: meterHeightLeft), transform: nil)
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
