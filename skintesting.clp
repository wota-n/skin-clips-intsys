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

(defrule abnormal_skin
	(infection_diagnosis)
        (bite_red no)
	=>
	(printout t crlf "Do you have abnormal skin growth? (yes|no)" crlf)
	(assert (abnormal_skin (read))))
	
	
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
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Nonprescription acne treatments may include salicylic acid, benzoyl peroxide, sulfur, alpha hydroxy acids, adapalene, or tea tree oil, all of which are available in nonprescription strengths. A combination of these treatments may be more effective than using one single product alone" crlf))
	(printout t crlf))

(defrule ichthyosis
	(no_fever_diagnosis)
	(fish_scale yes)
	=>
	(printout t crlf "Diagnosed as Ichthyosis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Ichthyosis can't be cured, but treatments can relieve the scaling and make you feel more comfortable." crlf))
	(printout t crlf))
	
(defrule meningitis
	(fever_diagnosis)
	(stiff_neck yes)
	=>
	(printout t crlf "Diagnosed as Meningitis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "People with suspected meningitis will usually have tests in hospital to confirm the diagnosis and check whether the condition is the result of a viral or bacterial infection." crlf))
	(printout t crlf))
	
(defrule sore_throat
	(fever_diagnosis)
	(cold_cough yes)
	=>
	(printout t crlf "Do you have sore throat? (yes|no)" crlf)
	(assert (sore_throat (read))))

(defrule blister_mouth
	(fever_diagnosis)
	(cold_cough yes)
        (sore_throat no)
	=>
	(printout t crlf "Do you have blister near mouth and lips? (yes|no)" crlf)
	(assert (blister_mouth (read))))
	
(defrule red_spot_itchy
	(infection_diagnosis)
	(bite_red yes)
	=>
	(printout t crlf "Do you have red spot itchy? (yes|no)" crlf)
	(assert (red_spot_itchy (read))))

(defrule private_area
	(infection_diagnosis)
	(abnormal_skin yes)
	=>
	(printout t crlf "Do you have affected skin in a private area? (yes|no)" crlf)
	(assert (private_area (read))))

(defrule small_red
	(infection_diagnosis)
	(abnormal_skin no)
	=>
	(printout t crlf "Do you have small red bumps or tiny white blisters and ulcers? (yes|no)" crlf)
	(assert (small_red (read))))



;====LEVEL 3/Result=================================================	
	
(defrule hives
        (no_fever_diagnosis)
	(red_patches yes)
	(pain_touch yes)
	=>
	(printout t crlf "Diagnosed as Hives" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Best treatment for hives and angiodema is to identify and remove the trigger, but this is not an easy task. Antihistamines are usually prescribed by your doctor to provide relief from symptoms. Antihistamines work best if taken on a regular schedule to prevent hives from forming in the first place." crlf))
	  (printout t crlf))

(defrule psoriasis
	(no_fever_diagnosis)
	(red_patches yes)
	(white_silvery yes)
	=>
	(printout t crlf "Diagnosed as Psoriasis" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
         else
        (if(= ?response 3) then (printout t crlf "Try an over-the-counter product first to moisturize your skin. Body lotion can help keep your skin from getting too dry and cracking. It can remove some of the scales or rough patches. Bathing in Epsom salts, Dead Sea salts, bath oil, or oatmeal can relieve symptoms as well." crlf))
	(printout t crlf))

(defrule eczema
	(no_fever_diagnosis)
	(red_patches yes)
	(small_blister yes)
	=>
	(printout t crlf "Diagnosed as Eczema" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "There is currently no cure for eczema. Treatment for the condition aims to heal the affected skin and prevent flares of symptoms. Treatment plan is based on an individual’s age, symptoms, and current state of health." crlf))
	(printout t crlf))
	
(defrule red_eyes
	(fever_diagnosis)
	(sore_throat yes)
	=>
	(printout t crlf "Do you have red eyes and runny nose? (yes|no)" crlf)
	(assert(red_eyes(read))))
	

(defrule swollen_tonsil
	(fever_diagnosis)
	(sore_throat yes)
	(red_eyes no)
	=>
	(printout t crlf "Do you have swollen tonsil and flushed face? (yes|no)" crlf)
	(assert(swollen_tonsil(read))))

(defrule cold_sore
	(fever_diagnosis)
	(blister_mouth yes)
	=>
	(printout t crlf "Diagnosed as Cold Sore" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Use antiviral creams as soon as you recognise the early tingling feeling. They do not always work after blisters appear." crlf))
	(printout t crlf))
	
(defrule insect_bites
	(infection_diagnosis)
	(red_spot_itchy yes)
	=>
	(printout t crlf "Diagnosed as Insect Bites" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Wash the affected area with soap and water. Apply a cold compress (such as a flannel or cloth cooled with cold water) or an ice pack to any swelling for at least 10 minutes. Raise or elevate the affected area if possible, as this can help reduce swelling." crlf))
	(printout t crlf))

(defrule genital_warts
	(infection_diagnosis)
	(private_area yes)
	=>
	(printout t crlf "Diagnosed as Genital Warts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "If your warts aren't causing discomfort, you might not need treatment. But if you have itching, burning and pain, or if you're concerned about spreading the infection, a doctor can help you clear an outbreak with medications or surgery." crlf))
	(printout t crlf))

(defrule common_warts
	(infection_diagnosis)
	(private_area no)
	=>
	(printout t crlf "Diagnosed as Common Warts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Most common warts go away without treatment, though it may take a year or two and new ones may develop nearby. It can be treated with different methods like salicylic acid, cryotherapy, other acids, minor surgery, and laser treatment" crlf))
	(printout t crlf))

(defrule swollen_gland
	(infection_diagnosis)
	(small_red yes)
	=>
	(printout t crlf "Do you have swollen gland? (yes|no)" crlf)
	(assert (swollen_gland (read))))
	
;====LEVEL 4===================================================

(defrule measles
	(fever_diagnosis)
	(sore_throat yes)
	(red_eyes yes)
	=>
	(printout t crlf "Diagnosed as Measles" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits))) 
                else
                (if(= ?response 3) then (printout t crlf "Stay home from work or school and other public places until you aren't contagious. This is four days after you first develop the measles rash. Avoid contact with people who may be vulnerable to infection, such as infants too young to be vaccinated and immunocompromised people." crlf))
	(printout t crlf))
	
(defrule scarlet_fever
	(fever_diagnosis)
	(sore_throat yes)
	(swollen_tonsil yes)
	=>
	(printout t crlf "Diagnosed as Scarlet Fever" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "It can easily be treated with antibiotics. Liquid antibiotics, such as penicillin or amoxicillin, are often used to treat children. These must be taken for 10 days, even though most people recover after four to five days." crlf))
	(printout t crlf))

(defrule herpes
	(infection_diagnosis)
	(small_red yes)
	(swollen_gland yes)
	=>
	(printout t crlf "Diagnosed as Herpes" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "No drug can get rid of the herpes virus. However, a doctor may prescribe an antiviral medication, such as acyclovir, to prevent the virus from multiplying." crlf))
	(printout t crlf))

;====No Result=================================================

(defrule no_result_1
	(small_blister no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Use antiviral creams as soon as you recognise the early tingling feeling. They do not always work after blisters appear." crlf))
	(printout t crlf))

(defrule no_result_2
	(fish_scale no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
        "3. Medical advice "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
                else
                (if(= ?response 3) then (printout t crlf "Wash the affected area with soap and water. Apply a cold compress (such as a flannel or cloth cooled with cold water) or an ice pack to any swelling for at least 10 minutes. Raise or elevate the affected area if possible, as this can help reduce swelling." crlf))
	(printout t crlf))

(defrule no_result_3
	(cold_cough no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
	(printout t crlf))

(defrule no_result_4
	(red_spot_itchy no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
	(printout t crlf))
	
(defrule no_result_5
	(swollen_tonsil no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
	(printout t crlf))

(defrule no_result_6
	(small_red no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
	(printout t crlf))

(defrule no_result_7
	(swollen_gland no)
	=>
	(printout t crlf "Condition is not in knowledge base, please seek further help from experts" crlf
	"1. Restart the program "crlf
	"2. Quit the program "crlf
	"Choice: ")
	(bind ?response (read))
		(if(= ?response 1) then (assert(start)))
		else
		(if(= ?response 2) then (assert(quits)))
	(printout t crlf))
