import { Controller } from "@hotwired/stimulus"
import { Loader } from "@googlemaps/js-api-loader"

export default class extends Controller {
  setLoader() {
    return new Loader({
      apiKey: process.env.GOOGLE_API_KEY,
      version: "weekly",
    });
  }
}