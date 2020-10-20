;====Start===============================================
(deffacts init (start))

(defrule ask_fever
		(start)
		?ml <- (start)
        => 
         (printout t crlf crlf 
           "a. Skin rashes without fever" crlf
           "b. Skin rashes with fever" crlf
           "c. Skin infections " crlf 
		   "d. Quit the program" crlf
		   "Enter the choice then hit Enter" crlf
		   "Choice: ")
        (bind ?fever (read))
        (if (eq ?fever a) then (assert (no_fever_diagnosis)))
        else 
		(if (eq ?fever b) then (assert (fever_diagnosis)))
        else 
		(if (eq ?fever c) then (assert (infection_diagnosis)))
		else
		(if (eq ?fever d) then (assert (quits)))
		(retract ?ml))
						 
;====Quit===================================================
						 
(defrule quits
	(type quit)
	=>
		(printout t "You quit the program." crlf)
		(halt))

;====Diagnosis Type==========================================
	
(defrule fever_diagnosis
	(ask_fever)
	=>
	(assert(fever_diagnosis)))

(defrule no_fever_diagnosis
	(ask_fever)
	=>
	(assert(no_fever_diagnosis)))
	
(defrule infection_diagnosis
	(ask_fever)
	=>
	(assert(infection_diagnosis)))
	
;====LEVEL 1=================================================

(defrule red_patches
	(no_fever_diagnosis)
	=>
	(printout t crlf "Do you have red patches on skin? (yes|no)" crlf)
	(assert (red_patches (read))))

(defrule skin_eruption
	(no_fever_diagnosis)
        (red_patches no)
	=>
	(printout t crlf "Do you have skin eruption on your face? (yes|no)" crlf)
	(assert (skin_eruption (read))))

(defrule fish_scale
	(no_fever_diagnosis)
        (red_patches no)
        (skin_eruption no)
	=>
	(printout t crlf "Do you have fish scale on you skin? (yes|no)" crlf)
	(assert (fish_scale (read))))
	
(defrule stiff_neck
	(fever_diagnosis)
	=>
	(printout t crlf "Do you have stiff neck? (yes|no)" crlf)
	(assert (stiff_neck (read))))
	
(defrule cold_cough
	(fever_diagnosis)
        (stiff_neck no)
	=>
	(printout t crlf "Do you have cold and cough? (yes|no)" crlf)
	(assert (cold_cough (read))))
	
(defrule bite_red
	(infection_diagnosis)
	=>
	(printout t crlf "Do you have bite or sting red? (yes|no)" crlf)
	(assert (bite_red (read))))

(defrule black_spot
	(infection_diagnosis)
        (bite_red no)
	=>
	(printout t crlf "Do you have tiny balck spots dotted on skin? (yes|no)" crlf)
	(assert (black_spot (read))))
	
	
;====LEVEL 2=================================================	

(defrule pain_touch
	(no_fever_diagnosis)
	(red_patches yes)
	=>
	(printout t crlf "Warm and mildly painful on touch? (yes|no)" crlf)
	(assert (pain_touch (read))))

(defrule white_silvery
	(no_fever_diagnosis)
	(red_patches yes)
        (pain_touch no)
	=>
	(printout t crlf "White silvery scales on your skin? (yes|no)" crlf)
	(assert (white_silvery (read))))

(defrule small_blister
	(no_fever_diagnosis)
	(red_patches yes)
        (pain_touch no)
        (white_silvery no)
	=>
	(printout t crlf "Small blister on your skin? (yes|no)" crlf)
	(assert (small_blister (read))))

(defrule acne
	(no_fever_diagnosis)
	(skin_eruption yes)
	=>
	(printout t crlf "Diagnosed as Acne" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

(defrule ichthyosis
	(no_fever_diagnosis)
	(fish_scale yes)
	=>
	(printout t crlf "Diagnosed as Ichthyosis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))
	
(defrule meningitis
	(fever_diagnosis)
	(stiff_neck yes)
	=>
	(printout t crlf "Diagnosed as Meningitis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))
	
(defrule sore_throat
	(fever_diagnosis)
	(cold_cough yes)
	=>
	(printout t crlf "Do you have sore throat and sneezing? (yes|no)" crlf)
	(assert (sore_throat (read))))

(defrule sudden_sore
	(fever_diagnosis)
	(cold_cough yes)
        (sore_throat no)
	=>
	(printout t crlf "Is your sore throat sudden? (yes|no)" crlf)
	(assert (sudden_sore (read))))

(defrule blister_mouth
	(fever_diagnosis)
	(cold_cough yes)
        (sore_throat no)
        (sudden_sore no)
	=>
	(printout t crlf "Do you have blister near mouth and lips? (yes|no)" crlf)
	(assert (blister_mouth (read))))
	
(defrule red_spot_itchy
	(infection_diagnosis)
	(bite_red yes)
	=>
	(printout t crlf "Do you have red spot itchy (yes|no)" crlf)
	(assert (red_spot_itchy (read))))

(defrule wartz
	(infection_diagnosis)
	(black_spot yes)
	=>
	(printout t crlf "Diagnosed as Wartz" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

;====LEVEL 3/Result=================================================	
	
(defrule hives
        (no_fever_diagnosis)
	(red_patches yes)
	(pain_touch yes)
	=>
	(printout t crlf "Diagnosed as Hives" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

(defrule psoriasis
	(no_fever_diagnosis)
	(red_patches yes)
	(white_silvery yes)
	=>
	(printout t crlf "Diagnosed as Psoriasis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

(defrule eczema
	(no_fever_diagnosis)
	(red_patches yes)
	(small_blister yes)
	=>
	(printout t crlf "Diagnosed as Eczema" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))
	
(defrule measles
	(fever_diagnosis)
	(sore_throat yes)
	=>
	(printout t crlf "Diagnosed as Measles" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

(defrule scarlet_fever
	(fever_diagnosis)
	(sudden_sore yes)
	=>
	(printout t crlf "Diagnosed as Scarlet Fever" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))

(defrule cold_sore
	(fever_diagnosis)
	(blister_mouth yes)
	=>
	(printout t crlf "Diagnosed as Cold Sore" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))
	
(defrule insect_bites
	(infection_diagnosis)
	(red_spot_itchy yes)
	=>
	(printout t crlf "Diagnosed as Insect Bites" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 0) then (assert(quits)))
	(printout t crlf))
