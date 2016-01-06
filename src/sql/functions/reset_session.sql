--
-- Name: auth(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS reset_session(bigint);

CREATE FUNCTION reset_session(_id bigint) RETURNS SETOF users
    LANGUAGE sql
AS $_$

UPDATE users SET sid = '' WHERE id = _id RETURNING *;

$_$;

ALTER FUNCTION public.reset_session(bigint) OWNER TO openhabr;
