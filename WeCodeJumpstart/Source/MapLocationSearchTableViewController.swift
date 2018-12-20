//
//  MapLocationSearchTableViewController.swift
//  WeCodeJumpstart
//
//  Created by Jereme Claussen on 1/4/19.
//  Copyright © 2019 WeCode. All rights reserved.
//

import MapKit
import UIKit

protocol MapLocationSearchTableViewControllerDelegate: class {
    func dropPinAndZoomInOn(_ placemark: MKPlacemark)
}

// MARK: -

class MapLocationSearchTableViewController: UITableViewController {

    // MARK: Properties

    weak var delegate: MapLocationSearchTableViewControllerDelegate?
    var mapView: MKMapView? = nil
    fileprivate var matchingItems: [MKMapItem] = []

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < matchingItems.count else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: "locationResultCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "locationResultCell")
        let selectedItem = matchingItems[indexPath.row].placemark

        cell.textLabel?.text = selectedItem.name

        if
            let subThoroughfare = selectedItem.subThoroughfare,
            let thoroughfare = selectedItem.thoroughfare,
            let locality = selectedItem.locality,
            let administrativeArea = selectedItem.administrativeArea
        {
            cell.detailTextLabel?.text = subThoroughfare + " " + thoroughfare + ", " + locality + " " + administrativeArea
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < matchingItems.count else { return }

        let selectedItem = matchingItems[indexPath.row].placemark
        delegate?.dropPinAndZoomInOn(selectedItem)

        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating

extension MapLocationSearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let mapView = mapView,
            let searchBarText = searchController.searchBar.text
        else {
            return
        }

        let request = MKLocalSearch.Request()

        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region

        let search = MKLocalSearch(request: request)

        search.start { (response, error) in
            guard let response = response else {
                if let error = error {
                    log.error("Searching locations failed: response nil: \(error)")
                } else {
                    log.error("Error: Searching locations failed: response nil: unknown error")
                }

                return
            }

            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
