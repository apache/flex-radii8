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
	 * Inspectors. Add references to RadiateReferences
	 * 
	 * To control the list of inspectors
	 * edit the /assets/data/inspectors-manifest-defaults.xml
	 * */
	public class Radii8LibraryInspectorAssets {
		
		public function Radii8LibraryInspectorAssets() {
			
		}
		
		///////////////////////////////////////////////////////
		// CORE
		///////////////////////////////////////////////////////
		
		/**
		 * var xml:XML = new XML(new Radii8LibraryInspectorAssets.inspectorsManifestDefaults());
		 * 
		 * NOTE: Add a reference to the classes here and in the XML file. 
		 * */
		[Embed(source="/assets/data/inspectors-manifest-defaults.xml", mimeType="application/octet-stream")]
		public static const inspectorsManifestDefaults:Class;
		
		
		///////////////////////////////////////////////////////
		// CONTAINERS
		///////////////////////////////////////////////////////
		
		//[Embed(source="assets/icons/containers/Accordion.png")]
		//public static const AccordionIcon:Class;
		
		//[Embed(source="assets/icons/containers/ApplicationControlBar.png")]
		//public static const ApplicationControlBarIcon:Class;
		
		//[Embed(source="assets/icons/spark/containers/BorderContainer.png")]
		//public static const BorderContainerIcon:Class;
		
		
	}
}