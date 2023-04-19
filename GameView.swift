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
    let hitboxHeight = 200
    let hitboxWitdth = 150
    
    let clouds = SKEmitterNode(fileNamed: "CloudsMap")!
    
	let astronaut = SKSpriteNode(imageNamed: "astronaut")
	
	let UI = SKSpriteNode(imageNamed: "UI")
	
	let resourceInventory = SKSpriteNode(imageNamed: "Resource inventory")
	
    let area1 = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 100))
    let WindTurbine = SKSpriteNode(imageNamed: "Wind Turbine")
    
    let area2 = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 100))
    let OilPlatform = SKSpriteNode(imageNamed: "Platform")

    let area3 = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 100))
    let SolarPanel = SKSpriteNode(imageNamed: "Solar")
    
    let area4 = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 100))
    let Factory = SKSpriteNode(imageNamed: "Factory")
    
    
//    area1.addChild(spriteArea1)
	var timer: TimeInterval = 25
    var timeLeft: TimeInterval = 10
	var timeLabel: SKLabelNode!
    let meterHeight: CGFloat = 280 // height of the meter
    var meterBar: SKShapeNode? // the meter bar itself
   
    var background = SKSpriteNode(imageNamed: "mapa.vazio")

    //let resources: [SKSpriteNode] = [resource1, resource2,resource3,resource4]
    
    var selectedNode: SKNode?
    var originalPosition: CGPoint?
    
    lazy var resourceCo2: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Co2")
        node.size = CGSize(width: 50, height: 50)
        node.name = "resource.co2"
        node.position = CGPoint(x: 100, y: 100)
        return node
    }()
    lazy var resourceSun: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Sun")
        node.size = CGSize(width: 50, height: 50)
        node.name = "resource.sun"
		node.position = CGPoint(x: 100, y: 100)
        return node
    }()
    lazy var resourceWind: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Wind")
        node.size = CGSize(width: 50, height: 50)
        node.name = "resource.wind"
		node.position = CGPoint(x: 100, y: 100)
        return node
    }()
    lazy var resourceWater: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Water")
        node.size = CGSize(width: 50, height: 50)
        node.name = "resource.water"
		node.position = CGPoint(x: 100, y: 100)
        return node
    }()
    
    override func didMove(to view: SKView) {
		astronaut.position = CGPoint(x: frame.maxX - 80, y: frame.minY + 210)
		astronaut.size = CGSize(width: 180, height: 200)
		astronaut.zPosition = 11
		addChild(astronaut)
		
		UI.size = self.size
		UI.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
		UI.zPosition = 10
		addChild(UI)
		
		timeLabel = SKLabelNode(fontNamed: "Helvetica")
		timeLabel.fontSize = 20
		timeLabel.fontColor = .black
		timeLabel.horizontalAlignmentMode = .right
		timeLabel.text = "Time: \(Int(timeLeft))"
		timeLabel.position = CGPoint(x: size.width - 30, y: size.height - 65)
		timeLabel.zPosition = 11
		addChild(timeLabel)
		
        clouds.zPosition = 9
        clouds.position = CGPoint(x: frame.maxX, y: frame.minY)
        clouds.zRotation = CGFloat.pi * 5 / 6
        clouds.advanceSimulationTime(120)
        clouds.xScale = -1.0
        addChild(clouds)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        background.size = self.size
        
		resourceInventory.position = CGPoint(x: 60, y: 100)
		resourceInventory.size = CGSize(width: 150, height: 60)
		addChild(resourceInventory)
		
        
        //Wind turbine
        area1.position = CGPoint(x: 195, y: 455)
        area1.name = "blue"
        WindTurbine.size.height = 260 / 2
        WindTurbine.size.width = 180 / 2
        WindTurbine.zPosition = 3
        area1.addChild(WindTurbine)
        
        //Oil platform
        area2.position = CGPoint(x: 371, y: 540)
        area2.name = "red"
        OilPlatform.size.height = 180
        OilPlatform.size.width = 180
        OilPlatform.zPosition = 3
        area2.addChild(OilPlatform)
        
        //Solar
        area3.position = CGPoint(x: 540, y: 401)
        area3.name = "green"
        SolarPanel.size.height = 100
        SolarPanel.size.width = 100
        SolarPanel.zPosition = 3
        area3.addChild(SolarPanel)
        
        area4.position = CGPoint(x: 827, y: 122)
        area4.name = "yellow"
        Factory.size.height = 80
        Factory.size.width = 80
        area4.addChild(Factory)

        
        
        // Add the areas to the scene
        addChild(area1)
        addChild(area2)
        addChild(area3)
        addChild(area4)
        resourceCo2.zPosition = 10
        addChild(resourceCo2)
        

        
        // create the meter bar as a red rectangle
        let meterRect = CGRect(x: view.frame.width - 30, y: view.frame.height - meterHeight - 20, width: 20, height: meterHeight)
        meterBar = SKShapeNode(rect: meterRect, cornerRadius: meterHeight/2)
        meterBar?.fillColor = SKColor.red
        meterBar?.position = CGPoint(x: view.frame.width - 35, y: view.frame.height/2 - 40)
		meterBar?.zPosition = 11
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
                if (selectedNode.name == "resource.wind"){
                    print("Blue on Blue")
					timerAdd()
                    //resource 3 = blue

                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area2.position){
                if (selectedNode.name == "resource.co2"){
                    print("Red on Red")
					timerAdd()
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
                if selectedNode.name == "resource.sun" {
                    print("Green on Green")
					timerAdd()

                    
                    let drop = dropResource(selectedNode)
                    selectedNode.removeFromParent()
                    addChild(drop)
                } else {
                    timeLeft -= timeAdded

                }
            }
            else if selectedNode.contains(area4.position) {
                print("at yellow")
                if selectedNode.name == "resource.water" {
                    print("Yelow on yellow")
					timerAdd()
                    
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
		timeLeft -= 0.01
		timer -= 0.01
        if timeLeft <= 0 {
            print("aaa")
            let nextScene = GameOverScene(size: size)
			view?.presentScene(nextScene, transition: .doorsCloseVertical(withDuration: 0.5))
        }
		if timer <= 0 {
			let nextScene = VictoryScene(size: size)
			view?.presentScene(nextScene,transition: .crossFade(withDuration: 0.4))
		}
        timeLabel.text =  "Time left: \(Int(timer))"
        
        let meterHeightLeft = max(0, CGFloat(timeLeft) / 10.0 * meterHeight)
        meterBar?.path = CGPath(rect: CGRect(x: 0, y: 0, width: 20, height: meterHeightLeft), transform: nil)
    }
    // Rest of your scene code goes here...
    func dropResource(_ node: SKNode) -> SKSpriteNode{
        var index = 0
        var resources: [SKSpriteNode] = [resourceCo2,resourceSun,resourceWind,resourceWater]
        for resource in resources {
            if resource.name == node.name{
               
                resources.remove(at: index)
                break
            }
            index = index + 1
        }
        let node = resources.randomElement()?.copy()  as! SKSpriteNode
		node.position = CGPoint(x: 0, y: 100)
        node.zPosition = 10
		node.run(SKAction.move(to: CGPoint(x: 100, y: 100), duration: 0.5))
		
        return node

    }
	func timerAdd(){
		if (timeLeft + timeAdded) > 10 {
			timeLeft = 10
		} else {
			timeLeft += timeAdded
		}
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
