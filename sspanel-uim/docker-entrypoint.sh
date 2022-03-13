echo -n >&2 "Checking environment..."

if ![ $SSPANEL_KEY ];then
    echo >&2 "SSPANEL_KEY not set!"
    exit
fi
if ![ $SSPANEL_BASEURL ];then
    echo >&2 "SSPANEL_BASEURL not set!"
    exit
fi
if ![ $SSPANEL_MUKEY ];then
    echo >&2 "SSPANEL_MUKEY not set!"
    exit
fi
if ![ $DB_HOST ] && ![ $DB_SOCKET ];then
    echo >&2 "DB_HOST or DB_SOCKET not set!"
    exit
fi
if ![ $DB_PASSWORD ];then
    echo >&2 "DB_PASSWORD not set!"
    exit
fi

echo  >&2 "Pass"
echo -n >&2 "Checking if installation exists..."

if [ ! -e public/index.php ]; then
    echo  >&2 "Not found"
    echo -n >&2 "Copying new files to directory..."

    if [ -n "$(find -mindepth 1 -maxdepth 1)" ]; then
			echo >&2 "Directory not empty!"
            exit 
	fi

    cp -r /usr/src/sspanel/* .

    echo >&2 "Done"
else
    echo >&2 "Found"
fi

echo -n >&2 "Checking connection to database..."

if [ $DB_HOST ]; then
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()"; then
        echo >&2 "Cannot connect to database!"
        exit
    fi
elif
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()"; then
        echo >&2 "Cannot connect to database!"
    fi
fi

echo >&2 "Good"
echo -n >&2 "Checking if database exists..."

if [ $DB_HOST ]; then
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE "$DB_DATABASE; then
        echo >&2 "Not found"
        echo -n >&2 "Initialize database..."

        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE "$DB_DATABASE" CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE USER '"$DB_USERNAME"'@'localhost';"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON "$DB_USERNAME".* TO '"$DB_USERNAME"'@'localhost' IDENTIFIED BY '"$DB_USERNAME"';"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "FLUSH PRIVILEGES;"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql

    elif
        echo >&2 "Found"
    fi
elif
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE "$DB_DATABASE; then
        echo >&2 "Not found"
        echo -n >&2 "Initialize database..."

        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE "$DB_DATABASE" CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE USER '"$DB_USERNAME"'@'localhost';"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON "$DB_USERNAME".* TO '"$DB_USERNAME"'@'localhost' IDENTIFIED BY '"$DB_USERNAME"';"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "FLUSH PRIVILEGES;"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql

    elif
        echo >&2 "Found"
    fi
fi

echo "All set, please enjoy!"

exec "$@"