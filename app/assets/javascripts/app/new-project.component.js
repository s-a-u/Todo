angular.module('todoApp').
    component('newProject', {
        templateUrl: '/app/new-project.template.html',
        bindings: {
            onCreate: '&',
        },
        controller: ['Project', function(Project){
            var self = this;
            self.project = new Project();

            self.submit = function(){
                self.project.$create(function(){
                    self.onCreate({project: self.project});
                    $('#hide-new-project-form').click();
                    self.project = new Project();
                });
            };

        }]
    });