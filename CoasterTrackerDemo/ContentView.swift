//
//  ContentView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            TabView {
                RollerCoasterListView()
                    .tabItem {
                        Label {
                            Text("Roller Coasters")
                        } icon: {
                            Image(systemName: "1.square.fill")
                        }
                    }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
