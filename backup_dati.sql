--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.6

-- Started on 2024-06-16 17:10:27

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

--
-- TOC entry 3490 (class 0 OID 26649)
-- Dependencies: 227
-- Data for Name: ambulatorio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ambulatorio VALUES (33);
INSERT INTO public.ambulatorio VALUES (22);
INSERT INTO public.ambulatorio VALUES (66);
INSERT INTO public.ambulatorio VALUES (55);


--
-- TOC entry 3477 (class 0 OID 26513)
-- Dependencies: 214
-- Data for Name: ospedale; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ospedale VALUES (1, 'Ospedale Maggiore', 'Via Roma 1');
INSERT INTO public.ospedale VALUES (2, 'Ospedale San Raffaele', 'Piazza Dante 2');
INSERT INTO public.ospedale VALUES (3, 'Ospedale Santa Maria', 'Corso Umberto 3');
INSERT INTO public.ospedale VALUES (4, 'Ospedale Nuovo', 'Via Milano 4');


--
-- TOC entry 3492 (class 0 OID 26669)
-- Dependencies: 229
-- Data for Name: ambulatorioesterno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ambulatorioesterno VALUES (66, 1, 'Via Pirelli 2', 'Ambulatorio Agostino', '2567543669');
INSERT INTO public.ambulatorioesterno VALUES (55, 2, 'Viale Argonne 33', 'Take Care', '6754389007');


--
-- TOC entry 3479 (class 0 OID 26530)
-- Dependencies: 216
-- Data for Name: reparto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reparto VALUES ('Cardiologia', 1, '1234567890');
INSERT INTO public.reparto VALUES ('Ortopedia', 1, '2345678901');
INSERT INTO public.reparto VALUES ('Medicina Generale', 2, '3456789012');
INSERT INTO public.reparto VALUES ('Pediatria', 3, '4567890123');
INSERT INTO public.reparto VALUES ('Cardiologia', 2, '1234567898');
INSERT INTO public.reparto VALUES ('Ortopedia', 2, '1234547898');
INSERT INTO public.reparto VALUES ('Medicina Generale', 3, '1234557898');
INSERT INTO public.reparto VALUES ('Cardiologia', 4, '12345447898');
INSERT INTO public.reparto VALUES ('Medicina Generale', 1, '33335447898');
INSERT INTO public.reparto VALUES ('Ortopedia', 4, '33435457898');
INSERT INTO public.reparto VALUES ('Pediatria', 1, '33439457898');
INSERT INTO public.reparto VALUES ('Pediatria', 2, '3564728988');
INSERT INTO public.reparto VALUES ('Chirurgia', 1, '3563763212');
INSERT INTO public.reparto VALUES ('Chirurgia', 2, '5367876532');
INSERT INTO public.reparto VALUES ('Chirurgia', 3, '4568790876');
INSERT INTO public.reparto VALUES ('Chirurgia', 4, '5563254789');
INSERT INTO public.reparto VALUES ('Clinica pediatrica', 1, '4589623578');
INSERT INTO public.reparto VALUES ('Clinica pediatrica', 2, '7845216598');
INSERT INTO public.reparto VALUES ('Clinica pediatrica', 3, '7852369548');
INSERT INTO public.reparto VALUES ('Neurologia', 1, '1259642359');
INSERT INTO public.reparto VALUES ('Neurologia', 4, '8956241573');
INSERT INTO public.reparto VALUES ('Oculistica', 1, '3456789123');
INSERT INTO public.reparto VALUES ('Oculistica', 2, '7842659562');
INSERT INTO public.reparto VALUES ('Virologia', 4, '3265984157');


--
-- TOC entry 3488 (class 0 OID 26628)
-- Dependencies: 225
-- Data for Name: stanza; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stanza VALUES (11, 'Cardiologia', 1);
INSERT INTO public.stanza VALUES (21, 'Ortopedia', 1);
INSERT INTO public.stanza VALUES (32, 'Medicina Generale', 2);
INSERT INTO public.stanza VALUES (43, 'Pediatria', 3);


--
-- TOC entry 3491 (class 0 OID 26654)
-- Dependencies: 228
-- Data for Name: ambulatoriointerno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ambulatoriointerno VALUES (33, 32, 'Medicina Generale', 2, 3);
INSERT INTO public.ambulatoriointerno VALUES (22, 43, 'Pediatria', 3, 4);


--
-- TOC entry 3485 (class 0 OID 26596)
-- Dependencies: 222
-- Data for Name: avvertenze; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.avvertenze VALUES ('Bere molta acqua');
INSERT INTO public.avvertenze VALUES ('Non assumere farmaci');
INSERT INTO public.avvertenze VALUES ('Riposo totale');
INSERT INTO public.avvertenze VALUES ('Togliere gioielli, piercing, occhiali, orologi');
INSERT INTO public.avvertenze VALUES ('Digiuno almeno 6 ore prima');
INSERT INTO public.avvertenze VALUES ('Attenzione all''alimentazione');
INSERT INTO public.avvertenze VALUES ('Non fumare nelle 3 ore precedenti');
INSERT INTO public.avvertenze VALUES ('Non effettuare durante il ciclo mestruale');


--
-- TOC entry 3483 (class 0 OID 26569)
-- Dependencies: 220
-- Data for Name: esame; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.esame VALUES (1, 'Risonanza Magnetica', 'Esame di risonanza magnetica', 'Sì', 200.00, 150.00);
INSERT INTO public.esame VALUES (2, 'Intolleranze Alimentari', 'Prove Allergiche', 'Sì', 80.00, 50.00);
INSERT INTO public.esame VALUES (3, 'Ecografia', 'Esame ecografico', 'No', 100.00, 80.00);
INSERT INTO public.esame VALUES (4, 'Mammografia', 'Esame della mammella', 'No', 150.00, 100.00);
INSERT INTO public.esame VALUES (5, 'Glicemia', 'Esame del Sangue', 'no', 80.00, 50.00);
INSERT INTO public.esame VALUES (6, 'Urinocoltura', 'Esame delle Urine', 'si', 70.00, 40.00);
INSERT INTO public.esame VALUES (7, 'Radiografia', ' Esame Radiologici', 'si', 120.00, 100.00);
INSERT INTO public.esame VALUES (8, 'Gastroscopia', 'Esame Endoscopico', 'si', 150.00, 100.00);
INSERT INTO public.esame VALUES (9, 'Prova da sforzo', 'Esame Cardiologico', 'no', 80.00, 50.00);
INSERT INTO public.esame VALUES (10, 'Pap test', 'Esame Ginecologico', 'si', 120.00, 100.00);


--
-- TOC entry 3502 (class 0 OID 26792)
-- Dependencies: 239
-- Data for Name: ha_avvertenze; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ha_avvertenze VALUES (1, 'Togliere gioielli, piercing, occhiali, orologi');
INSERT INTO public.ha_avvertenze VALUES (6, 'Attenzione all''alimentazione');
INSERT INTO public.ha_avvertenze VALUES (8, 'Digiuno almeno 6 ore prima');
INSERT INTO public.ha_avvertenze VALUES (9, 'Non fumare nelle 3 ore precedenti');
INSERT INTO public.ha_avvertenze VALUES (10, 'Non effettuare durante il ciclo mestruale');


--
-- TOC entry 3499 (class 0 OID 26757)
-- Dependencies: 236
-- Data for Name: patologia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patologia VALUES ('Diabete');
INSERT INTO public.patologia VALUES ('Ipertensione');
INSERT INTO public.patologia VALUES ('Asma');
INSERT INTO public.patologia VALUES ('Gastrite');
INSERT INTO public.patologia VALUES ('Aritmie ');
INSERT INTO public.patologia VALUES ('Aterosclerosi');
INSERT INTO public.patologia VALUES ('Epatite ');
INSERT INTO public.patologia VALUES ('Alzheimer');
INSERT INTO public.patologia VALUES ('Morbo di Parkinson');
INSERT INTO public.patologia VALUES ('Emicrania');
INSERT INTO public.patologia VALUES ('Osteoporosi');
INSERT INTO public.patologia VALUES ('Leucemia');
INSERT INTO public.patologia VALUES ('Malaria');
INSERT INTO public.patologia VALUES ('Vitiligine');


--
-- TOC entry 3482 (class 0 OID 26564)
-- Dependencies: 219
-- Data for Name: paziente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paziente VALUES ('MNDRNT79C03D086D', 'Renato', 'Amendola', '1979-04-04');
INSERT INTO public.paziente VALUES ('BRGMRA72C41M558U', 'Maria', 'Borghese', '1976-04-30');
INSERT INTO public.paziente VALUES ('BRNVCN71E13C352A', 'Vincenzo', 'Bruni', '1985-01-24');
INSERT INTO public.paziente VALUES ('DGRMRA80D03M208G', 'Mario', 'Gori', '1908-04-11');
INSERT INTO public.paziente VALUES ('LBLMHL87M17F537T', 'Nicole', 'Labio', '2004-05-28');
INSERT INTO public.paziente VALUES ('PRNGPP79A07H224B', 'Giovanna', 'Princi', '1985-01-03');
INSERT INTO public.paziente VALUES ('SCRVRN79L09D122V', 'Valeria', 'Salvo', '2000-03-22');


--
-- TOC entry 3498 (class 0 OID 26746)
-- Dependencies: 235
-- Data for Name: ricoverato; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ricoverato VALUES ('MNDRNT79C03D086D', '2012-03-03', '2012-04-03');
INSERT INTO public.ricoverato VALUES ('BRNVCN71E13C352A', '2012-12-06', '2013-01-10');
INSERT INTO public.ricoverato VALUES ('LBLMHL87M17F537T', '2024-05-12', '2024-06-12');


--
-- TOC entry 3501 (class 0 OID 26777)
-- Dependencies: 238
-- Data for Name: ha_patologie; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ha_patologie VALUES ('Vitiligine', '2024-05-12', 'LBLMHL87M17F537T');
INSERT INTO public.ha_patologie VALUES ('Malaria', '2012-03-03', 'MNDRNT79C03D086D');


--
-- TOC entry 3481 (class 0 OID 26552)
-- Dependencies: 218
-- Data for Name: personale; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personale VALUES ('RSSMRA85M01H501Z', 'Mario', 'Rossi', 1, 'Cardiologia', 10, 'personale medico');
INSERT INTO public.personale VALUES ('BNCLRA75H01H501K', 'Laura', 'Bianchi', 2, 'Medicina Generale', 15, 'personale amministrativo');
INSERT INTO public.personale VALUES ('FBRGNN80J20H501L', 'Gianna', 'Fabri', 3, 'Pediatria', 8, 'personale medico');
INSERT INTO public.personale VALUES ('PLRNTN75A10H502M', 'Antonio', 'Pellerano', 2, 'Cardiologia', 12, 'personale medico');
INSERT INTO public.personale VALUES ('FRSGLD85B15H502N', 'Gilda', 'Ferrari', 2, 'Ortopedia', 6, 'infermiere');
INSERT INTO public.personale VALUES ('DSMMLA82C02H503O', 'Lara', 'Desantis', 3, 'Medicina Generale', 20, 'personale amministrativo');
INSERT INTO public.personale VALUES ('GRNDSF75D03H503P', 'Fabio', 'Grandi', 3, 'Pediatria', 5, 'personale medico');
INSERT INTO public.personale VALUES ('SMLNCL80E04H504Q', 'Claudia', 'Salmi', 4, 'Cardiologia', 8, 'personale medico');
INSERT INTO public.personale VALUES ('VRLMRA88F05H504R', 'Marco', 'Verdi', 4, 'Ortopedia', 4, 'infermiere');
INSERT INTO public.personale VALUES ('PLRNTN79G06H501S', 'Nadia', 'Palladino', 1, 'Medicina Generale', 18, 'personale amministrativo');
INSERT INTO public.personale VALUES ('CRNTNI84H07H501T', 'Nico', 'Carotti', 1, 'Pediatria', 10, 'personale medico');
INSERT INTO public.personale VALUES ('RLLOTIH27EGD67W2', 'Tito', 'Rullo', 3, 'Pediatria', 12, 'personale medico');
INSERT INTO public.personale VALUES ('GTFDEYVL89G56FED', 'GIULIA', 'SARTI', 3, 'Medicina Generale', 22, 'personale medico');
INSERT INTO public.personale VALUES ('GFDEEUNG6IU70IJ7', 'Letizia', 'Di Gio', 2, 'Cardiologia', 12, 'personale medico');


--
-- TOC entry 3494 (class 0 OID 26694)
-- Dependencies: 231
-- Data for Name: primario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.primario VALUES ('FBRGNN80J20H501L', 'Pediatria', 3);
INSERT INTO public.primario VALUES ('PLRNTN75A10H502M', 'Cardiologia', 2);
INSERT INTO public.primario VALUES ('GTFDEYVL89G56FED', 'Medicina Generale', 3);


--
-- TOC entry 3495 (class 0 OID 26711)
-- Dependencies: 232
-- Data for Name: specializzazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.specializzazione VALUES ('Cardiologia');
INSERT INTO public.specializzazione VALUES ('Ortopedia');
INSERT INTO public.specializzazione VALUES ('Medicina Generale');
INSERT INTO public.specializzazione VALUES ('Pediatria');
INSERT INTO public.specializzazione VALUES ('Chirurgia');
INSERT INTO public.specializzazione VALUES ('Neurochirurgia');
INSERT INTO public.specializzazione VALUES ('Medicina del lavoro');
INSERT INTO public.specializzazione VALUES ('Ginecologia');


--
-- TOC entry 3500 (class 0 OID 26762)
-- Dependencies: 237
-- Data for Name: ha_specializzazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ha_specializzazione VALUES ('Pediatria', 'FBRGNN80J20H501L');
INSERT INTO public.ha_specializzazione VALUES ('Cardiologia', 'PLRNTN75A10H502M');
INSERT INTO public.ha_specializzazione VALUES ('Medicina Generale', 'GTFDEYVL89G56FED');
INSERT INTO public.ha_specializzazione VALUES ('Medicina del lavoro', 'FBRGNN80J20H501L');


--
-- TOC entry 3489 (class 0 OID 26638)
-- Dependencies: 226
-- Data for Name: letto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.letto VALUES (1, 11, 'Cardiologia', 1, true);
INSERT INTO public.letto VALUES (2, 21, 'Ortopedia', 1, false);
INSERT INTO public.letto VALUES (3, 32, 'Medicina Generale', 2, true);


--
-- TOC entry 3493 (class 0 OID 26684)
-- Dependencies: 230
-- Data for Name: orarioesterno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orarioesterno VALUES ('Lunedi', 55, '08:00:00', '12:00:00');
INSERT INTO public.orarioesterno VALUES ('Martedi', 66, '07:30:00', '12:00:00');
INSERT INTO public.orarioesterno VALUES ('Martedi', 55, '08:00:00', '12:00:00');


--
-- TOC entry 3480 (class 0 OID 26542)
-- Dependencies: 217
-- Data for Name: orariovisitereparto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orariovisitereparto VALUES ('Cardiologia', 1, 'Lunedì', '09:00:00', '12:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Ortopedia', 1, 'Martedì', '10:00:00', '13:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Medicina Generale', 2, 'Mercoledì', '11:00:00', '14:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Pediatria', 3, 'Giovedì', '09:30:00', '12:30:00');
INSERT INTO public.orariovisitereparto VALUES ('Cardiologia', 2, 'Venerdì', '08:30:00', '11:30:00');
INSERT INTO public.orariovisitereparto VALUES ('Ortopedia', 2, 'Sabato', '09:00:00', '12:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Medicina Generale', 3, 'Domenica', '10:00:00', '13:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Cardiologia', 4, 'Lunedì', '11:00:00', '14:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Medicina Generale', 1, 'Martedì', '08:00:00', '11:00:00');
INSERT INTO public.orariovisitereparto VALUES ('Ortopedia', 4, 'Mercoledì', '09:30:00', '12:30:00');
INSERT INTO public.orariovisitereparto VALUES ('Pediatria', 1, 'Giovedì', '10:30:00', '13:30:00');


--
-- TOC entry 3484 (class 0 OID 26580)
-- Dependencies: 221
-- Data for Name: prenotazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prenotazione VALUES ('BRNVCN71E13C352A', '2022-08-07', 4, 'giallo', '2023-09-04 10:00:00');
INSERT INTO public.prenotazione VALUES ('BRNVCN71E13C352A', '2022-08-12', 4, 'giallo', '2022-09-04 10:00:00');
INSERT INTO public.prenotazione VALUES ('LBLMHL87M17F537T', '2024-03-23', 10, 'verde', '2024-09-04 10:00:00');


--
-- TOC entry 3478 (class 0 OID 26520)
-- Dependencies: 215
-- Data for Name: prontosoccorso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prontosoccorso VALUES ('Via Roma 1', 1);
INSERT INTO public.prontosoccorso VALUES ('Piazza Dante 2', 2);
INSERT INTO public.prontosoccorso VALUES ('Corso Umberto 3', 3);
INSERT INTO public.prontosoccorso VALUES ('Via Milano 4', 4);


--
-- TOC entry 3487 (class 0 OID 26618)
-- Dependencies: 224
-- Data for Name: salaoperatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.salaoperatoria VALUES (101, 1, 'Cardiologia');
INSERT INTO public.salaoperatoria VALUES (102, 1, 'Ortopedia');
INSERT INTO public.salaoperatoria VALUES (201, 2, 'Medicina Generale');
INSERT INTO public.salaoperatoria VALUES (301, 3, 'Pediatria');


--
-- TOC entry 3496 (class 0 OID 26716)
-- Dependencies: 233
-- Data for Name: viceprimario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.viceprimario VALUES ('RSSMRA85M01H501Z', '2018-12-10', 'Cardiologia', 1);
INSERT INTO public.viceprimario VALUES ('GRNDSF75D03H503P', '2022-09-22', 'Pediatria', 3);
INSERT INTO public.viceprimario VALUES ('RLLOTIH27EGD67W2', '2000-01-01', 'Pediatria', 3);
INSERT INTO public.viceprimario VALUES ('GFDEEUNG6IU70IJ7', '2000-01-01', 'Cardiologia', 2);


--
-- TOC entry 3497 (class 0 OID 26731)
-- Dependencies: 234
-- Data for Name: sostituzione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sostituzione VALUES ('FBRGNN80J20H501L', 'GRNDSF75D03H503P', '2024-10-06', '2024-12-06');
INSERT INTO public.sostituzione VALUES ('FBRGNN80J20H501L', 'RLLOTIH27EGD67W2', '2024-12-03', '2024-12-06');
INSERT INTO public.sostituzione VALUES ('PLRNTN75A10H502M', 'GFDEEUNG6IU70IJ7', '2010-01-01', '2011-01-01');
INSERT INTO public.sostituzione VALUES ('PLRNTN75A10H502M', 'GFDEEUNG6IU70IJ7', '2023-01-01', '2024-01-15');


--
-- TOC entry 3486 (class 0 OID 26603)
-- Dependencies: 223
-- Data for Name: turnips; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.turnips VALUES ('Via Roma 1', 1, 'RSSMRA85M01H501Z', '08:00:00', '14:00:00');
INSERT INTO public.turnips VALUES ('Corso Umberto 3', 3, 'FBRGNN80J20H501L', '10:00:00', '16:00:00');
INSERT INTO public.turnips VALUES ('Via Milano 4', 4, 'VRLMRA88F05H504R', '08:30:00', '19:00:00');


-- Completed on 2024-06-16 17:10:27

--
-- PostgreSQL database dump complete
--

