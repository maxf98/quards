//
//  QuardsApp.swift
//  Quards
//
//  Created by Max Fest on 02.08.20.
//

import SwiftUI

@main
struct QuardsApp: App {
	
	var quardsModel = QuardsModel()
	var tabController = TabBarController()
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, quardsModel.coreDataStack.managedContext)
				.environmentObject(quardsModel)
				.environmentObject(tabController)
		}
	}
}
