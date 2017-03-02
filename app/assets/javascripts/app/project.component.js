angular.module('todoApp').
    component('project', {
        templateUrl: '/app/project.template.html',
        bindings: {
            project: '<',
            onDelete: '&'
        },
        controller: ['Project', 'Task', function(Project, Task){
            var self = this;
            self.Task = Task;

            self.delete = function(){
                if(confirm('Project will be removed permanently! Are you sure?')){
                    self.project.$destroy(function(){
                        self.onDelete({project: self.project});
                    });
                }
            };

            self.onTaskCreate = function(task){
                self.project.tasks.push(task);
            };

            self.onTaskDelete = function(task){
                var idx = self.project.tasks.indexOf(task);
                if (idx >= 0) {
                    self.project.tasks.splice(idx, 1);
                }
            };

            self.showUpdateForm = function(){
                self.showForm = true;
                self.projectCopy = angular.copy(self.project)
            };

            self.submit = function(){
                self.projectCopy.$update(function(){
                    self.project = self.projectCopy;
                    self.showForm = false;
                })
            };

            //this.$onInit = function() {
            //    $( ".tasks-list" ).sortable({
            //        containment: "parent",
            //        cursor: "move",
            //        handle: ".handle",
            //        stop: function(event, ui){
            //            console.log(ui.item.index())
            //        },
            //        axis: "y"
            //    });
            //};

            self.sortableOptions = {
                stop: function(e, ui) {
                    var task = new self.Task(ui.item.sortable.model);
                    task.position = ui.item.index();
                    task.$reorder();
                },
                handle: ".handle",
                axis: 'y'
            };
        }]
    });