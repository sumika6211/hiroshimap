import ApplicationController from "./application_controller";

let map
let marker

// Connects to data-controller="google-map--form"
export default class extends ApplicationController {

  static values = { location: {
                      lat: 34.397667,
                      lng: 132.4753786
                    },
                    zoom: 15,
                    addressList: [] }

  static targets = [ 'map', 'keyword', `address`,
                     'latitude', 'longitude', 'addressList' ]

  connect() {
    this.newMap()
  }

  newMap() {
    const loader = this.setLoader()
    loader.load().then(async () => {
      const { Map } = await google.maps.importLibrary("maps");
      const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");
      map = new Map(this.mapTarget, {
        center: this.Value,
        zoom: this.zoomValue,
        mapId: 'DEMO_MAP_ID'
      })
      this.initMarker()
      map.setCenter(this.locationValue)
      this.keywordTarget.addEventListener('change', () => {
        this.changeKeywordAction()
      })
      google.maps.event.addListener(map, 'click', (e) => {
        this.clickMapAction(e)
      });
    })
  }

  changeKeywordAction() {
    this.geoCoding(this.keywordTarget.value)
  }

  clickMapAction(e) {
    this._location = { lat: e.latLng.lat(), lng: e.latLng.lng() }
    this.clearMarker()
    this.setLocation(this._location)
    this.newMarker()
    this.keywordTarget.value = ""
    this.reverseGeoGoding()
  }

  geoCoding(keyword) {
    this._geocoder = new google.maps.Geocoder()
    this._geocoder.geocode({ address: keyword }, (results, status) => {
      if (status == 'OK') {
        this._result = results[0].geometry.location
        this._location = { lat: this._result.lat(), lng: this._result.lng() }
        this.clearMarker()
        this.setLocation(this._location)
        this.newMarker()
        map.setCenter(this._location)
        this.reverseGeoGoding()
      } else {
        this.clearLocationForm()
      }
    })
  }

  reverseGeoGoding() {
    this._geocoder = new google.maps.Geocoder()
    this._geocoder.geocode({ location: this.locationValue }, (results, status) => {
      if (status == 'OK') {
        this.setAddresList(results)
      } else {
        this.clearAddressList()
      }
    })
    this.addressTarget.value = ""
  }

  clearAddressList() {
    this.addressListValue = []
    this.addressListTarget.innerHTML = ""
  }

  setAddresList(result) {
    this.clearAddressList()
    this.setAddressListValue(result)
    this.addressListValue.forEach(address => {
      this._option = document.createElement('option')
      this._option.value = address
      this.addressListTarget.append(this._option)
    })
  }

  setAddressListValue(result) {
    this._addressList = []
    result.forEach(o => {
      this._address = o.formatted_address
      this._addressList.push(this._address)
    });
    this.addressListValue = this._addressList
  }

  clearMarker() {
    if (marker != null) {
      marker.setMap(null)
    }
  }

  newMarker() {
    marker = new google.maps.marker.AdvancedMarkerElement({
      map: map,
      position: this.locationValue
    })
  }

  writeToLocationForm(location) {
    this.latitudeTarget.value = location.lat
    this.longitudeTarget.value = location.lng
  }

  clearLocationForm() {
    this.latitudeTarget.value = ""
    this.longitudeTarget.value = ""
  }

  initMarker() {
    this._latitude = this.latitudeTarget.value
    this._longitude = this.longitudeTarget.value
    if (this._latitude != "" && this._longitude != "") {
      this.locationValue = { lat: parseFloat(this._latitude), lng: parseFloat(this._longitude) }
      this.newMarker(this.locationValue)
    }
  }

  setLocation(location) {
    this.locationValue = location
    this.writeToLocationForm(location)
  }
}
