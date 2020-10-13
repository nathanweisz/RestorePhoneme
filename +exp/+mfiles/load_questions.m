function [questions, targetwords, distractorwords] = load_questions()

targetwords={'Rosen', 'Rasen', 'Luft', 'Kasse', 'Gebiete', 'Tagtraum',...
    'Schlüssel', 'Kaffee', 'Stelle', 'Essen', 'Ende', 'Augen', 'Land',...
    'Versionen', 'Norden', 'Tigerkatze', 'Tür', 'Name'};
    
distractorwords={'Arbeit', 'Wiese', 'Tag', 'Tische', 'Element', 'Schildes',...
    'Richtung', 'Schultern', 'Büro', 'Gleitflug', 'Gefühl', 'Kugel', 'Fleck',...
    'Erklärung', 'Meinung', 'Menagerie', 'Flur', 'Höhle'};


questions = {};
    questions{1}.true = {'Marlene hat sich in einem Fitnessstudio angemeldet.'};
    questions{1}.false = {'Marlene belegte einen Sprachkurs an der Volkshochschule.', 'Dem Vorbesitzer wurde der Pachtvertrag gekündigt, weil er die Pacht nicht mehr gezahlt hat.', 'Auf dem Gartengrundstück wächst ein Apfelbaum.'};
    questions{2}.true = {'Marlene beschloss den Kauf einer Schubkarre auf den nächsten Monat zu verschieben.', 'Einer der Zwerge hatte dicke, rote Pausbacken.'};
    questions{2}.false = {'Die Zwergengruppe besteht aus vier Zwergen.', 'Theo bietet ihr Hilfe beim Schneiden ihrer Hecken an.'};
    questions{3}.true = {'Marlene hoffte insgeheim Theo würde die Wiese für Sie schneiden.', 'Marlenes Freundin heißt Vera.', 'Marlene war einige Tage krank.'};
    questions{3}.false = {'Ihr Nachbar brachte Marlene ein Fischbrötchen mit.'};
    
    questions{4}.true = {'Sadie hatte bisher in einer Arztpraxis gearbeitet', 'An der hinteren Wand verlief ein lang gezogener Tresen aus Glas.'};
    questions{4}.false = {'Cat hatte das Schild über der Tür selbst gemalt.', 'Der Name von Sadies Tochte ist Luna.', };
    questions{5}.true = {'Sadie hatte die Designs für die Kekse zigfach vorgezeichnet'};
    questions{5}.false = {'Sadie wohnt zusammen mit Lissy und Cat.', 'Sadie und Cat wünschen sich Lichterketten zur Dekoration des Schaufensters', 'Den Keksteig herzustellen, würde mehr als eine Stunde Zeit in Anspruch nehmen.'};
    questions{6}.true = {'Sadie dachte zunächst, dass der Mann in einem französischen Akzent spricht.', 'Der Mann trug eine schwarze Lederjacke.', 'Das Pfannkuchenrestaurant heißt "Let‘s Go Dutch".'};
    questions{6}.false = {'Dem Mann gehört eine französische Patisserie.'};
    
    questions{7}.true = {'Ihr Chef fragte Sie, ob er ihr den Kaktus wieder abnehmen soll.', 'Ihr Chef suchte seinen Autoschlüssel.'};
    questions{7}.false = {'Ihr Chef trägt Tüten voll mit Akten.', 'Nelly brauchte lange um ihr Handy zu finden.'};
    questions{8}.true = {'Er stolperte über die Tür des Aktenschrankes.', 'Er sagte, es sei nur eine kleine Schramme.'};
    questions{8}.false = {'Sie fand schließlich das gesuchte Pflaster.', 'Durch seine Zahnspange, sah er manchmal aus wie ein dummer kleiner Junge.'};
    questions{9}.true = {'Sie hatte gerade alles zusammengepackt, als er sie noch einmal zu sich bat', 'In dem Geschenkpapier war eine aufklappbare Box verpackt.' };
    questions{9}.false = {'Nelly schlägt ihrem Chef vor sich zu duzen.', 'Es war November.'};
    
    questions{10}.true = {'Die meisten Möwen sind zufrieden damit von der Küste zum Futter und zurück zu kommen.', 'Wenn er ganz dicht über dem Wasser dahinflog konnte er sich länger und müheloser in der Luft halten.', 'Jonathan verbrachte Tage mit seinen Experimenten im tiefen Gleitflug.'};
    questions{10}.false = {'Jonathans Vater meint, Zweck des Fliegens sei es von A nach B zu kommen.'};
    questions{11}.true = {'Er ließ eine Sardine fallen, die ihm eine Möwe abjagen wollte.', };
    questions{11}.false = {'Immer wenn er zum Sturzflug ansetzte, versagte ein Flügel im Aufschlag.', 'Einmal versuchte er den Sturzflug.', 'Als er wieder zu sich kam war es bereits morgens.'};
    questions{12}.true = {'Jonathan flog durch die Nacht.', 'Die innere Stimme warnt ihn, dass er keine Augen wie die Eule habe.'};
    questions{12}.false = {'Jonathan beschließt Richtigung Meer zu fliegen.', 'Bei seinem letzten Versuch war der Anprall des Flugwindes auf die Flügel stärker als vorher.'};
    
    questions{13}.true = {'Das Landesinnere ist von einer baumlosen Landschaft mit wenigen Hügeln geprägt', 'Herden von Karibus ziehen auf der Suche nach Pflanzen umher.', 'Die Inuit gelten als ausgeglichene und fröhliche Menschen'};
    questions{13}.false = {'Die Eskimos haben einen auffällig kleinen Kopf.'};
    questions{14}.true = {};
    questions{14}.false = {'Weit entfernt voneinander lebende Stämme unterscheiden sich vor allem in Wortschatz und Satzbau voneinander', 'Die Eskimo nennen sich selbst Inuit was übersetzt "Männer aus Eis" bedeutet.', 'Ein gutes Beispiel für unterschiedliche Dialekte sind die Inuit aus Alaska und Grönland.', 'Die Bewohner der Inseln im südwestlichen Alaska unterscheiden sich durch einen kräftigeren Körperbau von den übrigen Inuit.'};
    questions{15}.true = {'Nach einer Theorie waren die ersten Eskimos primitive Indianerstämme', 'Einer Theorie nach wanderten die Eskimos über eine schmale Landbrück zwischen dem asiatischen und dem amerikanischen Kontinent.', 'Nach einer Theorie wurden die Eskimo nach Auseinandersetzungen mit anderen Volksgruppen gen Norden verdrängt.'};
    questions{15}.false = {'Die Fähigkeit zur flexiblen Mutation ist keine Erklärung für den gedrungenen Körperbau der Eskimo.'};
    
    questions{16}.true = {'In der Regel bringt die Post hauptsächlich Reklamekram und Briefumschläge für ihre Mutter.', 'Sofies Vater war Kapitän.', 'Das Haus in dem Sofie lebt ist rot.'};
    questions{16}.false = {'Sofies Katze heißt Tom.'};
    questions{17}.true = {'Sofie setzte sich mit dem Brief in die Küche.', '„Das Mädchen mit den Flachshaaren“ ist eine Komposition.'};
    questions{17}.false = {'Ihr Vater hätte sie zuerst gerne Saskia genannt.', 'Sofie hat blonde Haare.'};
    questions{18}.true = {'In dem Umschlag war ein Zettel, der genauso aussah wie der erste.'};
    questions{18}.false = {'Die Katze Sherekan verschwand im Haus.', 'Sofies Großvater ist tot.', 'Der Briefkasten ist gelb.'};