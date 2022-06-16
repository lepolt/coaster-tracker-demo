//
//  RollerCoasterListView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import SwiftUI

struct RollerCoasterListView: View {
    @StateObject private var viewModel = RollerCoasterListViewModel()
    @State private var isAdding = false
    @State private var name = ""

    var body: some View {
        NavigationView {
            VStack {
                Button {
                    isAdding.toggle()
                } label: {
                    Text("Add new roller coaster")
                }
                .buttonStyle(.bordered)

                List {
                    ForEach(viewModel.list) { rollerCoaster in
                        Text(rollerCoaster.name!)
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $isAdding) {
                HStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)

                    Button {
                        viewModel.addNewRollerCoaster(name: name)
                        isAdding = false
                        name = ""
                    } label: {
                        Text("Save")
                    }
                }
                .padding()
            }
        }
    }
}

struct RollerCoasterListView_Previews: PreviewProvider {
    static var previews: some View {
        RollerCoasterListView()
    }
}
