//
//  Artwork.swift
//  HonoluluArt
//
//  Created by KPUGAME on 4/23/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation
import MapKit

import Contacts

class MaskStore: NSObject,MKAnnotation{
    let title: String?
    let name: String
    let type: String
    let coordinate: CLLocationCoordinate2D
    
    var markerTintColor: UIColor{
        switch type {
        case "01":
            return .red
        case "02":
            return .cyan
        case "03":
            return .blue
        default:
            return .green
        }
    }
 
    init(addr: String, name: String, type: String,
         coordinate: CLLocationCoordinate2D){
        self.title = addr
        self.name = name
        self.type = type
        self.coordinate = coordinate
        
        super.init()
    }
    init?(json: Dictionary<String,Any>){
        self.title = json["addr"] as? String ?? "NO Title"
        self.name = json["name"] as! String
        self.type = json["type"] as! String
        
        if let latitude = (json["lat"] as? NSNumber),
            let longitude = (json["lng"] as? NSNumber){
            self.coordinate = CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
        }else{
            self.coordinate = CLLocationCoordinate2D()
        }
        
        if self.title!.hasPrefix("부산광역시 금정구"){
            var t = 3  //부산광역시 금정구를 포함하고 있는지 확인
        }
    }
    var subtitle: String?{
        return name
    }
    func mapItem()-> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}
