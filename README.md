
# Worum geht es?
Einführungstext von Thomas Schmid.

# Technischer Leitfaden
## Ziel
Dieser Leitfaden richtet sich an technisch versiertes IT-Personal und erklärt die nötigen Schritte, die unternommen werden müssen, um den OpenSource Vereinbarkeitssimulator für das eigene Unternehmen online verfügbar zu machen.

## Technische Voraussetzungen 
Der Vereinbarkeitssimulator ist eine in R entwickelte Shiny-Applikation, die von den Benutzern online via Browser genutzt werden kann. Grundsätzlich gibt es die folgenden Möglichkeiten, die Software im Unternehmen zugänglich zu machen:

### Variante I: Installation unter [www.shinyapps.io](www.shinyapps.io)
Diese Installationsvariante wird in den nachfolgendenden Kapiteln genauer beschrieben. Wenn Sie diesen Weg wählen, benötigen Sie keine eigene Hardware, um den Vereinbarkeitssimulator betreiben zu können. Stattdessen eröffnen Sie einen Account unter www.shinyapps.io, unter dem Sie dann die hier angebotene Software installieren und betreiben. Die Kosten für einen Account sind abhängig von der *aktiven Zeit* pro Monat, d.h. die Zeitdauer, während der die Anwendung von Ihren Anwendern genutzt wird. Details dazu finden Sie [hier](https://www.shinyapps.io/#pricing). 

### Variante II: Installation auf dem eigenen Shiny-Server
Bei dieser Variante benötigen Sie Zugang zu einem Linux-Server mit Administrator-Rechten, auf dem Sie für Ihr Unternehmen einen Shiny-Server installieren und die darauf verwaltete Webapplikation im Intranet für Ihr Unternehmen verfügbar machen können. 

Diese Variante erfordert weiterführende Kenntnisse im Bereich Linux-, Server- und Netzwerk-Administration und wird hier nicht weiter behandelt. Informationen zum Download der Server-Software finden Sie [hier](https://www.rstudio.com/products/shiny/download-server/).

## Upload des Vereinbarkeitssimulators unter [www.shinyapps.io](www.shinyapps.io)

Unabhängig von der Variante der gewählten Installation benötigen Sie einen PC mit Internetverbindung, auf dem Sie R-Studio installieren können und auf dem Sie berechtigt sind, Software zu installieren. Im Folgenden werden die nötigen Schritte zur Installation nach Variante I erläutert.

### Vorbereitungen

#### Erstellung eines Accounts unter shinyapp.io
Um den Vereinbarkeitssimulator für Ihre Mitarbeiter im Internet zugreifbar zu machen benötigen Sie einen Account unter [https://www.shinyapps.io/](https://www.shinyapps.io/). Eröffnen Sie als erstes einen Account. Sie können problemlos zuerst einen kostenlosen Account eröffnen, damit herumexperimentieren und wenn alles funktioniert, den "Plan"" unter den Account-Settings erweitern. Wenn Sie den Simulator im Unternehmen nützen wollen, sollten Sie aber auf jeden Fall sicherstellen, dass der Plan Ihren Anforderungen entspricht.

Sie können Accountname und Applikationsname wählen und haben somit Einfluss auf die URL, unter welcher der Simulator später zugreifbar sein wird:

https://accountname.shinyapps.io/{applicationName}

Sobald Sie einen Account eingerichtet haben sind Sie bereit, Applikationen zu veröffentlichen.

### Installation benötigter Software auf Ihrem PC
Damit Sie den Vereinbarkeitssimulator veröffentlichen können benötigen Sie einen PC mit Zugriff zum Internet sowie der Installierten Software RStudio/R. Gehen Sie dazu wie folgt vor:

  - Installation von R (siehe Anleitung [hier](http://web.cs.ucla.edu/~gulzar/rstudio/))
  - Installation von RStudio (siehe Anleitung [hier](https://www.rstudio.com/products/rstudio/download/))
  - Installation gewisser R Packages (siehe Anleitung [hier](http://web.cs.ucla.edu/~gulzar/rstudio/))
    * rsconnect (Details zur Konfiguration siehe [hier](https://shiny.rstudio.com/articles/shinyapps.html))
    * shiny
    * dplyr
    * knitr
    * kableExtra
    * rmarkdown
    * testthat

Wichtig ist, dass Sie nach der Installation dieser Packete rsconnect richtig konfigurieren, dass RStudio Ihren shinyapps.io-Account kennt, unter welchem Sie später die Applikation veröffentlichen wollen. Nach diesen Schritten ist Ihr PC bereit, um den Vereinbarkeitssimulator lokal zu starten und auf shinyapps.io zu publishen.

### Herunterladen des Vereinbarkeitssimulators
Besuchen Sie die [github-Seite](https://github.com/ims-fhs/vsim) dieses Projektes und laden Sie das Projekt komplett herunter (clicken Sie auf den Download-Link). Sie Sie erhalten dann ein ZIP-Verzeichnis mit allen benötigten Dateien des Vereinbarkeitssimulators.

Entzippen Sie das ZIP-Archiv an einen Ort, wo Sie berechtigt sind, Dateien zu schreiben und öffnen Sie die RStudio-Projektdatei 'vsim.Rproj'. Wenn alles richtig funktioniert hat, wird nun das Projekt automatisch mit RStudio geöffnet. Falls nicht, starten Sie RStudio und öffnen Sie manuell das Projekt durch die Auswahl des Menupunktes 'File/Open Project' und Navigation zum entzippten Projekt-Verzeichnis.

### Vereinbarkeitssimulator lokal testen
Nachdem Sie das Projekt in RStudio geöffnet haben, öffnen Sie nun im RStudio die Datei inst/shiny-apps/vsim/server.R und drücken Sie Ctrl-Shift-S, um die Applikation zu starten. Nun öffnet sich ein Browserfenster mit der Startseite des Vereinbarkeitssimulators. Funktioniert dies nicht, prüfen Sie allfällige Fehlermeldungen, beheben Sie deren Ursache und versuchen Sie diese Schritte erneut auszuführen.

### Vereinbarkeitssimulator veröffentlichen
Wenn Sie rsconnect korrekt eingerichtet und konfiguriert haben, das Projekt 'vsim.Rproj' in RStudio gestartet und das server.R-Skript aus dem Verzeichnis inst/shiny-apps/vsim/server.R geöffnet haben, sollte oben rechts am Editor-Rand das Publish-Icon von shinyapps.io ersichtlich sein:

Ist dieses Icon nicht sichtbar, überprüfen Sie nochmals die Schritte zur Konfiguration von rsconnect und Ihrem shinyapps.io-Account, löschen Sie die shinyapps.io-Konfiguration unter den Einstellungen im RStudio über den Menupunkt Tools/Global Options/Publishing und konfigurieren Sie die Verknüpfung zu Ihrem shinyapps.io-Account erneut. Befolgen Sie dazu [diese Anweisungen](https://shiny.rstudio.com/articles/shinyapps.html).

Klicken Sie auf das Publish-Icon, haben Sie die Möglichkeit, die Applikation unter dem oben eingerichteten shinyapps.io-Account zu veröffentlichen und den Applikationsnamen, unter dem der Simulator verfügbar gemacht werden soll, anzugeben:

Geben Sie unter "Title" den Namen an, unter dem die Anwendung veröffentlicht werden soll. Klicken Sie nun auf den "Publish"-Button, um die Anwendung unter ihrem eingerichteten shinyapps.io-Account zu veröffentlichen. Der Veröffentlichungsvorgang dauert eine Weile und endet damit, dass die Webapplikation auf shinyapps.io im Browser geöffnet wird.

Angenommen Ihr Account lautet auf den Namen "mycompany" und Sie hätten unter "Title" den Applikationsnamen "vsim" gewählt, dann wäre der Simulator nach der Veröffentlichung unter folgender URL zu erreichen:

https://mycompany.shinyapps.io/vsim

Prüfen Sie als letztes, ob die Applikation wirklich unter der erwarteten URL verfügbar ist. War dieser Schritt ebenfalls erfolgreich, ist die Installation / Veröffentlichung abgeschlossen. 
