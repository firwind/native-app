//
//  AddTaskViewController.swift
//  Compare-Swift
//
//  Created by X-Liang on 2017/7/11.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class ItemData:NSObject, NSCoding {
    var image: UIImage?
    var title: String!
    var detail: String?
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.image = aDecoder.decodeObject(forKey: "Image") as? UIImage
        self.title = aDecoder.decodeObject(forKey: "Title") as? String ?? ""
        self.detail = aDecoder.decodeObject(forKey: "Detail") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.image, forKey: "Image")
        aCoder.encode(self.title, forKey: "Title")
        aCoder.encode(self.detail, forKey: "Detail")
    }
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var tableview: UITableView!
    var selectedImage: UIImage?
    
    var data = [ItemData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addTask(_ sender: Any) {
        let itemData = ItemData(title: titleTextField.text ?? "")
        itemData.image = selectedImage
        itemData.detail = detailTextView.text
        data.insert(itemData, at: 0)
        tableview.reloadData()
    }
}

extension AddTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
//            currentImageView.image = pickedImage
            selectedImage = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.data = data[indexPath.row]
        return cell
    }
}
