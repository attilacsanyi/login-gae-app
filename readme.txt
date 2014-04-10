+------------------------------------------------+
|        SPRING GAE FLEX WEBAPPLICATION          |
+------------------------------------------------+
4396-0238-2291-7139-5309
+----------------+
| Features:      |
+----------------+

- User with roles and customers entities
- Spring security with user service
- Flex internationalization with Babel Fx 2.0
- Swiz Framework 1.3.1
- MoveThis AS3 library for animation
- Google appengine with High Replicant datastore (1.6.1)

+----------------+
| Remarks:       |
+----------------+

1. Appengin java SDK is external (not plugin)
2. Build process automatically copy the hacked blazeds jar into target/atka-gaeflex/lib directory
	(the ant process copy the recuired jar(copyjars) also into WEB-INF/lib)

+----------------+
| Build/upload:  |
+----------------+

1. Check out the project from the repository: file:///W:/work/repositories/workspace/atka-gaeflex/trunk
2. Call build_and_deploy.bat from there

+----------------+
| TODO:          |
+----------------+

1.

+----------------+
| New features:  |
+----------------+

[NEW ] Update mock service calls for login
[NEW ] "StatusBar" exmpl: new role created in the event handler: var newRole:Role = event.result as Role;
[NEW ] Instead of getAllRolesHandler(); use the roleModel.roles.removeItemAt(roleModel.roles.getItemIndex(roleModel.role)); it is faster and not required servicecall
[NEW ] Find role by name
[NEW ] Change sysout to LOG DEBUG functions
[NEW ] Tab position order in role from
[NEW ] Add alpha effect when role update/delete button is appeared
[NEW ] Check if the deleted/updated role is still exist before the operation
[NEW ] Serialize to local machine: http://jacksondunstan.com/articles/1642
[NEW ] Focus on the role Form
[NEW ] Encrypt password with AES: http://www.code2learn.com/2011/06/encryption-and-decryption-of-data-using.html
		or http://www.jasypt.org/howtoencryptuserpasswords.html
[NEW ] Use my-secure-amf instead of my-amf
[NEW ] Use channel id like 'my-amf' from property
[NEW ] Add authentication is in progress message
[NEW ] Use @Secured in service implementations
[NEW ] Replace spring dependency to 3.1.0
[NEW ] Replace blazeds to graniteds 2.3.0 docs in the project_doc folder
[NEW ] Create default user if no one exist
[NEW ] Handle if user not found during login on java back-end
[NEW ]	[WARNING] Missing POM for com.adobe.flex.framework:playerglobal:swc:11.1:4.6.0.23201
		[WARNING] Missing POM for com.adobe.flex.framework:playerglobal:rb.swc:4.6.0.23201
[NEW] Update status in login work only under English locale
[NEW] Store logged in user info >> return AuthenticationResultUtils.getAuthenticationResult(); << "name" and "authorities" will be available in flex client.

[DONE ] Display roles in the logins role column (itemrenderer)
[DONE ] Add new login
[DONE ] Create demo login
[DONE ] Update demo login
[DONE ] Delete all login (except atka)
[DONE ] Add Cancel button to create login like in role case
[DONE ] Create demo login if no login exist
[DONE ] Use google app-engine 1.6.1
[DONE] i18n in SecurityView
[DONE] i18n in roleForm
[DONE] Create swc from the MoveThis used animation engine dependency
[DONE] Update role (the selected)
[DONE] Delete role (the selected) and after close the form
[DONE] Delete all role (except admin)
[DONE] Login status dropdown list with i18n
[DONE] Use one name convention: Expired, Locked, Disabled, ...

+----------------+
| Bugs:          |
+----------------+

[NEW ] Create login first and the role dropdown list is empty
[NEW ] After login created button stay disabled
[NEW ] Add required resourceinjectors
[NEW ] Add 600 width to roleView why it is neccessarry??

[DONE] Log in -> log out and inputs are empty and you can log in again (you have to give credentials again)
[DONE] flex: Create new Role error - Nullpoiner exception
[DONE] login.roles not saved ListCollectionView instantiate with ArrayCollection solved it: http://blog.rosshenderson.info/448/listcollectionviewarraycollection-tip-for-using-graniteds/
[DONE] Problem: org.springframework.orm.jpa.JpaSystemException : Detected attempt to establish login(32001) as the parent of role(31001) but the entity identified by role(31001) has already been persisted without a parent.  A parent cannot be established or changed once an object has been persisted.; nested exception is javax.persistence.PersistenceException: Detected attempt to establish login(32001) as the parent of role(31001) but the entity identified by role(31001) has already been persisted without a parent.  A parent cannot be established or changed once an object has been persisted.
Answer: http://stackoverflow.com/questions/1158919/one-to-many-child-has-already-been-persisted-without-parent
Workaround: http://stackoverflow.com/questions/1374659/many-to-many-relationship-in-java-google-ap-engine

+----------------+
| Experience:    |
+----------------+

1. <s:TextInput .../> with different state on text property not working on different bindings
2. only update and delete are supported while use ExecuteUpdate on javax.persistence.Query