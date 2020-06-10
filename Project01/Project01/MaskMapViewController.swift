//
//  MaskMapViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/13/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit
import MapKit

class MaskMapViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var maskMapView: MKMapView!
    var posts =  NSMutableArray()
    var name : String = ""
    var storeName : String = ""
    var MaskStores : [MaskStore] = []
       
       //전송받은 posts 배열에서 정보를 얻어서 Hospital 객체를 생성하고 배열에 추가 생성
    func loadInitialData(addr: String)->CLLocation{
          // guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            //   else{return}
           
           for i in 1...5{
           var fileN = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page="
               fileN = fileN + String(i) + "&perPage=5000"
           guard let url = URL(string: fileN) else {return CLLocation(latitude: 35.6791963, longitude: 128.2422529)}
           
           
           let optionalData = try? Data(contentsOf: url)
          
           guard
               let data = optionalData,
               let json = try? JSONSerialization.jsonObject(with: data),
               let dictionary = json as? [String: Any],
               let works = dictionary["storeInfos"] as? [Dictionary<String,Any>]
               //let dic2 =   dic as? [[Any]],
               //let works = dictionary["storeInfos"] as? [[Any]]
               else{
                return CLLocation(latitude: 35.6791963, longitude: 128.2422529)
                
            }
           //let t = works[0]
          // let t = works.compactMap{$0 as? [String : Any] }
           let validWorks = works.flatMap{ MaskStore(json: $0) }
           MaskStores.append(contentsOf: validWorks)
           }
        for store in MaskStores {
            if (store.name == self.storeName)
            {
                return CLLocation(latitude: store.coordinate.latitude, longitude: store.coordinate.longitude)
            }
        }
        return CLLocation(latitude: 35.6791963, longitude: 128.2422529)
       }
       let regionRadius : CLLocationDistance = 5000
       
       func centerMapOnLocation(location: CLLocation)
       {
           let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
           maskMapView.setRegion(coordinateRegion, animated: true)
       }
       

       override func viewDidLoad() {
           super.viewDidLoad()
                  let initialLocation = CLLocation(latitude: 35.6791963, longitude: 128.2422529)
                  // Do any additional setup after loading the view.
                  //centerMapOnLocation(location: initialLocation)
                 
                  maskMapView.delegate = self
                    
                  maskMapView.register(MaskStoreMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                  centerMapOnLocation(location: loadInitialData(addr: name))
                  maskMapView.addAnnotations(MaskStores)
       }
       

       /*
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
       {
           guard let annotation = annotation as? MaskStore else{ return nil }
           let identifier = "marker"
           var view: MKMarkerAnnotationView
           
           if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
               as? MKMarkerAnnotationView{
               dequeuedView.annotation = annotation
               view = dequeuedView
           } else {
               view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               view.canShowCallout = true
               view.calloutOffset = CGPoint(x: -5, y: -5)
               view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
           }
           return view
       }
       
       func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                      calloutAccessoryControlTapped control: UIControl){
             let location = view.annotation as! MaskStore
             let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
             location.mapItem().openInMaps(launchOptions: launchOptions)
         }
 
}
