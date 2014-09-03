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
package {
	
	
	/**
	 * List of classes and tools to include. 
	 * 
	 * Be sure to add a reference to this class in the RadiateReferences.
	 * */
	public class Radii8LibraryToolAssets {
		
		public function Radii8LibraryToolAssets() {
			
		}
		
		///////////////////////////////////////////////////////
		// CORE
		///////////////////////////////////////////////////////
		
		/**
		 * var xml:XML = new XML(new Radii8LibraryToolAssets.toolsManifestDefaults());
		 * // get list of tool classes
		 * items = XML(xml).tool;
		 * 
		 * 
		 * Be sure to add a reference to the RadiateReferences.
		 * */
		[Embed(source="/assets/data/tools-manifest-defaults.xml", mimeType="application/octet-stream")]
		public static const toolsManifestDefaults:Class;
		
		
		///////////////////////////////////////////////////////
		// ICONS
		///////////////////////////////////////////////////////
		
		[Embed(source="assets/icons/tools/BlackArrow.png")]
		public static const BlackArrowIcon:Class;
		
		[Embed(source="assets/icons/tools/WhiteArrow.png")]
		public static const WhiteArrowIcon:Class;
		
		[Embed(source="assets/icons/tools/dragStripIcon.png")]
		public static const DragStripIcon:Class;
		
		[Embed(source="assets/icons/tools/EyeDropper.png")]
		public static const EyeDropper:Class;
		
		
		
	}
}