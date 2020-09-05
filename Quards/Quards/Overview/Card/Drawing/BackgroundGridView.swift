//
//  BackgroundGridView.swift
//  Drash
//
//  Created by Max Fest on 16.04.20.
//  Copyright © 2020 Max Fest. All rights reserved.
//

import SwiftUI

struct BackgroundGridView: View {
	
	var body: some View {
		let size = CGSize(width: 30, height: 30)
		let image = Image(uiImage: gridImage(size: size))
		
		return Rectangle()
			.fill(ImagePaint(image: image))
			.edgesIgnoringSafeArea(.all)
	}
	
	func gridImage(size: CGSize) -> UIImage {
		let width = size.width
		let height = size.height
		return UIGraphicsImageRenderer(size: size).image { context in
			UIColor.lightGray.setStroke()
			let path = UIBezierPath()
			path.move(to: CGPoint(x: width, y: 0))
			path.addLine(to: CGPoint(x: width, y: height))
			path.addLine(to: CGPoint(x: 0, y: height))
			path.stroke()
		}
	}
}

struct BackgroundGridView_Previews: PreviewProvider {
	static var previews: some View {
		BackgroundGridView()
	}
}
