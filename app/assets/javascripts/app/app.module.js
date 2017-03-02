//= require ./resources/resources.module

angular.module('todoApp', ['resources', 'ui.sortable']).
    config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }]);;