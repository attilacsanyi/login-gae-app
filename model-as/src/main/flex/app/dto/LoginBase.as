/**
 * Generated by Gas3 v2.1.0 (Granite Data Services).
 *
 * WARNING: DO NOT CHANGE THIS FILE. IT MAY BE OVERRIDDEN EACH TIME YOU USE
 * THE GENERATOR. CHANGE INSTEAD THE INHERITED CLASS (Login.as).
 */

package app.dto {

import flash.events.EventDispatcher;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;
import mx.collections.ArrayCollection;
import mx.collections.ListCollectionView;
import mx.events.CollectionEvent;
import mx.events.PropertyChangeEvent;

[Bindable]
[Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
public class LoginBase extends EventDispatcher {

private var _key:String;
private var _password:String;
private var _roles:ListCollectionView;
private var _status:String;
private var _username:String;
public function LoginBase(){

_roles = new ArrayCollection();

}


public function set key(value:String):void {
            if(_key != value){
              var oldValue:String = _key;
              _key = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "key", oldValue, value));
            }
        }
public function get key():String {
            return _key;
        }

public function set password(value:String):void {
            if(_password != value){
              var oldValue:String = _password;
              _password = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "password", oldValue, value));
            }
        }
public function get password():String {
            return _password;
        }

public function set roles(value:ListCollectionView):void {
            if(_roles != value){
              var oldValue:ListCollectionView = _roles;
              _roles = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "roles", oldValue, value));
            }
        }
public function get roles():ListCollectionView {
            return _roles;
        }

public function set status(value:String):void {
            if(_status != value){
              var oldValue:String = _status;
              _status = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", oldValue, value));
            }
        }
public function get status():String {
            return _status;
        }

public function set username(value:String):void {
            if(_username != value){
              var oldValue:String = _username;
              _username = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "username", oldValue, value));
            }
        }
public function get username():String {
            return _username;
        }
override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
super.addEventListener(type, listener, useCapture, priority, useWeakReference);

if(type == PropertyChangeEvent.PROPERTY_CHANGE){

_roles.addEventListener(CollectionEvent.COLLECTION_CHANGE, listener);

}

}



public function readExternal(input:IDataInput):void {
_key = input.readObject() as String;
_password = input.readObject() as String;
_roles = input.readObject() as ListCollectionView;
_status = input.readObject() as String;
_username = input.readObject() as String;
}

public function writeExternal(output:IDataOutput):void {
output.writeObject(_key);
output.writeObject(_password);
output.writeObject(_roles);
output.writeObject(_status);
output.writeObject(_username);
}
    }
}