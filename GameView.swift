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
    let hitboxHeight = 150
    let hitboxWitdth = 150
    
    let area1 = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    let area2 = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 100))
    let area3 = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 100))
    let area4 = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 100))
    
    
//    area1.addChild(spriteArea1)
    var timeLeft: TimeInterval = 10
    var timeLabel = SKLabelNode(text: "Time: 10")
    let meterHeight: CGFloat = 200 // height of the meter
    var meterBar: SKShapeNode? // the meter bar itself
   
    var background = SKSpriteNode(imageNamed: "mapa.vazio")

    //let resources: [SKSpriteNode] = [resource1, resource2,resource3,resource4]
    
    var selectedNode: SKNode?
    var originalPosition: CGPoint?
    
    lazy var resource1: SKSpriteNode = {
       let node = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
       node.name = "resource.red"
       node.position = CGPoint(x: 60, y: 100)
       return node
    }()
    lazy var resource2: SKSpriteNode = {
       let node = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
       node.name = "resource.green"
       node.position = CGPoint(x: 80, y: 100)
       return node
    }()
    lazy var resource3: SKSpriteNode = {
       let node = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
       node.name = "resource.blue"
       node.position = CGPoint(x: 100, y: 100)
       return node
    }()
    lazy var resource4: SKSpriteNode = {
       let node = SKSpriteNode(color: .yellow, size: CGSize(width: 50, height: 50))
       node.name = "resource.yellow"
       node.position = CGPoint(x: 120, y: 100)
       return node
    }()
    
    override func didMove(to view: SKView) {
        let spriteArea2 = SKSpriteNode(imageNamed: "Platform")
        spriteArea2.size.height = 180
        spriteArea2.size.width = 180
        spriteArea2.zPosition = 3
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
                addChild(background)
        background.size = self.size
        // Position the areas
        area1.position = CGPoint(x: 215, y: 425)
        area1.name = "blue"
        
        area2.position = CGPoint(x: 371, y: 540)
        area2.name = "red"

        area2.addChild(spriteArea2)
        area3.position = CGPoint(x: 540, y: 401)
        area3.name = "green"
        area4.position = CGPoint(x: 827, y: 122)
        area4.name = "yellow"
        
        // Add the areas to the scene
        addChild(area1)
        addChild(area2)
        addChild(area3)
        addChild(area4)
        
        addChild(resource1)
        

        
        // create the meter bar as a red rectangle
        let meterRect = CGRect(x: view.frame.width - 30, y: view.frame.height - meterHeight - 20, width: 20, height: meterHeight)
        meterBar = SKShapeNode(rect: meterRect, cornerRadius: 5)
        meterBar?.fillColor = SKColor.red
        meterBar?.position = CGPoint(x: view.frame.width - 30, y: view.frame.height/2 - 70)
        addChild(meterBar!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
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
        let pulseAction = SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.3)//,
            //SKAction.scale(to: 1.0, duration: 0.3)
        ])
        if selectedNode.contains(area1.position){
            area1.run(pulseAction)
        } else{
            area1.removeAllActions()
            area1.run(SKAction.scale(to: 1.0, duration: 0.10))

        }
        if selectedNode.contains(area2.position){
            area2.run(pulseAction)
        } else {
            area2.removeAllActions()
            area2.run(SKAction.scale(to: 1.0, duration: 0.10))

        }
        if selectedNode.contains(area3.position){
            area3.run(pulseAction)
        } else {
            area3.removeAllActions()
            area3.run(SKAction.scale(to: 1.0, duration: 0.10))

        }
        if selectedNode.contains(area4.position){
            area4.run(pulseAction)
        } else {
            area4.removeAllActions()
            area4.run(SKAction.scale(to: 1.0, duration: 0.10))

        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedNode = selectedNode else { return }
        print("let go")
        
        area1.removeAllActions()
        area2.removeAllActions()
        area3.removeAllActions()
        area4.removeAllActions()
        if let originalPosition = originalPosition {
            if selectedNode.contains(area1.position) {
                print("at blue")
                if (selectedNode.name == "resource.blue"){
                    print("Blue on Blue")
                    timeLeft += timeAdded
                    //resource 3 = blue

                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area2.position){
                if (selectedNode.name == "resource.red"){
                    print("Red on Red")
                    timeLeft += timeAdded
                    //resource1 = red

                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area3.position){
                print("at green")
                if selectedNode.name == "resource.green" {
                    print("Green on Green")
                    timeLeft += timeAdded

                    
                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area4.position) {
                print("at yellow")
                if selectedNode.name == "resource.yellow" {
                    print("Yelow on yellow")
                    timeLeft += timeAdded
          
                    
                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
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
    func dropResource(_ node: SKNode) -> SKSpriteNode{
        var index = 0
        var resources: [SKSpriteNode] = [resource1,resource2,resource3,resource4]
        for resource in resources {
            if resource.name == node.name{
               
                resources.remove(at: index)
                break
            }
            index = index + 1
        }
        let node = resources.randomElement()?.copy()  as! SKSpriteNode
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        return node

    }
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
