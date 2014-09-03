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

package com.flexcapacitor.model {
	
	/**
	 * Holds data on inspector
	 * */
	public class InspectableClass {
		
		public function InspectableClass(data:XML = null) {
			
			if (data) {
				unmarshall(data);
			}
		}
		
		/**
		 * Name 
		 * */
		public var name:String;
		
		/**
		 * Name of class
		 * */
		public var className:String;
		
		/**
		 * List of inspectors
		 * */
		public var inspectors:Array = [];
		
		public function unmarshall(data:XML):InspectableClass {
			var inspectorsXMLList:XMLList;
			var inspectorXML:XML;
			var length:uint;
			var inspectorArray:uint;
			var inspectorData:InspectorData;
			
			// get list of inspectors
			// create instances
			// store in inspectors list
			
			name = data.attribute("name");
			className = data.attribute("className");
			
			inspectorsXMLList = data..inspector;
			length = inspectorsXMLList.length();
			
			for (var i:int;i<length;i++) {
				inspectorXML = inspectorsXMLList[i];
				inspectorData = new InspectorData(inspectorXML);
				inspectors.push(inspectorData);
			}
			
			return this;
		}
	}
}