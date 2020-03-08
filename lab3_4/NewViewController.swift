//
//  NewViewController.swift
//  lab3_4
//
//  Created by Шынгыс on 3/8/20.
//  Copyright © 2020 Шынгыс. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    
    
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var x: UITextField!
    @IBOutlet weak var y: UITextField!
    
    
    @IBOutlet var buttons: [UIButton]!
   
    
   
    var color: UIColor?
    var coordinates: UIView?


    
    @IBAction func colorPicked(_ sender: UIButton) {
        buttons.forEach {(button) in
               if button == sender {
                   button.isSelected = true
               } else {
                   button.isSelected = false
               }
           }
           
               guard let color_figure = sender.backgroundColor else {return}
               color = color_figure
    }
    
    
       

    var add_coordinates: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let delete = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deleteFunc))
        let add = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(save))
        
        guard let coordinates =  coordinates else {
             navigationItem.rightBarButtonItems = [ add]
            return
        }
        navigationItem.rightBarButtonItems = [delete, add]
        
        self.width.text = coordinates.frame.width.description
        self.height.text = coordinates.frame.height.description
        self.x.text = coordinates.frame.origin.x.description
        self.y.text = coordinates.frame.origin.y.description
        
        buttons.forEach {(button) in
            if button.backgroundColor == coordinates.backgroundColor {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
    }
    @objc func save() {
        
        guard let width = width.text, let height = height.text, let x = x.text, let y = y.text, let color = color else {
            let alert = UIAlertController(title: "", message: "Miss data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let width_new = Double(width), let heightNew = Double(height), let xNew = Double(x), let yNew = Double(y) else {
            return
        }
        
        guard let coordinates = coordinates else {
            add_coordinates?(width_new, heightNew, xNew, yNew, color)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        coordinates.backgroundColor = color
        coordinates.frame = CGRect(x: CGFloat(xNew), y: CGFloat(yNew), width: CGFloat(width_new), height: CGFloat(heightNew))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteFunc() {
        guard let coordinates = coordinates else {return}
        coordinates.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
}
