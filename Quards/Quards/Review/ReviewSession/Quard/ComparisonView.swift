//
//  ComparisonView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

struct ComparisonView: View {
	var attempt: UIImage
	var answer: UIImage
	
	@State private var currentOffset: CGFloat = UIScreen.main.bounds.width - 30
	@State private var newOffset: CGFloat = UIScreen.main.bounds.width - 30
	
	@State var draggingLeft = true
			
	var body: some View {
		let dragGesture = DragGesture()
			.onChanged { value in
				let temp = self.currentOffset
				self.currentOffset = value.translation.width + self.newOffset
				self.draggingLeft = temp > self.currentOffset
			}
			.onEnded { value in
				if draggingLeft {
					withAnimation {
						self.currentOffset = 0
					}
				} else {
					withAnimation {
						self.currentOffset = UIScreen.main.bounds.width - 30
					}
				}
				self.newOffset = self.currentOffset
			}
		
		ZStack {
			ScrollView {
				Image(uiImage: attempt)
					.padding(.top, 30)
			}
			
			ScrollView {
				Image(uiImage: answer)
			}
			.background(Color.white)
			.overlay(RoundedRectangle(cornerRadius: 15).stroke())
			.offset(x: self.currentOffset)
			.gesture(dragGesture)
			.highPriorityGesture(TapGesture()
														.onEnded { _ in
															withAnimation {
																self.currentOffset = self.currentOffset == 0 ? UIScreen.main.bounds.width - 30 : 0
															}
														})
		}
	}
}
