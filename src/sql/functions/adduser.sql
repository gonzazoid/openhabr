--
-- Name: adduser(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS adduser(character varying, character varying, character varying, character varying);

CREATE FUNCTION adduser(_nickname character varying, _mail character varying, _pwd character varying, _sid character varying)
    RETURNS boolean
    LANGUAGE plpgsql
AS $_$

DECLARE
    result boolean;

BEGIN

IF NOT EXISTS(SELECT * FROM users WHERE nickname = _nickname OR mail = _mail) THEN

    INSERT INTO users ("nickname", "mail", "pwd", "sid") values (_nickname, _mail, _pwd, _sid);
    result = true;

ELSE

    result = false;

END IF;

RETURN result;

END;

$_$;

ALTER FUNCTION public.adduser(character varying, character varying, character varying, character varying) OWNER TO openhabr;
