//
//  ViewController.swift
//  WillDidSetTest
//
//  Created by Noah Park on 2022/09/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var willSetCountLabel: UILabel!
    @IBOutlet weak var didSetCountLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var substractButton: UIButton!
    
    private var willSetCount = 0 {
        willSet {
            willSetCountLabel.text = "willSetCount = \(willSetCount)"
        }
        
//        willSet(newVal) {
//            willSetCountLabel.text = "willSetCount = \(newVal)"
//        }
    }
    
    private var didSetCount = 0 {
        didSet {
            didSetCountLabel.text = "didSetCount = \(didSetCount)"
        }
        
//        didSet(oldVal) {
//            didSetCountLabel.text = "didSetCount = \(oldVal)"
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        willSetCountLabel.text = "willSetCount = \(willSetCount)"
        didSetCountLabel.text = "didSetCount = \(didSetCount)"
        
        addButton.addTarget(self, action: #selector(addCount), for: .touchUpInside)
        substractButton.addTarget(self, action: #selector(substractCount), for: .touchUpInside)
        
    }
    
    @objc func addCount(_ sender: UIButton) {
        willSetCount += 1
        didSetCount += 1
    }
    
    @objc func substractCount(_ sender: UIButton) {
        willSetCount -= 1
        didSetCount -= 1
    }


}

