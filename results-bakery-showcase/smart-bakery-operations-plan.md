# Smart Bakery Operations

## Goal

Smart Bakery Operations ist ein Demo- und Fachkonzept fuer eine vernetzte Baeckerei-Plattform in der ExFace-App `demo.bakery` (`Knusprige Demo Broetchen`). Ziel ist ein operatives Cockpit fuer Filialbestaende, Backlinien, Anlagen, Prognosen, Produktionsplanung, Lieferlogistik, Temperaturqualitaet, Energieverbrauch und CO2-Monitoring.

Die Demo soll zeigen, wie Live-Ereignisse aus Filialen, Produktion, Lager, Lieferkette und IoT-Anlagen automatisch in Alerts, Umplanungen, KPI-Sichten und Entscheidungsvorschlaege uebersetzt werden.

## Scope

Im Scope fuer die erste Demo-Ausbaustufe:

- Echtzeit-Ueberwachung von Filialbestaenden je Produkt und Standort.
- KI-basierte Absatzprognosen pro Standort, Produkt und Planungstag.
- Vernetzte Backoefen, Backlinien, Kuehlzonen und Produktionsanlagen mit Status- und Telemetriedaten.
- Automatisierte Produktionsplanung mit Prioritaeten, Sollmengen, Linienzuordnung und Umplanungsstatus.
- Temperatur-, Qualitaets-, Energie- und CO2-Monitoring je Anlage, Produktlinie und Produktionsauftrag.
- Optimierte Auslieferung an Filialen mit Routen, Stops, ETA und Puenktlichkeits-KPI.
- Live-Ereignisse fuer Ofenausfall, Nachfrageanstieg, Rohstoffverzoegerung, Temperaturabweichung und drohenden Ausverkauf.
- Demo-Highlights: Live-Dashboard, Filialnachfrage-Heatmap, Ofenausfall-Simulation, Backmengenprognose fuer den naechsten Tag, Echtzeit-Alarmierung, Energie- und CO2-Cockpit.

Nicht im Scope der ersten Planungsstufe:

- Echtes Machine-Learning-Training; Prognosen werden zunaechst als importierte oder simulierte Zeitreihen geplant.
- Vollstaendige Tourenoptimierung mit externem Routing-Service; die Demo plant Routen, ETA und Optimierungsstatus als Datenmodell.
- Direkte Maschinenintegration; IoT-Daten werden als Telemetrie- und Ereignistabellen geplant.

## Users And Roles

| Rolle | Ziel | Typische Aufgaben |
| --- | --- | --- |
| Produktionsleitung | Backlinien steuern und Stoerungen beherrschen | Dashboard pruefen, Auftraege freigeben, Ofenausfall simulieren, Umplanung ausloesen |
| Filialleitung | Warenverfuegbarkeit sichern | Bestand melden, drohenden Ausverkauf sehen, Nachfragepeaks bestaetigen |
| Disposition / Supply Chain | Rohstoffe und Auslieferung koordinieren | Lieferverzoegerungen bearbeiten, Routen ueberwachen, Ersatzlieferungen priorisieren |
| Qualitaetsmanagement | Temperatur- und Qualitaetsabweichungen verfolgen | Alerts pruefen, Grenzwertverletzungen dokumentieren, Massnahmenstatus pflegen |
| Energiemanagement | Energie und CO2 je Produktlinie auswerten | Energieverbrauch vergleichen, Effizienz-KPIs beobachten |
| Demo-Operator | Live-Szenarien vorfuehren | Demo-Events ausloesen, Vorher/Nachher-Status erklaeren |
| Management | KPIs und Geschaeftswirkung sehen | Lebensmittelverschwendung, Verfuegbarkeit, Umsatz und Puenktlichkeit bewerten |

## Business Processes

### 1. Filialbestand Ueberwachen

1. Filialen melden Bestand, Mindestbestand, Regalverfuegbarkeit und erwarteten Tagesbedarf je Produkt.
2. Das System berechnet Verfuegbarkeitsstatus (`OK`, `LOW`, `CRITICAL`, `OUT_OF_STOCK_RISK`).
3. Drohender Ausverkauf bei Bestsellern erzeugt ein Live-Ereignis und einen Alert.
4. Produktionsplanung und Auslieferung koennen Bestellmengen priorisieren.

### 2. Absatzprognose Und Produktionsbedarf

1. Prognosen werden je Filiale, Produkt und Datum gespeichert.
2. Prognosequellen koennen KI-Modell, Historie, Wetter/Event-Faktor oder manuelle Anpassung sein.
3. Aus Prognose, Bestand und Sicherheitsbestand entsteht ein Vorschlag fuer Backmengen.
4. Produktionsleitung sieht die benoetigten Backmengen fuer den naechsten Tag und kann Planauftraege erzeugen.

### 3. Automatisierte Produktionsplanung

1. Produktionsauftraege werden je Produkt, Menge, Faelligkeit, Linie und Status geplant.
2. Anlagenstatus, Linienkapazitaet, Rohstoffverfuegbarkeit und Prioritaet beeinflussen die Reihenfolge.
3. Bei Ofenausfall wird eine Umplanung erstellt: betroffene Auftraege, neue Linie, neuer Slot, Verzugsrisiko.
4. Umplanung bleibt als nachvollziehbares Demo-Ereignis sichtbar.

### 4. Vernetzte Anlagen Und Telemetrie

1. Anlagen senden Status, Temperatur, Energie, Durchsatz und Fehlercodes.
2. Grenzwertverletzungen erzeugen Alerts fuer Qualitaet oder Technik.
3. Energie- und CO2-Werte werden Produktionsauftraegen und Produktlinien zugeordnet.
4. Das Dashboard aggregiert Produktionsstatus aller Backlinien.

### 5. Rohstoff- Und Lieferkettenereignisse

1. Rohstofflieferungen haben Status, geplante Ankunft, ETA und Risiko.
2. Lieferverzoegerung bei Mehl oder anderen Rohstoffen erzeugt ein Live-Ereignis.
3. Betroffene Produktlinien und Produktionsauftraege werden markiert.
4. Disposition sieht Handlungsbedarf und kann Prioritaeten anpassen.

### 6. Auslieferung An Filialen

1. Lieferauftraege werden in Routen und Stops gruppiert.
2. Jeder Stop hat geplante Zeit, ETA, Status und Puenktlichkeitsbewertung.
3. Kritische Filialen werden priorisiert.
4. KPI zeigt Puenktlichkeit der Filialbelieferung.

### 7. KPI-Auswertung

1. KPI-Snapshots speichern Tages- oder Schichtwerte je Standort, Produktlinie oder global.
2. Lebensmittelverschwendung, Produktionsauslastung, Energie pro Einheit, Warenverfuegbarkeit, Lieferpuenktlichkeit und Umsatz pro Kategorie werden berechnet oder importiert.
3. Management- und Demo-Dashboards nutzen diese Snapshot-Daten fuer schnelle Visualisierung.

## Data Model

Geplante Business-Entitaeten:

| Fachliche Entitaet | Geplanter technischer Name | Zweck |
| --- | --- | --- |
| Filiale / Standort | `bakery_location` | Produktionsstandorte, Filialen, Lager und Verteilzentren |
| Produktkategorie | `bakery_product_category` | Umsatz- und Sortimentsgruppen wie Brot, Broetchen, Kuchen |
| Produkt | `bakery_product` | Verkaufbare und produzierbare Backwaren |
| Filialbestand | `bakery_branch_inventory` | Echtzeit-Bestand je Filiale und Produkt |
| Absatzprognose | `bakery_demand_forecast` | Prognose und Bedarf je Standort, Produkt und Datum |
| Nachfrageereignis | `bakery_demand_signal` | Live-Signale wie Nachfrageanstieg oder Bestseller-Ausverkaufsrisiko |
| Rohstoff | `bakery_raw_material` | Mehl, Hefe, Saaten, Verpackung usw. |
| Rohstofflieferung | `bakery_supplier_delivery` | Lieferstatus und Verzoegerungen bei Rohstoffen |
| Produktionslinie | `bakery_production_line` | Linien fuer Backwarenproduktion |
| Anlage / Sensor | `bakery_equipment` | Backoefen, Kuehlungen, Mixer, Verpackung und Sensoren |
| Anlagentelemetrie | `bakery_equipment_telemetry` | Zeitreihen fuer Temperatur, Energie, Status und Durchsatz |
| Produktionsauftrag | `bakery_production_order` | Geplante und laufende Backmengen |
| Produktionsereignis | `bakery_production_event` | Stoerungen, Umplanung, Start/Stop und manuelle Eingriffe |
| Lieferroute | `bakery_delivery_route` | Tourenplanung fuer Filialbelieferung |
| Lieferstop | `bakery_delivery_stop` | Auslieferung pro Filiale innerhalb einer Route |
| Alert / Live-Ereignis | `bakery_alert_event` | Zentrale Ereignisse und Alarme fuer Cockpit und Demo |
| KPI Snapshot | `bakery_kpi_snapshot` | Aggregierte KPI-Werte je Tag, Standort, Linie oder Kategorie |

Beziehungsuebersicht:

| Beziehung | Kardinalitaet | Hinweis |
| --- | --- | --- |
| Produktkategorie zu Produkt | 1:n | Jedes Produkt gehoert zu einer Kategorie |
| Standort zu Filialbestand | 1:n | Nur Standorte mit Typ `BRANCH` fuehren Filialbestand |
| Standort zu Absatzprognose | 1:n | Prognosen werden je Filiale oder Produktionsstandort geplant |
| Produkt zu Absatzprognose | 1:n | Ein Produkt hat viele Prognosewerte |
| Produktionslinie zu Anlage | 1:n | Eine Linie kann mehrere Anlagen haben |
| Produktionslinie zu Produktionsauftrag | 1:n | Auftrag laeuft auf einer Linie oder wird noch zugeordnet |
| Anlage zu Telemetrie | 1:n | Telemetrie ist zeitbezogen |
| Produktionsauftrag zu Produktionsereignis | 1:n | Ereignisse dokumentieren Statuswechsel und Umplanung |
| Lieferroute zu Lieferstop | 1:n | Route enthaelt Stops in Sequenz |
| Standort zu Lieferstop | 1:n | Stop beliefert eine Filiale |
| Alert zu Standort / Linie / Anlage / Auftrag | n:0..1 | Alert kann auf mehrere optionale Kontexte verweisen |
| KPI Snapshot zu Standort / Linie / Kategorie | n:0..1 | KPI kann global oder kontextbezogen sein |

## SQL Tables

Alle Tabellen sind fuer die MySQL-Datenquelle `bakery_datasource` der App `demo.bakery` geplant. Tabellen sollten in einem spaeteren InitDB- oder Migrations-Handoff mit `created_on`, `modified_on`, optionalen Audit-Spalten und konsistenten UID-/ID-Konventionen der lokalen ExFace-Installation umgesetzt werden. Finale UIDs werden nicht in diesem Plan erfunden.

### `bakery_location`

Purpose: Standorte fuer Filialen, Produktion, Lager und Verteilzentren.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID, Umsetzung durch SQL-Agent klaeren |
| `location_code` | `VARCHAR(40)` | no |  | Eindeutiger Standortcode |
| `name` | `VARCHAR(120)` | no |  | Anzeigename |
| `location_type` | `VARCHAR(30)` | no |  | `BRANCH`, `PRODUCTION`, `WAREHOUSE`, `DISTRIBUTION_CENTER` |
| `city` | `VARCHAR(120)` | yes | `NULL` | Ort |
| `latitude` | `DECIMAL(10,7)` | yes | `NULL` | Fuer Heatmap und Routing |
| `longitude` | `DECIMAL(10,7)` | yes | `NULL` | Fuer Heatmap und Routing |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiver Standort |
| `created_on` | `DATETIME` | no | current timestamp | Anlagezeit |
| `modified_on` | `DATETIME` | yes | `NULL` | Aenderungszeit |

Primary key: `id`.
Unique keys: `uid`, `location_code`.
Indexes: `location_type`, `active_flag`, `city`.

### `bakery_product_category`

Purpose: Kategorien fuer Sortiment, Umsatz-KPI und Produktlinien.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `category_code` | `VARCHAR(40)` | no |  | Eindeutiger Code |
| `name` | `VARCHAR(120)` | no |  | Anzeigename |
| `sort_order` | `INT` | no | `100` | Reihenfolge in Auswahl und Dashboard |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiv |

Primary key: `id`.
Unique keys: `uid`, `category_code`.
Indexes: `active_flag`, `sort_order`.

### `bakery_product`

Purpose: Backwaren fuer Bestand, Prognose, Produktion und Umsatz.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `product_code` | `VARCHAR(60)` | no |  | Eindeutiger Produktcode |
| `name` | `VARCHAR(160)` | no |  | Produktname |
| `category_id` | `BIGINT UNSIGNED` | no |  | FK zu `bakery_product_category.id` |
| `unit` | `VARCHAR(20)` | no | `pcs` | Einheit, z. B. `pcs`, `kg` |
| `shelf_life_hours` | `INT` | yes | `NULL` | Haltbarkeit fuer Waste-KPI |
| `bestseller_flag` | `TINYINT(1)` | no | `0` | Bestseller-Prioritaet |
| `standard_batch_qty` | `DECIMAL(12,3)` | no | `0` | Standard-Chargengroesse |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiv |

Primary key: `id`.
Unique keys: `uid`, `product_code`.
Foreign keys: `category_id` references `bakery_product_category(id)`.
Indexes: `category_id`, `bestseller_flag`, `active_flag`.

### `bakery_branch_inventory`

Purpose: Echtzeit-Bestand und Ausverkaufsrisiko je Filiale und Produkt.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `location_id` | `BIGINT UNSIGNED` | no |  | FK zu Filiale |
| `product_id` | `BIGINT UNSIGNED` | no |  | FK zu Produkt |
| `stock_qty` | `DECIMAL(12,3)` | no | `0` | Aktueller Bestand |
| `reserved_qty` | `DECIMAL(12,3)` | no | `0` | Reservierte Menge |
| `minimum_qty` | `DECIMAL(12,3)` | no | `0` | Mindestbestand |
| `expected_demand_qty` | `DECIMAL(12,3)` | no | `0` | Erwartete Nachfrage bis Tagesende |
| `availability_status` | `VARCHAR(30)` | no | `OK` | `OK`, `LOW`, `CRITICAL`, `OUT_OF_STOCK_RISK` |
| `last_update_on` | `DATETIME` | no | current timestamp | Letztes Bestandssignal |

Primary key: `id`.
Unique keys: `uid`, composite `location_id, product_id`.
Foreign keys: `location_id` references `bakery_location(id)`, `product_id` references `bakery_product(id)`.
Indexes: `availability_status`, `last_update_on`, `product_id`.

### `bakery_demand_forecast`

Purpose: KI- oder regelbasierte Absatzprognosen und Produktionsbedarf.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `location_id` | `BIGINT UNSIGNED` | no |  | Zielstandort |
| `product_id` | `BIGINT UNSIGNED` | no |  | Produkt |
| `forecast_date` | `DATE` | no |  | Planungstag |
| `forecast_qty` | `DECIMAL(12,3)` | no | `0` | Erwartete Absatzmenge |
| `recommended_bake_qty` | `DECIMAL(12,3)` | no | `0` | Empfohlene Backmenge |
| `confidence_pct` | `DECIMAL(5,2)` | yes | `NULL` | Prognoseguete in Prozent |
| `source` | `VARCHAR(40)` | no | `AI_MODEL` | `AI_MODEL`, `HISTORY`, `MANUAL`, `SIMULATION` |
| `reason_text` | `VARCHAR(255)` | yes | `NULL` | Demo-Erklaerung fuer Prognose |
| `created_on` | `DATETIME` | no | current timestamp | Anlagezeit |

Primary key: `id`.
Unique keys: `uid`, composite `location_id, product_id, forecast_date, source` if duplicate source values are not required.
Foreign keys: `location_id` references `bakery_location(id)`, `product_id` references `bakery_product(id)`.
Indexes: `forecast_date`, `product_id`, `source`.

### `bakery_demand_signal`

Purpose: Live-Nachfragesignale wie unerwartete Peaks oder Ausverkaufswarnungen.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `location_id` | `BIGINT UNSIGNED` | no |  | Filiale oder Region |
| `product_id` | `BIGINT UNSIGNED` | no |  | Produkt |
| `signal_type` | `VARCHAR(40)` | no |  | `DEMAND_SPIKE`, `BESTSELLER_SHORTAGE`, `MANUAL_STORE_REPORT` |
| `signal_strength_pct` | `DECIMAL(6,2)` | no | `0` | Abweichung gegen Erwartung |
| `observed_qty` | `DECIMAL(12,3)` | yes | `NULL` | Beobachtete Nachfrage |
| `expected_qty` | `DECIMAL(12,3)` | yes | `NULL` | Erwartete Nachfrage |
| `detected_on` | `DATETIME` | no | current timestamp | Erkennung |
| `status` | `VARCHAR(30)` | no | `NEW` | `NEW`, `ACKNOWLEDGED`, `PLANNED`, `CLOSED` |

Primary key: `id`.
Unique keys: `uid`.
Foreign keys: `location_id` references `bakery_location(id)`, `product_id` references `bakery_product(id)`.
Indexes: `signal_type`, `status`, `detected_on`.

### `bakery_raw_material`

Purpose: Rohstoffe fuer Produktionsplanung und Lieferkettenereignisse.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `material_code` | `VARCHAR(60)` | no |  | Eindeutiger Rohstoffcode |
| `name` | `VARCHAR(160)` | no |  | Name |
| `unit` | `VARCHAR(20)` | no | `kg` | Einheit |
| `current_stock_qty` | `DECIMAL(14,3)` | no | `0` | Lagerbestand |
| `minimum_stock_qty` | `DECIMAL(14,3)` | no | `0` | Mindestbestand |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiv |

Primary key: `id`.
Unique keys: `uid`, `material_code`.
Indexes: `active_flag`, `current_stock_qty`.

### `bakery_supplier_delivery`

Purpose: Ueberwachung von Rohstofflieferungen und Verzoegerungen.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `raw_material_id` | `BIGINT UNSIGNED` | no |  | FK zu Rohstoff |
| `supplier_name` | `VARCHAR(160)` | no |  | Lieferant |
| `ordered_qty` | `DECIMAL(14,3)` | no | `0` | Bestellte Menge |
| `planned_arrival_on` | `DATETIME` | no |  | Geplante Ankunft |
| `eta_on` | `DATETIME` | yes | `NULL` | Aktuelle ETA |
| `delay_minutes` | `INT` | no | `0` | Verzoegerung |
| `status` | `VARCHAR(30)` | no | `PLANNED` | `PLANNED`, `IN_TRANSIT`, `DELAYED`, `ARRIVED`, `CANCELLED` |
| `risk_level` | `VARCHAR(20)` | no | `LOW` | `LOW`, `MEDIUM`, `HIGH`, `CRITICAL` |

Primary key: `id`.
Unique keys: `uid`.
Foreign keys: `raw_material_id` references `bakery_raw_material(id)`.
Indexes: `status`, `risk_level`, `planned_arrival_on`.

### `bakery_production_line`

Purpose: Backlinien mit Kapazitaet, Status und Produktlinienbezug.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `line_code` | `VARCHAR(40)` | no |  | Eindeutiger Liniencode |
| `name` | `VARCHAR(120)` | no |  | Anzeigename |
| `location_id` | `BIGINT UNSIGNED` | no |  | Produktionsstandort |
| `category_id` | `BIGINT UNSIGNED` | yes | `NULL` | Schwerpunkt-Produktkategorie |
| `capacity_units_per_hour` | `DECIMAL(12,3)` | no | `0` | Nennkapazitaet |
| `status` | `VARCHAR(30)` | no | `READY` | `READY`, `RUNNING`, `MAINTENANCE`, `DOWN`, `PLANNED_STOP` |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiv |

Primary key: `id`.
Unique keys: `uid`, `line_code`.
Foreign keys: `location_id` references `bakery_location(id)`, `category_id` references `bakery_product_category(id)`.
Indexes: `status`, `location_id`, `category_id`.

### `bakery_equipment`

Purpose: Anlagen und Sensoren innerhalb einer Produktionslinie oder Lagerzone.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `equipment_code` | `VARCHAR(60)` | no |  | Eindeutiger Code |
| `name` | `VARCHAR(160)` | no |  | Anzeigename |
| `equipment_type` | `VARCHAR(40)` | no |  | `OVEN`, `COOLING`, `MIXER`, `PACKAGING`, `SENSOR`, `ENERGY_METER` |
| `production_line_id` | `BIGINT UNSIGNED` | yes | `NULL` | FK zu Linie |
| `location_id` | `BIGINT UNSIGNED` | no |  | Standort |
| `status` | `VARCHAR(30)` | no | `ONLINE` | `ONLINE`, `WARNING`, `OFFLINE`, `FAILURE`, `MAINTENANCE` |
| `min_temperature_c` | `DECIMAL(6,2)` | yes | `NULL` | Unterer Grenzwert |
| `max_temperature_c` | `DECIMAL(6,2)` | yes | `NULL` | Oberer Grenzwert |
| `active_flag` | `TINYINT(1)` | no | `1` | Aktiv |

Primary key: `id`.
Unique keys: `uid`, `equipment_code`.
Foreign keys: `production_line_id` references `bakery_production_line(id)`, `location_id` references `bakery_location(id)`.
Indexes: `equipment_type`, `status`, `location_id`.

### `bakery_equipment_telemetry`

Purpose: Zeitreihen fuer Temperatur, Energie, Leistung, Durchsatz und Maschinenstatus.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `equipment_id` | `BIGINT UNSIGNED` | no |  | Anlage oder Sensor |
| `measured_on` | `DATETIME` | no |  | Messzeitpunkt |
| `temperature_c` | `DECIMAL(6,2)` | yes | `NULL` | Temperatur |
| `energy_kwh` | `DECIMAL(12,3)` | yes | `NULL` | Energie im Messintervall oder kumuliert |
| `co2_kg` | `DECIMAL(12,3)` | yes | `NULL` | CO2-Aequivalent |
| `throughput_qty` | `DECIMAL(12,3)` | yes | `NULL` | Produzierte Menge im Intervall |
| `machine_status` | `VARCHAR(30)` | no | `ONLINE` | Maschinenstatus |
| `quality_status` | `VARCHAR(30)` | no | `OK` | `OK`, `WARNING`, `LIMIT_EXCEEDED` |
| `error_code` | `VARCHAR(60)` | yes | `NULL` | Fehlercode |

Primary key: `id`.
Unique keys: `uid`.
Foreign keys: `equipment_id` references `bakery_equipment(id)`.
Indexes: composite `equipment_id, measured_on`, `quality_status`, `machine_status`.

### `bakery_production_order`

Purpose: Produktionsplanung, Status und Mengen je Produkt und Linie.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `order_no` | `VARCHAR(60)` | no |  | Produktionsauftragsnummer |
| `product_id` | `BIGINT UNSIGNED` | no |  | Produkt |
| `production_line_id` | `BIGINT UNSIGNED` | yes | `NULL` | Geplante Linie |
| `planned_start_on` | `DATETIME` | no |  | Geplanter Start |
| `planned_end_on` | `DATETIME` | no |  | Geplantes Ende |
| `actual_start_on` | `DATETIME` | yes | `NULL` | Ist-Start |
| `actual_end_on` | `DATETIME` | yes | `NULL` | Ist-Ende |
| `planned_qty` | `DECIMAL(12,3)` | no | `0` | Sollmenge |
| `actual_qty` | `DECIMAL(12,3)` | no | `0` | Istmenge |
| `waste_qty` | `DECIMAL(12,3)` | no | `0` | Ausschuss / Verderb |
| `priority` | `VARCHAR(20)` | no | `NORMAL` | `LOW`, `NORMAL`, `HIGH`, `URGENT` |
| `status` | `VARCHAR(30)` | no | `PLANNED` | `PLANNED`, `RELEASED`, `RUNNING`, `PAUSED`, `RESCHEDULED`, `DONE`, `CANCELLED` |
| `reschedule_reason` | `VARCHAR(255)` | yes | `NULL` | Grund fuer Umplanung |
| `energy_kwh` | `DECIMAL(12,3)` | no | `0` | Energie je Auftrag |
| `co2_kg` | `DECIMAL(12,3)` | no | `0` | CO2 je Auftrag |

Primary key: `id`.
Unique keys: `uid`, `order_no`.
Foreign keys: `product_id` references `bakery_product(id)`, `production_line_id` references `bakery_production_line(id)`.
Indexes: `status`, `priority`, `planned_start_on`, `production_line_id`, `product_id`.

### `bakery_production_event`

Purpose: Nachvollziehbare Produktionsereignisse inklusive Ofenausfall und Umplanung.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `production_order_id` | `BIGINT UNSIGNED` | yes | `NULL` | Betroffener Auftrag |
| `production_line_id` | `BIGINT UNSIGNED` | yes | `NULL` | Betroffene Linie |
| `equipment_id` | `BIGINT UNSIGNED` | yes | `NULL` | Betroffene Anlage |
| `event_type` | `VARCHAR(40)` | no |  | `OVEN_FAILURE`, `RESCHEDULE`, `START`, `STOP`, `QUALITY_DEVIATION` |
| `severity` | `VARCHAR(20)` | no | `INFO` | `INFO`, `WARNING`, `CRITICAL` |
| `event_on` | `DATETIME` | no | current timestamp | Ereigniszeit |
| `message` | `VARCHAR(255)` | no |  | Kurztext |
| `old_value` | `VARCHAR(255)` | yes | `NULL` | Vorher-Wert fuer Demo |
| `new_value` | `VARCHAR(255)` | yes | `NULL` | Nachher-Wert fuer Demo |

Primary key: `id`.
Unique keys: `uid`.
Foreign keys: `production_order_id` references `bakery_production_order(id)`, `production_line_id` references `bakery_production_line(id)`, `equipment_id` references `bakery_equipment(id)`.
Indexes: `event_type`, `severity`, `event_on`.

### `bakery_delivery_route`

Purpose: Auslieferungsroute an Filialen.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `route_no` | `VARCHAR(60)` | no |  | Routenkennung |
| `departure_location_id` | `BIGINT UNSIGNED` | no |  | Lager oder Produktion |
| `planned_departure_on` | `DATETIME` | no |  | Geplanter Start |
| `actual_departure_on` | `DATETIME` | yes | `NULL` | Ist-Start |
| `status` | `VARCHAR(30)` | no | `PLANNED` | `PLANNED`, `LOADING`, `IN_TRANSIT`, `DONE`, `DELAYED`, `CANCELLED` |
| `optimization_status` | `VARCHAR(30)` | no | `NOT_OPTIMIZED` | `NOT_OPTIMIZED`, `OPTIMIZED`, `MANUAL_OVERRIDE` |
| `delay_minutes` | `INT` | no | `0` | Aktuelle Verzoegerung |

Primary key: `id`.
Unique keys: `uid`, `route_no`.
Foreign keys: `departure_location_id` references `bakery_location(id)`.
Indexes: `status`, `planned_departure_on`, `optimization_status`.

### `bakery_delivery_stop`

Purpose: Stopps einer Route inklusive Filialbelieferung und Puenktlichkeit.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `delivery_route_id` | `BIGINT UNSIGNED` | no |  | Route |
| `location_id` | `BIGINT UNSIGNED` | no |  | Filiale |
| `stop_sequence` | `INT` | no |  | Reihenfolge |
| `planned_arrival_on` | `DATETIME` | no |  | Geplante Ankunft |
| `eta_on` | `DATETIME` | yes | `NULL` | ETA |
| `actual_arrival_on` | `DATETIME` | yes | `NULL` | Ist-Ankunft |
| `status` | `VARCHAR(30)` | no | `PLANNED` | `PLANNED`, `IN_TRANSIT`, `ARRIVED`, `DELAYED`, `SKIPPED` |
| `on_time_flag` | `TINYINT(1)` | yes | `NULL` | Puenktlichkeit |
| `priority` | `VARCHAR(20)` | no | `NORMAL` | Lieferprioritaet |

Primary key: `id`.
Unique keys: `uid`, composite `delivery_route_id, stop_sequence`.
Foreign keys: `delivery_route_id` references `bakery_delivery_route(id)`, `location_id` references `bakery_location(id)`.
Indexes: `status`, `planned_arrival_on`, `location_id`, `priority`.

### `bakery_alert_event`

Purpose: Zentrales Live-Ereignis fuer Cockpit, Alarmierung und Demo-Simulation.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `alert_type` | `VARCHAR(50)` | no |  | `OVEN_FAILURE`, `DEMAND_SPIKE`, `RAW_MATERIAL_DELAY`, `COOLING_LIMIT`, `BRANCH_STOCKOUT_RISK`, `QUALITY_DEVIATION`, `ENERGY_SPIKE` |
| `severity` | `VARCHAR(20)` | no | `INFO` | `INFO`, `WARNING`, `CRITICAL` |
| `status` | `VARCHAR(30)` | no | `OPEN` | `OPEN`, `ACKNOWLEDGED`, `IN_PROGRESS`, `RESOLVED`, `CLOSED` |
| `title` | `VARCHAR(160)` | no |  | Kurztitel |
| `message` | `TEXT` | yes | `NULL` | Beschreibung |
| `location_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionaler Standort |
| `product_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionales Produkt |
| `production_line_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionale Linie |
| `equipment_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionale Anlage |
| `production_order_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionaler Auftrag |
| `detected_on` | `DATETIME` | no | current timestamp | Erkennung |
| `acknowledged_on` | `DATETIME` | yes | `NULL` | Bestaetigt am |
| `resolved_on` | `DATETIME` | yes | `NULL` | Geloest am |
| `simulation_flag` | `TINYINT(1)` | no | `0` | Demo-Simulation |

Primary key: `id`.
Unique keys: `uid`.
Foreign keys: optional zu `bakery_location`, `bakery_product`, `bakery_production_line`, `bakery_equipment`, `bakery_production_order`.
Indexes: `alert_type`, `severity`, `status`, `detected_on`, `simulation_flag`.

### `bakery_kpi_snapshot`

Purpose: KPI-Werte fuer Management, Dashboard und Demo-Kacheln.

| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | `BIGINT UNSIGNED` | no | auto increment | Technischer Primaerschluessel |
| `uid` | `BINARY(16)` or local UID type | no | generated | ExFace UID |
| `snapshot_date` | `DATE` | no |  | KPI-Tag |
| `snapshot_level` | `VARCHAR(30)` | no | `GLOBAL` | `GLOBAL`, `LOCATION`, `LINE`, `CATEGORY`, `PRODUCT` |
| `kpi_code` | `VARCHAR(60)` | no |  | z. B. `FOOD_WASTE_PCT`, `LINE_UTILIZATION_PCT` |
| `kpi_name` | `VARCHAR(160)` | no |  | Anzeigename |
| `value_num` | `DECIMAL(14,4)` | no | `0` | KPI-Wert |
| `unit` | `VARCHAR(30)` | no |  | Einheit, z. B. `%`, `kWh/unit`, `EUR` |
| `location_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionaler Standort |
| `production_line_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionale Linie |
| `category_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionale Kategorie |
| `product_id` | `BIGINT UNSIGNED` | yes | `NULL` | Optionales Produkt |
| `trend_direction` | `VARCHAR(20)` | yes | `NULL` | `UP`, `DOWN`, `STABLE` |
| `target_value_num` | `DECIMAL(14,4)` | yes | `NULL` | Zielwert |

Primary key: `id`.
Unique keys: `uid`, optional composite `snapshot_date, snapshot_level, kpi_code, location_id, production_line_id, category_id, product_id` if NULL handling is compatible.
Foreign keys: optional zu `bakery_location`, `bakery_production_line`, `bakery_product_category`, `bakery_product`.
Indexes: `snapshot_date`, `kpi_code`, `snapshot_level`.

## ExFace Objects

Alle Objekte sollen unter `demo/bakery/Model/<object_alias>/` angelegt werden. Objektalias-Stil nach vorhandenen Demo-Apps: voll qualifizierte Aliase mit App-Prefix, z. B. `demo.bakery.bakery_product`. Datenquelle: `bakery_datasource`. `DATA_ADDRESS` entspricht dem jeweiligen SQL-Tabellennamen.

### Objektuebersicht

| Object alias | Label | DATA_ADDRESS | Hauptzweck |
| --- | --- | --- | --- |
| `demo.bakery.bakery_location` | Bakery Location | `bakery_location` | Filialen, Lager und Produktionsstandorte |
| `demo.bakery.bakery_product_category` | Bakery Product Category | `bakery_product_category` | Kategorien fuer Sortiment und KPIs |
| `demo.bakery.bakery_product` | Bakery Product | `bakery_product` | Produkte / Backwaren |
| `demo.bakery.bakery_branch_inventory` | Bakery Branch Inventory | `bakery_branch_inventory` | Filialbestaende und Verfuegbarkeit |
| `demo.bakery.bakery_demand_forecast` | Bakery Demand Forecast | `bakery_demand_forecast` | Absatzprognosen und Backmengenvorschlaege |
| `demo.bakery.bakery_demand_signal` | Bakery Demand Signal | `bakery_demand_signal` | Nachfragepeaks und Filialmeldungen |
| `demo.bakery.bakery_raw_material` | Bakery Raw Material | `bakery_raw_material` | Rohstoffe |
| `demo.bakery.bakery_supplier_delivery` | Bakery Supplier Delivery | `bakery_supplier_delivery` | Rohstofflieferungen |
| `demo.bakery.bakery_production_line` | Bakery Production Line | `bakery_production_line` | Backlinien |
| `demo.bakery.bakery_equipment` | Bakery Equipment | `bakery_equipment` | Anlagen und Sensoren |
| `demo.bakery.bakery_equipment_telemetry` | Bakery Equipment Telemetry | `bakery_equipment_telemetry` | IoT-Zeitreihen |
| `demo.bakery.bakery_production_order` | Bakery Production Order | `bakery_production_order` | Produktionsauftraege |
| `demo.bakery.bakery_production_event` | Bakery Production Event | `bakery_production_event` | Produktionsereignisse und Umplanung |
| `demo.bakery.bakery_delivery_route` | Bakery Delivery Route | `bakery_delivery_route` | Lieferroute |
| `demo.bakery.bakery_delivery_stop` | Bakery Delivery Stop | `bakery_delivery_stop` | Routenstopps |
| `demo.bakery.bakery_alert_event` | Bakery Alert Event | `bakery_alert_event` | Zentrale Alerts und Live-Ereignisse |
| `demo.bakery.bakery_kpi_snapshot` | Bakery KPI Snapshot | `bakery_kpi_snapshot` | KPI-Aggregate |

### Gemeinsame Attributkonventionen

| Attribute alias | Datatype | Required | Editable | UID | Label | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `UID` | `UID` | yes | no | yes | no | Umsetzung nach ExFace-Konvention des Object Builders |
| `ID` | `Integer` | yes | no | no | no | Technischer Primaerschluessel, falls lokale Pattern dies nutzen |
| `CREATED_ON` | `DateTime` | yes | no | no | no | Audit |
| `MODIFIED_ON` | `DateTime` | no | no | no | no | Audit |

### Wichtige Objektattribute

#### `demo.bakery.bakery_location`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  | Implementation generiert UID |
| `LOCATION_CODE` | Location Code | String | `location_code` | yes | yes | no | no |  | Eindeutiger Code |
| `NAME` | Name | String | `name` | yes | yes | no | yes |  | Hauptlabel |
| `LOCATION_TYPE` | Location Type | String | `location_type` | yes | yes | no | no |  | Werte: Branch, Production, Warehouse, Distribution Center |
| `CITY` | City | String | `city` | no | yes | no | no |  | Fuer Filter |
| `LATITUDE` | Latitude | Number | `latitude` | no | yes | no | no |  | Heatmap |
| `LONGITUDE` | Longitude | Number | `longitude` | no | yes | no | no |  | Heatmap |
| `ACTIVE_FLAG` | Active | Boolean | `active_flag` | yes | yes | no | no |  | Standardfilter aktiv |

#### `demo.bakery.bakery_product`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `PRODUCT_CODE` | Product Code | String | `product_code` | yes | yes | no | no |  | Eindeutig |
| `NAME` | Product | String | `name` | yes | yes | no | yes |  | Hauptlabel |
| `CATEGORY` | Category | Relation | `category_id` | yes | yes | no | no | `demo.bakery.bakery_product_category` | Relation ueber `category_id` |
| `UNIT` | Unit | String | `unit` | yes | yes | no | no |  | pcs/kg |
| `SHELF_LIFE_HOURS` | Shelf Life Hours | Integer | `shelf_life_hours` | no | yes | no | no |  | Waste-KPI |
| `BESTSELLER_FLAG` | Bestseller | Boolean | `bestseller_flag` | yes | yes | no | no |  | Fuer Ausverkaufsalerts |
| `STANDARD_BATCH_QTY` | Standard Batch Qty | Number | `standard_batch_qty` | yes | yes | no | no |  | Produktionsvorschlag |
| `ACTIVE_FLAG` | Active | Boolean | `active_flag` | yes | yes | no | no |  |  |

#### `demo.bakery.bakery_branch_inventory`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `LOCATION` | Branch | Relation | `location_id` | yes | yes | no | yes | `demo.bakery.bakery_location` | Nur Branch-Standorte |
| `PRODUCT` | Product | Relation | `product_id` | yes | yes | no | yes | `demo.bakery.bakery_product` |  |
| `STOCK_QTY` | Stock Qty | Number | `stock_qty` | yes | yes | no | no |  | Echtzeitwert |
| `RESERVED_QTY` | Reserved Qty | Number | `reserved_qty` | yes | yes | no | no |  |  |
| `MINIMUM_QTY` | Minimum Qty | Number | `minimum_qty` | yes | yes | no | no |  | Grenzwert |
| `EXPECTED_DEMAND_QTY` | Expected Demand Qty | Number | `expected_demand_qty` | yes | yes | no | no |  | Tagesrestbedarf |
| `AVAILABILITY_STATUS` | Availability Status | String | `availability_status` | yes | yes | no | no |  | Status-Ampel |
| `LAST_UPDATE_ON` | Last Update | DateTime | `last_update_on` | yes | no | no | no |  | Sortierung absteigend |

#### `demo.bakery.bakery_demand_forecast`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `LOCATION` | Location | Relation | `location_id` | yes | yes | no | yes | `demo.bakery.bakery_location` | Filiale oder Produktionsstandort |
| `PRODUCT` | Product | Relation | `product_id` | yes | yes | no | yes | `demo.bakery.bakery_product` |  |
| `FORECAST_DATE` | Forecast Date | Date | `forecast_date` | yes | yes | no | no |  | Standardfilter morgen/heute |
| `FORECAST_QTY` | Forecast Qty | Number | `forecast_qty` | yes | yes | no | no |  | KI-Prognose |
| `RECOMMENDED_BAKE_QTY` | Recommended Bake Qty | Number | `recommended_bake_qty` | yes | yes | no | no |  | Produktionsvorschlag |
| `CONFIDENCE_PCT` | Confidence % | Number | `confidence_pct` | no | yes | no | no |  |  |
| `SOURCE` | Source | String | `source` | yes | yes | no | no |  | AI_MODEL usw. |
| `REASON_TEXT` | Reason | String | `reason_text` | no | yes | no | no |  | Demo-Erklaertext |

#### `demo.bakery.bakery_production_line`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `LINE_CODE` | Line Code | String | `line_code` | yes | yes | no | no |  | Eindeutig |
| `NAME` | Production Line | String | `name` | yes | yes | no | yes |  |  |
| `LOCATION` | Location | Relation | `location_id` | yes | yes | no | no | `demo.bakery.bakery_location` | Produktionsstandort |
| `CATEGORY` | Product Category | Relation | `category_id` | no | yes | no | no | `demo.bakery.bakery_product_category` | Schwerpunkt |
| `CAPACITY_UNITS_PER_HOUR` | Capacity / Hour | Number | `capacity_units_per_hour` | yes | yes | no | no |  | Auslastung |
| `STATUS` | Status | String | `status` | yes | yes | no | no |  | Dashboard-Ampel |
| `ACTIVE_FLAG` | Active | Boolean | `active_flag` | yes | yes | no | no |  |  |

#### `demo.bakery.bakery_equipment`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `EQUIPMENT_CODE` | Equipment Code | String | `equipment_code` | yes | yes | no | no |  | Eindeutig |
| `NAME` | Equipment | String | `name` | yes | yes | no | yes |  |  |
| `EQUIPMENT_TYPE` | Equipment Type | String | `equipment_type` | yes | yes | no | no |  | OVEN, COOLING usw. |
| `PRODUCTION_LINE` | Production Line | Relation | `production_line_id` | no | yes | no | no | `demo.bakery.bakery_production_line` | Optional bei Lagerkuehlung |
| `LOCATION` | Location | Relation | `location_id` | yes | yes | no | no | `demo.bakery.bakery_location` |  |
| `STATUS` | Status | String | `status` | yes | yes | no | no |  | ONLINE, FAILURE usw. |
| `MIN_TEMPERATURE_C` | Min Temperature C | Number | `min_temperature_c` | no | yes | no | no |  | Grenzwert |
| `MAX_TEMPERATURE_C` | Max Temperature C | Number | `max_temperature_c` | no | yes | no | no |  | Grenzwert |

#### `demo.bakery.bakery_equipment_telemetry`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `EQUIPMENT` | Equipment | Relation | `equipment_id` | yes | yes | no | yes | `demo.bakery.bakery_equipment` |  |
| `MEASURED_ON` | Measured On | DateTime | `measured_on` | yes | yes | no | yes |  | Zeitachse |
| `TEMPERATURE_C` | Temperature C | Number | `temperature_c` | no | yes | no | no |  |  |
| `ENERGY_KWH` | Energy kWh | Number | `energy_kwh` | no | yes | no | no |  | Energie |
| `CO2_KG` | CO2 kg | Number | `co2_kg` | no | yes | no | no |  | CO2-Aequivalent |
| `THROUGHPUT_QTY` | Throughput Qty | Number | `throughput_qty` | no | yes | no | no |  | Produktionsmenge |
| `MACHINE_STATUS` | Machine Status | String | `machine_status` | yes | yes | no | no |  |  |
| `QUALITY_STATUS` | Quality Status | String | `quality_status` | yes | yes | no | no |  |  |
| `ERROR_CODE` | Error Code | String | `error_code` | no | yes | no | no |  |  |

#### `demo.bakery.bakery_production_order`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `ORDER_NO` | Order No | String | `order_no` | yes | yes | no | yes |  | Hauptlabel |
| `PRODUCT` | Product | Relation | `product_id` | yes | yes | no | no | `demo.bakery.bakery_product` |  |
| `PRODUCTION_LINE` | Production Line | Relation | `production_line_id` | no | yes | no | no | `demo.bakery.bakery_production_line` | Bei Umplanung aenderbar |
| `PLANNED_START_ON` | Planned Start | DateTime | `planned_start_on` | yes | yes | no | no |  |  |
| `PLANNED_END_ON` | Planned End | DateTime | `planned_end_on` | yes | yes | no | no |  |  |
| `PLANNED_QTY` | Planned Qty | Number | `planned_qty` | yes | yes | no | no |  |  |
| `ACTUAL_QTY` | Actual Qty | Number | `actual_qty` | yes | yes | no | no |  |  |
| `WASTE_QTY` | Waste Qty | Number | `waste_qty` | yes | yes | no | no |  | Lebensmittelverschwendung |
| `PRIORITY` | Priority | String | `priority` | yes | yes | no | no |  | LOW bis URGENT |
| `STATUS` | Status | String | `status` | yes | yes | no | no |  | PLANNED usw. |
| `RESCHEDULE_REASON` | Reschedule Reason | String | `reschedule_reason` | no | yes | no | no |  |  |
| `ENERGY_KWH` | Energy kWh | Number | `energy_kwh` | yes | yes | no | no |  |  |
| `CO2_KG` | CO2 kg | Number | `co2_kg` | yes | yes | no | no |  |  |

#### `demo.bakery.bakery_alert_event`

| ALIAS | Label | Datatype | DATA_ADDRESS | Required | Editable | UID | Label flag | Relation target | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `UID` | UID | UID | `uid` | yes | no | yes | no |  |  |
| `ALERT_TYPE` | Alert Type | String | `alert_type` | yes | yes | no | no |  | Live-Ereignis-Art |
| `SEVERITY` | Severity | String | `severity` | yes | yes | no | no |  | INFO/WARNING/CRITICAL |
| `STATUS` | Status | String | `status` | yes | yes | no | no |  | Workflowstatus |
| `TITLE` | Title | String | `title` | yes | yes | no | yes |  | Hauptlabel |
| `MESSAGE` | Message | String | `message` | no | yes | no | no |  |  |
| `LOCATION` | Location | Relation | `location_id` | no | yes | no | no | `demo.bakery.bakery_location` | Optional |
| `PRODUCT` | Product | Relation | `product_id` | no | yes | no | no | `demo.bakery.bakery_product` | Optional |
| `PRODUCTION_LINE` | Production Line | Relation | `production_line_id` | no | yes | no | no | `demo.bakery.bakery_production_line` | Optional |
| `EQUIPMENT` | Equipment | Relation | `equipment_id` | no | yes | no | no | `demo.bakery.bakery_equipment` | Optional |
| `PRODUCTION_ORDER` | Production Order | Relation | `production_order_id` | no | yes | no | no | `demo.bakery.bakery_production_order` | Optional |
| `DETECTED_ON` | Detected On | DateTime | `detected_on` | yes | no | no | no | Sortierung absteigend |
| `ACKNOWLEDGED_ON` | Acknowledged On | DateTime | `acknowledged_on` | no | no | no | no | Aktion setzt Wert |
| `RESOLVED_ON` | Resolved On | DateTime | `resolved_on` | no | no | no | no | Aktion setzt Wert |
| `SIMULATION_FLAG` | Simulation | Boolean | `simulation_flag` | yes | yes | no | no | Demo-Events |

Weitere Objektattribute fuer die uebrigen Objekte sollen aus den SQL-Spalten 1:1 erzeugt werden. Relationsfelder sollen die oben genannten Foreign Keys als Relation-Attribute erhalten.

## Pages And Navigation

Seiten sollen unter `demo/bakery/Model/99_PAGE/` geplant werden. Page-Aliase orientieren sich am Demo-Stil mit App-Prefix und sprechenden Slugs, z. B. `demo.bakery.smart-bakery-cockpit`.

| Page alias | Name | Menu / Parent | Object alias | Widget / Layout | Inhalt und Verhalten |
| --- | --- | --- | --- | --- | --- |
| `demo.bakery.smart-bakery-cockpit` | Smart Bakery Cockpit | Bakery Operations | `demo.bakery.bakery_alert_event` | Dashboard / SplitVertical / Tiles + DataTables | Live-KPIs, offene Alerts, Produktionslinienstatus, kritische Filialbestaende, Lieferverzoegerungen. Buttons: Ofenausfall simulieren, Nachfragepeak simulieren, Rohstoffverzoegerung simulieren, Alerts bestaetigen. |
| `demo.bakery.production-lines-live` | Production Lines Live | Bakery Operations | `demo.bakery.bakery_production_line` | DataTable + Detail/Dialog | Linien mit Status, Kapazitaet, aktueller Auftrag, Auslastung. Row action: Linie oeffnen, Stoerung simulieren, Umplanung anzeigen. |
| `demo.bakery.production-planning` | Production Planning | Bakery Operations | `demo.bakery.bakery_production_order` | DataTable mit Filterband | Filter: Datum, Linie, Status, Prioritaet, Produktkategorie. Buttons: Auftrag erzeugen aus Prognose, Umplanung starten, Auftrag freigeben. Double-click: Produktionsauftrag-Dialog. |
| `demo.bakery.demand-heatmap` | Branch Demand Heatmap | Bakery Analytics | `demo.bakery.bakery_branch_inventory` | Dashboard / Map-or-Heatmap + DataTable fallback | Heatmap der Filialnachfrage ueber Standortkoordinaten, Statusfarben fuer Ausverkaufsrisiko. Fallback als gruppierte Tabelle nach Stadt/Filiale/Produkt. |
| `demo.bakery.next-day-forecast` | Next Day Bake Forecast | Bakery Analytics | `demo.bakery.bakery_demand_forecast` | DataTable + Charts | Morgen-Filter, Forecast Qty, Recommended Bake Qty, Confidence, Reason. Buttons: Produktionsauftraege vorschlagen, manuelle Anpassung. |
| `demo.bakery.branch-inventory-monitor` | Branch Inventory Monitor | Bakery Operations | `demo.bakery.bakery_branch_inventory` | DataTable | Spalten: Filiale, Produkt, Bestand, Mindestbestand, erwartete Nachfrage, Status, letztes Update. Row action: Ausverkaufsalert erzeugen. |
| `demo.bakery.equipment-telemetry` | Equipment Telemetry | Bakery Technical | `demo.bakery.bakery_equipment_telemetry` | DataTable + Zeitreihen-Chart | Filter: Anlage, Typ, Zeitraum, Quality Status. Spalten fuer Temperatur, Energie, CO2, Durchsatz, Status. |
| `demo.bakery.energy-co2-monitoring` | Energy And CO2 Monitoring | Bakery Analytics | `demo.bakery.bakery_kpi_snapshot` | Dashboard / Tiles + DataTable | Energieverbrauch pro Produktionseinheit, CO2 je Produktlinie, Trend, Zielwert. Drilldown auf Produktionsauftraege und Telemetrie. |
| `demo.bakery.raw-material-supply` | Raw Material Supply | Bakery Supply Chain | `demo.bakery.bakery_supplier_delivery` | DataTable | Lieferungen mit Rohstoff, Menge, ETA, Verzoegerung, Risiko. Row action: Lieferverzoegerung als Alert erzeugen. |
| `demo.bakery.delivery-operations` | Delivery Operations | Bakery Supply Chain | `demo.bakery.bakery_delivery_route` | Tabs / Master-detail | Tab Routes und Stops. Route mit Status, Optimierung, Verzoegerung; Stopps mit ETA, Filiale, Prioritaet. |
| `demo.bakery.alert-center` | Alert Center | Bakery Operations | `demo.bakery.bakery_alert_event` | DataTable | Filter: Alert Type, Severity, Status, Simulation. Buttons: bestaetigen, in Bearbeitung setzen, loesen, Demo-Event erzeugen. |
| `demo.bakery.master-data` | Bakery Master Data | Bakery Administration | `demo.bakery.bakery_product` | Tabs | Tabs fuer Produkte, Kategorien, Standorte, Linien, Anlagen, Rohstoffe. |

### Dashboard-Kacheln Und KPI-Signale

| Bereich | Kennzahl / Signal | Quelle | Darstellung |
| --- | --- | --- | --- |
| Food Waste | Lebensmittelverschwendung in % und Menge | `bakery_production_order`, `bakery_kpi_snapshot` | KPI tile mit Trend |
| Utilization | Produktionsauslastung | `bakery_production_line`, `bakery_production_order`, KPI Snapshot | Tile + Linienliste |
| Energy | Energie pro Produktionseinheit | `bakery_equipment_telemetry`, `bakery_production_order`, KPI Snapshot | Tile + Zeitreihe |
| Availability | Warenverfuegbarkeit in Filialen | `bakery_branch_inventory`, KPI Snapshot | Heatmap + Kritischliste |
| Delivery | Puenktlichkeit Filialbelieferung | `bakery_delivery_stop`, KPI Snapshot | Tile + Routenstatus |
| Sales | Umsatz pro Produktkategorie | `bakery_kpi_snapshot` | Balken/Tabelle |
| Quality | Temperatur- und Qualitaetsabweichungen | `bakery_equipment_telemetry`, `bakery_alert_event` | Alert-Liste |

## Actions And Behaviors

### Object Actions

| Action alias | Target object | Purpose | Planned behavior |
| --- | --- | --- | --- |
| `SIMULATE_OVEN_FAILURE` | `demo.bakery.bakery_equipment` or `demo.bakery.bakery_production_line` | Demo-Highlight Ofenausfall | Setzt Anlage/Linie auf `FAILURE`/`DOWN`, erzeugt `bakery_alert_event`, erzeugt `bakery_production_event`, markiert betroffene Produktionsauftraege fuer Umplanung. |
| `AUTO_RESCHEDULE_PRODUCTION` | `demo.bakery.bakery_production_order` | Automatische Umplanung | Sucht alternative Linie mit passender Kategorie und Status `READY`, aktualisiert Linie/Zeiten/Status, erzeugt Event. In Demo zunaechst einfache Regel statt Optimierungsengine. |
| `GENERATE_NEXT_DAY_PLAN` | `demo.bakery.bakery_demand_forecast` | Produktionsvorschlaege aus Prognose erzeugen | Gruppiert Prognosen fuer morgen und erzeugt Produktionsauftraege je Produkt/Kategorie. |
| `SIMULATE_DEMAND_SPIKE` | `demo.bakery.bakery_demand_signal` | Nachfrageanstieg vorfuehren | Erzeugt Demand Signal, passt Forecast/Expected Demand an, erzeugt Alert. |
| `REPORT_BRANCH_STOCKOUT_RISK` | `demo.bakery.bakery_branch_inventory` | Filiale meldet drohenden Ausverkauf | Setzt Verfuegbarkeitsstatus auf kritisch, erzeugt Alert, priorisiert Lieferstop oder Produktionsauftrag. |
| `SIMULATE_RAW_MATERIAL_DELAY` | `demo.bakery.bakery_supplier_delivery` | Lieferverzoegerung simulieren | Setzt Lieferung auf `DELAYED`, erhoeht Risiko, erzeugt Alert und optional betroffene Auftraegevents. |
| `ACKNOWLEDGE_ALERT` | `demo.bakery.bakery_alert_event` | Alert bestaetigen | Setzt Status und `acknowledged_on`. |
| `RESOLVE_ALERT` | `demo.bakery.bakery_alert_event` | Alert abschliessen | Setzt Status und `resolved_on`. |
| `CHECK_TEMPERATURE_LIMITS` | `demo.bakery.bakery_equipment_telemetry` | Grenzwertpruefung | Vergleicht Telemetrie mit Anlagenlimits, erzeugt Quality Alert bei Abweichung. |

### Behaviors

| Behavior | Target | Notes |
| --- | --- | --- |
| Status color behavior | Inventar, Linie, Equipment, Alert | Ampelfarben fuer Statusfelder in DataTables und Dashboard. |
| Timestamp default behavior | Live-Event-Tabellen | `detected_on`, `last_update_on`, `measured_on` bei Anlage automatisch setzen, soweit lokal ueblich. |
| KPI aggregation behavior | KPI Snapshot | Kann spaeter als geplante Aktion oder Import umgesetzt werden. |
| Readonly telemetry behavior | Equipment Telemetry | Telemetrie ist fachlich importiert/simuliert; UI sollte Werte nicht standardmaessig editieren. |
| Demo simulation behavior | Alert Event und Production Event | Simulationen markieren `simulation_flag = 1`, damit Demo-Daten filterbar bleiben. |

## Initial Data

Initialdaten sollen genug Substanz fuer eine live wirkende Demo enthalten.

| Entity | Example data |
| --- | --- |
| Locations | 1 Produktion, 1 Lager, 1 Verteilzentrum, 8-12 Filialen mit Koordinaten und Stadt |
| Product Categories | Bread, Rolls, Pastry, Cake, Snacks |
| Products | Baguette, Sourdough Bread, Pretzel Roll, Croissant, Cinnamon Bun, Cheesecake Slice, Sandwich Roll |
| Raw Materials | Wheat Flour, Rye Flour, Yeast, Butter, Sugar, Seeds, Packaging |
| Production Lines | Bread Line 1, Rolls Line 1, Pastry Line 1, Cake Line 1 |
| Equipment | Ovens per line, cooling zone, mixer, packaging, energy meters, temperature sensors |
| Inventory | Unterschiedliche Bestandslagen, mehrere kritische Bestseller-Situationen |
| Forecasts | Heute und morgen je Filiale/Produkt, mit Confidence und Reason Text |
| Production Orders | Laufende, geplante und erledigte Auftraege, mindestens ein Auftrag pro Linie |
| Delivery Routes | 2-3 Routen mit mehreren Stops, eine verzoegerte Route |
| Alerts | Offene Alerts fuer Ofen, Nachfragepeak, Rohstoffverzoegerung, Kuehlung und Ausverkaufsrisiko |
| KPI Snapshots | 7 Tage Historie fuer alle genannten KPIs |

Wichtige Demo-Szenarien als Seed-Daten oder Simulationsaktionen:

| Scenario | Data setup | Expected visible result |
| --- | --- | --- |
| Backofen faellt aus | Ofen auf einer aktiven Linie, laufende Auftraege | Alert kritisch, Linie `DOWN`, betroffene Auftraege `RESCHEDULED` nach Aktion |
| Nachfrageanstieg | Bestseller in mehreren Filialen mit hohem Signal | Heatmap faerbt Filialen kritisch, Forecast steigt |
| Mehl-Lieferung verzoegert | Supplier Delivery fuer Wheat Flour mit ETA +120 Minuten | Supply-Chain-Alert und Risikoanzeige |
| Kuehlung ueber Grenzwert | Cooling Equipment mit Telemetrie ueber Max | Quality Alert, Temperaturtabelle markiert Abweichung |
| Filiale droht Ausverkauf | Branch Inventory fuer Bestseller unter Mindestbestand | Branch Alert, Lieferstop/Produktion mit hoher Prioritaet |

## Security And Page Groups

Geplante Page-Gruppen oder Rollenlogik:

| Page group | Pages | Intended roles |
| --- | --- | --- |
| Bakery Operations | Cockpit, Production Lines Live, Production Planning, Branch Inventory Monitor, Alert Center | Produktionsleitung, Filialleitung, Demo-Operator |
| Bakery Analytics | Demand Heatmap, Next Day Forecast, Energy And CO2 Monitoring | Management, Produktionsleitung, Energiemanagement |
| Bakery Supply Chain | Raw Material Supply, Delivery Operations | Disposition / Supply Chain |
| Bakery Technical | Equipment Telemetry | Technik, Qualitaetsmanagement, Energiemanagement |
| Bakery Administration | Master Data | Admin, Demo-Operator |

Sicherheitsannahmen:

- Demo-Operator darf Simulationsaktionen ausfuehren.
- Filialleitung sieht eigene oder alle Filialen je nach Demo-Konfiguration; Mandanten-/Row-Level-Filter sind noch offen.
- Management sieht aggregierte KPI- und Dashboardseiten.
- Technische Telemetrie kann fuer nicht-technische Rollen read-only sein.

## Open Questions

| Question | Impact | Suggested default for demo |
| --- | --- | --- |
| Soll die Bakery-App rein demohaft Englisch bleiben oder deutsch lokalisiert werden? | Labels, Page-Namen, Seed-Daten | Objektlabels Englisch wie bestehende Metadaten, Page-Titel fachlich Englisch, Doku Deutsch |
| Welche UID-/ID-Konvention soll der SQL-Agent fuer App-Tabellen verwenden? | SQL InitDB und Object Attributes | Lokales ExFace-Pattern aus Core/Demo-Apps vor Implementierung pruefen |
| Gibt es echte Filialstandorte oder sollen Demo-Koordinaten verwendet werden? | Heatmap und Routen | Demo-Koordinaten fuer 8-12 Filialen nutzen |
| Soll eine echte Karten-/Heatmap-Komponente verwendet werden oder DataTable-Fallback? | Page Builder Aufwand | Erst DataTable/Status-Heatmap, Karte als optionaler Ausbau |
| Sollen Prognosen aus GenAI/externem Service kommen? | Integration und Datenschutz | Zunaechst simulierte Prognosewerte in `bakery_demand_forecast` |
| Welche Page Groups existieren bereits in der Zielinstallation? | Security-Handoff | Page-Gruppen im Page Builder anhand lokaler Konvention anlegen oder mappen |
| Wird InitDB oder Migration bevorzugt? | SQL-Handoff | Da App noch keine SQL-Struktur hat, InitDB fuer Baseline planen |
| Sollen Produktionsrezepte/Rohstoffbedarf je Produkt modelliert werden? | Genauigkeit der Rohstoffplanung | Fuer erste Demo offen lassen; optional spaeter `bakery_product_material` ergaenzen |

## Implementation Handoffs

### ExFace InitDB Installer / ExFace SQL Migration Builder

Use this planning document: `demo/bakery/Docs/Planning/smart-bakery-operations.md`.

Recommended path: because `demo.bakery` currently has no app-specific SQL structure, create baseline MySQL InitDB under `demo/bakery/Install/Sql/MySQL/InitDB/` unless the project convention requires migrations.

Implement the SQL tables from section `SQL Tables`:

- `bakery_location`
- `bakery_product_category`
- `bakery_product`
- `bakery_branch_inventory`
- `bakery_demand_forecast`
- `bakery_demand_signal`
- `bakery_raw_material`
- `bakery_supplier_delivery`
- `bakery_production_line`
- `bakery_equipment`
- `bakery_equipment_telemetry`
- `bakery_production_order`
- `bakery_production_event`
- `bakery_delivery_route`
- `bakery_delivery_stop`
- `bakery_alert_event`
- `bakery_kpi_snapshot`

Also add seed/demo data from `Initial Data` if the user requests an installable demo baseline.

### ExFace Object Builder

Use this planning document: `demo/bakery/Docs/Planning/smart-bakery-operations.md`.

Create object folders under `demo/bakery/Model/<object_alias>/` for all aliases listed in `ExFace Objects`. Required files: `02_OBJECT.json` and `04_ATTRIBUTE.json`. Use `bakery_datasource` and the planned `DATA_ADDRESS` values. Implement the detailed attributes for the listed core objects and generate 1:1 attributes plus relations for the remaining SQL-backed objects.

Priority order:

1. Master data: location, product category, product, raw material.
2. Operations: production line, equipment, production order, alert event.
3. Monitoring: inventory, forecast, demand signal, telemetry.
4. Logistics and analytics: supplier delivery, delivery route, delivery stop, production event, KPI snapshot.

After object changes, hand off mandatory SQL migration/initdb alignment to the ExFace SQL Migration Builder.

### ExFace Page Builder

Use this planning document: `demo/bakery/Docs/Planning/smart-bakery-operations.md`.

Create pages from `Pages And Navigation`, starting with:

1. `demo.bakery.smart-bakery-cockpit`
2. `demo.bakery.production-lines-live`
3. `demo.bakery.production-planning`
4. `demo.bakery.demand-heatmap`
5. `demo.bakery.next-day-forecast`
6. `demo.bakery.alert-center`

The first screen should be the operational cockpit, not a landing page. Use practical DataTables, filters, status columns, row actions and dashboard tiles. Heatmap can be implemented as a table/status visualization first if no map widget is available.

### ExFace App Builder

No app scaffold is required: target app already exists as `demo.bakery` in `demo/bakery` with `composer.json`, `Model/00_APP.json`, `Model/05_DATASRC.json` and `Model/06_CONNECTION.json`.

## Simple SQL Datenmodell Und Demodaten

Installierbare Datei: `Install/Sql/MySQL/InitDB/01_tables.sql`.

Die InitDB-Baseline verwendet bewusst einfache `CREATE TABLE IF NOT EXISTS`-Statements und einfache `INSERT INTO`-Statements. Die technischen Primaerschluessel folgen dem lokalen Demo-Pattern mit `oid BINARY(16)`.

### Enthaltene Tabellen

- `bakery_location`
- `bakery_product_category`
- `bakery_product`
- `bakery_branch_inventory`
- `bakery_demand_forecast`
- `bakery_demand_signal`
- `bakery_raw_material`
- `bakery_supplier_delivery`
- `bakery_production_line`
- `bakery_equipment`
- `bakery_equipment_telemetry`
- `bakery_production_order`
- `bakery_production_event`
- `bakery_delivery_route`
- `bakery_delivery_stop`
- `bakery_alert_event`
- `bakery_kpi_snapshot`

### Direkt angehaengte Demodaten

```sql
INSERT INTO `bakery_location` (`oid`, `created_on`, `modified_on`, `location_code`, `name`, `location_type`, `city`, `latitude`, `longitude`, `active_flag`) VALUES
	(UNHEX('BA000000000000000000000000000001'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PROD-01', 'Main Bakery Production', 'PRODUCTION', 'Wuerzburg', 49.7913000, 9.9534000, 1),
	(UNHEX('BA000000000000000000000000000002'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'WH-01', 'Central Flour Warehouse', 'WAREHOUSE', 'Wuerzburg', 49.7950000, 9.9400000, 1),
	(UNHEX('BA000000000000000000000000000003'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'DC-01', 'Morning Distribution Hub', 'DISTRIBUTION_CENTER', 'Wuerzburg', 49.7860000, 9.9600000, 1),
	(UNHEX('BA000000000000000000000000000004'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-101', 'Branch Market Square', 'BRANCH', 'Wuerzburg', 49.7939000, 9.9294000, 1),
	(UNHEX('BA000000000000000000000000000005'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-102', 'Branch University', 'BRANCH', 'Wuerzburg', 49.7809000, 9.9713000, 1),
	(UNHEX('BA000000000000000000000000000006'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-103', 'Branch Riverside', 'BRANCH', 'Wuerzburg', 49.8002000, 9.9251000, 1),
	(UNHEX('BA000000000000000000000000000007'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-104', 'Branch Station', 'BRANCH', 'Wuerzburg', 49.8011000, 9.9366000, 1);

INSERT INTO `bakery_product_category` (`oid`, `created_on`, `modified_on`, `category_code`, `name`, `sort_order`, `active_flag`) VALUES
	(UNHEX('BA000000000000000000000000000101'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BREAD', 'Bread', 10, 1),
	(UNHEX('BA000000000000000000000000000102'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'ROLLS', 'Rolls', 20, 1),
	(UNHEX('BA000000000000000000000000000103'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PASTRY', 'Pastry', 30, 1),
	(UNHEX('BA000000000000000000000000000104'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CAKE', 'Cake', 40, 1);

INSERT INTO `bakery_product` (`oid`, `created_on`, `modified_on`, `product_code`, `name`, `category_oid`, `unit`, `shelf_life_hours`, `bestseller_flag`, `standard_batch_qty`, `active_flag`) VALUES
	(UNHEX('BA000000000000000000000000000201'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BAGUETTE', 'Baguette', UNHEX('BA000000000000000000000000000101'), 'pcs', 18, 1, 160.000, 1),
	(UNHEX('BA000000000000000000000000000202'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'SOURDOUGH', 'Sourdough Bread', UNHEX('BA000000000000000000000000000101'), 'pcs', 36, 1, 120.000, 1),
	(UNHEX('BA000000000000000000000000000203'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PRETZEL_ROLL', 'Pretzel Roll', UNHEX('BA000000000000000000000000000102'), 'pcs', 12, 1, 420.000, 1),
	(UNHEX('BA000000000000000000000000000204'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CROISSANT', 'Croissant', UNHEX('BA000000000000000000000000000103'), 'pcs', 10, 1, 260.000, 1),
	(UNHEX('BA000000000000000000000000000205'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CINNAMON_BUN', 'Cinnamon Bun', UNHEX('BA000000000000000000000000000103'), 'pcs', 14, 0, 180.000, 1),
	(UNHEX('BA000000000000000000000000000206'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CHEESECAKE_SLICE', 'Cheesecake Slice', UNHEX('BA000000000000000000000000000104'), 'pcs', 24, 0, 90.000, 1);

INSERT INTO `bakery_branch_inventory` (`oid`, `created_on`, `modified_on`, `location_oid`, `product_oid`, `stock_qty`, `reserved_qty`, `minimum_qty`, `expected_demand_qty`, `availability_status`, `last_update_on`) VALUES
	(UNHEX('BA000000000000000000000000000601'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000201'), 22.000, 3.000, 20.000, 65.000, 'LOW', '2026-06-23 09:10:00'),
	(UNHEX('BA000000000000000000000000000602'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), 14.000, 2.000, 35.000, 120.000, 'OUT_OF_STOCK_RISK', '2026-06-23 09:12:00'),
	(UNHEX('BA000000000000000000000000000603'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000005'), UNHEX('BA000000000000000000000000000204'), 48.000, 4.000, 25.000, 90.000, 'OK', '2026-06-23 09:15:00'),
	(UNHEX('BA000000000000000000000000000604'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000006'), UNHEX('BA000000000000000000000000000202'), 9.000, 0.000, 18.000, 42.000, 'CRITICAL', '2026-06-23 09:20:00'),
	(UNHEX('BA000000000000000000000000000605'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000007'), UNHEX('BA000000000000000000000000000205'), 36.000, 2.000, 20.000, 44.000, 'OK', '2026-06-23 09:25:00');

INSERT INTO `bakery_alert_event` (`oid`, `created_on`, `modified_on`, `alert_type`, `severity`, `status`, `title`, `message`, `location_oid`, `product_oid`, `production_line_oid`, `equipment_oid`, `production_order_oid`, `detected_on`, `acknowledged_on`, `resolved_on`, `simulation_flag`) VALUES
	(UNHEX('BA000000000000000000000000001501'), '2026-06-23 09:05:00', '2026-06-23 09:05:00', 'OVEN_FAILURE', 'CRITICAL', 'OPEN', 'Rolls tunnel oven above safe range', 'Temperature drift on rolls line requires immediate replanning.', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000203'), UNHEX('BA000000000000000000000000000402'), UNHEX('BA000000000000000000000000000502'), UNHEX('BA000000000000000000000000001002'), '2026-06-23 09:05:00', NULL, NULL, 1),
	(UNHEX('BA000000000000000000000000001502'), '2026-06-23 09:20:00', '2026-06-23 09:20:00', 'DEMAND_SPIKE', 'WARNING', 'OPEN', 'Pretzel roll demand spike', 'Market Square branch reports higher than expected demand.', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), NULL, NULL, NULL, '2026-06-23 09:20:00', NULL, NULL, 1),
	(UNHEX('BA000000000000000000000000001503'), '2026-06-23 09:30:00', '2026-06-23 09:30:00', 'RAW_MATERIAL_DELAY', 'WARNING', 'IN_PROGRESS', 'Wheat flour delivery delayed', 'Supplier ETA moved by 120 minutes.', UNHEX('BA000000000000000000000000000002'), NULL, NULL, NULL, NULL, '2026-06-23 09:30:00', '2026-06-23 09:35:00', NULL, 1),
	(UNHEX('BA000000000000000000000000001504'), '2026-06-23 09:10:00', '2026-06-23 09:10:00', 'COOLING_LIMIT', 'CRITICAL', 'OPEN', 'Warehouse cooling above limit', 'Cooling zone reached 9.2 C and exceeds the configured threshold.', UNHEX('BA000000000000000000000000000002'), NULL, NULL, UNHEX('BA000000000000000000000000000504'), NULL, '2026-06-23 09:10:00', NULL, NULL, 1),
	(UNHEX('BA000000000000000000000000001505'), '2026-06-23 09:12:00', '2026-06-23 09:12:00', 'BRANCH_STOCKOUT_RISK', 'WARNING', 'OPEN', 'Pretzel rolls at stockout risk', 'Branch Market Square may sell out before the next delivery.', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), NULL, NULL, NULL, '2026-06-23 09:12:00', NULL, NULL, 0);

INSERT INTO `bakery_kpi_snapshot` (`oid`, `created_on`, `modified_on`, `snapshot_date`, `snapshot_level`, `kpi_code`, `kpi_name`, `value_num`, `unit`, `location_oid`, `production_line_oid`, `category_oid`, `product_oid`, `trend_direction`, `target_value_num`) VALUES
	(UNHEX('BA000000000000000000000000001601'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'FOOD_WASTE_PCT', 'Food Waste', 2.7000, '%', NULL, NULL, NULL, NULL, 'DOWN', 3.0000),
	(UNHEX('BA000000000000000000000000001602'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LINE', 'LINE_UTILIZATION_PCT', 'Production Utilization', 86.4000, '%', NULL, UNHEX('BA000000000000000000000000000402'), NULL, NULL, 'UP', 82.0000),
	(UNHEX('BA000000000000000000000000001603'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'ENERGY_KWH_PER_UNIT', 'Energy Per Production Unit', 0.1840, 'kWh/unit', NULL, NULL, NULL, NULL, 'STABLE', 0.1900),
	(UNHEX('BA000000000000000000000000001604'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LOCATION', 'BRANCH_AVAILABILITY_PCT', 'Branch Availability', 93.5000, '%', UNHEX('BA000000000000000000000000000004'), NULL, NULL, NULL, 'DOWN', 97.0000),
	(UNHEX('BA000000000000000000000000001605'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'DELIVERY_ON_TIME_PCT', 'Delivery On Time', 91.0000, '%', NULL, NULL, NULL, NULL, 'DOWN', 95.0000),
	(UNHEX('BA000000000000000000000000001606'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'CATEGORY', 'SALES_EUR', 'Sales Bread Category', 12850.0000, 'EUR', NULL, NULL, UNHEX('BA000000000000000000000000000101'), NULL, 'UP', 12000.0000),
	(UNHEX('BA000000000000000000000000001607'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LINE', 'CO2_KG_PER_UNIT', 'CO2 Per Unit Rolls Line', 0.0680, 'kg/unit', NULL, UNHEX('BA000000000000000000000000000402'), NULL, NULL, 'STABLE', 0.0700);
```
