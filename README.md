# Gestione Aziende Ospedaliere – Database & Web Application

Progetto universitario sviluppato per il corso di Basi di Dati e Web A.A. 2023/2024 presso l’Università degli Studi di Milano.  

Il progetto consiste nella progettazione e realizzazione di una piattaforma web per la gestione di aziende ospedaliere regionali, comprendente modellazione della base di dati, implementazione SQL e sviluppo di un’applicazione web in PHP. 

---

## Obiettivo del progetto

L’obiettivo era progettare un sistema in grado di gestire:

- ospedali
- reparti
- personale medico e amministrativo
- ricoveri
- pronto soccorso
- laboratori e ambulatori
- esami clinici
- prenotazioni pazienti

attraverso una base di dati relazionale e un’interfaccia web dedicata.

---

## Tecnologie utilizzate

- SQL
- MySQL
- PHP
- HTML
- CSS
- Database Relazionali
- Modellazione E-R

---

## Progettazione Database

Il progetto ha previsto:

### Modellazione concettuale
- schema Entità-Relazione (E-R)
- vincoli di cardinalità
- relazioni tra entità
- identificatori e vincoli logici 

### Ristrutturazione schema E-R
Ottimizzazione dello schema concettuale per la successiva traduzione relazionale.

### Traduzione relazionale
Creazione dello schema relazionale completo con:
- chiavi primarie
- chiavi esterne
- vincoli di integrità
- ottimizzazioni database 

---

## Funzionalità implementate

### Gestione strutture ospedaliere
- inserimento ospedali
- modifica strutture
- gestione reparti
- gestione sale operatorie

### Gestione personale
- medici
- infermieri
- personale amministrativo
- primari e vice primari
- gestione sostituzioni temporanee dei primari 

### Gestione pazienti
- registrazione pazienti
- storico ricoveri
- gestione patologie
- dimissioni

### Gestione esami e prenotazioni
- prenotazione esami
- gestione urgenze
- laboratori interni ed esterni
- esami specialistici
- gestione costi e regime sanitario 

### Interrogazioni SQL avanzate
Implementazione di query per:
- vice primari che hanno sostituito una sola volta il primario
- vice primari che hanno effettuato almeno due sostituzioni
- vice primari che non hanno mai sostituito il primario 

---

## Competenze sviluppate

Durante il progetto ho approfondito:
- progettazione database relazionali
- modellazione E-R
- SQL avanzato
- progettazione web application
- gestione vincoli di integrità
- progettazione backend PHP
- interrogazioni complesse su database

---

## Struttura del progetto

```text
/database
    ├── schema.sql
    ├── insert.sql
    └── queries.sql

/webapp
    ├── php pages
    ├── forms
    ├── CRUD operations
    └── database connection
```

---

## Note

Il progetto è stato sviluppato individualmente per finalità accademiche nell’ambito del corso di Basi di Dati e Web.  
L’applicazione rappresenta una versione semplificata di un sistema gestionale ospedaliero regionale. 
