//
//  ViewController.swift
//  fullAppBookmarkUIKit
//
//  Created by Тулеби Берик on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let bgImage: UIImageView = {
        let image = UIImage(named: "Image")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "Save all interesting\nlinks in one app"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.white
        button.setTitle("Let's start collecting", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [bgImage, bottomLabel, startButton].forEach{ self.view.addSubview($0)}
        bgImage.fillView(self.view)

        bottomLabel.anchor(left: self.view.leftAnchor, bottom: startButton.topAnchor, right: self.view.rightAnchor, paddingLeft: 16, paddingBottom: 24)
        
        startButton.anchor(left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 16, paddingBottom: 50, paddingRight: 16, height: 58)

        startButton.addTarget(self, action: #selector(goToSecondViewController), for: .touchUpInside)

        
        
    }
    
    @objc func goToSecondViewController() {
         let main = SecondViewController()
         navigationController?.pushViewController(main, animated: true)
     }
}


