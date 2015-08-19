'use strict'

angular
  .module('rbmaComponents.pageTypes')

  .factory 'rbmaSushiSequencerPageSchema', (rbmaPageBaseProperties, rbmaPageMetaDataProperties) ->
    type: 'object'
    properties: angular.extend {}, rbmaPageBaseProperties, rbmaPageMetaDataProperties,
      artists:
        type: 'array'
        items:
          type: 'object'
          title: 'artist'
          properties:
            name:
              type: 'string'
            video:
              type: 'object'
            posterImage:
              type: 'object'


  .factory 'rbmaSushiSequencerPageForm', (rbmaPageMetaDataFields) -> [
    type: 'fieldset'
    title: 'Header'
    items: [
      'title'
      'subtitle'
    ]
  ,
    type: 'fieldset'
    title: 'Meta Data'
    items: [
      'author'
      'slug'
    ].concat rbmaPageMetaDataFields
  ,
    type: 'fieldset'
    title: 'Artists'
    items: [
      key: 'artists'
      startEmpty: true
      items: [
        {key: 'artists[].name', type: 'text'}
        {key: 'artists[].video', type: 'video'}
        {key: 'artists[].posterImage', type: 'asset'}
      ]
    ]
  ]

  .run (acadminPageTypeRegistry, rbmaSushiSequencerPageSchema, rbmaSushiSequencerPageForm) ->
    acadminPageTypeRegistry.register 'sushiSequencer',
      schema: rbmaSushiSequencerPageSchema
      form: rbmaSushiSequencerPageForm
      directive: 'rbma-sushi-sequencer-page'
      label: 'sushi sequencer'
      specialFeature: true
      order: 10
