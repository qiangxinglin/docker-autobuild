
                                 
echo >&2 " _____ _____ _____             _ "
echo >&2 "|   __|   __|  _  |___ ___ ___| |"
echo >&2 "|__   |__   |   __| .'|   | -_| |"
echo >&2 "|_____|_____|__|  |__,|_|_|___|_|"
                                 
                   
echo -n >&2 "\nChecking environment..."

if [ -z $SSPANEL_KEY ]; then
    echo >&2 "SSPANEL_KEY not set!"
    exit
fi
if [ -z $SSPANEL_BASEURL ];then
    echo >&2 "SSPANEL_BASEURL not set!"
    exit
fi
if [ -z $SSPANEL_MUKEY ];then
    echo >&2 "SSPANEL_MUKEY not set!"
    exit
fi
if [ -z $DB_HOST ] && [ -z $DB_SOCKET ];then
    echo >&2 "DB_HOST or DB_SOCKET not set!"
    exit
fi
if [ -z $DB_PASSWORD ];then
    echo >&2 "DB_PASSWORD not set!"
    exit
fi

echo  >&2 "Pass"
echo -n >&2 "\nChecking if installation exists..."

if [ ! -e public/index.php ]; then
    echo  >&2 "Not found"
    echo -n >&2 "\nCopying new files to directory..."

    if [ -n "$(find -mindepth 1 -maxdepth 1)" ]; then
			echo >&2 "Directory not empty!"
            exit 
	fi

    cp -r /usr/src/sspanel/. .

    echo >&2 "Done"
else
    echo >&2 "Found"
fi

echo -n >&2 "\nChecking connection to database..."

if [ -z $DB_HOST ]; then
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()" > /dev/null; then
        echo >&2 "Cannot connect to database!"
    fi
else
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()" > /dev/null; then
        echo >&2 "Cannot connect to database!"
        exit
    fi
fi

echo >&2 "Good"
echo -n >&2 "\nChecking if database exists..."

if [ -z $DB_HOST ]; then
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE "$DB_DATABASE > /dev/null; then
        echo -n >&2 "\nInitialize database..."

        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE "$DB_DATABASE" CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql

	echo >&2 "Done"
    else
        echo >&2 "Found"
    fi
else
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE "$DB_DATABASE > /dev/null; then
        echo -n >&2 "\nInitialize database..."

        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE "$DB_DATABASE" CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql
	
	echo >&2 "Done"
    else
        echo >&2 "Found"
    fi
fi

echo -n >&2 "\nApplying permissions..."

chmod -R 777 storage

echo >&2 "Done"

echo -n >&2 "\nChecking if admin account exists..."

if [ -z $DB_HOST ]; then
	temp_sql_result=$(mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT user_name FROM sspanel.user WHERE user_name = 'admin';")
else
	temp_sql_result=$(mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT user_name FROM sspanel.user WHERE user_name = 'admin';")
fi

if [ -z $temp_sql_result ]; then
	echo >&2 "Not found"
	echo -n >&2 "\nAttemping to create admin account..."
	if [ -z $SSPANEL_ADMIN_EMAIL ] || [-z $SSPANEL_ADMIN_PASSWORD ];then
		echo >&2 "SSPANEL_ADMIN_EMAIL or SSPANEL_ADMIN_PASSWORD not set!"
	else
		printf $SSPANEL_ADMIN_EMAIL'\n'$SSPANEL_ADMIN_PASSWORD'\ny\n' | php xcat User createAdmin
		echo >&2 "Done"
	fi
fi

echo -n >&2 "\nChecking if client binaries exist..."

if [ ! -d "public/clients" ]; then
	echo >&2 "Not found"
	echo -n >&2 "\nDownloading client binaries..."
	echo -n >&2 "\nThis should take about 5 min, depend on your internet connection."
	echo -n >&2 "\nTo skip this check, make sure public/clients/ folder exists."
	php xcat ClientDownload
	echo >&2 "\n Done"
else
	echo >&2 "Found"
fi

echo -n >&2 "\nUpdating ip database..."

php xcat Tool initQQwry

echo >&2 "Done"


echo >&2  "\nAll set, please enjoy!\n\n"

exec "apache2-foreground"
