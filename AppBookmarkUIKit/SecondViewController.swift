//
//  SecondViewController .swift
//  fullAppBookmarkUIKit
//
//  Created by Тулеби Берик on 07.05.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    var bookmarks: [Bookmark] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bookmark App"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    private let centeredLabel: UILabel = {
        let label = UILabel()
        label.text = "Save your first\nbookmark"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .bold)
        
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.black
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 16
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        [titleLabel, addButton, centeredLabel].forEach{ self.view.addSubview($0)}
        
        titleLabel.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 70, paddingLeft: 130, paddingRight: 130)
        
        addButton.anchor(left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 16, paddingBottom: 50, paddingRight: 16, height: 58)
        addButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        centeredLabel.centerInView(in: self.view)
        
    }
    @objc func showAlert() {

        let alertController = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)

        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Bookmark title"
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Bookmark link"
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                })
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            if let textField1 = alertController.textFields?.first,
                let textField2 = alertController.textFields?.last {
                let title = textField1.text ?? ""
                let link = textField2.text ?? ""
                if !title.isEmpty && !link.isEmpty{
                    let bookmark = Bookmark(title: title, link: link)
                    self.bookmarks.append(bookmark)
                    self.navigateToBookmarksView()
                    UserDefaults.standard.set(true, forKey: "FirstBookmark")
                }
            }
        }
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func navigateToBookmarksView() {
        let bookmarksViewController = TableView()
        bookmarksViewController.bookmarks = self.bookmarks
        navigationController?.pushViewController(bookmarksViewController, animated: true)
    }
    func saveBookmarksToUserDefaults() {
        let bookmarkData = bookmarks.map { bookmark in
            return [
                "title": bookmark.title,
                "link": bookmark.link
            ]
        }
        UserDefaults.standard.set(bookmarkData, forKey: "Bookmarks")
    }
}


