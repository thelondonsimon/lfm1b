<?php

$dataDir = '/pgdata/tmp/';

echo "Truncating database...\n";
$pgc = pg_connect("host=localhost port=5432 dbname=lfm1b user=simon password=daffy321");
pg_query($pgc, file_get_contents('dbsetup.sql'));
pg_close($pgc);
$pdo = new \PDO('pgsql:dbname=lfm1b;host=localhost;user=simon;password=daffy321');


echo "Loading Artists data...\n";
$pdo->exec("COPY artist FROM '{$dataDir}LFM-1b_artists.txt'");
$pdo->exec("ALTER TABLE artist ADD CONSTRAINT pk_artist_id PRIMARY KEY(id)");


echo "Loading Albums data...\n";
$pdo->exec("COPY album FROM '{$dataDir}LFM-1b_albums.txt'");
$pdo->exec("ALTER TABLE album ADD CONSTRAINT pk_album_id PRIMARY KEY(id)");
$pdo->exec("CREATE INDEX idx_album_artist_id ON album USING btree (artist_id)");


echo "Loading Tracks data...\n";
$pdo->exec("COPY track FROM '{$dataDir}LFM-1b_tracks.txt'");
$pdo->exec("ALTER TABLE track ADD CONSTRAINT pk_track_id PRIMARY KEY(id)");
$pdo->exec("CREATE INDEX idx_track_artist_id ON track USING btree (artist_id)");


echo "Loading Users data...\n";
$pdo->exec("COPY lfm_user FROM '{$dataDir}LFM-1b_users.txt' WITH CSV HEADER DELIMITER E'\t'");
$pdo->exec("ALTER TABLE lfm_user ADD CONSTRAINT pk_lfm_user_id PRIMARY KEY(id)");
$pdo->exec("ALTER TABLE lfm_user ADD COLUMN date_registered timestamp");
$pdo->exec("UPDATE lfm_user SET date_registered = to_timestamp(date_registered_unix)");
$pdo->exec("ALTER TABLE lfm_user DROP COLUMN date_registered_unix");


echo "Loading Users Additional data...\n";
$pdo->exec("COPY lfm_user_detail FROM '{$dataDir}LFM-1b_users_additional.txt' WITH CSV HEADER DELIMITER E'\t'");
$pdo->exec("ALTER TABLE lfm_user_detail ADD CONSTRAINT pk_lfm_user_detail_user_id PRIMARY KEY(user_id)");

$pdo->exec("UPDATE lfm_user_detail SET novelty_artist_avg_month = null WHERE novelty_artist_avg_month = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN novelty_artist_avg_month TYPE numeric(20,17) USING novelty_artist_avg_month::numeric");
$pdo->exec("UPDATE lfm_user_detail SET novelty_artist_avg_6months = null WHERE novelty_artist_avg_6months = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN novelty_artist_avg_6months TYPE numeric(20,17) USING novelty_artist_avg_6months::numeric");
$pdo->exec("UPDATE lfm_user_detail SET novelty_artist_avg_year = null WHERE novelty_artist_avg_year = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN novelty_artist_avg_year TYPE numeric(20,17) USING novelty_artist_avg_year::numeric");
$pdo->exec("UPDATE lfm_user_detail SET mainstreaminess_avg_month = null WHERE mainstreaminess_avg_month = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN mainstreaminess_avg_month TYPE numeric(20,17) USING mainstreaminess_avg_month::numeric");
$pdo->exec("UPDATE lfm_user_detail SET mainstreaminess_avg_6months = null WHERE mainstreaminess_avg_6months = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN mainstreaminess_avg_6months TYPE numeric(20,17) USING mainstreaminess_avg_6months::numeric");
$pdo->exec("UPDATE lfm_user_detail SET mainstreaminess_avg_year = null WHERE mainstreaminess_avg_year = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN mainstreaminess_avg_year TYPE numeric(20,17) USING mainstreaminess_avg_year::numeric");
$pdo->exec("UPDATE lfm_user_detail SET mainstreaminess_global = null WHERE mainstreaminess_global = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN mainstreaminess_global TYPE numeric(20,17) USING mainstreaminess_global::numeric");
$pdo->exec("UPDATE lfm_user_detail SET cnt_listeningevents_per_week = null WHERE cnt_listeningevents_per_week = '?'");
$pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN cnt_listeningevents_per_week TYPE numeric(20,17) USING cnt_listeningevents_per_week::numeric");
for ($i = 1; $i < 8; $i++) {
    $pdo->exec("UPDATE lfm_user_detail SET le_prop_weekday{$i} = null WHERE le_prop_weekday{$i} = '?'");
    $pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN le_prop_weekday{$i} TYPE numeric(7,6) USING le_prop_weekday{$i}::numeric");
}
for ($i = 0; $i < 24; $i++) {
    $pdo->exec("UPDATE lfm_user_detail SET le_prop_hour{$i} = null WHERE le_prop_hour{$i} = '?'");
    $pdo->exec("ALTER TABLE lfm_user_detail ALTER COLUMN le_prop_hour{$i} TYPE numeric(7,6) USING le_prop_hour{$i}::numeric");
}



echo "Loading Listening Events data...\n";
$pdo->exec("COPY listen FROM '{$dataDir}LFM-1b_LEs.txt'");
$pdo->exec("ALTER TABLE listen ADD COLUMN id serial");
$pdo->exec("ALTER TABLE listen ADD CONSTRAINT pk_listen_id PRIMARY KEY(id)");
$pdo->exec("ALTER TABLE listen ADD COLUMN listen_datetime timestamp");
$pdo->exec("UPDATE listen SET listen_datetime = to_timestamp(listen_datetime_unix)");
$pdo->exec("ALTER TABLE listen DROP COLUMN listen_datetime_unix");
