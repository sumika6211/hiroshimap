import ApplicationController from "./application_controller";
// Connects to data-controller="google-map--show"
export default class extends ApplicationController {
  static targets = [ 'map' ]
  connect() {
    this.newMap()
  }

  newMap() {
    const loader = this.setLoader()
    loader.load().then(async () => {
      const { Map } = await google.maps.importLibrary("maps");
      this._location = JSON.parse(this.mapTarget.dataset.json)
      this._map = new Map(this.mapTarget, {
        center: { lat: this._location.lat, lng: this._location.lng },
        zoom: 15,
      })
      new google.maps.Marker({
        map: this._map,
        position: this._location
      })
    })
  }
}
