--
-- Name: addcomment(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS addcomment(bigint, bigint, bigint, character varying);

CREATE FUNCTION addcomment(_user_id bigint, _post_id bigint, _parent_id bigint, _text character varying)
    RETURNS boolean
    LANGUAGE plpgsql
AS $_$

DECLARE
    result boolean;

BEGIN

    INSERT INTO comments ("article_id", "author", "reply_to", "body") VALUES (_post_id, _user_id, _parent_id, _text);
    UPDATE articles SET comments_count = comments_count + 1 WHERE id = _post_id;
    result = true;

RETURN result;

END;

$_$;

ALTER FUNCTION public.addcomment(bigint, bigint, bigint, character varying) OWNER TO openhabr;
