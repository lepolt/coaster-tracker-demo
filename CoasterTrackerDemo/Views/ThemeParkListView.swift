//
//  ThemeParkListView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/20/22.
//

import SwiftUI

struct ThemeParkListView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .forward)])
    private var themeParks: FetchedResults<ThemePark>

    @State private var isAdding = false
    @State private var name = ""

    var body: some View {
        VStack {
            Button {
                isAdding.toggle()
            } label: {
                Text("Add Theme Park")
            }
            .buttonStyle(.bordered)

            List {
                ForEach(themeParks) { park in
                    Text(park.name!)
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            HStack {
                TextField("Add new theme park", text: $name)
                    .textFieldStyle(.roundedBorder)

                Button {
                    addNew(name: name)
                    isAdding = false
                    name = ""
                } label: {
                    Text("Save")
                }

            }
            .padding()
        }
    }

    func addNew(name: String) {
        let themePark = ThemePark(context: context)
        themePark.name = name
        themePark.id = UUID()

        do {
            try context.save()
        } catch let error as NSError {
            assertionFailure("Error saving new ThemePark: \(error), \(error.userInfo)")
        }
    }
}

struct ThemeParkListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeParkListView()
    }
}
