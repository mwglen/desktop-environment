(define-package "magit" "20220225.943" "A Git porcelain inside Emacs."
  '((emacs "25.1")
    (dash "20210826")
    (git-commit "20211004")
    (magit-section "20211004")
    (transient "20210920")
    (with-editor "20211001"))
  :commit "44c58868c997f0b86d66faeed2f0b29064f8d0b9" :authors
  '(("Marius Vollmer" . "marius.vollmer@gmail.com")
    ("Jonas Bernoulli" . "jonas@bernoul.li"))
  :maintainer
  '("Jonas Bernoulli" . "jonas@bernoul.li")
  :keywords
  '("git" "tools" "vc")
  :url "https://github.com/magit/magit")
;; Local Variables:
;; no-byte-compile: t
;; End: