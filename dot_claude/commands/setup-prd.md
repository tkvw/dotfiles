Genereer een PRD.md voor dit project.

Lees eerst CLAUDE.md voor context over het project.
Interview me daarna met de AskUserQuestion tool.
Bundel gerelateerde vragen, max 2-3 per keer.

Onderwerpen:

- Welk probleem lost dit op en waarom bestaat het?
- Doelgroep
- Design principes
- Packages/modules: welke, wat doen ze, hoe hangen ze samen?
- Gewenste publieke API per package/module
- Non-functional requirements (bundle size, runtime support, performance)
- Wat is bewust NIET in scope?

Roadmap:

- Welke packages/features zijn er in totaal?
- Wat is de status van elk? (actief, gepland, idee)
- Wat is de volgorde en waarom?
- Waar ligt nu de focus?

Markeer in de PRD duidelijk wat de huidige focus is.
Voor geplande onderdelen: beschrijf het doel, maar niet de
implementatiedetails. Voor actieve onderdelen: beschrijf de
volledige API en requirements.

Voeg toe aan de PRD:
"Focus op de huidige fase. Houd rekening met toekomstige fases
in API design (niet blokkeren), maar implementeer ze niet."

Sla onderwerpen over die al duidelijk zijn uit CLAUDE.md.
Schrijf het resultaat naar PRD.md in de project root.

Voeg een verwijzing naar PRD.md toe in CLAUDE.md onder een

## Context sectie, als die er nog niet staat.
