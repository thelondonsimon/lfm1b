ALTER TABLE public.album
  ADD CONSTRAINT pk_album_id PRIMARY KEY(id);

ALTER TABLE public.artist
  ADD CONSTRAINT pk_artist_id PRIMARY KEY(id);

ALTER TABLE public.listen
  ADD CONSTRAINT pk_listen_id PRIMARY KEY(id);

ALTER TABLE public.track
  ADD CONSTRAINT pk_track_id PRIMARY KEY(id);

ALTER TABLE public.user
  ADD CONSTRAINT pk_user_id PRIMARY KEY(id);

ALTER TABLE public.user_detail
  ADD CONSTRAINT pk_user_id PRIMARY KEY(id);
