//
//  CoastersByThemeParkView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/20/22.
//

import SwiftUI

struct CoastersByThemeParkView: View {
    @StateObject var viewModel = CoastersByThemeParkViewModel()

    var body: some View {
        List {
            ForEach(Array(viewModel.data.keys), id: \.self) { park in
                Section(header: Text(park)) {
                    ForEach(viewModel.data[park]!) { coaster in
                        Text(coaster.name!)
                    }
                }
            }
        }
    }
}

struct CoastersByThemeParkView_Previews: PreviewProvider {
    static var previews: some View {
        CoastersByThemeParkView()
    }
}
