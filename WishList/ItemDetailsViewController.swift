//
//  ItemDetailsViewController.swift
//  WishList
//
//  Created by Pragun Sharma on 20/07/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextLabel: CustomTextField!
    @IBOutlet weak var price: CustomTextField!
    @IBOutlet weak var details: CustomTextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var thumbImage: UIImageView!

    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topitem = self.navigationController?.navigationBar.topItem {
            topitem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let store = Store(context: context)
        store.name = "BestBuy"
        let store2 = Store(context: context)
        store2.name = "Amazon"
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        let store4 = Store(context: context)
        store4.name = "Safeway"
        let store5 = Store(context: context)
        store5.name = "Tesla Dealership"
        let store6 = Store(context: context)
        store6.name = "Ikea"
        
        ad.saveContext()
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Update When Selected
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
       
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleTextLabel.text {
            item.title = title
        }
        
        if let price = price.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = details.text {
            item.details = details
        }
        
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func loadItemData() {
        if let item = itemToEdit {
            titleTextLabel.text = item.title
            price.text = String(item.price)
            details.text = item.details
            
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        pickerView.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index = index + 1
                } while (index < stores.count)
            }
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: {})
    }
    
    
    
}
