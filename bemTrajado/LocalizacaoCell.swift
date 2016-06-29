//
//  LocalizacaoCell.swift
//  bemTrajado
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit
import MapKit

class LocalizacaoCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        addSubview(mapkit)
        
        addConstraintsWithFormat("H:|[v0]|", views: mapkit)
        addConstraintsWithFormat("V:|[v0(400)]", views: mapkit)
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: -22.933078, longitude: -43.257244)
        centerMapOnLocation(initialLocation)
        
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapkit.setRegion(coordinateRegion, animated: true)
    }
    
    let mapkit: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
}
