# TODO: Do proper parameter validation and return appropriate
# status codes. For example, empty strings should not be valid
# parameters.
# TODO: Discard standard error on all commands

ZFS_CMD=/sbin/zfs


# Reads the value of a ZFS propety.
# TODO: This will never fail for user properties but returns
# '-' as the value for non-existent user properties.
# This needs to be split into two functions, one for builtin
# properties and other for user properties.
rdnzl_zfs_get_user_property_value()
{
    # TODO: Test that the number of argument is correct.
    ZFSFS="$1"
    ZFSPROP="$2"

    # TODO: Test that there is at least one colon (:) in ZFSPROP
    USERPROPVALUE=$("${ZFS_CMD}" get -H -o value "$ZFSPROP" "$ZFSFS")
    
    if test "${USERPROPVALUE}" = "-"; then
        return 1
    fi

    echo "${USERPROPVALUE}"
    return 0
}

# Tests if a dataset exists
# Produces no output, caller should test $?
rdnzl_zfs_filesystem_exists()
{
    ZFS_DATASET="$1"

    "${ZFS_CMD}" list -t filesystem -H -o name "${ZFS_DATASET}" >/dev/null 2>&1
}

# Same for snapshots
rdnzl_zfs_snapshot_exists()
{
    ZFS_SNAPSHOT="$1"

    "${ZFS_CMD}" list -t snapshot -H -o name "${ZFS_SNAPSHOT}" >/dev/null 2>&1
}

# Returns the filesystem name of a path
rdnzl_zfs_filesystem_from_path()
{
    ZFS_PATH="$1"

    "${ZFS_CMD}" list -H -o name "${ZFS_PATH}"  
}

