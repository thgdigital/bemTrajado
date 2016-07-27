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
        addSubview(enderecolabel)
        addSubview(whatslabel)
        addSubview(descricaoCartaolabel)
        addSubview(descricaoEntregalabel)
        mapkit.delegate = self
        
        addConstraintsWithFormat("H:|[v0]|", views: mapkit)
        addConstraintsWithFormat("H:|-10-[v0]|", views: enderecolabel)
        addConstraintsWithFormat("H:|-10-[v0]|", views: whatslabel)
        addConstraintsWithFormat("H:|-10-[v0]|", views: descricaoCartaolabel)
        addConstraintsWithFormat("H:|-10-[v0]|", views: descricaoEntregalabel)
        addConstraintsWithFormat("V:|[v0(400)]-40-[v1]-10-[v2]-10-[v3]-10-[v4]", views: mapkit, enderecolabel, whatslabel, descricaoCartaolabel, descricaoEntregalabel)
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: -22.933078, longitude: -43.257244)
        centerMapOnLocation(initialLocation)
        
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapkit.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation();
        point.coordinate = CLLocationCoordinate2DMake(-22.933078, -43.257244)
        point.title = "Bem Trajados Multimarcas"
        point.subtitle = "RUA ANDARAÍ , 314/ANDARAÍ"
        
        mapkit.addAnnotation(point)
        mapkit.showAnnotations([point], animated: false)
    }
    
    let mapkit: MKMapView = {
        let map = MKMapView()
        return map
    }()
    let enderecolabel:UILabel = {
        let label = UILabel()
        label.text = "ENDEREÇO: RUA ANDARAÍ , 314/ANDARAÍ"
        label.font = UIFont.systemFontOfSize(14, weight: 200)
        return label
    }()
    
    let whatslabel:UILabel = {
        let label = UILabel()
        label.text = "WHATSS : 976593368"
        label.font = UIFont.systemFontOfSize(14, weight: 200)
        return label
    }()
    
    let descricaoCartaolabel:UILabel = {
        let label = UILabel()
        label.text = "ACEITAMOS TODOS CARTÕES"
        label.font = UIFont.systemFontOfSize(14, weight: 200)
        return label
    }()
    let descricaoEntregalabel:UILabel = {
        let label = UILabel()
        label.text = "FAZEMOS ENTREGAS"
        label.font = UIFont.systemFontOfSize(14, weight: 200)
        return label
    }()
    
}
extension LocalizacaoCell: MKMapViewDelegate{
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
}
