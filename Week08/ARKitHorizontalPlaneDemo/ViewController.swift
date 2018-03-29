//
//  ViewController.swift
//  ARKitHorizontalPlaneDemo
//
//  Created by Jayven Nhan on 11/14/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

// Models
let ModelAssets: [String] = [
    "AJIdleFixed.dae",
    "ClaireIdleFixed.dae",
    "TYHappyFixed.dae",
    //"GrannyBellyDancingFixed.dae",
    "VegasHipHopFixed.dae",
    "KayaIdleFixed.dae",
    "BossExcitedFixed.dae"
]

var assetIdx = 0
let maxAssetIdx = 5

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var isTitle = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGestureToSceneView()
        
        // Uncomment to configure lighting
        // configureLighting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        
        sceneView.delegate = self
        
        // This is for debugging
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addItemToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Safely unwrap the anchor argument as an ARPlaneAnchor to make sure that we have information about a detected real world flat surface at hand
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a SCNPlane to visualize the ARPlaneAnchor
        // An ARPlaneAnchor extent is the estimated size of the detected plane in the world
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // Give the plane a transparent light blue colour
        plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue
        
        // initialize a SCNNode with the SCNPlane geometry
        let planeNode = SCNNode(geometry: plane)
        
        // Set the planeNode's position with the value of planeAnchor's center x,y and z position
        // Rotate the planeNode's x euler angle by 90 degrees in the counter-clockwise direction, else the planeNode will sit up perpendicular to the table.
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // Add the planeNode as the child node onto the newly added SceneKit node
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Safely unwrap the anchor argument as ARPlaneAnchor, the node's first child node and the planeNode's geometry as SCNPlane.
        guard let planeAnchor = anchor as? ARPlaneAnchor,
        let planeNode = node.childNodes.first,
        let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // Update the plane's width and height using planeAnchor extent's x and z properties
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // Update the planeNode's position to the planeAnchor's center x, y, and z coordinates
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        
    }
    
    @objc func addItemToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
//        guard let shipScene = SCNScene(named: "snwmnnn.scn"),
//        let shipNode = shipScene.rootNode.childNode(withName: "Sphere", recursively: false)
//            else { return }
//
//        shipNode.position = SCNVector3(x,y,z)
//        shipNode.scale = SCNVector3(0.02, 0.02, 0.02)
//        sceneView.scene.rootNode.addChildNode(shipNode)
        
        //let scene = SCNScene()

        //sceneView.scene = scene

        
        //let idleScene = SCNScene(named: "AJIdleFixed.dae")!
        let idleScene = SCNScene(named: ModelAssets[assetIdx])!

        let node = SCNNode()

        for child in idleScene.rootNode.childNodes {
            node.addChildNode(child)
        }

        node.position = SCNVector3(x,y,z)
        node.scale = SCNVector3(0.0005, 0.0005, 0.0005)

        sceneView.scene.rootNode.addChildNode(node)
        
        if(assetIdx<maxAssetIdx) {
            assetIdx = assetIdx + 1
        } else {
            assetIdx = 0
        }
    }
    
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
    }
}
