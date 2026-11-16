//
//  StudyMapView.swift
//  Study Spot
//
//  Created by apple on 16/11/2026.
//

import SwiftUI
import MapKit

struct StudyMapView: View {
    @Environment(\.dismiss) private var dismiss

    let spotName: String?
    let showBack: Bool

    private let cafe = CLLocationCoordinate2D(
        latitude: 25.1972, longitude: 55.2744
    )
    private let library = CLLocationCoordinate2D(
        latitude: 25.1985, longitude: 55.2774
    )

    var body: some View {
        VStack(spacing: 12) {
            if showBack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
            }

            Text("Map")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Demo locations")
                .font(.subheadline)
                .foregroundColor(.gray)

            Map(initialPosition: .region(region)) {
                Marker("Quiet Cafe", coordinate: cafe)
                Marker("Campus Library", coordinate: library)
            }
        }
        .padding(.top, 16)
        .navigationBarHidden(true)
    }

    private var region: MKCoordinateRegion {
        let center = spotName == "Campus Library" ? library : cafe
        let zoom = spotName == nil ? 0.025 : 0.008

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(
                latitudeDelta: zoom,
                longitudeDelta: zoom
            )
        )
    }
}
