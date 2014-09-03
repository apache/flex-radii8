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
	import com.flexcapacitor.views.IInspector;
	
	import flash.system.ApplicationDomain;
	
	import mx.core.ClassFactory;
	
	/**
	 * Hold information and reference to inspector instance
	 * */
	public class InspectorData {
		
		/**
		 * Constructor obviously
		 * */
		public function InspectorData(data:XML = null) {
			
			if (data) {
				unmarshall(data);
			}
		}
		
		/**
		 * Display name of inspector. If empty the class name is used.
		 * */
		public var name:String;
		
		/**
		 * Fully qualified class name
		 * */
		public var className:String;
		
		/**
		 * Instance of inspector
		 * */
		public var instance:IInspector;
		
		/**
		 * Reference to class used to create the instance
		 * */
		public var classType:Object;
		
		/**
		 * Defaults to set when creating the instance
		 * */
		public var defaults:Object;
		
		/**
		 * Icon
		 * */
		public var icon:Object;
		
		/**
		 * Import from XML data
		 * */
		public function unmarshall(data:XML):InspectorData {
			name = data.attribute("name");
			className = data.attribute("className");
			//defaults = data.defaults;
			
			return this;
		}
		
		/**
		 * Gets an instance of the inspector class or null if the definition is not found.
		 * */
		public function getInstance(domain:ApplicationDomain = null):IInspector {
			var classFactory:ClassFactory;
			var hasDefinition:Boolean;
			
			if (!instance) {
				domain = !domain ? ApplicationDomain.currentDomain : domain;
				hasDefinition = domain.hasDefinition(className);
				
				if (hasDefinition) {
					classType = domain.getDefinition(className);
					
					classFactory = new ClassFactory(classType as Class);
					//classFactory.properties = defaultProperties;
					instance = classFactory.newInstance();
				}
				else {
					return null;
				}
			
			}

			return instance;
			
		}
	}
}