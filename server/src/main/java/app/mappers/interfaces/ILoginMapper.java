package app.mappers.interfaces;

import app.domains.LoginEntity;
import app.dto.Login;

public interface ILoginMapper {

	LoginEntity mapToLoginEntity(Login login);

	Login mapToLogin(LoginEntity loginEntity);
    
}
