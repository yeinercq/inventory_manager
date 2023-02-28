// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MovementController from "./movement_controller"
application.register("movement", MovementController)

import RemoteModalController from "./remote_modal_controller"
application.register("remote-modal", RemoteModalController)

import RemovalsController from "./removals_controller"
application.register("removals", RemovalsController)
