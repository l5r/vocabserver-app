;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

(add-delta-logger)
(add-delta-messenger "http://delta-notifier/")

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* t)
(setf *backend* "http://triplestore:8890/sparql")

(in-package :server)
(setf *log-incoming-requests-p* t); nil)

;;;;;;;;;;;;;;;;;
;;; access rights
(in-package :acl)

(defparameter *access-specifications* nil
  "All known ACCESS specifications.")

(defparameter *graphs* nil
  "All known GRAPH-SPECIFICATION instances.")

(defparameter *rights* nil
  "All known GRANT instances connecting ACCESS-SPECIFICATION to GRAPH.")

(define-prefixes
  ;; Core
  :mu "http://mu.semte.ch/vocabularies/core/"
  :session "http://mu.semte.ch/vocabularies/session/"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  :service "http://services.semantic.works/"
  ;; Custom prefix URIs here, prefix casing is ignored
  :push "http://mu.semte.ch/vocabularies/push/"
  :rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  :cache "http://mu.semte.ch/vocabularies/cache/"
  :dct "http://purl.org/dc/terms/"
  )

(type-cache::add-type-for-prefix "http://mu.semte.ch/sessions/" "http://mu.semte.ch/vocabularies/session/Session")

(define-graph public ("http://mu.semte.ch/graphs/public")
    ("http://mu.semte.ch/vocabularies/ext/VocabularyMeta" -> _)
    ("http://mu.semte.ch/vocabularies/ext/DatasetType" -> _)
    ("http://www.w3.org/ns/shacl#NodeShape" -> _)
    ("http://www.w3.org/ns/shacl#PropertyShape" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabularyMeta" -> _)
    ("http://rdfs.org/ns/void#Dataset" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabDownloadJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/MetadataExtractionJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/ContentUnificationJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabDeleteJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabDeleteWaitJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabsExportJob" -> _)
    ("http://mu.semte.ch/vocabularies/ext/VocabsImportJob" -> _)
    ("http://vocab.deri.ie/cogs#Job" -> _)
    ("http://redpencil.data.gift/vocabularies/tasks/Task" -> _)
    ("http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#DataContainer" -> _)
    ("http://open-services.net/ns/core#Error" -> _)
    ("http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject" -> _)
)

(define-graph tab-ids ("http://mu.semte.ch/graphs/tab-ids") ; :sparql nil)
  ("push:Tab"
   -> "push:session"
   -> "mu:uuid"
   -> "rdf:type"
   -> "rdf:label"))

(define-graph push-updates ("http://mu.semte.ch/graphs/push-updates")
  ("push:Update"
    -> "push:target"
    -> "push:message"
    -> "push:channel"
    -> "mu:uuid"
    -> "rdf:type"))

(define-graph cache-clears ("http://mu.semte.ch/graphs/cache-clears")
  ("cache:Clear"
   -> "mu:uuid"
   -> "rdf:type"
   -> "cache:path"
   -> "cache:allowedGroups"))

(supply-allowed-group "public")

(grant (read write)
  :to-graph (public)
  :for-allowed-group "public")

(grant (write)
       :to push-updates
       :for "public")

(with-scope "service:polling-push-updates"
  (grant (write)
         :to tab-ids
         :for "public"))

(with-scope "service:cache"
  (grant (write)
         :to cache-clears
         :for "public"))

(with-scope "service:cache-monitor"
  (grant (write)
         :to push-updates
         :for "public"))

(with-scope "service:resource-monitor"
  (grant (write)
         :to push-updates
         :for "public"))

; (in-package #:server)

; (define-condition nothing-error (error)
;   ())

; (defun acceptor (env)
;   ;; (declare (ignore env))
;   ;; '(200 (:content-type "application/sparql-results+json") ("HELLO HELLO HELLO"))
;   (let ((initial-worker-id (woo.worker::worker-id woo.worker::*worker*))
;         request-number)
;     (bt:with-lock-held (*request-counter-lock*)
;       (setf request-number
;             (incf *request-count*)))
;         (let* ((headers (getf env :headers))
;                (allowed-groups-header (gethash "mu-auth-allowed-groups" headers))
;                (sudo-header (gethash "mu-auth-sudo" headers))
;                (is-sudo-call (or (and sudo-header t)
;                                  (equal allowed-groups-header "sudo"))))
;           (with-call-context (:mu-call-id (gethash "mu-call-id" headers)
;                               :mu-session-id (gethash "mu-session-id" headers)
;                               :mu-call-id-trail (gethash "mu-call-id-trail" headers)
;                               :mu-auth-sudo is-sudo-call
;                               :mu-auth-allowed-groups (when (and (not is-sudo-call)
;                                                                  (stringp allowed-groups-header))
;                                                         (jsown:parse allowed-groups-header))
;                               :mu-call-scope (parse-mu-call-scope-header (gethash "mu-auth-scope" headers))
;                               :source-ip (getf env :remote-addr))
;             (cond
;               ((recovery-status-request-p env)
;                (return-recovery-status))
;               (t
;                (with-parser-setup

; (let* ((query-string (let ((str (extract-query-string env (gethash "content-type" headers))))
;                                             (when *log-incoming-requests-p*
;                                               (format t "Requested query as string:~%~A~%With access rights:~{~A: ~A~&~}"
;                                                       str
;                                                       (list :mu-call-id (mu-call-id)
;                                                             :mu-call-id-trail (mu-call-id-trail)
;                                                             :mu-session-id (mu-session-id)
;                                                             :mu-auth-sudo (mu-auth-sudo)
;                                                             :mu-auth-allowed-groups (jsown:to-json (mu-auth-allowed-groups))
;                                                             :mu-call-scope (mu-call-scope)
;                                                             :source-ip (source-ip))))
;                                             str))
;                             (response (execute-query-for-context query-string)))
;                        `(200
;                          (:content-type "application/sparql-results+json"
;                           :mu-auth-allowed-groups ,(jsown:to-json (mu-auth-allowed-groups))
;                           :request-number ,request-number
;                           :initial-worker-id ,initial-worker-id
;                           :final-worker-id ,(woo.worker::worker-id woo.worker::*worker*))
;                          (,response)))

;                                    )))))
;         ))
