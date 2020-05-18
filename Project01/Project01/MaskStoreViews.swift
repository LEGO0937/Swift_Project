//
//  ArtworkViews.swift
//  HonoluluArt
//
//  Created by KPUGAME on 4/23/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import MapKit

class MaskStoreMarkerView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation? {
        willSet{
            guard let artwork = newValue as? MaskStore else{return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            markerTintColor = artwork.markerTintColor
            glyphText = String(artwork.name.first!)
        }
    }
}
