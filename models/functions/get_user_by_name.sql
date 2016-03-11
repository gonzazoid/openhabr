--
-- Name: get_user_by_name(character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

DROP FUNCTION IF EXISTS get_user_by_name(character varying);

CREATE FUNCTION get_user_by_name(_nickname character varying) RETURNS TABLE(
    id bigint
   ,nickname character varying
   ,mail     character varying
   ,carma    real
   ,rating   real
   ,fullname character varying
   ,status   character varying
   ,pwd      character varying
   ,sid      character varying
   ,medals   integer[]
   ,readonly boolean
   ,medal_title character varying[]
   ,medal_description character varying[]
)
    LANGUAGE sql
    AS $$
-- надо подтянуть медальки
SELECT users.*, m.medal_title, m.medal_description
FROM(
    SELECT users.id, array_agg(medals.title) AS medal_title, array_agg(medals.description) AS medal_description
    FROM users, medals 
    WHERE nickname = _nickname AND medals.id = ANY(users.medals)
    GROUP BY users.id
) m, users
WHERE users.id = m.id;
$$;

ALTER FUNCTION public.get_user_by_name(character varying) OWNER TO openhabr;
