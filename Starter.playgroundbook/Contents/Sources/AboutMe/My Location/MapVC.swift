//
//  MapVC.swift
//  AboutMe-3
//
//  Created by Hao Dong on 23/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
import MapKit
//import CoreTelephony

class MapVC: UIViewController {
    
    var mapView: MKMapView!
    let location = CLLocationCoordinate2D(latitude: 23.163971, longitude: 113.361418)
    //116.446899,39.831049
    let beijing = CLLocationCoordinate2D(latitude: 39.831049, longitude: 116.446899)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMapView()
        //134.218688,31.687308
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.687308, longitude: 135.074162), span: MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0))
        //let reg = MKCoordinateRegionMakeWithDistance(location, 500 * 1000, 500 * 1000)
        mapView.region = region
        mapView.delegate = self
        
        
        
        let ann = MKPointAnnotation()
        ann.coordinate = location
        ann.title = "Guangzhou"
        ann.subtitle = "Yep, I live here."
        mapView.addAnnotation(ann)
        let beijingAnn = MKPointAnnotation()
        beijingAnn.coordinate = beijing
        beijingAnn.title = "Beijing"
        beijingAnn.subtitle = "I attended iDev there."
        mapView.addAnnotation(beijingAnn)
        //delay(delay: 5.0, closure: {
        //    self.mapView.setRegion(reg, animated: true)
        //})
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = self.navigationController {
            print("nav")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionDismiss(_:)))
            //nav.setToolbarItems([UINavigationItem(title: "Back")], animated: true)
        }
    }
    func actionDismiss(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpMapView() {
        mapView = MKMapView()
        mapView.frame = view.frame
        view.addSubview(mapView)
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var v : MKAnnotationView! = nil
        let ident = "Photo"
        
        v = mapView.dequeueReusableAnnotationView(withIdentifier: ident)
        if v == nil {
            v = MKPinAnnotationView(annotation: annotation, reuseIdentifier: ident)
        }
        (v as! MKPinAnnotationView).pinTintColor = MKPinAnnotationView.purplePinColor()
        (v as! MKPinAnnotationView).animatesDrop = true
        v.canShowCallout = true
        
        let disclosureButton = UIButton(type: .detailDisclosure)
        v.rightCalloutAccessoryView = disclosureButton
        
        return v
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //print("tap view")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("tap")
        let vc = MyLocationVC()
        if (view.annotation?.title)! == "Beijing" {
            vc.location = .Beijing
        } else {
            vc.location = .Guangzhou
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



