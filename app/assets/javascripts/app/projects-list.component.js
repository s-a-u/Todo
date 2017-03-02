angular.module('todoApp').
    component('projectsList', {
        templateUrl: '/app/projects-list.template.html',
        controller: ['Project', function(Project){
            var self = this;
            self.projects = Project.index();

            self.onProjectCreate = function(project){
                self.projects.push(project);
            };

            self.onProjectDelete = function(project){
                var idx = self.projects.indexOf(project);
                if (idx >= 0) {
                    self.projects.splice(idx, 1);
                }
            }
        }]
    });