
DROP TABLE IF EXISTS public.listen CASCADE;
DROP TABLE IF EXISTS public.artist CASCADE;
DROP TABLE IF EXISTS public.album CASCADE;
DROP TABLE IF EXISTS public.track CASCADE;
DROP TABLE IF EXISTS public.lfm_user_detail CASCADE;
DROP TABLE IF EXISTS public.lfm_user CASCADE;

CREATE TABLE public.album
(
  id bigint NOT NULL,
  title text,
  artist_id bigint
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.album
  OWNER TO simon;


CREATE TABLE public.artist
(
  id bigint NOT NULL,
  name text,
  CONSTRAINT pk_artist_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.artist
OWNER TO simon;


CREATE TABLE public.track
(
id bigint NOT NULL,
title text,
artist_id bigint
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.track
OWNER TO simon;
CREATE INDEX idx_track_artist_id
  ON public.track
  USING btree
  (artist_id);


CREATE TABLE public.lfm_user
(
    id bigint NOT NULL,
    country text,
    age integer,
    gender text,
    play_count bigint,
    date_registered_unix bigint
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.lfm_user
OWNER TO simon;


CREATE TABLE public.lfm_user_detail
(
    lfm_user_id bigint NOT NULL,
    novelty_artist_avg_month text,
    novelty_artist_avg_6months text,
    novelty_artist_avg_year text,
    mainstreaminess_avg_month text,
    mainstreaminess_avg_6months text,
    mainstreaminess_avg_year text,
    mainstreaminess_global text,
    cnt_listeningevents integer,
    cnt_distinct_tracks integer,
    cnt_distinct_artists integer,
    cnt_listeningevents_per_week text,
    le_prop_weekday1 text,
    le_prop_weekday2 text,
    le_prop_weekday3 text,
    le_prop_weekday4 text,
    le_prop_weekday5 text,
    le_prop_weekday6 text,
    le_prop_weekday7 text,
    le_prop_hour0 text,
    le_prop_hour1 text,
    le_prop_hour2 text,
    le_prop_hour3 text,
    le_prop_hour4 text,
    le_prop_hour5 text,
    le_prop_hour6 text,
    le_prop_hour7 text,
    le_prop_hour8 text,
    le_prop_hour9 text,
    le_prop_hour10 text,
    le_prop_hour11 text,
    le_prop_hour12 text,
    le_prop_hour13 text,
    le_prop_hour14 text,
    le_prop_hour15 text,
    le_prop_hour16 text,
    le_prop_hour17 text,
    le_prop_hour18 text,
    le_prop_hour19 text,
    le_prop_hour20 text,
    le_prop_hour21 text,
    le_prop_hour22 text,
    le_prop_hour23 text
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.lfm_user_detail
OWNER TO simon;


CREATE TABLE public.listen
(
    lfm_user_id bigint,
    artist_id bigint,
    album_id bigint,
    track_id bigint,
    listen_datetime_unix bigint
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.listen
OWNER TO simon;
