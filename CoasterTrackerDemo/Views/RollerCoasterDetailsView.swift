//
//  RollerCoasterDetailsView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import SwiftUI

struct RollerCoasterDetailsView: View {
    @StateObject private var viewModel: RollerCoasterDetailsViewModel
    @State private var isAddingToPark = false

    init(id: UUID) {
        self._viewModel = StateObject(wrappedValue: RollerCoasterDetailsViewModel(id: id))
    }

    var body: some View {
        VStack {
            if let rollerCoaster = viewModel.rollerCoaster {
                Text(rollerCoaster.name!)

                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: rollerCoaster.isFavorite ? "heart.fill" : "heart")
                }

                if rollerCoaster.themePark == nil {
                    Button {
                        isAddingToPark.toggle()
                    } label: {
                        Text("Add to theme  park")
                    }

                } else {
                    Text("Park: \(rollerCoaster.themePark!.name!)")
                }


            } else {
                Text("Womp, womp.")
            }
        }
        .sheet(isPresented: $isAddingToPark) {
            List {
                ForEach(viewModel.themeParks) { park in
                    Button {
                        viewModel.addToThemePark(park)
                        isAddingToPark = false
                    } label: {
                        Text(park.name!)
                            .buttonStyle(.bordered)
                    }
                }
            }
        }

    }
}

struct RollerCoasterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RollerCoasterDetailsView(id: UUID())
    }
}
