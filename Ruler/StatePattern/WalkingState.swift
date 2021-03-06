//
//  WalkingState.swift
//  Ruler
//
//  Created by Johannes Heinke Business on 11.09.18.
//  Copyright © 2018 Mikavaa. All rights reserved.
//

import Foundation

var globalSettingNode: World.NodeWorker! = nil
let world = World.init()
internal final class WalkingState: State {
    
    override final func initState() {
        print("WalkingState")
        _ = self.execute({ (_, _, handler) in
            handler.measuringModeSwitch.appear()
        })
    }
    
    override final func handleTouchesBegan(at point: CGPoint) {
        _ = self.execute({ (_, sceneView, handler) in
            guard let knownNode = sceneView.getNode(for: point), knownNode.name == "MeasurePoint" else {
                switch handler.measuringModeSwitch.selectedSegmentIndex {
                case 0:
                    handler.currentState = handler.measuringState
                case 1:
                    handler.currentState = handler.measuringState2
                default:
                    print("Switch Error")
                }
                return
            }
            //: Go to SettingState
            guard let settingNodeWorker = world.getNodeWorker(for: knownNode) else {
                return
            }
            globalSettingNode = settingNodeWorker
            handler.currentState = handler.settingState
        })
    }
    
    override final func deinitState() {
        _ = self.execute({ (_, _, handler) in
            handler.measuringModeSwitch.disappear()
        })
    }
}
