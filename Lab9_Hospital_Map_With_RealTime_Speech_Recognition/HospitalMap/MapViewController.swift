import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let regionRadius : CLLocationDistance = 5000
    var hospitals : [Hospital] = []
    @IBOutlet weak var mapView: MKMapView!
    var posts = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.5384514, longitude: 127.0709764)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(hospitals)
    }
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData(){
        for post in posts{
            let yadmNm = (post as AnyObject).value(forKey: "yadmNm") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "addr") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "XPos") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "YPos") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let hospital = Hospital(title: yadmNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            hospitals.append(hospital)
        }
    }
    
    func mapView(_ mapView : MKMapView, annotationView view : MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Hospital
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView : MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? Hospital else {return nil}
        
        let identifier = "marker"
        var view : MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x : -5, y : 5)
            view.rightCalloutAccessoryView = UIButton(type : .detailDisclosure)
        }
        return view
    }
    
}
