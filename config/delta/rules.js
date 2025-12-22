export default [
  {
    match: {},
    callback: {
      url: 'http://search/update',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 2000,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/1999/02/22-rdf-syntax-ns#type",
      },
      object: {
        type: "uri",
        value: "http://mu.semte.ch/vocabularies/ext/VocabDownloadJob",
      },
    },
    callback: {
      url: "http://vocab-fetch/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: true,
    },
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/1999/02/22-rdf-syntax-ns#type",
      },
      object: {
        type: "uri",
        value: "http://mu.semte.ch/vocabularies/ext/VocabsExportJob",
      },
    },
    callback: {
      url: "http://vocab-configs/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: true,
    },
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/1999/02/22-rdf-syntax-ns#type",
      },
      object: {
        type: "uri",
        value: "http://mu.semte.ch/vocabularies/ext/VocabsImportJob",
      },
    },
    callback: {
      url: "http://vocab-configs/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: true,
    },
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/ns/adms#status",
      },
      object: {
        type: "uri",
        value: "http://redpencil.data.gift/id/concept/JobStatus/scheduled",
      },
    },
    callback: {
      url: "http://vocab-configs/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: true,
    },
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/ns/adms#status",
      },
      object: {
        type: "uri",
        value: "http://redpencil.data.gift/id/concept/JobStatus/scheduled",
      },
    },
    callback: {
      url: "http://vocab-fetch/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: false,
    },
  },
  {
    match: {
      // form of element is {subject,predicate,object}
      predicate: {
        type: "uri",
        value: "http://www.w3.org/ns/adms#status",
      },
      object: {
        type: "uri",
        value: "http://redpencil.data.gift/id/concept/JobStatus/scheduled",
      },
    },
    callback: {
      url: "http://content-unification/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: false,
    },
  },
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'
      },
      object: {
        type: 'uri',
        value: 'http://rdfs.org/ns/void#Dataset'
      }
    },
    callback: {
      url: 'http://uuid-generation/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 250,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'
      },
      object: {
        type: 'uri',
        value: 'http://rdfs.org/ns/void#Dataset'
      }
    },
    callback: {
      url: 'http://ldes-consumer-manager/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 2500,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'
      },
      object: {
        type: 'uri',
        value: 'http://www.w3.org/2004/02/skos/core#Concept'
      }
    },
    callback: {
      url: 'http://uuid-generation/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 200,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://www.w3.org/ns/adms#status'
      }
    },
    callback: {
      method: 'POST',
      url: 'http://job-controller/delta'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 1000,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      // we expect the full body to be sent in this case
      object: { value: "http://mu.semte.ch/vocabularies/push/Update" },
    },
    callback: {
      url: "http://polling-push-update/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 100,
      foldEffectiveChanges: false,
      ignoreFromSelf: false,
    },
  },
  {
    match: {
      // we expect the full body to be sent in this case
      object: { value: "http://mu.semte.ch/vocabularies/cache/Clear" },
    },
    callback: {
      url: "http://push-update-cache-monitor/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 100,
      foldEffectiveChanges: false,
      ignoreFromSelf: false,
    },
  },
  {
    match: {
      // we expect the full body to be sent in this case
      object: { value: "http://mu.semte.ch/vocabularies/push/Tab" },
    },
    callback: {
      url: "http://push-update-cache-monitor/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 100,
      foldEffectiveChanges: false,
      ignoreFromSelf: false,
    },
  },
  {
    match: {
      // we should also monitor the tabs, but this is the default if we accept everything for now.  For the tab it is
      // assumed we receive the full body.
      object: {
        // value: "http://mu.semte.ch/vocabularies/push/Tab"
      },
    },
    callback: {
      url: "http://push-update-resource-monitor/.mu/delta",
      method: "POST",
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 100,
      foldEffectiveChanges: false,
      ignoreFromSelf: false,
      ropagateAllowedGroups: false,
    },
  }
];
