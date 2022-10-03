import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = [ "bookingType" ]

  connect() {
    console.log("Hello booking_type!")
  }

  change(event) {
    console.log("booking type change")
    console.log(event.target.selectedOptions[0].text)
    // let provider_id = event.target.selectedOptions[0].value;
    // let target = this.bookingTypeTarget.id;
    // get(`/providers/${provider_id}/services?target=${target}`, {
    //   responseKind: "turbo-stream",
    // })
  }
}
