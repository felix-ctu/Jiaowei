class GPSConvert {
    constructor() {
        this.pi = 3.14159265358979324;
        this.a = 6378245.0;
        this.ee = 0.00669342162296594323;
    }

    outOfChina(lon, lat) {
        if (lon < 72.004 || lon > 137.8347)
            return true;
        if (lat < 0.8293 || lat > 55.8271)
            return true;
        return false;
    }

    transformLat(y, x) {
        let ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
        ret += (20.0 * Math.sin(6.0 * x * this.pi) + 20.0 * Math.sin(2.0 * x * this.pi)) * 2.0 / 3.0;
        ret += (20.0 * Math.sin(y * this.pi) + 40.0 * Math.sin(y / 3.0 * this.pi)) * 2.0 / 3.0;
        ret += (160.0 * Math.sin(y / 12.0 * this.pi) + 320 * Math.sin(y * this.pi / 30.0)) * 2.0 / 3.0;
        return ret;
    }

    transformLon(y, x) {
        let ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
        ret += (20.0 * Math.sin(6.0 * x * this.pi) + 20.0 * Math.sin(2.0 * x * this.pi)) * 2.0 / 3.0;
        ret += (20.0 * Math.sin(x * this.pi) + 40.0 * Math.sin(x / 3.0 * this.pi)) * 2.0 / 3.0;
        ret += (150.0 * Math.sin(x / 12.0 * this.pi) + 300.0 * Math.sin(x / 30.0 * this.pi)) * 2.0 / 3.0;
        return ret;
    }

    transform(wgLon, wgLat) {
        let result = [];
        if (this.outOfChina(wgLon, wgLat)) {
            result.push(wgLon);
            result.push(wgLat);
            return result;
        }

        let dLat = this.transformLat(wgLon - 105.0, wgLat - 35.0);
        let dLon = this.transformLon(wgLon - 105.0, wgLat - 35.0);
        let radLat = wgLat / 180.0 * this.pi;
        let magic = Math.sin(radLat);
        magic = 1 - this.ee * magic * magic;
        let sqrtMagic = Math.sqrt(magic);
        dLat = (dLat * 180.0) / ((this.a * (1 - this.ee)) / (magic * sqrtMagic) * this.pi);
        dLon = (dLon * 180.0) / (this.a / sqrtMagic * Math.cos(radLat) * this.pi);

        let beforeLon = parseFloat((wgLon + dLon).toFixed(6));
        let beforeLat = parseFloat((wgLat + dLat).toFixed(6));

        result.push(beforeLon + 0.001222);
        result.push(beforeLat - 0.000805);
        // result.push(beforeLon + 0.001322);
        // result.push(beforeLat - 0.000691);
        return result;
    }
}