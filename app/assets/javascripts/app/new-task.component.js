angular.module('todoApp').
    component('newTask', {
        templateUrl: '/app/new-task.template.html',
        bindings: {
            onCreate: '&',
            project: '='
        },
        controller: ['Task', function(Task){
            var self = this;

            self.newTask = function(){
                return new Task({project_id: self.project.id});
            };

            self.task = self.newTask();

            self.submit = function(){
                self.task.$create(function(){
                    self.onCreate({task: self.task});
                    self.task = self.newTask();
                });
            }
        }]
    });