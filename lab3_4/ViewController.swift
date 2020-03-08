//
//  ViewController.swift
//  lab3_4
//
//  Created by Шынгыс on 3/8/20.
//  Copyright © 2020 Шынгыс. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(presentCreateView))
        // Do any additional setup after loading the view.
    }
    @objc func presentCreateView() {
             
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectVC = storyboard.instantiateViewController(identifier: "someid") as NewViewController
        
            
        selectVC.add_coordinates = { width, height, x, y, color in
                   
                   let coordinates = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                   
                   let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap))
                   coordinates.addGestureRecognizer(tapGestureRecognizer)
                   
                   let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(recognizer:)))
                   coordinates.addGestureRecognizer(panGestureRecognizer)
                   
                   let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch))
                   coordinates.addGestureRecognizer(pinchGestureRecognizer)
                   
                   coordinates.backgroundColor = color
                   self.view.addSubview(coordinates)
               }
               navigationController?.pushViewController(selectVC, animated: true)
           }
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if let coordinates = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectVC = storyboard.instantiateViewController(identifier: "someid") as NewViewController
            selectVC.coordinates = coordinates
            navigationController?.pushViewController(selectVC, animated: true)
        }
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        if let coordinates = sender.view {
            if sender.state == .began || sender.state == .changed {
                coordinates.transform = (coordinates.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
    
    var baseOrigin: CGPoint!
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if let coordinates = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = coordinates.frame.origin
            case .changed:
                let d = recognizer.translation(in: coordinates)
                coordinates.frame.origin.x = baseOrigin.x + d.x
                coordinates.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
            

}


