--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_foreground_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_background_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_project_logo_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_sessions DROP CONSTRAINT IF EXISTS directus_sessions_user_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_parent_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_activity_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_user_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_permissions DROP CONSTRAINT IF EXISTS directus_permissions_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_folders DROP CONSTRAINT IF EXISTS directus_folders_parent_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_uploaded_by_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_modified_by_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_folder_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_fields DROP CONSTRAINT IF EXISTS directus_fields_group_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_webhooks DROP CONSTRAINT IF EXISTS directus_webhooks_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_email_unique;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_sessions DROP CONSTRAINT IF EXISTS directus_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_roles DROP CONSTRAINT IF EXISTS directus_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_relations DROP CONSTRAINT IF EXISTS directus_relations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_permissions DROP CONSTRAINT IF EXISTS directus_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_migrations DROP CONSTRAINT IF EXISTS directus_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_folders DROP CONSTRAINT IF EXISTS directus_folders_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_fields DROP CONSTRAINT IF EXISTS directus_fields_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_collections DROP CONSTRAINT IF EXISTS directus_collections_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_activity DROP CONSTRAINT IF EXISTS directus_activity_pkey;
ALTER TABLE IF EXISTS public.directus_webhooks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_revisions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_relations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_presets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_fields ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_activity ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.directus_webhooks_id_seq;
DROP TABLE IF EXISTS public.directus_webhooks;
DROP TABLE IF EXISTS public.directus_users;
DROP SEQUENCE IF EXISTS public.directus_settings_id_seq;
DROP TABLE IF EXISTS public.directus_settings;
DROP TABLE IF EXISTS public.directus_sessions;
DROP TABLE IF EXISTS public.directus_roles;
DROP SEQUENCE IF EXISTS public.directus_revisions_id_seq;
DROP TABLE IF EXISTS public.directus_revisions;
DROP SEQUENCE IF EXISTS public.directus_relations_id_seq;
DROP TABLE IF EXISTS public.directus_relations;
DROP SEQUENCE IF EXISTS public.directus_presets_id_seq;
DROP TABLE IF EXISTS public.directus_presets;
DROP SEQUENCE IF EXISTS public.directus_permissions_id_seq;
DROP TABLE IF EXISTS public.directus_permissions;
DROP TABLE IF EXISTS public.directus_migrations;
DROP TABLE IF EXISTS public.directus_folders;
DROP TABLE IF EXISTS public.directus_files;
DROP SEQUENCE IF EXISTS public.directus_fields_id_seq;
DROP TABLE IF EXISTS public.directus_fields;
DROP TABLE IF EXISTS public.directus_collections;
DROP SEQUENCE IF EXISTS public.directus_activity_id_seq;
DROP TABLE IF EXISTS public.directus_activity;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO enflujo;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO enflujo;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying
);


ALTER TABLE public.directus_collections OWNER TO enflujo;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


ALTER TABLE public.directus_fields OWNER TO enflujo;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO enflujo;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize integer,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO enflujo;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO enflujo;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO enflujo;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


ALTER TABLE public.directus_permissions OWNER TO enflujo;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO enflujo;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer
);


ALTER TABLE public.directus_presets OWNER TO enflujo;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO enflujo;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    many_primary character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_primary character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(255)
);


ALTER TABLE public.directus_relations OWNER TO enflujo;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO enflujo;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO enflujo;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO enflujo;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO enflujo;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO enflujo;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


ALTER TABLE public.directus_settings OWNER TO enflujo;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO enflujo;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


ALTER TABLE public.directus_users OWNER TO enflujo;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: enflujo
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text
);


ALTER TABLE public.directus_webhooks OWNER TO enflujo;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: enflujo
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO enflujo;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: enflujo
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (1, 'authenticate', 'f39224e0-02c9-4a80-9f1c-66d84054187c', '2021-04-25 22:41:04.877543+00', '::ffff:172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_users', 'f39224e0-02c9-4a80-9f1c-66d84054187c', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (2, 'create', 'f39224e0-02c9-4a80-9f1c-66d84054187c', '2021-04-25 22:41:34.301879+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_settings', '1', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (3, 'authenticate', '3dc5402e-1285-49d0-bdaf-d1b9337deb06', '2021-04-25 23:03:27.74155+00', '::ffff:172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_users', '3dc5402e-1285-49d0-bdaf-d1b9337deb06', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (4, 'update', '3dc5402e-1285-49d0-bdaf-d1b9337deb06', '2021-04-25 23:03:38.040565+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_settings', '1', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (5, 'authenticate', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:30:45.183459+00', '::ffff:172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_users', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (6, 'create', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:32:00.621176+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_files', '73f63da8-453b-4db1-b4e3-c1f5da609f8f', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (7, 'create', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:32:41.367338+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_files', '9c2ef055-a691-477e-9584-9396ba1fa5a4', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (8, 'create', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:33:15.755137+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_files', 'ef886404-a66d-43e6-aa05-5e1071f1f159', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) VALUES (9, 'update', 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:33:55.14494+00', '172.30.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'directus_settings', '1', NULL) ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) VALUES ('73f63da8-453b-4db1-b4e3-c1f5da609f8f', 'local', '73f63da8-453b-4db1-b4e3-c1f5da609f8f.svg', 'enflujo-logo-nombre-grande.svg', 'Enflujo Logo Nombre Grande', 'image/svg+xml', NULL, 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:32:00.621176+00', NULL, '2021-04-25 23:32:00.642+00', NULL, 28556, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) VALUES ('9c2ef055-a691-477e-9584-9396ba1fa5a4', 'local', '9c2ef055-a691-477e-9584-9396ba1fa5a4.png', 'fondo@2x.png', 'Fondo@2x', 'image/png', NULL, 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:32:41.367338+00', NULL, '2021-04-25 23:32:41.43+00', NULL, 1448970, 3840, 2160, NULL, NULL, NULL, NULL, NULL, '{}') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) VALUES ('ef886404-a66d-43e6-aa05-5e1071f1f159', 'local', 'ef886404-a66d-43e6-aa05-5e1071f1f159.svg', 'enflujo-icono.svg', 'Enflujo Icono', 'image/svg+xml', NULL, 'b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', '2021-04-25 23:33:15.755137+00', NULL, '2021-04-25 23:33:15.769+00', NULL, 2362, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201028A', 'Remove Collection Foreign Keys', '2021-04-25 23:04:38.12039+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029A', 'Remove System Relations', '2021-04-25 23:04:38.135492+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029B', 'Remove System Collections', '2021-04-25 23:04:38.140946+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029C', 'Remove System Fields', '2021-04-25 23:04:38.148936+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201105A', 'Add Cascade System Relations', '2021-04-25 23:04:38.217552+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201105B', 'Change Webhook URL Type', '2021-04-25 23:04:38.222417+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210225A', 'Add Relations Sort Field', '2021-04-25 23:04:38.226424+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210304A', 'Remove Locked Fields', '2021-04-25 23:04:38.23041+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210312A', 'Webhooks Collections Text', '2021-04-25 23:04:38.235036+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210331A', 'Add Refresh Interval', '2021-04-25 23:04:38.237836+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210415A', 'Make Filesize Nullable', '2021-04-25 23:04:38.244553+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210416A', 'Add Collections Accountability', '2021-04-25 23:04:38.249334+00') ON CONFLICT DO NOTHING;
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210422A', 'Remove Files Interface', '2021-04-25 23:04:38.253112+00') ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) VALUES ('b25c2477-e4da-423e-a598-139e55c2d303', 'Admin', 'supervised_user_circle', NULL, NULL, false, NULL, NULL, true, true) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) VALUES ('5e39c57a-6f90-4c9b-a7f9-890f45ea618f', 'Admin', 'supervised_user_circle', NULL, NULL, false, NULL, NULL, true, true) ON CONFLICT DO NOTHING;
INSERT INTO public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) VALUES ('1ca2d3f5-17ad-46b9-8482-ffa294e8101a', 'Admin', 'supervised_user_circle', NULL, NULL, false, NULL, NULL, true, true) ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) VALUES (1, 'Laboratorio Enflujo', 'http://enflujo.uniandes.edu.co', '#5757F7', 'ef886404-a66d-43e6-aa05-5e1071f1f159', '73f63da8-453b-4db1-b4e3-c1f5da609f8f', '9c2ef055-a691-477e-9584-9396ba1fa5a4', NULL, 25, NULL, 'all', NULL, NULL) ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: enflujo
--

INSERT INTO public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) VALUES ('b30a85be-d0dc-4f84-a3a2-dc4475c9fe17', NULL, NULL, 'admin@admin.com', '$argon2i$v=19$m=4096,t=3,p=1$buN4WVQ1eS5aTBmDoZVpIg$IOsTLAMSpnVm6pvDmj4K4vq45ZR01MJIVchpXPJ5ArM', NULL, NULL, NULL, NULL, NULL, 'en-US', 'auto', NULL, 'active', 'b25c2477-e4da-423e-a598-139e55c2d303', NULL, '2021-04-25 23:34:02.364+00', '/files/') ON CONFLICT DO NOTHING;


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: enflujo
--



--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 9, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 1, false);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: enflujo
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id);


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id);


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id);


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: enflujo
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- PostgreSQL database dump complete
--

