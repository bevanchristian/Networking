//
//  DogApi.swift
//  DogApiUdacity
//
//  Created by bevan christian on 14/05/21.
//

import Foundation
import UIKit
class DogApi:Decodable{
    enum EndPoint {
        case random
        case byBreed(String)
        case list
        var url : URL{
            return URL(string: self.valueString)!
        }

        var valueString:String{
            switch self {
            case .random:
                return "https://dog.ceo/api/breeds/image/random"
            case .byBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .list:
                return "https://dog.ceo/api/breeds/list/all"
            default:
                return "0"
            }
        }
    }
    // jadi pastikan semua endpoint itu dibelakang
   //manggilnya tinggal  print(DogApi.EndPoint.random.url)
    
    static func getJson<T:Decodable>(url:URL,completion: @escaping (T)->Void){
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else{
            return
        }
        let decode = JSONDecoder()
            do{
                let parseData = try! decode.decode(T.self, from: data)
                completion(parseData)
            }catch{
                return
            }
        }.resume()
    }
    

    
    
    static func foto(url:String,completion: @escaping (UIImage)->Void){
        var imagedata:UIImage!
        let task2 = URLSession.shared.dataTask(with: URL(string:url)!) { (data, response, error) in
            guard let data = data else{
                print("eerror")
                return
            }
            print("masuk2\(data)")
            imagedata = UIImage(data: data)
            completion(imagedata)
           
            
        
        }.resume()
       
    }
 
    
}
