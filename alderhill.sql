--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: alanstirling
--

CREATE TABLE courses (
    id integer NOT NULL,
    name character varying,
    description text,
    qualification boolean DEFAULT false,
    level character varying,
    part_time boolean DEFAULT false,
    full_time boolean DEFAULT false,
    application_process text,
    progression text,
    course_content text,
    external_link character varying,
    cost double precision,
    duration character varying,
    qualification_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying
);


ALTER TABLE courses OWNER TO alanstirling;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: alanstirling
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE courses_id_seq OWNER TO alanstirling;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alanstirling
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: alanstirling
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);


ALTER TABLE friendly_id_slugs OWNER TO alanstirling;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: alanstirling
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE friendly_id_slugs_id_seq OWNER TO alanstirling;

--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alanstirling
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: alanstirling
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO alanstirling;

--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: alanstirling
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: alanstirling
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: alanstirling
--

COPY courses (id, name, description, qualification, level, part_time, full_time, application_process, progression, course_content, external_link, cost, duration, qualification_no, created_at, updated_at, slug) FROM stdin;
1	Level 3 Certificate in Web Design and Development (RQF) 	This qualification is designed to instruct how to manage a project that requires the creation of a website and provide the essential skills, knowledge and understanding to work on web development projects. From understanding a web browser and how the internet works to programming on a server to build functinal web applications. It also covers aspects such as web technologies, JavaScript, HTML, internet security and Cascading Style Sheets. It gives the learner an understanding of the jobs available and the work requirements of a web designer or developer. Participants may undergo assessment and have the opportunity to receive a Level 3 Certificate (RQF), which is an industry regulated qualification.	t	Level 3	t	t	There are no pre-requisites to applying for the course but an initial interview will be conducted to assess basic compitence in mathematics and english as well as general apptitude.	Progression could be to job roles or other ICT practitioner qualifications, the job roles could include web design engineer, web developer or webmaster, software developer.			1000	220 Hours	601/8498/X	2017-02-28 13:00:00	2017-02-28 16:33:20.841407	web-design-and-development
2	Level 2 Award in Principles of Digital Marketing Platforms (QCF)	This qualification is designed to support and help develop the knowledge of learners who may be professionals, starting up their own business or working for others in the use of digital marketing platforms. The learning covers the understanding required to use the correct platforms for the purpose of the marketing activity and the benefits of the different platforms used to help increase opportunities and marketing.	t	Level 2	t	f	There are no pre-requisites to applying for the course but a sufficient level of English and Maths is required to participate.				100		601/5979/0	2017-02-28 16:37:37.388171	2017-02-28 16:37:37.388171	digital-marketing
3	Building a Website	This course covers the essential skills required to understand how to create and maintain a website. HTML and CSS are the main languages used in developing web pages. This course uses these languages and other tools to create web pages with text, images, links, audio and much more. By the end of this course you will have fully function web site available online that you can add to and update when you want.	f		t	f	There are no pre-requisites to applying for the course but a sufficient level of English and Maths is required to participate. 		<table class="schedule">\r\n          <tbody><tr>\r\n            <th>Week 1</th>\r\n            <td>\r\n              <ul>\r\n                <li>Introduction to web pages</li>\r\n                <li>HTML5</li>\r\n                <li>HTML5 APIs</li>\r\n                <li>Your first web site</li>\r\n                <li>Testing a web page</li>\r\n              </ul>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n            <th>Week 2</th>\r\n            <td>\r\n              <ul>\r\n                <li>Introduction to stylesheets</li>\r\n                <li>CSS3</li>\r\n                <li>CSS design and layout</li>\r\n                <li>Design frameworks (Bootstrap)</li>\r\n              </ul>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n            <th>Week 3</th>\r\n            <td>\r\n              <ul>\r\n                <li>HTML and CSS Fast and Right</li>\r\n                <li>Validation</li>\r\n                <li>Using templates</li>\r\n                <li>Good practices</li>\r\n              </ul>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n            <th>Week 4</th>\r\n            <td>\r\n              <ul>\r\n                <li>Web site platforms and frameworks</li>\r\n                <li>Introduction to Wordpress</li>\r\n                <li>Introduction to Squarespace</li>\r\n              </ul>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n            <th>Week 5</th>\r\n            <td>\r\n              <ul>\r\n                <li>Managing a website project</li>\r\n                <li>Hosting a website</li>\r\n                <li>Deploying a website</li>\r\n                <li>Managing domain names</li>\r\n              </ul>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>		\N			2017-02-28 16:39:43.091972	2017-02-28 16:40:18.475006	building-a-website
4	Getting Started with Linux	This course is designed to give you a start in using open source software to programme and develop projects for use in real systems and processes. If you want to develop software or systems using open source software then you will probably have to use linux at some point. Getting to know the basics of linux and the software that is available on the linux operating system will give you the tools and knowledge you need to continue developing in an open source environment.	f		t	f	There are no pre-requisites to applying for the course but a sufficient level of English and Maths is required to participate.				\N			2017-02-28 16:41:17.587152	2017-02-28 16:41:17.587152	getting-started-with-linux
\.


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alanstirling
--

SELECT pg_catalog.setval('courses_id_seq', 4, true);


--
-- Data for Name: friendly_id_slugs; Type: TABLE DATA; Schema: public; Owner: alanstirling
--

COPY friendly_id_slugs (id, slug, sluggable_id, sluggable_type, scope, created_at) FROM stdin;
\.


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alanstirling
--

SELECT pg_catalog.setval('friendly_id_slugs_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: alanstirling
--

COPY schema_migrations (version) FROM stdin;
20170228125934
20170228140828
\.


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: alanstirling
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: alanstirling
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: alanstirling
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: alanstirling
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: alanstirling
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: alanstirling
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: alanstirling
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

