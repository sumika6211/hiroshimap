import ApplicationController from "./application_controller";

let map
let markers = []
let infoWindows = []

// Connects to data-controller="google-map--index"
export default class extends ApplicationController {
  static values = { location: {
                        lat: 34.3926867,
                        lng: 132.4522012
                    },
                    zoom: 5,
                    points: [] }

  static targets = [ 'map' ]

  connect() {
    this.setPoints()
    this.newMap()
  }

  newMap() {
    const loader = this.setLoader()
    loader.load().then(async () => {
      const { Map } = await google.maps.importLibrary("maps");
      map = new Map(this.mapTarget, {
        center: this.locationValue,
        zoom: this.zoomValue,
      })
      this.addMarkersToMap()
    })
  }

  addMarkersToMap() {
    this.pointsValue.forEach((o, i) => {
      this.addMarkerToMarkers(o)
      this.addInfoWindowToInfoWindows(o)
      this.addEventToMarker(i)
    })
  }

  addMarkerToMarkers(o) {
    this._marker = new google.maps.Marker({
      position: { lat: o.lat, lng: o.lng },
      map,
      name: o.name
    })
    markers.push(this._marker)
  }

  addInfoWindowToInfoWindows(o) {
    // 引数の値から吹き出しを１件作成
    // 吹き出しの中にはpoints/:idへのリンク
    // リンクには data-turbolinks="false" でリロードさせるとJS側のワーニングが出ない。
    this._infoWindow = new google.maps.InfoWindow({
      content: `
        <a href="/posts data-turbolinks="false">
          ${o.name}
        </a>
      `
    })
    // infoWindowに1件吹き出しを追加
    infoWindows.push(this._infoWindow)
  }

  addEventToMarker(i) {
    markers[i].addListener('click', () => {
      infoWindows[i].open(map, markers[i]);
    });
  }

  setPoints() {
    this.pointsValue = JSON.parse(this.mapTarget.dataset.json)
    this.getLastPointLocation()
  }

  getLastPointLocation() {
    if (this.pointsValue.length > 0) {
      this._lastPoint = this.pointsValue.sort((a, b) => { a.id - b.id }).reverse()[0]
      this.locationValue = this._lastPoint
      this.zoomValue = 12
    }
  }
}
