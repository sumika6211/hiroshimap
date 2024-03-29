// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import GoogleMap__ApplicationController from "./google_map/application_controller"
application.register("google-map--application", GoogleMap__ApplicationController)

import GoogleMap__FormController from "./google_map/form_controller"
application.register("google-map--form", GoogleMap__FormController)

import GoogleMap__IndexController from "./google_map/index_controller"
application.register("google-map--index", GoogleMap__IndexController)

import GoogleMap__ShowController from "./google_map/show_controller"
application.register("google-map--show", GoogleMap__ShowController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)
