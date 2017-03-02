angular.module('todoApp').
    component('task', {
        templateUrl: '/app/task.template.html',
        bindings: {
            plainTask: '<task',
            onDelete: '&'
        },
        controller: ['Task', function(Task){
            var self = this;

            self.task = new Task(self.plainTask)
            self.delete = function(){
                if(confirm('Task will be removed permanently. Are you sure?')){
                    self.task.$destroy(function(){
                        self.onDelete({task: self.plainTask})
                    });
                }
            };

            self.edit = function(){
                self.showForm = true;
                self.taskCopy = angular.copy(self.task)
            };

            self.submit = function(){
                self.taskCopy.$update(function(){
                    self.task = self.taskCopy;
                    self.showForm = false;
                })
            };

            self.update = function(){
                self.task.$update();
            }
        }]
    });