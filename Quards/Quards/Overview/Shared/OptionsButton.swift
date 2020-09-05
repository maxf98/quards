//
//  SwiftUIView.swift
//  Quards
//
//  Created by Max Fest on 20.08.20.
//

import SwiftUI

struct OptionsButton: View {
	@Binding var showingOptions: Bool
	
	var body: some View {
		GeometryReader { geometry in
			Button(action: {
				self.showingOptions.toggle()
			}) {
				ZStack {
					Rectangle()
						.opacity(0)
						.frame(width: geometry.size.width, height: geometry.size.height)
					HStack(spacing: 3) {
						ForEach(1..<4){ _ in
							Circle().frame(width: geometry.size.width / 3.5)
						}
					}
				}
			}
		}
	}
}

