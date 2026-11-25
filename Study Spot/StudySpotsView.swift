//
//  StudySpotsView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//


import SwiftUI
import SwiftData

// Screen 5: Study Spots (list from SwiftData, search, swipe to delete)
struct StudySpotsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var spots: [StudySpot]

    @State private var searchText = ""

    // Only the spots that match the search text (loops + Strings lesson)
    private var filteredSpots: [StudySpot] {
        var result: [StudySpot] = []
        for spot in spots {
            if searchText.isEmpty || spot.name.lowercased().contains(searchText.lowercased()) {
                result.append(spot)
            }
        }
        return result
    }

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Discover great places to study\non campus.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(studyGreen)

                    TextField("Search spots...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)

                    // "+" opens the Add Spot screen (screen 7)
                    NavigationLink(destination: AddSpotView()) {
                        Image(systemName: "plus")
                            .padding()
                            .background(studyGreen)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)

                List {
                    ForEach(filteredSpots) { spot in
                        NavigationLink(destination: SpotDetailsView(spot: spot)) {
                            HStack(spacing: 14) {
                                Image(systemName: spot.icon)
                                    .font(.system(size: 30))
                                    .foregroundColor(studyGreen)

                                VStack(alignment: .leading, spacing: 6) {
                                    Text(spot.name)
                                        .font(.headline)
                                    Text(spot.notes)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteSpots)
                }
            }
        }
        .navigationTitle("Study Spots")
    }

    // Unit 4.5: delete from the database
    private func deleteSpots(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredSpots[$0] }.forEach(modelContext.delete)
        }
    }
}
