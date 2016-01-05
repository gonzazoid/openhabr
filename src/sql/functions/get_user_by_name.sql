--
-- Name: get_user_by_name(character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS get_user_by_name(character varying);

CREATE FUNCTION get_user_by_name(_nickname character varying) RETURNS SETOF users
    LANGUAGE sql
    AS $$

SELECT * FROM  users WHERE nickname = _nickname;

$$;

ALTER FUNCTION public.get_user_by_name(character varying) OWNER TO openhabr;
