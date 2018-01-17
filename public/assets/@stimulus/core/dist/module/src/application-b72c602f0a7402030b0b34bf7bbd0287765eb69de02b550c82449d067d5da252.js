import { createConfiguration } from "./configuration";
import { Router } from "./router";
var Application = /** @class */ (function () {
    function Application(configurationOptions) {
        if (configurationOptions === void 0) { configurationOptions = {}; }
        this.configuration = createConfiguration(configurationOptions);
        this.router = new Router(this);
    }
    Application.start = function (configurationOptions) {
        var application = new Application(configurationOptions);
        application.start();
        return application;
    };
    Application.prototype.start = function () {
        this.router.start();
    };
    Application.prototype.stop = function () {
        this.router.stop();
    };
    Application.prototype.register = function (identifier, controllerConstructor) {
        this.router.register(identifier, controllerConstructor);
    };
    Application.prototype.unregister = function (identifier) {
        this.router.unregister(identifier);
    };
    Application.prototype.getControllerForElementAndIdentifier = function (element, identifier) {
        var context = this.router.getContextForElementAndIdentifier(element, identifier);
        return context ? context.controller : null;
    };
    return Application;
}());
export { Application };
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYXBwbGljYXRpb24uanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9wYWNrYWdlcy9Ac3RpbXVsdXMvY29yZS9zcmMvYXBwbGljYXRpb24udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUF1QyxtQkFBbUIsRUFBRSxNQUFNLGlCQUFpQixDQUFBO0FBRTFGLE9BQU8sRUFBRSxNQUFNLEVBQUUsTUFBTSxVQUFVLENBQUE7QUFFakM7SUFVRSxxQkFBWSxvQkFBK0M7UUFBL0MscUNBQUEsRUFBQSx5QkFBK0M7UUFDekQsSUFBSSxDQUFDLGFBQWEsR0FBRyxtQkFBbUIsQ0FBQyxvQkFBb0IsQ0FBQyxDQUFBO1FBQzlELElBQUksQ0FBQyxNQUFNLEdBQUcsSUFBSSxNQUFNLENBQUMsSUFBSSxDQUFDLENBQUE7SUFDaEMsQ0FBQztJQVRNLGlCQUFLLEdBQVosVUFBYSxvQkFBMkM7UUFDdEQsSUFBTSxXQUFXLEdBQUcsSUFBSSxXQUFXLENBQUMsb0JBQW9CLENBQUMsQ0FBQTtRQUN6RCxXQUFXLENBQUMsS0FBSyxFQUFFLENBQUE7UUFDbkIsTUFBTSxDQUFDLFdBQVcsQ0FBQTtJQUNwQixDQUFDO0lBT0QsMkJBQUssR0FBTDtRQUNFLElBQUksQ0FBQyxNQUFNLENBQUMsS0FBSyxFQUFFLENBQUE7SUFDckIsQ0FBQztJQUVELDBCQUFJLEdBQUo7UUFDRSxJQUFJLENBQUMsTUFBTSxDQUFDLElBQUksRUFBRSxDQUFBO0lBQ3BCLENBQUM7SUFFRCw4QkFBUSxHQUFSLFVBQVMsVUFBa0IsRUFBRSxxQkFBNEM7UUFDdkUsSUFBSSxDQUFDLE1BQU0sQ0FBQyxRQUFRLENBQUMsVUFBVSxFQUFFLHFCQUFxQixDQUFDLENBQUE7SUFDekQsQ0FBQztJQUVELGdDQUFVLEdBQVYsVUFBVyxVQUFrQjtRQUMzQixJQUFJLENBQUMsTUFBTSxDQUFDLFVBQVUsQ0FBQyxVQUFVLENBQUMsQ0FBQTtJQUNwQyxDQUFDO0lBRUQsMERBQW9DLEdBQXBDLFVBQXFDLE9BQWdCLEVBQUUsVUFBa0I7UUFDdkUsSUFBTSxPQUFPLEdBQUcsSUFBSSxDQUFDLE1BQU0sQ0FBQyxpQ0FBaUMsQ0FBQyxPQUFPLEVBQUUsVUFBVSxDQUFDLENBQUE7UUFDbEYsTUFBTSxDQUFDLE9BQU8sQ0FBQyxDQUFDLENBQUMsT0FBTyxDQUFDLFVBQVUsQ0FBQyxDQUFDLENBQUMsSUFBSSxDQUFBO0lBQzVDLENBQUM7SUFDSCxrQkFBQztBQUFELENBQUMsQUFuQ0QsSUFtQ0MifQ==
;
