////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package com.flexcapacitor.controller {
	import com.flexcapacitor.tools.EyeDropper;
	import com.flexcapacitor.tools.Selection;
	import com.flexcapacitor.tools.Zoom;
	import com.flexcapacitor.views.inspectors.BorderStyles;
	import com.flexcapacitor.views.EyeDropperInspector;
	import com.flexcapacitor.views.SelectionInspector;
	import com.flexcapacitor.views.Size;
	import com.flexcapacitor.views.ZoomInspector;
	import com.flexcapacitor.views.inspectors.BasicBackgroundStyles;
	import com.flexcapacitor.views.inspectors.FontStyles;
	import com.flexcapacitor.views.inspectors.Identity;
	import com.flexcapacitor.views.inspectors.Image;
	import com.flexcapacitor.views.inspectors.TextInspector;
	
	/**
	 * Create references so classes are included. 
	 * */
	public class RadiateReferences {
		
		
		public function RadiateReferences()
		{
			
		}
		
		///////////////////////////////////////////////////////
		// TOOLS CLASSES
		///////////////////////////////////////////////////////
		
		public static var selectionTool:com.flexcapacitor.tools.Selection;
		public static var selectionInspector:com.flexcapacitor.views.SelectionInspector;
		
		public static var zoomTool:com.flexcapacitor.tools.Zoom;
		public static var zoomInspector:com.flexcapacitor.views.ZoomInspector;
		
		public static var eyeDropperTool:com.flexcapacitor.tools.EyeDropper;
		public static var eyeDropperInspector:com.flexcapacitor.views.EyeDropperInspector;
		
		///////////////////////////////////////////////////////
		// TOOLS CLASSES
		///////////////////////////////////////////////////////
		
		public static var identity:com.flexcapacitor.views.inspectors.Identity;
		public static var size:com.flexcapacitor.views.Size;
		public static var borderStyles:com.flexcapacitor.views.inspectors.BorderStyles;
		public static var fontStyles:com.flexcapacitor.views.inspectors.FontStyles;
		public static var textInspector:com.flexcapacitor.views.inspectors.TextInspector;
		public static var basicBackgroundInspector:com.flexcapacitor.views.inspectors.BasicBackgroundStyles;
		public static var imageInspector:com.flexcapacitor.views.inspectors.Image;
		public static var borderStylesInspector:com.flexcapacitor.views.inspectors.BorderStyles;
		
		
		
	}
}