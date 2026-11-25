//
//  StudyMapView.swift
//  Study Spot
//
//  Created by apple on 16/11/2026.
//



import SwiftUI
import MapKit
import CoreLocation

// Unit 5.1: coordinates of the two places
extension CLLocationCoordinate2D {
    static let quietCafe = CLLocationCoordinate2D(latitude: 25.1972, longitude: 55.2744)
    static let campusLibrary = CLLocationCoordinate2D(latitude: 25.1985, longitude: 55.2774)
}

// Screen 8: Map
// spotName = "" shows both places, otherwise the map zooms to that spot
struct StudyMapView: View {
    @ObservedObject var locationManager = LocationManager()

    var spotName: String = ""

    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapStyleName = "Standard"
    let styleNames = ["Standard", "Hybrid"]

    // Unit 1.4: if / else to choose the map style
    private var currentStyle: MapStyle {
        if mapStyleName == "Standard" {
            return .standard
        } else {
            return .hybrid
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Picker("Map Style", selection: $mapStyleName) {
                ForEach(styleNames, id: \.self) { style in
                    Text(style)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)

            Map(position: $cameraPosition) {
                Marker("Quiet Cafe", systemImage: "cup.and.saucer.fill", coordinate: .quietCafe)
                    .tint(.red)
                Marker("Campus Library", systemImage: "building.columns.fill", coordinate: .campusLibrary)
                    .tint(.red)
            }
            .mapStyle(currentStyle)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapPitchToggle()
            }
        }
        .navigationTitle("Map")
        .onAppear {
            locationManager.requestPermission()
            showSpot()
        }
    }

    // Move the camera to the chosen spot
    func showSpot() {
        if spotName == "Quiet Cafe" {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: .quietCafe,
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                )
            )
        } else if spotName == "Campus Library" {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: .campusLibrary,
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                )
            )
        } else {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: .quietCafe,
                    span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
                )
            )
        }
    }
}

// ---------------------------------------------------------
// Unit 5.1: asks the user for location permission
// ---------------------------------------------------------
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Location permission: not determined.")
        case .restricted, .denied:
            print("Location permission: denied/restricted.")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location permission: granted.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }
}
