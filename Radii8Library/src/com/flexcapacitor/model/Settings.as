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
	 * Class used to store settings and projects
	 * */
	[RemoteClass(alias="Settings")]
	public class Settings implements ISettings {
		
		public function Settings() {
			
			lastOpened = modified = created = new Date().time;
		}
		
		private var _version:uint = 1;

		public function get version():uint {
			return _version;
		}

		public function set version(value:uint):void {
			_version = value;
		}
		
		
		public var created:uint;
		public var modified:uint;
		private var _modifiedValue:uint;

		public function get modifiedValue():uint {
			return new Date().time;
		}

		public function set modifiedValue(value:uint):void {
			_modifiedValue = value;
		}

		public var lastOpened:uint; 
		
		public var configuration:Object;
		
		public var openProjects:Array = [];
		
		public var openDocuments:Array = [];
		
		public var openWorkspace:Array = [];
		
		public var selectedDocument:IDocumentMetaData;
		
		public var selectedProject:IDocumentMetaData;
		
		public var saveCount:int;
		
		
		
		public function unmarshall(data:Object):void {
			
			
			
		}
		
	}
}