import ApplicationController from "./application_controller";

let map
let markers = []
let infoWindows = []

// Connects to data-controller="google-map--index"
export default class extends ApplicationController {
  static values = { location: {
                        lat: 34.397667,
                        lng: 132.4753786
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
      // 地図を statis values の情報から作成
      map = new Map(this.mapTarget, {
        center: this.locationValue,
        zoom: this.zoomValue,
      })
      // 地図に全マーカーをセット
      this.addMarkersToMap()
    })
  }

  // ###地図にピンを追加する

  addMarkersToMap() {
    // 全ポイントをループで１件ずつ処理
    this.pointsValue.forEach((o, i) => {
      // markers　に 座標データー１件を追加
      this.addMarkerToMarkers(o)
      // infoWindowｓ に 吹き出しデーターを１件追加
      this.addInfoWindowToInfoWindows(o)
      // マーカーに該当する吹き出しを開くクリックイベントを追加
      this.addEventToMarker(i)
    })
  }

  addMarkerToMarkers(o) {
    // 引数の値からマーカーを１件作成
    this._marker = new google.maps.Marker({
      position: { lat: o.lat, lng: o.lng },
      map,
      name: o.name
    })
    // markersに１件マーカーを追加
    markers.push(this._marker)
  }

  addInfoWindowToInfoWindows(o) {
    // 引数の値から吹き出しを１件作成
    // 吹き出しの中にはpoints/:idへのリンク
    // リンクには data-turbolinks="false" でリロードさせるとJS側のワーニングが出ない。
    this._infoWindow = new google.maps.InfoWindow({
      content: `
        <a href="/points/${o.id}" data-turbolinks="false">
          ${o.name}
        </a>
      `
    })
    // infoWindowに1件吹き出しを追加
    infoWindows.push(this._infoWindow)
  }

  addEventToMarker(i) {
    // i番目のマーカーにクリックイベントを追加
    markers[i].addListener('click', () => {
      // 同じインデックス番号iを吹き出しを開く
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
