//
//  TableView.swift
//  fullAppBookmarkUIKit
//
//  Created by Тулеби Берик on 07.05.2023.
//

import UIKit

class TableView: UIViewController{
    
    var bookmarks: [Bookmark] = []
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        return tableView
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
        self.title = "List"
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        [tableView, addButton].forEach{ self.view.addSubview($0)}
        
        addButton.anchor(left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 16, paddingBottom: 50, paddingRight: 16, height: 58)
        addButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        tableView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor,bottom: addButton.topAnchor, right: self.view.rightAnchor)
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: "BookmarkCell")
        
        if let bookmarkData = UserDefaults.standard.array(forKey: "Bookmarks") as? [[String: Any]] {
               bookmarks = bookmarkData.compactMap { bookmarkDict in
                   guard let title = bookmarkDict["title"] as? String,
                         let link = bookmarkDict["link"] as? String else {
                       return nil
                   }
                   return Bookmark(title: title, link: link)
               }
           }
        
    }
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    @objc func showAlert(forIndex index: Int = -1) {
        let alertController = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Bookmark title"
            if index >= 0 && index < self.bookmarks.count {
                textField.text = self.bookmarks[index].title
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Bookmark link"
            if index >= 0 && index < self.bookmarks.count {
                textField.text = self.bookmarks[index].link
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField1 = alertController.textFields?.first,
                  let textField2 = alertController.textFields?.last,
                  let newTitle = textField1.text,
                  let newLink = textField2.text else {
                return
            }
            
            if index >= 0 && index < self?.bookmarks.count ?? 0 {
                // Update existing bookmark
                self?.bookmarks[index].title = newTitle
                self?.bookmarks[index].link = newLink
            } else {
                // Create a new bookmark
                if !newTitle.isEmpty && !newLink.isEmpty{
                    let bookmark = Bookmark(title: newTitle, link: newLink)
                    self?.bookmarks.append(bookmark)
                    //userDefaults.set(bookmark, forKey: "myKey")
                }
            }
            self?.saveBookmarksToUserDefaults()
            self?.tableView.reloadData()
        }
        
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
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

extension TableView: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as! BookmarkCell
        let bookmark = bookmarks[indexPath.row]
        cell.bookmarkImageView.image = UIImage(named: "link")
        cell.titleLabel.text = bookmark.title
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = bookmarks[indexPath.row]
        if let url = URL(string: bookmark.link) {
            UIApplication.shared.open(url)
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){_, indexPath in
            self.bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let changeAction = UITableViewRowAction(style: .normal, title: "Change") { (_, indexPath) in
            self.showAlert(forIndex: indexPath.row)
            }
        changeAction.backgroundColor = .systemBlue
        return[deleteAction, changeAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

