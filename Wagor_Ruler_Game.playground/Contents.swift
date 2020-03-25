import UIKit
import Foundation
import UIKit
import PlaygroundSupport
import SpriteKit

class GameScene:SKScene{
    var node:SKSpriteNode!
    var ground:SKSpriteNode!
    var ruler:SKSpriteNode!
    var time:TimeInterval!
    let successcolor = UIColor.green
    let failcolor = UIColor.red
    var flag = 0
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .white
        physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        ruler = SKSpriteNode(color: .blue, size: .init(width: 50, height: 2))
        ruler.position = .init(x: self.frame.midX, y: 330)
        
        node = SKSpriteNode(color: .black, size: .init(width: 20, height: 300))
        node.inputView?.layer.cornerRadius = 10
        node.position = .init(x: self.frame.midX, y: 500)
        node.physicsBody = SKPhysicsBody.init(rectangleOf: .init(width: 20, height: 300))
        node.physicsBody?.affectedByGravity = false
        
        ground = SKSpriteNode(color: .black, size: .init(width: 500, height: 5))
        ground.position = .init(x: self.frame.midX, y: 5)
        ground.physicsBody = SKPhysicsBody.init(rectangleOf: .init(width: 500, height: 5))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
        self.addChild(node)
        self.addChild(ruler)
    }
    
    func gameSet(delaytime:Double){
        self.time = delaytime
    }
    
    
    override func sceneDidLoad() {
//=======================我是分隔線==========================
                
        gameSet(delaytime: 2.0)
                
                
//=========================================================
        
        let timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false, block: {(timer) in
            self.node.physicsBody?.affectedByGravity = true
            timer.invalidate()
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newpos = node.position
        node.position = newpos
        node.physicsBody?.isDynamic = false
        if flag == 1{
            return
        }
//=======================我又是分隔線==========================
        if ruler.position.y < node.position.y+150 && ruler.position.y > node.position.y-150{
            flag = 1
            backgroundColor = successcolor
        }else{
            backgroundColor = failcolor
            flag = 1
        }
//==========================================================
    }
    
}

let gameView = SKView(frame: .init(x: 0, y: 0, width: 500, height: 500))
let scene = GameScene(size: gameView.frame.size)
gameView.presentScene(scene)

PlaygroundPage.current.liveView = gameView
