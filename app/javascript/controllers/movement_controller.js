import { Controller } from "@hotwired/stimulus"
import  { get } from "@rails/request.js"
// Connects to data-controller="movement"
export default class extends Controller {

  static targets = ["optionSelect"]
  static values = {
    url: String
  }

  change(event) {
    let mov_type = event.target.selectedOptions[0].value
    let target = this.optionSelectTarget.id

    get(this.urlValue+'/options?target='+target+'&mov_selected='+mov_type, {
      responseKind: "turbo-stream"
    })
  }
}
