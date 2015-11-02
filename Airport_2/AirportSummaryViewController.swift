//
//  AirportSummaryViewController.swift
//  Airport_2
//
//  Created by Julian West on 22/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit
import MapKit

class AirportSummaryViewController: UIViewController, MKMapViewDelegate {

    //UI outlets
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAirportName: UILabel!
    @IBOutlet weak var mapDetail: MKMapView!
    
    var focusAirport: Airport!
    var compareAirport: Airport!
    var geodesic : MKGeodesicPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let focusLocation = focusAirport.location!
        let compareLocation = compareAirport.location!
        
        //Put pins
        let airportPin = MKPointAnnotation()
        airportPin.coordinate = focusAirport.location!
        airportPin.title = focusAirport.name!
        airportPin.subtitle = focusAirport.municipality!
        mapDetail.addAnnotation(airportPin)
        let comparePin = MKPointAnnotation()
        comparePin.coordinate = compareAirport.location!
        comparePin.title = compareAirport.name
        comparePin.subtitle = compareAirport.municipality!
        mapDetail.addAnnotation(comparePin)
        let annotations: [MKPointAnnotation] = [airportPin,comparePin]
        
        //Calculating distance
        let locationAsCLLocationFocus = CLLocation(latitude: focusLocation.latitude, longitude: focusLocation.longitude)
        let locationAsCLLocationCompare = CLLocation(latitude: compareLocation.latitude, longitude: compareLocation.longitude)
        let distanceAirports = locationAsCLLocationFocus.distanceFromLocation(locationAsCLLocationCompare)
        
        //Geodesic values
        var geodesicLocations: [CLLocationCoordinate2D] = [focusAirport.location!, compareAirport.location!]
        geodesic = MKGeodesicPolyline(coordinates: &geodesicLocations[0], count: 2)
        mapDetail.addOverlay(geodesic!)
        mapDetail.insertOverlay(geodesic!, aboveOverlay: mapDetail.overlays.last!)
        
        //Centering around pins
        let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var zoomRect:MKMapRect = MKMapRectNull
        
        for index in 0..<mapDetail.annotations.count {
            let annotation = annotations[index]
            let aPoint:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            let rect:MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        
        mapDetail.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)

        lblDistance.text = String(format: "%.2fkm", distanceAirports / 1000)
        
        lblAirportName.text = focusAirport.name!
        // Do any additional setup after loading the view.
    }
    
    //Geodesic line override
    func mapView (mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKGeodesicPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.greenColor()
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        return MKPolylineRenderer(overlay: overlay)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D, zoomLevel: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, zoomLevel, zoomLevel)
        mapDetail.setRegion(coordinateRegion, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}