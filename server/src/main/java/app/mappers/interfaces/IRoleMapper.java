package app.mappers.interfaces;

import app.domains.RoleEntity;
import app.dto.Role;

public interface IRoleMapper {

	RoleEntity mapToRoleEntity(Role role);

	Role mapToRole(RoleEntity roleEntity);

}
