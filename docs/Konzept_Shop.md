# Konzept: Shop-Kundenkonten und Benutzer

Status: Fachliches Zielkonzept mit Admin-Kundenliste und begrenzter Account-Edit-Seite.
Dieses Dokument beschreibt die vereinbarte Trennung zwischen Core-Benutzern
und Shop-Kundenkonten. Nur die unter Umsetzungsstand genannten Funktionen
sind bereits umgesetzt; der uebrige Text bleibt Zielkonzept.

## Verbindliche Pflege

Bei jeder Anpassung oder Erweiterung des Shop-Konzepts muss diese Markdown-Datei
im selben Arbeitsschritt entsprechend aktualisiert werden. Das gilt auch fuer
Aenderungen bei der spaeteren Umsetzung, insbesondere an Datenmodell,
Pattern-Struktur, Account-Zuordnungen und fachlichen Regeln.
Ueberholte Aussagen ersetzen und Konzept, Umsetzungsstand sowie ausdruecklich
zurueckgestellte Funktionen widerspruchsfrei halten. Keine automatische
Dokumentgenerierung zur Laufzeit.

## 1. Zustaendigkeiten

- Der Core verwaltet `USER`: eine persoenliche Identitaet mit Anmeldung,
  E-Mail-Adresse, Passwort, Aktivstatus und allgemeinen Benutzergruppen.
- Eine E-Mail-Adresse darf nur einem Core-User zugeordnet sein. Die
  Registrierung muss diese Eindeutigkeit sicherstellen.
- Core-Benutzergruppen regeln allgemeine Anwendungsrechte, beispielsweise
  Administrator oder normaler Benutzer. Sie sind keine Shop-Kundengruppen.
- Der Shop verwaltet `ACCOUNT`: das kaufmaennische Kundenkonto einer Firma
  oder eines Privatkunden mit Adressen, Merklisten und Bestellungen.
- Ein Privatkunde verwendet dasselbe Modell: normalerweise ein Account mit
  einem zugeordneten User. Keine gesonderte Privatkunden-Architektur.
- Shop-Kundengruppen fuer spaetere Konditionen oder Preise gehoeren fachlich
  zum Account, nicht zur persoenlichen Core-Benutzergruppe. Ihre konkrete
  Umsetzung ist hier noch nicht festgelegt.
- Shop-Accounts und ihre Benutzerzuordnungen liegen ausschliesslich in der
  Shop-Datenbank. Keine Account-Stammdaten oder Gegenzuordnungen im Core
  duplizieren. Die bisherigen Core-Pattern `ACCOUNT` und `USER.D.ACCOUNT`
  wurden auskommentiert; das allein migriert oder entfernt keine Bestandsdaten.

## 2. Mehrere Benutzer und mehrere Accounts

Die Beziehung zwischen Core-User und Shop-Account ist n:m:

- Ein Firmenaccount kann mehrere Mitarbeiter als User zugeordnet haben.
- Ein User kann mehreren Accounts zugeordnet sein, beispielsweise als
  Einkaeufer fuer zwei Unternehmen.
- Dafuer wird weder eine zweite E-Mail-Adresse noch ein weiterer Login benoetigt.
- Jeder Mitarbeiter meldet sich mit seinem persoenlichen Core-User an.
  Es gibt keine gemeinsam verwendeten Firmen-Zugangsdaten.

Die Zuordnung wird nur einmal gespeichert: im Shop unter
`ACCOUNT.D[AccountId].USER.D[CoreUserId]`. Die Datensatz-ID der Zuordnung
ist die referenzierte Core-User-ID; E-Mail und Passwort werden nicht kopiert.
Ein `Active`-Feld kennzeichnet die aktive Mitgliedschaft.
Der Shop prueft die Existenz und den Aktivstatus des referenzierten Core-Users.

## 3. Berechtigungen und Account-Kontext

Zunaechst duerfen alle aktiv zugeordneten User saemtliche fuer Kunden
vorgesehenen Funktionen innerhalb des ausgewaehlten Accounts verwenden.
Es gibt vorerst keine individuellen Mitgliedsrechte, Rollen oder Felder wie
`ManageUsers`, `EditBasket` oder `PlaceOrder`.

Das ist keine Freigabe fremder Accounts oder allgemeiner Backend-
Administratorrechte. Bei jedem geschuetzten Account-Zugriff muessen
angemeldeter User, aktiver Account und aktive Mitgliedschaft geprueft werden.
Eine vom Browser uebergebene oder in der Sitzung gespeicherte Account-ID
ersetzt diese Pruefung nicht.

Die Sitzung unterscheidet fachlich zwischen:

```text
UserId        = angemeldete Person
ShopAccountId = ausgewaehltes Shop-Kundenkonto
```

Diese Bezeichnungen beschreiben das Ziel, keine bereits erfolgte Umbenennung
bestehender Session-Felder. Bei mehreren zugeordneten Accounts muss ein Wechsel
des Account-Kontexts moeglich sein. Account-bezogene Daten duerfen beim Wechsel
nicht zwischen Firmen vermischt werden.

Wie neue Mitglieder eingeladen und Zuordnungen bestaetigt werden, ist noch
festzulegen. Die Kenntnis einer E-Mail-Adresse allein darf keine fremde
Identitaet uebernehmen oder einen bestehenden User ungeprueft zuordnen.

## 4. Vorgesehene Pattern-Struktur

Moduldefinitionen liegen gemaess allgemeiner Modulregel in
`system/default/default.pattern.php`; `init.php` laedt und registriert sie
isoliert beim Shop-CData. Folgender Baum zeigt das fachliche Ziel,
nicht einen bereits umgesetzten Pattern-Stand:

```text
ACCOUNT
  D[AccountId]
    Active
    Name
    Number
    D
      USER
        D[CoreUserId]
          Active
      ADDRESS
        D[AddressId]
          ... Adressdaten
      MEMO
        D[ListId]
          Active
          Name
          OwnerUserId
          D
            ARTICLE
              D[ArticleId]
                Active
                Quantity
      ORDER
        D[OrderId]
          CreatedByUserId
          ... Bestelldaten und historische Positionen
```

`D` ist die vorhandene CData-Datensatzebene. Account-ID und Core-User-ID sind
unterschiedliche Identitaeten und duerfen nicht gleichgesetzt werden.
`Number` bezeichnet gemaess aktuellem Pattern eine fachliche Kundennummer,
nicht die Login-ID.
Bestehende Pattern-Felder werden nicht allein durch dieses Konzept umbenannt.

### Umsetzungsstand: Admin-Kundenliste

`admin__account.list` verwendet ausschliesslich die vorhandenen Shop-Patterns:

- Account-ID, `Number`, `Name` und `Active`; Adressen mit Kontaktinformationen
  sowie Anzahl der Benutzerzuordnungen, Merklisten und Bestellungen.
  Zaehler enthalten alle vorhandenen Zuordnungen/Datensaetze, auch inaktive.
- `Active`, `Name` und `Number` stehen als Account-Felder direkt unter
  `ACCOUNT`, nicht innerhalb der Untertypdefinition `ACCOUNT.D`.
  Diese Verschachtelung wurde nach ausdruecklicher Freigabe korrigiert;
  keine neuen Pattern-Felder und keine Bestandsdatenmigration.
- Aktivierung und Deaktivierung erfolgen ueber den Aktiv-Haken und Speichern.
  Name, Kundennummer und Unterdaten sind in dieser Liste nur lesbar.
- Accounts ohne Bestellungen koennen nach Bestaetigung zum Loeschen markiert
  werden. Erst Speichern entfernt Account samt Adressen, Shop-Mitgliedschaften
  und Merklisten. Die referenzierten Core-User bleiben erhalten.
- Bei Accounts mit Bestellungen ist der Loeschbutton ausgeblendet.
  Auch manipulierte Loeschanfragen werden serverseitig abgelehnt,
  ohne den Account automatisch zu deaktivieren. Zum Deaktivieren muss der
  Benutzer ausdruecklich den Aktiv-Haken entfernen und speichern.
- Bei ungueltigen Eingaben, verschwundenen Accounts oder geschuetzten
  Loeschzielen wird der gesamte angefragte Speichervorgang vor dem Schreiben
  abgelehnt und eine Fehlermeldung angezeigt. Keine Neuanlage ueber diese Liste.
  Eingaben werden gemeinsam ueber die erlaubten Feldnamen und strikten
  0/1-Werte geprueft; bestehende Accounts werden gesammelt geladen.
  Die paginierte Anzeige verwendet denselben Ladepfad auch beim Zuruecksetzen
  einer nicht mehr vorhandenen Seite auf die letzte Seite.
- Leere oder ungueltige Account-IDs sind nicht vorgesehen. Die Liste erlaubt
  fuer solche IDs keine Aenderungen; ein bereinigungsbeduerftiger Altbestand
  wird gesondert untersucht, nicht bei normalen Seitenaufrufen automatisch geloescht.
- Keine allgemeine Bedienungsbeschreibung oder dauerhafte Altbestandswarnung
  oberhalb der Tabelle anzeigen. Konkrete Speicherfehler bleiben sichtbar.
- Speichern ausschliesslich per POST; Abbrechen verwirft nicht gespeicherte
  Aenderungen. Speichern/Abbrechen stehen in der gemeinsamen unteren Aktionsleiste.
  Die Liste zeigt maximal 50 Accounts je Seite. Eine breite Tabelle scrollt
  ausschliesslich im lokalen responsiven Container.
- Der Bearbeiten-Button oeffnet `admin__account.edit` mit der Account-ID
  unter `R[Id]`. Fuer ungueltige Bestands-IDs wird kein Edit-Link angeboten.
- Die ueberarbeitete Seite verwendet `{i18n}` und die deutsche Modul-Sprachdatei.
  Eine englische Uebersetzung ist gemaess Modulregel vor Veroeffentlichung faellig.

Die Liste implementiert keine Registrierung, Einladung, Account-Auswahl,
Mitgliedschaftsverwaltung oder individuellen User-Rechte und keinen Basket.

### Umsetzungsstand: Admin-Kundenkonto bearbeiten

`admin__account.edit` bearbeitet ausschliesslich vorhandene Account-Unterdaten
gemaess unveraendertem Pattern:

- Account-ID, Name und Kundennummer werden nur angezeigt.
- Alle zu diesem Account gehoerenden Adressen werden angezeigt, auch inaktive.
  Editierbar sind `Active`, `FName`, `LName`, `Street`, `HNumber`, `Postcode`,
  `City`, `CountryId`, `Phone` und `Mail`.
- Adressen koennen nach Bestaetigung zum Loeschen markiert werden.
  Erst Speichern entfernt die Adresse. Bestelldaten und dort gespeicherte
  historische Adressen bleiben unveraendert.
- Alle Benutzerzuordnungen werden mit Core-User-ID, Name und E-Mail aufgelistet.
  Ein gesonderter Status zeigt, ob der Core-User aktiv, inaktiv oder nicht
  mehr vorhanden ist. Ausser Name, E-Mail und Aktivstatus werden keine
  Core-User-Attribute, insbesondere keine Passwortfelder, ans Template weitergegeben.
- Der Aktiv-Haken je Zuordnung aendert ausschliesslich deren
  `ACCOUNT.D[AccountId].USER.D[CoreUserId].Active`. Deaktivieren oder erneutes
  Aktivieren aendert weder den Core-User noch seine Mitgliedschaft in anderen
  Accounts. Eine aktive Zuordnung ersetzt keine erforderliche aktive
  Core-Anmeldung.
- Speichern erfolgt ausschliesslich per POST. Es werden nur vorhandene
  Adressen und Zuordnungen dieses Accounts akzeptiert, keine Neuanlage,
  fremden Accounts, zusaetzlichen Felder oder Loeschung von User-Zuordnungen.
  Bei ungueltigen Eingaben wird die gesamte Aenderung vor dem Schreiben
  abgelehnt und ein Fehler angezeigt. Nach Speichern werden die Daten neu geladen.
- Fehlende oder ungueltige Account-IDs erzeugen eine sichtbare Fehlermeldung
  ohne Speichern-Button. Eine Account-ID `0` bleibt eine gueltige ID.
- Speichern und Abbrechen stehen in der gemeinsamen unteren Aktionsleiste.
  Abbrechen kehrt zur Kundenliste zurueck, ohne Aenderungen zu speichern.
  Die Seite verwendet deutsche Modul-Sprachvariablen und bestehende
  `input`-Controls mit registrierten Formularnamen.

Anlegen von Accounts, Adressen oder Benutzerzuordnungen sowie Bearbeiten
persoenlicher Core-User-Daten bleiben ausserhalb dieser Seite.
Individuelle Mitgliedsrechte und Basket werden weiterhin nicht umgesetzt.

## 5. Adressen und Merklisten

Adressen gehoeren zum jeweiligen Account. Mehrere Rechnungs- und
Lieferadressen sind moeglich; deren konkrete Kennzeichnung wird bei der
spaeteren Umsetzung festgelegt.

Jeder User kann eigene benannte Memo-/Wunschlisten innerhalb eines Accounts
anlegen. `OwnerUserId` kennzeichnet den Ersteller beziehungsweise Eigentuemer;
dieses Feld fuehrt vorerst keine private Sichtbarkeit oder Bearbeitungssperre
ein. Gemaess aktuellem Berechtigungsmodell duerfen alle zugeordneten User
auch diese Listen innerhalb ihres Accounts verwenden und bearbeiten.
Ein zusaetzliches `Shared`-Feld oder private Listenrechte werden vorerst
nicht vorgesehen.

Listen bleiben an ihren Account gebunden, auch wenn derselbe User fuer
mehrere Firmen arbeitet. Artikelzuordnungen koennen eine gewuenschte Menge
enthalten. Eine spaetere Uebernahme in einen Warenkorb soll Artikel und Mengen
kopieren, nicht die Liste loeschen oder dauerhaft live verknuepfen.
Diese Uebernahme wird jetzt nicht umgesetzt.

## 6. Bestellungen

Eine Bestellung gehoert zum Kundenaccount. `CreatedByUserId` dokumentiert
zusaetzlich die ausloesende Person, nicht den Kundenaccount.

Rechnungs- und Lieferadressen, Artikelbezeichnungen, Mengen, Preise und
Steuern werden zum Bestellzeitpunkt als historische Momentaufnahme
gespeichert. Spaetere Aenderungen an Usern, Accounts, Adressen oder Artikeln
duerfen bestehende Bestellungen nicht nachtraeglich umschreiben.
Das Entfernen einer Mitgliedschaft entfernt keine Bestellhistorie.

## 7. Ausdruecklich zurueckgestellt

- Individuelle User-Rechte und Rollen innerhalb eines Accounts.
- Private beziehungsweise differenziert freigegebene Merklisten.
- Basket-Pattern, gemeinsame Warenkoerbe und deren technische Umsetzung.
- Warenkorb-Synchronisierung, Parallelbearbeitung und Checkout-Anbindung.

Der langfristige Wunsch eines gemeinsam befuellten und spaeter gemeinsam
bestellten Warenkorbs bleibt festgehalten. Dafuer werden jetzt aber keine
Basket-Felder, Positionsstrukturen oder Sperr-/Versionsmechanismen eingefuehrt.
Vorhandener Warenkorbcode wird durch diese Dokumentation nicht veraendert.

## 8. Spaetere Umsetzung und Pruefung

Vor der Implementierung bestehende Account-Verwendungen, Session-Felder
und Datenbankinhalte pruefen und eine erforderliche Migration gesondert planen.
Insbesondere den bisher aus dem Core stammenden Account-Begriff nicht
ungeprueft mit dem neuen Shop-Account gleichsetzen.

Mindestens pruefen:

- Ein Core-User kann zwei Shop-Accounts ohne zweiten Login verwenden.
- Mehrere User koennen demselben Account zugeordnet sein.
- Ein User ohne aktive Zuordnung kann nicht auf einen fremden Account zugreifen.
- Alle aktiven Mitglieder haben vorerst dieselben Account-Befugnisse.
- Account-Wechsel trennt Adressen, Merklisten und Bestellungen zuverlaessig.
- Persoenliche Login-Daten bleiben ausschliesslich im Core.
- Bestellhistorie bleibt bei Aenderungen an Stammdaten oder Mitgliedschaften erhalten.
- Bestehende Daten werden nur durch eine ausdrueckliche Migration veraendert.
