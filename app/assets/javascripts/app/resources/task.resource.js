angular.module('resources').
    factory("Task", ['$resource', function($resource) {
        return $resource("/api/projects/:project_id/tasks/:id", { id: "@id", project_id: '@project_id' },
            {
                'create':  { method: 'POST' },
                'index':   { method: 'GET', isArray: true },
                'show':    { method: 'GET', isArray: false },
                'update':  { method: 'PUT' },
                'destroy': { method: 'DELETE' },
                'reorder': { method: 'PATCH', url: '/api/projects/:project_id/tasks/:id/reorder'}
            }
        );
    }]);