//
//  ViewController.swift
//  DogApiUdacity
//
//  Created by bevan christian on 14/05/21.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
 
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var picker: UIPickerView!
    var breed = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        let urlList = DogApi.EndPoint.list.url
        let taskList = DogApi.getJson(url: urlList) { [self] (response:DogListModel) in
            breed = response.message.keys.map({$0})
            print(breed)
        }
        
        // jadi pastikan semua endpoint itu dibelakang
       
        
       
    }
    func getPhotoFromData(url:String){
        DogApi.foto(url: url) { [self] (image) in
            imageHandler(image2: image)
        }
    }
    
    func imageHandler(image2:UIImage){
        DispatchQueue.main.async { [self] in
            image.image = image2
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // nentuin ada berapa banyak kolom
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // jumlah baris kebawah
        return breed.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //setiap baris diisi dengan string apa
        return breed[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // yang dipencetyangmana
        let url = DogApi.EndPoint.byBreed(breed[row]).url
        print(url)
        DogApi.getJson(url: url) { [self] (response:DogModel) in
            getPhotoFromData(url: response.message)
        }
    }

}

