--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.6

-- Started on 2024-06-16 17:05:56

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 26649)
-- Name: ambulatorio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ambulatorio (
    id integer NOT NULL
);


ALTER TABLE public.ambulatorio OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 26669)
-- Name: ambulatorioesterno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ambulatorioesterno (
    idambulatorio integer NOT NULL,
    codiceospedale integer NOT NULL,
    indirizzo character varying(100) NOT NULL,
    nome character varying(50) NOT NULL,
    ntelefono character varying(15) NOT NULL
);


ALTER TABLE public.ambulatorioesterno OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 26654)
-- Name: ambulatoriointerno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ambulatoriointerno (
    idambulatorio integer NOT NULL,
    numerostanza integer NOT NULL,
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL,
    piano integer NOT NULL
);


ALTER TABLE public.ambulatoriointerno OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 26596)
-- Name: avvertenze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avvertenze (
    descrizione text NOT NULL
);


ALTER TABLE public.avvertenze OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 26569)
-- Name: esame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.esame (
    idesame integer NOT NULL,
    nome character varying(50) NOT NULL,
    descrizione text NOT NULL,
    specialistico character varying(50),
    costoprivato numeric(10,2) NOT NULL,
    costosanitario numeric(10,2) NOT NULL,
    CONSTRAINT esame_costoprivato_check CHECK ((costoprivato > (0)::numeric)),
    CONSTRAINT esame_costosanitario_check CHECK ((costosanitario > (0)::numeric))
);


ALTER TABLE public.esame OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 26792)
-- Name: ha_avvertenze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ha_avvertenze (
    idesame integer NOT NULL,
    descrizioneavvertenze text NOT NULL
);


ALTER TABLE public.ha_avvertenze OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 26777)
-- Name: ha_patologie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ha_patologie (
    nomepatologia character varying(50) NOT NULL,
    dataricovero date NOT NULL,
    cfricoverato character(16) NOT NULL
);


ALTER TABLE public.ha_patologie OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 26762)
-- Name: ha_specializzazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ha_specializzazione (
    nomespecializzazione character varying(50) NOT NULL,
    cfprimario character(16) NOT NULL
);


ALTER TABLE public.ha_specializzazione OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 26638)
-- Name: letto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.letto (
    codiceletto integer NOT NULL,
    numerostanza integer NOT NULL,
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL,
    stato boolean DEFAULT false NOT NULL
);


ALTER TABLE public.letto OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 26684)
-- Name: orarioesterno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orarioesterno (
    giorno character varying(10) NOT NULL,
    idambulatorio integer NOT NULL,
    oraapertura time without time zone NOT NULL,
    orachiusura time without time zone NOT NULL
);


ALTER TABLE public.orarioesterno OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 26542)
-- Name: orariovisitereparto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orariovisitereparto (
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL,
    giorno character varying(10) NOT NULL,
    orarioapertura time without time zone NOT NULL,
    orariochiusura time without time zone NOT NULL
);


ALTER TABLE public.orariovisitereparto OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 26513)
-- Name: ospedale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ospedale (
    codice integer NOT NULL,
    nome character varying(100) NOT NULL,
    indirizzo character varying(100) NOT NULL
);


ALTER TABLE public.ospedale OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 26757)
-- Name: patologia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patologia (
    nome character varying(50) NOT NULL
);


ALTER TABLE public.patologia OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 26564)
-- Name: paziente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paziente (
    cf character(16) NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    datanascita date NOT NULL
);


ALTER TABLE public.paziente OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 26552)
-- Name: personale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personale (
    cf character(16) NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    codiceospedale integer NOT NULL,
    nomereparto character varying(50) NOT NULL,
    anzianitaservizio integer DEFAULT 1,
    tipopersonale character varying(50) NOT NULL,
    CONSTRAINT personale_tipopersonale_check CHECK (((tipopersonale)::text = ANY ((ARRAY['personale medico'::character varying, 'infermiere'::character varying, 'personale amministrativo'::character varying])::text[])))
);


ALTER TABLE public.personale OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 26580)
-- Name: prenotazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prenotazione (
    cfpaziente character(16) NOT NULL,
    dataprenotazione date NOT NULL,
    idesame integer NOT NULL,
    urgenza character varying(100) NOT NULL,
    dataoraesame timestamp without time zone NOT NULL,
    CONSTRAINT prenotazione_urgenza_check CHECK (((urgenza)::text = ANY ((ARRAY['rosso'::character varying, 'giallo'::character varying, 'verde'::character varying])::text[])))
);


ALTER TABLE public.prenotazione OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 26694)
-- Name: primario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.primario (
    cfprimario character varying(16) NOT NULL,
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL
);


ALTER TABLE public.primario OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 26520)
-- Name: prontosoccorso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prontosoccorso (
    indirizzo character varying(100) NOT NULL,
    codiceospedale integer NOT NULL
);


ALTER TABLE public.prontosoccorso OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 26530)
-- Name: reparto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reparto (
    nome character varying(50) NOT NULL,
    codiceospedale integer NOT NULL,
    telefono character varying(15) NOT NULL
);


ALTER TABLE public.reparto OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 26746)
-- Name: ricoverato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ricoverato (
    cfpaziente character(16) NOT NULL,
    dataricovero date NOT NULL,
    datadimissione date,
    CONSTRAINT ricoverato_check CHECK ((datadimissione > dataricovero))
);


ALTER TABLE public.ricoverato OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 26618)
-- Name: salaoperatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaoperatoria (
    numerosala integer NOT NULL,
    codiceospedale integer NOT NULL,
    nomereparto character varying(50) NOT NULL
);


ALTER TABLE public.salaoperatoria OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 26731)
-- Name: sostituzione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sostituzione (
    cfprimario character(16) NOT NULL,
    cfviceprimario character(16) NOT NULL,
    datainizio date NOT NULL,
    datafine date NOT NULL
);


ALTER TABLE public.sostituzione OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 26711)
-- Name: specializzazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specializzazione (
    nome character varying(50) NOT NULL
);


ALTER TABLE public.specializzazione OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 26628)
-- Name: stanza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stanza (
    numero integer NOT NULL,
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL
);


ALTER TABLE public.stanza OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 26603)
-- Name: turnips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turnips (
    indirizzops character varying(100) NOT NULL,
    codiceospedale integer NOT NULL,
    cfpersonale character(16) NOT NULL,
    orainizio time without time zone NOT NULL,
    orafine time without time zone NOT NULL
);


ALTER TABLE public.turnips OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 26716)
-- Name: viceprimario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viceprimario (
    cfviceprimario character(16) NOT NULL,
    dataassunzione date NOT NULL,
    nomereparto character varying(50) NOT NULL,
    codiceospedale integer NOT NULL
);


ALTER TABLE public.viceprimario OWNER TO postgres;

--
-- TOC entry 3286 (class 2606 OID 26653)
-- Name: ambulatorio ambulatorio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatorio
    ADD CONSTRAINT ambulatorio_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 26673)
-- Name: ambulatorioesterno ambulatorioesterno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatorioesterno
    ADD CONSTRAINT ambulatorioesterno_pkey PRIMARY KEY (idambulatorio);


--
-- TOC entry 3288 (class 2606 OID 26658)
-- Name: ambulatoriointerno ambulatoriointerno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatoriointerno
    ADD CONSTRAINT ambulatoriointerno_pkey PRIMARY KEY (idambulatorio);


--
-- TOC entry 3276 (class 2606 OID 26602)
-- Name: avvertenze avvertenze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avvertenze
    ADD CONSTRAINT avvertenze_pkey PRIMARY KEY (descrizione);


--
-- TOC entry 3270 (class 2606 OID 26579)
-- Name: esame esame_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esame
    ADD CONSTRAINT esame_nome_key UNIQUE (nome);


--
-- TOC entry 3272 (class 2606 OID 26577)
-- Name: esame esame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.esame
    ADD CONSTRAINT esame_pkey PRIMARY KEY (idesame);


--
-- TOC entry 3312 (class 2606 OID 26798)
-- Name: ha_avvertenze ha_avvertenze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_avvertenze
    ADD CONSTRAINT ha_avvertenze_pkey PRIMARY KEY (idesame, descrizioneavvertenze);


--
-- TOC entry 3310 (class 2606 OID 26781)
-- Name: ha_patologie ha_patologie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_patologie
    ADD CONSTRAINT ha_patologie_pkey PRIMARY KEY (nomepatologia, cfricoverato, dataricovero);


--
-- TOC entry 3308 (class 2606 OID 26766)
-- Name: ha_specializzazione ha_specializzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_specializzazione
    ADD CONSTRAINT ha_specializzazione_pkey PRIMARY KEY (nomespecializzazione, cfprimario);


--
-- TOC entry 3284 (class 2606 OID 26643)
-- Name: letto letto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letto
    ADD CONSTRAINT letto_pkey PRIMARY KEY (codiceletto, numerostanza, nomereparto, codiceospedale);


--
-- TOC entry 3292 (class 2606 OID 26688)
-- Name: orarioesterno orarioesterno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orarioesterno
    ADD CONSTRAINT orarioesterno_pkey PRIMARY KEY (giorno, idambulatorio);


--
-- TOC entry 3264 (class 2606 OID 26546)
-- Name: orariovisitereparto orariovisitereparto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orariovisitereparto
    ADD CONSTRAINT orariovisitereparto_pkey PRIMARY KEY (nomereparto, codiceospedale, giorno);


--
-- TOC entry 3254 (class 2606 OID 26519)
-- Name: ospedale ospedale_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ospedale
    ADD CONSTRAINT ospedale_nome_key UNIQUE (nome);


--
-- TOC entry 3256 (class 2606 OID 26517)
-- Name: ospedale ospedale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ospedale
    ADD CONSTRAINT ospedale_pkey PRIMARY KEY (codice);


--
-- TOC entry 3306 (class 2606 OID 26761)
-- Name: patologia patologia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patologia
    ADD CONSTRAINT patologia_pkey PRIMARY KEY (nome);


--
-- TOC entry 3268 (class 2606 OID 26568)
-- Name: paziente paziente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paziente
    ADD CONSTRAINT paziente_pkey PRIMARY KEY (cf);


--
-- TOC entry 3266 (class 2606 OID 26558)
-- Name: personale personale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personale
    ADD CONSTRAINT personale_pkey PRIMARY KEY (cf);


--
-- TOC entry 3274 (class 2606 OID 26585)
-- Name: prenotazione prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_pkey PRIMARY KEY (cfpaziente, dataprenotazione, idesame);


--
-- TOC entry 3294 (class 2606 OID 26698)
-- Name: primario primario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_pkey PRIMARY KEY (cfprimario);


--
-- TOC entry 3258 (class 2606 OID 26524)
-- Name: prontosoccorso prontosoccorso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prontosoccorso
    ADD CONSTRAINT prontosoccorso_pkey PRIMARY KEY (indirizzo, codiceospedale);


--
-- TOC entry 3296 (class 2606 OID 26700)
-- Name: primario reparto_ospedale; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT reparto_ospedale UNIQUE (nomereparto, codiceospedale);


--
-- TOC entry 3260 (class 2606 OID 26534)
-- Name: reparto reparto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reparto
    ADD CONSTRAINT reparto_pkey PRIMARY KEY (nome, codiceospedale);


--
-- TOC entry 3262 (class 2606 OID 26536)
-- Name: reparto reparto_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reparto
    ADD CONSTRAINT reparto_telefono_key UNIQUE (telefono);


--
-- TOC entry 3304 (class 2606 OID 26751)
-- Name: ricoverato ricoverato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ricoverato
    ADD CONSTRAINT ricoverato_pkey PRIMARY KEY (cfpaziente, dataricovero);


--
-- TOC entry 3280 (class 2606 OID 26622)
-- Name: salaoperatoria salaoperatoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaoperatoria
    ADD CONSTRAINT salaoperatoria_pkey PRIMARY KEY (numerosala, codiceospedale);


--
-- TOC entry 3302 (class 2606 OID 26735)
-- Name: sostituzione sostituzione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_pkey PRIMARY KEY (cfprimario, cfviceprimario, datainizio);


--
-- TOC entry 3298 (class 2606 OID 26715)
-- Name: specializzazione specializzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specializzazione
    ADD CONSTRAINT specializzazione_pkey PRIMARY KEY (nome);


--
-- TOC entry 3282 (class 2606 OID 26632)
-- Name: stanza stanza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stanza
    ADD CONSTRAINT stanza_pkey PRIMARY KEY (numero, nomereparto, codiceospedale);


--
-- TOC entry 3278 (class 2606 OID 26607)
-- Name: turnips turnips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnips
    ADD CONSTRAINT turnips_pkey PRIMARY KEY (indirizzops, codiceospedale, orainizio, cfpersonale);


--
-- TOC entry 3300 (class 2606 OID 26720)
-- Name: viceprimario viceprimario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_pkey PRIMARY KEY (cfviceprimario);


--
-- TOC entry 3326 (class 2606 OID 26674)
-- Name: ambulatorioesterno ambulatorioesterno_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatorioesterno
    ADD CONSTRAINT ambulatorioesterno_codiceospedale_fkey FOREIGN KEY (codiceospedale) REFERENCES public.ospedale(codice) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3327 (class 2606 OID 26679)
-- Name: ambulatorioesterno ambulatorioesterno_idambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatorioesterno
    ADD CONSTRAINT ambulatorioesterno_idambulatorio_fkey FOREIGN KEY (idambulatorio) REFERENCES public.ambulatorio(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3324 (class 2606 OID 26664)
-- Name: ambulatoriointerno ambulatoriointerno_idambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatoriointerno
    ADD CONSTRAINT ambulatoriointerno_idambulatorio_fkey FOREIGN KEY (idambulatorio) REFERENCES public.ambulatorio(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3325 (class 2606 OID 26659)
-- Name: ambulatoriointerno ambulatoriointerno_numerostanza_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambulatoriointerno
    ADD CONSTRAINT ambulatoriointerno_numerostanza_nomereparto_codiceospedale_fkey FOREIGN KEY (numerostanza, nomereparto, codiceospedale) REFERENCES public.stanza(numero, nomereparto, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3340 (class 2606 OID 26804)
-- Name: ha_avvertenze ha_avvertenze_descrizioneavvertenze_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_avvertenze
    ADD CONSTRAINT ha_avvertenze_descrizioneavvertenze_fkey FOREIGN KEY (descrizioneavvertenze) REFERENCES public.avvertenze(descrizione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3341 (class 2606 OID 26799)
-- Name: ha_avvertenze ha_avvertenze_idesame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_avvertenze
    ADD CONSTRAINT ha_avvertenze_idesame_fkey FOREIGN KEY (idesame) REFERENCES public.esame(idesame) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3338 (class 2606 OID 26782)
-- Name: ha_patologie ha_patologie_cfricoverato_dataricovero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_patologie
    ADD CONSTRAINT ha_patologie_cfricoverato_dataricovero_fkey FOREIGN KEY (cfricoverato, dataricovero) REFERENCES public.ricoverato(cfpaziente, dataricovero) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3339 (class 2606 OID 26787)
-- Name: ha_patologie ha_patologie_nomepatologia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_patologie
    ADD CONSTRAINT ha_patologie_nomepatologia_fkey FOREIGN KEY (nomepatologia) REFERENCES public.patologia(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3336 (class 2606 OID 26767)
-- Name: ha_specializzazione ha_specializzazione_cfprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_specializzazione
    ADD CONSTRAINT ha_specializzazione_cfprimario_fkey FOREIGN KEY (cfprimario) REFERENCES public.primario(cfprimario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3337 (class 2606 OID 26772)
-- Name: ha_specializzazione ha_specializzazione_nomespecializzazione_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ha_specializzazione
    ADD CONSTRAINT ha_specializzazione_nomespecializzazione_fkey FOREIGN KEY (nomespecializzazione) REFERENCES public.specializzazione(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3323 (class 2606 OID 26644)
-- Name: letto letto_numerostanza_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letto
    ADD CONSTRAINT letto_numerostanza_nomereparto_codiceospedale_fkey FOREIGN KEY (numerostanza, nomereparto, codiceospedale) REFERENCES public.stanza(numero, nomereparto, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3328 (class 2606 OID 26689)
-- Name: orarioesterno orarioesterno_idambulatorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orarioesterno
    ADD CONSTRAINT orarioesterno_idambulatorio_fkey FOREIGN KEY (idambulatorio) REFERENCES public.ambulatorioesterno(idambulatorio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3315 (class 2606 OID 26547)
-- Name: orariovisitereparto orariovisitereparto_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orariovisitereparto
    ADD CONSTRAINT orariovisitereparto_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3316 (class 2606 OID 26559)
-- Name: personale personale_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personale
    ADD CONSTRAINT personale_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3317 (class 2606 OID 26586)
-- Name: prenotazione prenotazione_cfpaziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_cfpaziente_fkey FOREIGN KEY (cfpaziente) REFERENCES public.paziente(cf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3318 (class 2606 OID 26591)
-- Name: prenotazione prenotazione_idesame_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_idesame_fkey FOREIGN KEY (idesame) REFERENCES public.esame(idesame) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3329 (class 2606 OID 26701)
-- Name: primario primario_cfprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_cfprimario_fkey FOREIGN KEY (cfprimario) REFERENCES public.personale(cf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3330 (class 2606 OID 26706)
-- Name: primario primario_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primario
    ADD CONSTRAINT primario_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3313 (class 2606 OID 26525)
-- Name: prontosoccorso prontosoccorso_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prontosoccorso
    ADD CONSTRAINT prontosoccorso_codiceospedale_fkey FOREIGN KEY (codiceospedale) REFERENCES public.ospedale(codice) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3314 (class 2606 OID 26537)
-- Name: reparto reparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reparto
    ADD CONSTRAINT reparto_codiceospedale_fkey FOREIGN KEY (codiceospedale) REFERENCES public.ospedale(codice) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3335 (class 2606 OID 26752)
-- Name: ricoverato ricoverato_cfpaziente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ricoverato
    ADD CONSTRAINT ricoverato_cfpaziente_fkey FOREIGN KEY (cfpaziente) REFERENCES public.paziente(cf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3321 (class 2606 OID 26623)
-- Name: salaoperatoria salaoperatoria_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaoperatoria
    ADD CONSTRAINT salaoperatoria_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3333 (class 2606 OID 26736)
-- Name: sostituzione sostituzione_cfprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_cfprimario_fkey FOREIGN KEY (cfprimario) REFERENCES public.primario(cfprimario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3334 (class 2606 OID 26741)
-- Name: sostituzione sostituzione_cfviceprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sostituzione
    ADD CONSTRAINT sostituzione_cfviceprimario_fkey FOREIGN KEY (cfviceprimario) REFERENCES public.viceprimario(cfviceprimario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3322 (class 2606 OID 26633)
-- Name: stanza stanza_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stanza
    ADD CONSTRAINT stanza_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3319 (class 2606 OID 26613)
-- Name: turnips turnips_cfpersonale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnips
    ADD CONSTRAINT turnips_cfpersonale_fkey FOREIGN KEY (cfpersonale) REFERENCES public.personale(cf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3320 (class 2606 OID 26608)
-- Name: turnips turnips_indirizzops_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnips
    ADD CONSTRAINT turnips_indirizzops_codiceospedale_fkey FOREIGN KEY (indirizzops, codiceospedale) REFERENCES public.prontosoccorso(indirizzo, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3331 (class 2606 OID 26721)
-- Name: viceprimario viceprimario_cfviceprimario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_cfviceprimario_fkey FOREIGN KEY (cfviceprimario) REFERENCES public.personale(cf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3332 (class 2606 OID 26726)
-- Name: viceprimario viceprimario_nomereparto_codiceospedale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viceprimario
    ADD CONSTRAINT viceprimario_nomereparto_codiceospedale_fkey FOREIGN KEY (nomereparto, codiceospedale) REFERENCES public.reparto(nome, codiceospedale) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-06-16 17:05:56

--
-- PostgreSQL database dump complete
--

