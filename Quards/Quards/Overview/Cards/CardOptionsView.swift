//
//  CardOptionsView.swift
//  Quards
//
//  Created by Max Fest on 20.08.20.
//

import SwiftUI

struct CardOptionsView: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@StateObject var card: Card
	@Binding var showPopover: Bool
	
	var body: some View {
		VStack {
			Button(action: {
				self.showPopover = false
				self.quardsModel.deleteCard(card: card)
			}) {
				Label("Delete", systemImage: "trash")
					.padding()
			}
		}
	}
}

