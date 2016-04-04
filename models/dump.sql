--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: adduser(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

CREATE FUNCTION adduser(_nickname character varying, _mail character varying, _pwd character varying, _sid character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

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

$$;


ALTER FUNCTION public.adduser(_nickname character varying, _mail character varying, _pwd character varying, _sid character varying) OWNER TO openhabr;

--
-- Name: users_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE users_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id OWNER TO openhabr;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE users (
    id bigint DEFAULT nextval('users_id'::regclass) NOT NULL,
    nickname character varying NOT NULL,
    mail character varying NOT NULL,
    carma real DEFAULT 0 NOT NULL,
    rating real DEFAULT 0 NOT NULL,
    fullname character varying DEFAULT ' '::character varying NOT NULL,
    status character varying DEFAULT 'пользователь'::character varying NOT NULL,
    pwd character varying(128) NOT NULL,
    sid character varying(128) DEFAULT ' '::character varying NOT NULL,
    medals integer[] DEFAULT '{3}'::integer[] NOT NULL,
    readonly boolean DEFAULT true NOT NULL
);


ALTER TABLE users OWNER TO openhabr;

--
-- Name: auth(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

CREATE FUNCTION auth(_nickname character varying, _pwd character varying, _sid character varying) RETURNS SETOF users
    LANGUAGE plpgsql
    AS $$

BEGIN

RETURN QUERY UPDATE users SET sid = _sid WHERE nickname = _nickname AND pwd = _pwd RETURNING *;

END;

$$;


ALTER FUNCTION public.auth(_nickname character varying, _pwd character varying, _sid character varying) OWNER TO openhabr;

--
-- Name: get_user_by_name(character varying); Type: FUNCTION; Schema: public; Owner: openhabr
--

CREATE FUNCTION get_user_by_name(_nickname character varying) RETURNS TABLE(id bigint, nickname character varying, mail character varying, carma real, rating real, fullname character varying, status character varying, pwd character varying, sid character varying, medals integer[], readonly boolean, medal_title character varying[], medal_description character varying[])
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


ALTER FUNCTION public.get_user_by_name(_nickname character varying) OWNER TO openhabr;

--
-- Name: reset_session(bigint); Type: FUNCTION; Schema: public; Owner: openhabr
--

CREATE FUNCTION reset_session(_id bigint) RETURNS SETOF users
    LANGUAGE sql
    AS $$

UPDATE users SET sid = '' WHERE id = _id RETURNING *;

$$;


ALTER FUNCTION public.reset_session(_id bigint) OWNER TO openhabr;

--
-- Name: articles_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE articles_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE articles_id OWNER TO openhabr;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE articles (
    id bigint DEFAULT nextval('articles_id'::regclass) NOT NULL,
    author bigint NOT NULL,
    type integer NOT NULL,
    stamp timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    hubs integer[] NOT NULL,
    tags bigint[],
    title character varying NOT NULL,
    cut character varying NOT NULL,
    body character varying NOT NULL,
    views integer DEFAULT 0 NOT NULL,
    favorites integer DEFAULT 0 NOT NULL,
    rating real DEFAULT 0 NOT NULL,
    draft boolean DEFAULT true NOT NULL,
    cut_title character varying,
    comments_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE articles OWNER TO openhabr;

--
-- Name: TABLE articles; Type: COMMENT; Schema: public; Owner: openhabr
--

COMMENT ON TABLE articles IS 'статьи';


--
-- Name: COLUMN articles.type; Type: COMMENT; Schema: public; Owner: openhabr
--

COMMENT ON COLUMN articles.type IS 'перевод/новость/урок/статья/исследование';


--
-- Name: comments_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE comments_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id OWNER TO openhabr;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE comments (
    id bigint DEFAULT nextval('comments_id'::regclass) NOT NULL,
    article_id bigint NOT NULL,
    author bigint NOT NULL,
    reply_to bigint DEFAULT 0 NOT NULL,
    body character varying NOT NULL,
    stamp timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    rating real DEFAULT 0 NOT NULL,
    last_changed timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE comments OWNER TO openhabr;

--
-- Name: COLUMN comments.reply_to; Type: COMMENT; Schema: public; Owner: openhabr
--

COMMENT ON COLUMN comments.reply_to IS 'id коммента, на который отвечает этот. 0 - если ответ на статью а не комментарий';


--
-- Name: hubs_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE hubs_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hubs_id OWNER TO openhabr;

--
-- Name: hubs; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE hubs (
    id bigint DEFAULT nextval('hubs_id'::regclass) NOT NULL,
    name character varying,
    title character varying
);


ALTER TABLE hubs OWNER TO openhabr;

--
-- Name: COLUMN hubs.name; Type: COMMENT; Schema: public; Owner: openhabr
--

COMMENT ON COLUMN hubs.name IS 'используется в урле';


--
-- Name: COLUMN hubs.title; Type: COMMENT; Schema: public; Owner: openhabr
--

COMMENT ON COLUMN hubs.title IS 'выводится в тексте';


--
-- Name: medals_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE medals_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE medals_id OWNER TO openhabr;

--
-- Name: medals; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE medals (
    id integer DEFAULT nextval('medals_id'::regclass) NOT NULL,
    title character varying NOT NULL,
    description character varying NOT NULL
);


ALTER TABLE medals OWNER TO openhabr;

--
-- Name: tags_id; Type: SEQUENCE; Schema: public; Owner: openhabr
--

CREATE SEQUENCE tags_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id OWNER TO openhabr;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: openhabr; Tablespace:
--

CREATE TABLE tags (
    id bigint DEFAULT nextval('tags_id'::regclass) NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE tags OWNER TO openhabr;

--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: hubs_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY hubs
    ADD CONSTRAINT hubs_pkey PRIMARY KEY (id);


--
-- Name: medals_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY medals
    ADD CONSTRAINT medals_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: openhabr; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: pgsql
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pgsql;
GRANT ALL ON SCHEMA public TO pgsql;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
