package danielnaiff.backend.entities.enums;

public enum RoleValues {

//    ADMIN(1L),
    BASIC(2L);

    Long roleId;

    RoleValues(Long roleId) {
        this.roleId = roleId;
    }

    public Long getRoleId() {
        return roleId;
    }

}
