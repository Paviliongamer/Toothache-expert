(defrule ask-experienced-ticklish
	(main)
=>
	(printout t "Question: Do you experienced a ticklish feeling on your tooth when having something cold or hot ? " crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?experienced-ticklish (read))
	(assert (experienced-ticklish ?experienced-ticklish)))

	(defrule ask-sensitive-tooth
	(experienced-ticklish ?experienced-ticklish)
=>
	(if (eq ?experienced-ticklish yes)
	then
	(printout t "We suspect that you have a sensitive tooth" crlf crlf)
	(assert(have-sensitive-tooth yes))
	else
	(assert(have-sensitive-tooth no))))

(defrule ask-inflammation
	(have-sensitive-tooth yes)
=>
	(printout t "Question: Do you have inflammation around the base of your teeth ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?inflammation (read))
	(assert(inflammation ?inflammation)))

(defrule ask-pulpitis
	(inflammation ?inflammation)
=>
	(if (eq ?inflammation yes)
		
	then
	(printout t "We suspect that you have pulpitis" crlf crlf)
	(assert(have-pulpitis yes))
	else
	(assert(have-pulpitis no))))

(defrule ask-swollen
	(or
	(have-sensitive-tooth no)
	(have-pulpitis no))
=>
	
	(printout t "Question: Do you have swollen, tender, red or bleeding gum ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?swollen (read))
	(assert(swollen ?swollen)))

(defrule ask-bad-breath
	(swollen ?swollen)
=>
	(if (or (eq ?swollen no)
	(eq ?swollen yes))
	then
	(printout t "Question: Do you have a bad breath ? " crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?bad-breath (read))
	(assert (bad-breath ?bad-breath))
	else
	(assert(have-gum-disease no))))



(defrule ask-gum-disease
	(swollen ?swollen)
	(bad-breath ?bad-breath)
=>
	(if (and (eq ?swollen yes)
		(eq ?bad-breath yes))
	then
	(printout t "We suspect that you have gum disease" crlf crlf)
	(assert(have-gum-disease yes))
	else
	(assert(have-gum-disease no))))


(defrule ask-sugary-food
	(have-gum-disease yes)
=>
	(printout t "Question: Do you consume a lot of sugary food ? " crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?sugary-food (read))
	(assert ( sugary-food ?sugary-food)))

(defrule ask-visible-hole
	(sugary-food ?sugary-food)
=>
	(if (eq ?sugary-food yes)
	then
	(printout t "Question: Do you have visible hole on your teeth ? " crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?visible-hole (read))
	(assert (visible-hole ?visible-hole))
	else
	(assert(have-cavities no))))

(defrule ask-cavity
	(sugary-food ?sugary-food)
	(visible-hole ?visible-hole)
=>
	(if (and (eq ?sugary-food yes)
		(eq ?visible-hole yes))
	then
	(printout t "We suspect that you have cavities in your mouth" crlf crlf)
	(assert(have-cavities yes))
	else
	(assert(have-cavities no))))

(defrule ask-fever
	(and
	(have-gum-disease yes)
	(have-cavities yes)
	(have-sensitive-tooth yes))
=>
	
	(printout t "Question: Do you have fever ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?fever (read))
	(assert(fever ?fever)))

(defrule ask-tooth-abscess
	(fever ?fever)
=>
	(if (eq ?fever yes)
	then
	(printout t "We suspect that you have tooth abscess" crlf crlf)
	(assert(have-tooth-abscess yes))
	else
	(assert(have-tooth-abscess no))))

(defrule ask-extracted-any-tooth-recently
	(or (have-gum-disease no)
	(have-cavities no)
	(have-tooth-abscess no))
	(bad-breath ?bad-breath)
=>
	(if (eq ?bad-breath yes)
	then
	(printout t "Question: Do you have extracted any tooth recently ? "crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?extracted-any-tooth-recently (read))
	(assert (extracted-any-tooth-recently ?extracted-any-tooth-recently))
	else
	(assert(have-alveolar-osteitis no))))

(defrule ask-experience-pain-in-the-socket-area
	(extracted-any-tooth-recently ?extracted-any-tooth-recently)
=>
	(if 
	(eq ?extracted-any-tooth-recently yes)
	then
	(printout t "Question: Do you have experience pain in the socket area (the hole in the bone where the tooth has been removed) ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?experience-pain-in-the-socket (read))
	(assert(experience-pain-in-the-socket ?experience-pain-in-the-socket))
	else
	(assert(have-alveolar-osteitis no))))

(defrule ask-alveolar-osteitis
	(extracted-any-tooth-recently ?extracted-any-tooth-recently)
	(bad-breath ?bad-breath)
	(experience-pain-in-the-socket ?experience-pain-in-the-socket)
=>
	(if (and (eq ?extracted-any-tooth-recently yes)
		(eq ?bad-breath yes)
		(eq ?experience-pain-in-the-socket yes))
	then
	(printout t "We suspect that it is due to Alveolar Osteitis " crlf crlf)
	(assert(have-alveolar-osteitis yes))
	else
	(assert(have-alveolar-osteitis no))))

(defrule ask-pain-experienced-is-sharp	
	(have-alveolar-osteitis no)
=>
	(printout t "Question: Do you experience sharp tooth pain ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?pain-experienced-is-sharp (read))
	(assert(pain-experienced-is-sharp ?pain-experienced-is-sharp)))


(defrule ask-stabbing-pain-when-bite-into-food
	(pain-experienced-is-sharp ?pain-experienced-is-sharp)
=>
	(if (eq ?pain-experienced-is-sharp yes)
	then
	(printout t "Question: Do you have stabbing tooth pain when bite into food ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?stabbing-pain-when-bite-into-food (read))
	(assert(stabbing-pain-when-bite-into-food ?stabbing-pain-when-bite-into-food))
	else
	(assert(have-cracked-tooth no))))

(defrule ask-cracked-tooth
	(pain-experienced-is-sharp ?pain-experienced-is-sharp)
	(stabbing-pain-when-bite-into-food ?stabbing-pain-when-bite-into-food)
=>
	(if (and 
		(eq ?pain-experienced-is-sharp yes)
		(eq ?stabbing-pain-when-bite-into-food yes))
	then
	(printout t "We suspect that you have a Cracked Tooth" crlf crlf)
	(assert(have-cracked-tooth yes))
	else
	(assert(have-cracked-tooth no))))

(defrule ask-damaged-tooth
	(have-cracked-tooth no)
=>
	(printout t "Question: Do you have damaged tooth ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?damaged-tooth (read))
	(assert(damaged-tooth ?damaged-tooth)))


(defrule ask-often-clenching
	(damaged-tooth ?damaged-tooth)
=>
	(if (eq ?damaged-tooth yes)
	then
	(printout t "Question: Do you often clench teeth?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?often-clenching (read))
	(assert(often-clenching ?often-clenching))
	else
	(assert(have-bruxism no))))


(defrule ask-experience-pain-in-jaw-or-have-sleep-disruption
	(often-clenching ?often-clenching)
=>
	(if (eq ?often-clenching yes)
	then
	(printout t "Question: Do you experience pain in jaw or have sleep disruption ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?experience-pain-in-jaw-or-have-sleep-disruption (read))
	(assert(experience-pain-in-jaw-or-have-sleep-disruption ?experience-pain-in-jaw-or-have-sleep-disruption))
	else
	(assert(have-bruxism no))))

(defrule ask-bruxism
	(damaged-tooth ?damaged-tooth)
	(often-clenching ?often-clenching)
	(experience-pain-in-jaw-or-have-sleep-disruption ?experience-pain-in-jaw-or-have-sleep-disruption)
=>
	(if (and 
		(eq ?damaged-tooth yes)
		(eq ?often-clenching yes)
		(eq ?experience-pain-in-jaw-or-have-sleep-disruption yes))
	then
	(printout t "We suspect that you have bruxism" crlf crlf)
	(assert(have-bruxism yes))
	else
	(assert(have-bruxism no))))


(defrule ask-got-a-lot-of-calculus-bleeding-gums
	(have-bruxism no)
=>
	(printout t "Question: Do you have a lot of calculus ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?got-a-lot-of-calculus-bleeding-gums (read))
	(assert(got-a-lot-of-calculus-bleeding-gums ?got-a-lot-of-calculus-bleeding-gums)))

(defrule ask-bleeding-gums
	(got-a-lot-of-calculus-bleeding-gums ?got-a-lot-of-calculus-bleeding-gums)
	
=>
	(if (eq ?got-a-lot-of-calculus-bleeding-gums yes)
	then
	(printout t "Question: Do you have bleeding gums ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?bleeding-gums (read))
	(assert(bleeding-gums ?bleeding-gums))
	else
	(assert(have-periodontits no))))


(defrule ask-tooth-mobility
	(bleeding-gums ?bleeding-gums)
=>
	(if 
	(eq ?bleeding-gums yes)
	then
	(printout t "Question: Do you have tooth mobility ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?tooth-mobility (read))
	(assert(tooth-mobility ?tooth-mobility))
	else
	(assert(have-periodontits no))))

(defrule ask-periodontits
	(got-a-lot-of-calculus-bleeding-gums ?got-a-lot-of-calculus-bleeding-gums)
	(bleeding-gums ?bleeding-gums)
	(tooth-mobility ?tooth-mobility)
=>
	(if (and 
		(eq ?got-a-lot-of-calculus-bleeding-gums yes)
		(eq ?bleeding-gums yes)
		(eq ?tooth-mobility yes))
	then
	(printout t "We suspect that you have periodontitis" crlf crlf)
	(assert(have-periodontits yes))
	else
	(assert(have-periodontits no))))

(defrule ask-experienced-pain-at-the-corner-of-the-mouth 
	(have-periodontits no)
=>
	(printout t "Question: Do you have experienced pain at the corner of the mouth ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?experienced-pain-at-the-corner-of-the-mouth (read))
	(assert(experienced-pain-at-the-corner-of-the-mouth ?experienced-pain-at-the-corner-of-the-mouth)))


(defrule ask-swelling-around-jaws
	(experienced-pain-at-the-corner-of-the-mouth ?experienced-pain-at-the-corner-of-the-mouth)
=>
	(if (eq ?experienced-pain-at-the-corner-of-the-mouth yes)
	then
	(printout t "Question: Do you you have swelling around your jaws ?"crlf)
	(printout t "Answer [yes/no]: ")
	(bind ?swelling-around-jaws (read))
	(assert(swelling-around-jaws ?swelling-around-jaws))
	else
	(printout t "Diagnosis have completed, please consult a dentist for further assistance. " crlf crlf)
	(assert(have-growth-of-wisdom-teeth-is-the-cause no))))


(defrule ask-growth-of-wisdom-teeth-is-the-cause
	(experienced-pain-at-the-corner-of-the-mouth ?experienced-pain-at-the-corner-of-the-mouth)
	(swelling-around-jaws ?swelling-around-jaws)
=>
	(if (and 
		(eq ?experienced-pain-at-the-corner-of-the-mouth yes)
		(eq ?swelling-around-jaws yes))
	then
	(printout t "We suspect that you have the growth of wisdom teeth" crlf crlf)
	(assert(have-growth-of-wisdom-teeth-is-the-cause yes))
	else
	(printout t "Diagnosis have completed, please consult a dentist for further assistance. " crlf crlf)
	(assert(have-growth-of-wisdom-teeth-is-the-cause no))))
