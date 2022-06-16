//
//  RollerCoasterDetailsView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import SwiftUI

struct RollerCoasterDetailsView: View {
    @StateObject private var viewModel: RollerCoasterDetailsViewModel

    init(id: UUID) {
        self._viewModel = StateObject(wrappedValue: RollerCoasterDetailsViewModel(id: id))
    }

    var body: some View {
        VStack {
            if let rollerCoaster = viewModel.rollerCoaster {
                Text(rollerCoaster.name!)

            } else {
                Text("Womp, womp.")
            }
        }
    }
}

struct RollerCoasterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RollerCoasterDetailsView(id: UUID())
    }
}
