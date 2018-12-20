//
//  MapViewController.swift
//  WeCodeJumpstart
//
//  Created by Jereme Claussen on 1/4/19.
//  Copyright © 2019 WeCode. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {

    // MARK: Properties

    @IBOutlet var mapView: MKMapView!
    fileprivate let locationManager = CLLocationManager()
    fileprivate let searchTableStoryboardID = "MapLocationSearchTable"
    fileprivate var resultSearchController: UISearchController?
    fileprivate var selectedPin: MKPlacemark?

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLocationManager()
        configureSearchController()
        configureSearchBar()
    }

    // MARK: Private - Configuration

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func configureSearchController() {
        guard
            let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: searchTableStoryboardID) as? MapLocationSearchTableViewController
        else {
            log.error("Unable to locate view controller for '\(searchTableStoryboardID)'")
            return
        }

        locationSearchTable.mapView = mapView
        locationSearchTable.delegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true

        definesPresentationContext = true
    }

    private func configureSearchBar() {
        guard let resultSearchController = resultSearchController else {
            log.error("No resultSearchController instance found!")
            return
        }

        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController.searchBar
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.error("location manager failed with error: \(error)")
    }
}

// MARK: - MapLocationSearchTableViewControllerDelegate

extension MapViewController: MapLocationSearchTableViewControllerDelegate {
    func dropPinAndZoomInOn(_ placemark: MKPlacemark) {
        guard let mapView = mapView else {
            log.error("mapView unexpectedly nil")
            return
        }

        selectedPin = placemark

        mapView.removeAnnotations(mapView.annotations)

        let annontation = MKPointAnnotation()

        annontation.coordinate = placemark.coordinate
        annontation.title = placemark.name

        if
            let subThoroughfare = placemark.subThoroughfare,
            let thoroughfare = placemark.thoroughfare,
            let locality = placemark.locality,
            let administrativeArea = placemark.administrativeArea
        {
            annontation.subtitle = subThoroughfare + " " + thoroughfare + ", " + locality + " " + administrativeArea
        }

        mapView.addAnnotation(annontation)

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)

        mapView.setRegion(region, animated: true)
    }
}
