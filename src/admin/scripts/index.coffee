'use strict'

angular
  .module('rbmaComponents.pageTypes')

  .factory 'rbmaFreestyleComponentPageSchema', (rbmaPageBaseProperties, rbmaPageMetaDataProperties) ->
    type: 'object'
    properties: angular.extend {}, rbmaPageBaseProperties, rbmaPageMetaDataProperties,
      
      lead:
        type: 'string'
      
      mainImage:
        type: 'object'
      
      mainImageCredit:
        type: 'string'
      
      primaryColor:
        type: 'string'
        format: 'color'

      secondaryColor:
        type: 'string'
        format: 'color'

      bodyColor:
        type: 'string'
        format: 'color'

      primaryTypeface:
        type: 'string'
        enum: ['serif', 'sans-serif']
        default: 'sans-serif'

      bodyTypeface:
        type: 'string'
        enum: ['serif', 'sans-serif']
        default: 'sans-serif'

      layout:
        type: 'string'
        enum: ['left', 'center','right']
        default: 'center'

      headerStyle:
        type: 'string'
        enum: ['1', '2', '3', '4', '5', '6', '7']
        default: '1'

      tags:
        type: 'string'

      firstPublished:
        type: 'string'
        format: 'date'

      related:
        type: 'array'
        maxItems: 2
        items:
          type: 'object'
          title: 'link'
          properties:
            id:
              type: 'string'


    blocksProperties:
      body:
        excludeBlockTypes: ['related', 'teasergroup', 'link', 'linklist', 'audio']







  .factory 'rbmaFreestyleComponentPageForm', (rbmaPageMetaDataFields) -> [
    type: 'fieldset'
    title: 'Header'
    items: [
      'title'
      'subtitle'
      { key: 'lead', type: 'textarea'}
      { key: 'mainImage', type: 'asset', title: 'Main Image'}
      { key: 'mainImageCredit', type: 'text', title: 'Image Credit'}
    ]
  ,

    type: 'fieldset'
    title: 'Style'
    items: [
      {
        key: 'primaryColor'
        colorFormat: 'hex'
        spectrumOptions:
          showAlpha: false
          showPalette: false
          showInput: true
          allowEmpty: false
      }
      {
        key: 'secondaryColor'
        colorFormat: 'hex'
        spectrumOptions:
          showAlpha: false
          showPalette: false
          showInput: true
          allowEmpty: false
      }
      {
        key: 'bodyColor'
        colorFormat: 'hex'
        spectrumOptions:
          showAlpha: false
          showPalette: false
          showInput: true
          allowEmpty: false
      }
      'primaryTypeface'
      'secondaryTypeface'
      'bodyTypeface'
      'layout'
      {
        key: 'headerStyle'
        titleMap:
          1: '[1] Title + Image'
          2: '[2] Centred title on top of image'
          3: '[3] Left title on top of image'
          4: '[4] Large background image'
          5: '[5] Image first'
          6: '[6] Long lead'
          7: '[7] Title only'
      }
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
    title: 'Related Stories'
    items: [
      key: 'related'
      startEmpty: true
      items: [
        key: 'related[].id'
        type: 'document'
      ]
    ]
    
  ]

  .run (acadminPageTypeRegistry, rbmaFreestyleComponentPageSchema, rbmaFreestyleComponentPageForm) ->
    acadminPageTypeRegistry.register 'freestyleComponent',
      schema: rbmaFreestyleComponentPageSchema
      form: rbmaFreestyleComponentPageForm
      directive: 'rbma-freestyle-component-page'
      label: 'freestyle component'
      specialFeature: true
      order: 10
