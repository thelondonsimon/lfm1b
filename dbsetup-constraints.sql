ALTER TABLE public.album
  ADD CONSTRAINT pk_album_id PRIMARY KEY(id);

ALTER TABLE public.artist
  ADD CONSTRAINT pk_artist_id PRIMARY KEY(id);

ALTER TABLE public.listen
  ADD CONSTRAINT pk_listen_id PRIMARY KEY(id);

ALTER TABLE public.track
  ADD CONSTRAINT pk_track_id PRIMARY KEY(id);

ALTER TABLE public.lfm_user
  ADD CONSTRAINT pk_lfm_user_id PRIMARY KEY(id);

ALTER TABLE public.lfm_user_detail
    ADD CONSTRAINT pk_lfm_user_lfm_user_id PRIMARY KEY(lfm_user_id);

ALTER TABLE public.lfm_user_detail
    ADD CONSTRAINT fk_flm_user_detail_lfm_user_id FOREIGN KEY (lfm_user_id)
        REFERENCES public.lfm_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE public.track
    ADD CONSTRAINT fk_track_artist_id FOREIGN KEY (artist_id)
        REFERENCES public.artist (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;

ALTER TABLE public.album
    ADD CONSTRAINT fk_album_artist_id FOREIGN KEY (artist_id)
        REFERENCES public.artist (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;

ALTER TABLE public.listen
    ADD CONSTRAINT fk_listen_artist_id FOREIGN KEY (artist_id)
        REFERENCES public.artist (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE public.listen
    ADD CONSTRAINT fk_listen_lfm_user_id FOREIGN KEY (lfm_user_id)
        REFERENCES public.lfm_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE public.listen
    ADD CONSTRAINT fk_listen_track_id FOREIGN KEY (track_id)
        REFERENCES public.track (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;

ALTER TABLE public.listen
    ADD CONSTRAINT fk_listen_album_id FOREIGN KEY (album_id)
        REFERENCES public.album (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL;
