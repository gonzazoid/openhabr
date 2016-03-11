--
-- Name: auth(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS auth(character varying, character varying, character varying);

CREATE FUNCTION auth(_nickname character varying, _pwd character varying, _sid character varying)
    RETURNS SETOF users

    LANGUAGE plpgsql
AS $_$

BEGIN

RETURN QUERY UPDATE users SET sid = _sid WHERE nickname = _nickname AND pwd = _pwd RETURNING *;

END;

$_$;

ALTER FUNCTION public.auth(character varying, character varying, character varying) OWNER TO openhabr;
