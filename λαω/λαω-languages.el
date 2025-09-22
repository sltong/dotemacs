;;; λαω-languages.el --- Languages -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright (C) 2024 λαω

;; Author: Lao Tong <lao.s.t@pm.me>
;; Maintainer: Lao Tong <lao.s.t@pm.me>
;; Keywords: local

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU Affero General Public License
;; as published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; Affero General Public License for more details.

;; You should have received a copy of the GNU Affero General Public
;; License along with this program. If not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Languages.

;;; Code:

;; create a custom Greek input method
(quail-define-package "greek-λαω" "Greek" "Ελ" t
"Greek input method based on the TeX Babel input method (`greek-babel').

Greek letters are mapped to QWERTY keys as they are on modern Greek
keyboard layouts.

The TeX Babel input method uses mule-unicode-0100-24ff.

-------------------------------------
character     capital         small
-------------------------------------
alpha           A               a
beta            B               b
gamma           G               g
delta           D               d
epsilon         E               e
zeta            Z               z
eta             H               h
theta           U               u
iota            I               i
kappa           K               k
lambda          L               l
mu              M               m
nu              N               n
xi              J               j
omicron         O               o
pi              P               p
rho             R               r
sigma           S               s
final sigma                     w
tau             T               t
upsilon         Y               y
phi             F               f
chi             X               x
psi             Y               y
omega           V               v
-------------------------------------
sampi                           !
digamma                         #
stigma                          $
koppa           &               %
-------------------------------------

------------------------
mark            key
------------------------
ypogegrammeni   |
psili           >
dasia           <
oxia            \\='
koronis         \\='\\='
varia           \\=`
perispomeni     ~
dialytika       \"
ano teleia      ;
erotimatiko     ?
----------------------
"
nil t t nil nil nil nil nil nil nil t)

(quail-define-rules
 ("!"  ?ϡ) ; sampi
 ("#"  ?Ϝ) ; DIGAMMA
 ("$"  ?ϛ) ; stigma
 ("%"  ?ϟ) ; koppa
 ("&"  ?Ϟ) ; KOPPA
 (">"  ?᾿) ; psili
 ("'"  ?´) ; oxia
 (";"  ?·) ; ano teleia
 ("?"  ?;) ; erotimatiko
 ("\"" ?¨) ; dialytika
 ("|"  ?ͺ) ; ypogegrammeni
 ("''" ?᾽) ; koronis
 ("((" ?«) ; #x00ab
 ("))" ?») ; #x00bb

 ("A"  ?Α)  ("a"  ?α)
 ("A|" ?ᾼ)  ("a|" ?ᾳ)
 ("B"  ?Β)  ("b"  ?β)
 ("C"  ?Ψ)  ("c"  ?ψ)
 ("D"  ?Δ)  ("d"  ?δ)
 ("E"  ?Ε)  ("e"  ?ε)
 ("F"  ?Φ)  ("f"  ?φ)
 ("G"  ?Γ)  ("g"  ?γ)
 ("H"  ?Η)  ("h"  ?η)
 ("H|" ?ῌ)  ("h|" ?ῃ)
 ("I"  ?Ι)  ("i"  ?ι)
 ("J"  ?Ξ)  ("j"  ?ξ)
 ("K"  ?Κ)  ("k"  ?κ)
 ("L"  ?Λ)  ("l"  ?λ)
 ("M"  ?Μ)  ("m"  ?μ)
 ("N"  ?Ν)  ("n"  ?ν)
 ("O"  ?Ο)  ("o"  ?ο)
 ("P"  ?Π)  ("p"  ?π)
 ("R"  ?Ρ)  ("r"  ?ρ)
 ("S"  ?Σ)  ("s"  ?σ)
 ("T"  ?Τ)  ("t"  ?τ)
 ("U"  ?Θ)  ("u"  ?θ)
 ("V"  ?Ω)  ("v"  ?ω)
 ("V|" ?ῼ)  ("v|" ?ῳ)
 ("X"  ?Χ)  ("w"  ?ς)
 ("Y"  ?Υ)  ("x"  ?χ)
 ("Z"  ?Ζ)  ("y"  ?υ)
            ("z"  ?ζ)

 ("`"  ?`) ; varia
 ("~"  ?῀) ; perispomeni
 ("<"  ?῾) ; dasia

 ("<i"   ?ἱ)
 (">i"   ?ἰ)
 ("'i"   ?ί)
 ("<'i"  ?ἵ)
 (">'i"  ?ἴ)
 ("`i"   ?ὶ)
 ("<`i"  ?ἳ)
 (">`i"  ?ἲ)
 ("~i"   ?ῖ)
 ("<~i"  ?ἷ)
 (">~i"  ?ἶ)
 ("\"i"  ?ϊ)
 ("\"'i" ?ΐ)
 ("\"`i" ?ῒ)

 ;; TODO add the rest of the Greek Extended Unicode set
 ("\"~i" ?ῗ)

 ("<I"  ?Ἱ)
 (">I"  ?Ἰ)
 ("'I"  ?Ί)
 ("<'I" ?Ἵ)
 (">'I" ?Ἴ)
 ("`I"  ?Ὶ)
 ("<`I" ?Ἳ)
 (">`I" ?Ἲ)
 ("<~I" ?Ἷ)
 (">~I" ?Ἶ)
 ("\"I" ?Ϊ)

 ("<~"  ?῟)
 (">~"  ?῏)
 ("<'"  ?῞)
 (">'"  ?῎)
 ("<`"  ?῝)
 (">`"  ?῍)
 ("\"'" ?΅)
 ("\"`" ?῭)

 ("<e"  ?ἑ)
 (">e"  ?ἐ)
 ("'e"  ?έ)
 ("<'e" ?ἕ)
 (">'e" ?ἔ)
 ("`e"  ?ὲ)
 ("<`e" ?ἓ)
 (">`e" ?ἒ)

 ("<E"  ?Ἑ)
 (">E"  ?Ἐ)
 ("'E"  ?Έ)
 ("<'E" ?Ἕ)
 (">'E" ?Ἔ)
 ("`E"  ?Ὲ)
 ("<`E" ?Ἓ)
 (">`E" ?Ἒ)

 ("<a"  ?ἁ)
 (">a"  ?ἀ)
 ("'a"  ?ά)
 ("<'a" ?ἅ)
 (">'a" ?ἄ)
 ("`a"  ?ὰ)
 ("<`a" ?ἃ)
 (">`a" ?ἂ)
 ("~a"  ?ᾶ)
 ("<~a" ?ἇ)
 (">~a" ?ἆ)

 ("<A"  ?Ἁ)
 (">A"  ?Ἀ)
 ("'A"  ?Ά)
 ("<'A" ?Ἅ)
 (">'A" ?Ἄ)
 ("`A"  ?Ὰ)
 ("<`A" ?Ἃ)
 (">`A" ?Ἂ)
 ("<~A" ?Ἇ)
 (">~A" ?Ἆ)

 ("<a|"  ?ᾁ)
 (">a|"  ?ᾀ)
 ("'a|"  ?ᾴ)
 ("<'a|" ?ᾅ)
 (">'a|" ?ᾄ)
 ("`a|"  ?ᾲ)
 ("<`a|" ?ᾃ)
 (">`a|" ?ᾂ)
 ("~a|"  ?ᾷ)
 ("<~a|" ?ᾇ)
 (">~a|" ?ᾆ)

 ("<A|"  ?ᾉ)
 (">A|"  ?ᾈ)
 ("<'A|" ?ᾍ)
 (">'A|" ?ᾌ)
 ("<`A|" ?ᾋ)
 (">`A|" ?ᾊ)
 ("<~A|" ?ᾏ)
 (">~A|" ?ᾎ)

 ("<r" ?ῥ)
 (">r" ?ῤ)

 ("<R" ?Ῥ)

 ("<h"  ?ἡ)
 (">h"  ?ἠ)
 ("'h"  ?ή)
 ("<'h" ?ἥ)
 (">'h" ?ἤ)
 ("`h"  ?ὴ)
 ("<`h" ?ἣ)
 (">`h" ?ἢ)
 ("~h"  ?ῆ)
 ("<~h" ?ἧ)
 (">~h" ?ἦ)

 ("<H"  ?Ἡ)
 (">H"  ?Ἠ)
 ("'H"  ?Ή)
 ("<'H" ?Ἥ)
 (">'H" ?Ἤ)
 ("`H"  ?Ὴ)
 ("<`H" ?Ἣ)
 (">`H" ?Ἢ)
 ("<~H" ?Ἧ)
 (">~H" ?Ἦ)

 ("|" ?ͺ) ; ypogegrammeni

 ("<h|"  ?ᾑ)
 (">h|"  ?ᾐ)
 ("'h|"  ?ῄ)
 ("<'h|" ?ᾕ)
 (">'h|" ?ᾔ)
 ("`h|"  ?ῂ)
 ("<`h|" ?ᾓ)
 (">`h|" ?ᾒ)
 ("~h|"  ?ῇ)
 ("<~h|" ?ᾗ)
 (">~h|" ?ᾖ)

 ("<H|"  ?ᾙ)
 (">H|"  ?ᾘ)
 ("<'H|" ?ᾝ)
 (">'H|" ?ᾜ)
 ("<`H|" ?ᾛ)
 (">`H|" ?ᾚ)
 ("<~H|" ?ᾟ)
 (">~H|" ?ᾞ)

 ("<o"  ?ὁ)
 (">o"  ?ὀ)
 ("'o"  ?ό)
 ("<'o" ?ὅ)
 (">'o" ?ὄ)
 ("`o"  ?ὸ)
 ("<`o" ?ὃ)
 (">`o" ?ὂ)

 ("<O"  ?Ὁ)
 (">O"  ?Ὀ)
 ("'O"  ?Ό)
 ("<'O" ?Ὅ)
 (">'O" ?Ὄ)
 ("`O"  ?Ὸ)
 ("<`O" ?Ὃ)
 (">`O" ?Ὂ)

 ("<y"   ?ὑ)
 (">y"   ?ὐ)
 ("'y"   ?ύ)
 ("<'y"  ?ὕ)
 (">'y"  ?ὔ)
 ("`y"   ?ὺ)
 ("<`y"  ?ὓ)
 (">`y"  ?ὒ)
 ("~y"   ?ῦ)
 ("<~y"  ?ὗ)
 (">~y"  ?ὖ)
 ("\"y"  ?ϋ)
 ("\"'y" ?ΰ)
 ("`\"y" ?ῢ)

 ("<Y"  ?Ὑ)
 ("'Y"  ?Ύ)
 ("<'Y" ?Ὕ)
 ("`Y"  ?Ὺ)
 ("<`Y" ?Ὓ)
 ("<~Y" ?Ὗ)
 ("\"Y" ?Ϋ)

 ("<v"  ?ὡ)
 (">v"  ?ὠ)
 ("'v"  ?ώ)
 ("<'v" ?ὥ)
 (">'v" ?ὤ)
 ("`v"  ?ὼ)
 ("<`v" ?ὣ)
 (">`v" ?ὢ)
 ("~v"  ?ῶ)
 ("<~v" ?ὧ)
 (">~v" ?ὦ)

 ("<V"  ?Ὡ)
 (">V"  ?Ὠ)
 ("'V"  ?Ώ)
 ("<'V" ?Ὥ)
 (">'V" ?Ὤ)
 ("`V"  ?Ὼ)
 ("<`V" ?Ὣ)
 (">`V" ?Ὢ)
 ("<~V" ?Ὧ)
 (">~V" ?Ὦ)

 ("<v|"  ?ᾡ)
 (">v|"  ?ᾠ)
 ("'v|"  ?ῴ)
 ("<'v|" ?ᾥ)
 (">'v|" ?ᾤ)
 ("`v|"  ?ῲ)
 ("<`v|" ?ᾣ)
 (">`v|" ?ᾢ)
 ("~v|"  ?ῷ)
 ("<~v|" ?ᾧ)
 (">~v|" ?ᾦ)

 ("<V|"  ?ᾩ)
 (">V|"  ?ᾨ)
 ("'V|"  ?ῴ) ; duplicate of lowercase
 ("<'V|" ?ᾭ)
 (">'V|" ?ᾬ)
 ("<`V|" ?ᾫ)
 (">`V|" ?ᾪ)
 ("<~V|" ?ᾯ)
 (">~V|" ?ᾮ)
 )

(setopt default-input-method "greek-λαω")

(provide 'λαω-languages)
;;; λαω-languages.el ends here
