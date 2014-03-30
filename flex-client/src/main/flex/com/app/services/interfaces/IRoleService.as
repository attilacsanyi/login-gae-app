package com.app.services.interfaces
{
	import app.dto.Role;
	
	import mx.rpc.AsyncToken;

	public interface IRoleService
	{
		function getAllRoles():AsyncToken;
		function createDemoRole():AsyncToken;
		function createRole(role:Role):AsyncToken;
	}
}