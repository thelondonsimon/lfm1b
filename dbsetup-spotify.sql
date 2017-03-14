CREATE TABLE public.spotify_album
(
  id text NOT NULL,
  name text NOT NULL,
  label text,
  release_date date,
  release_date_precision smallint,
  image text,
  image_width smallint,
  image_height smallint,
  album_type text,
  date_created timestamp NOT NULL,
  date_updated timestamp NOT NULL,
  CONSTRAINT pk_spotify_album_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_artist
(
  id text NOT NULL,
  name text NOT NULL,
  image text,
  image_width smallint,
  image_height smallint,
  album_type text,
  date_created timestamp NOT NULL,
  date_updated timestamp NOT NULL,
  CONSTRAINT pk_spotify_artist_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_track
(
  id text NOT NULL,
  name text NOT NULL,
  spotify_album_id text,
  duration_ms integer,
  track_number smallint,
  disc_number smallint,
  analysis_url text,
  acousticness real,
  danceability real,
  energy real,
  instrumentalness real,
  key smallint,
  liveness real,
  loudness real,
  mode smallint,
  speechiness real,
  tempo real,
  time_signature smallint,
  valence real,
  date_created timestamp NOT NULL,
  date_updated timestamp NOT NULL,
  CONSTRAINT pk_spotify_track_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_genre
(
  id serial NOT NULL,
  name text NOT NULL,
  date_created timestamp NOT NULL,
  CONSTRAINT pk_spotify_genre_id PRIMARY KEY (id),
  CONSTRAINT uc_spotify_genre_name UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_genre_link
(
  id serial NOT NULL,
  spotify_album_id text,
  spotify_artist_id text,
  spotify_track_id text,
  CONSTRAINT pk_spotify_album_genre_link PRIMARY KEY (id),
  CONSTRAINT fk_spotify_genre_link_album_id FOREIGN KEY (spotify_album_id)
      REFERENCES public.spotify_album (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_genre_link_artist_id FOREIGN KEY (spotify_artist_id)
      REFERENCES public.spotify_artist (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_genre_link_track_id FOREIGN KEY (spotify_track_id)
      REFERENCES public.spotify_track (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_popularity
(
  id serial NOT NULL,
  spotify_album_id text,
  spotify_artist_id text,
  spotify_track_id text,
  popularity integer,
  followers integer,
  popularity_date timestamp NOT NULL,
  CONSTRAINT pk_spotify_popularity_id PRIMARY KEY (id),
  CONSTRAINT fk_spotify_popularity_album_id FOREIGN KEY (spotify_album_id)
      REFERENCES public.spotify_album (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_popularity_artist_id FOREIGN KEY (spotify_artist_id)
      REFERENCES public.spotify_artist (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_popularity_track_id FOREIGN KEY (spotify_track_id)
      REFERENCES public.spotify_track (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_album_artist
(
  spotify_album_id text NOT NULL,
  spotify_artist_id text NOT NULL,
  CONSTRAINT pk_spotify_album_artist PRIMARY KEY (spotify_album_id, spotify_artist_id),
  CONSTRAINT fk_spotify_album_artist_album_id FOREIGN KEY (spotify_album_id)
    REFERENCES public.spotify_album (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_album_artist_artist_id FOREIGN KEY (spotify_artist_id)
    REFERENCES public.spotify_artist (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_album_track
(
  spotify_album_id text NOT NULL,
  spotify_track_id text NOT NULL,
  CONSTRAINT pk_spotify_album_track PRIMARY KEY (spotify_album_id, spotify_track_id),
  CONSTRAINT fk_spotify_album_track_album_id FOREIGN KEY (spotify_album_id)
    REFERENCES public.spotify_album (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_album_track_track_id FOREIGN KEY (spotify_track_id)
    REFERENCES public.spotify_track (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
CREATE TABLE public.spotify_artist_track
(
  spotify_artist_id text NOT NULL,
  spotify_track_id text NOT NULL,
  CONSTRAINT pk_spotify_artist_track PRIMARY KEY (spotify_artist_id, spotify_track_id),
  CONSTRAINT fk_spotify_artist_track_album_id FOREIGN KEY (spotify_artist_id)
    REFERENCES public.spotify_artist (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_spotify_artist_track_track_id FOREIGN KEY (spotify_track_id)
    REFERENCES public.spotify_track (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
--
ALTER TABLE public.album
    ADD COLUMN spotify_album_id text;
ALTER TABLE public.album
    ADD COLUMN last_spotify_search timestamp;
CREATE INDEX idx_album_last_spotify_search
    ON public.album
    USING btree
    (last_spotify_search);
ALTER TABLE public.album
    ADD CONSTRAINT fk_album_spotify_album_id FOREIGN KEY (spotify_album_id)
      REFERENCES public.spotify_album (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL;
--
ALTER TABLE public.artist
    ADD COLUMN spotify_artist_id text;
ALTER TABLE public.artist
    ADD COLUMN last_spotify_search timestamp;
CREATE INDEX idx_artist_last_spotify_search
    ON public.artist
    USING btree
    (last_spotify_search);
ALTER TABLE public.artist
    ADD CONSTRAINT fk_album_spotify_artist_id FOREIGN KEY (spotify_artist_id)
        REFERENCES public.spotify_artist (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;
--
ALTER TABLE public.track
    ADD COLUMN spotify_track_id text;
ALTER TABLE public.track
    ADD COLUMN last_spotify_search timestamp;
CREATE INDEX idx_track_last_spotify_search
    ON public.track
    USING btree
    (last_spotify_search);
ALTER TABLE public.track
    ADD CONSTRAINT fk_album_spotify_track_id FOREIGN KEY (spotify_track_id)
        REFERENCES public.spotify_track (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;
