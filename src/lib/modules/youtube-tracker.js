function YtTracking(player, options) {
  if ((player === null) || (player === undefined)) {
    throw new Error('Missing player object');
    return;
  }

  if ((options.callback === null) || (typeof options.callback !== 'function')) {
    throw new Error('Missing the callback function');
    return;
  }

  this.player = player;
  this.trackValues = options.trackings || ['0%', '25%', '50%', '75%', '100%'];
  this.callback = options.callback;
  this.trackList = [];
  this.videoTimer = null;

  this.setupTrackList();
}

YtTracking.prototype.setupTrackList = function() {
  for(var i = 0, j = this.trackValues.length; i < j; i++) {
    this.trackList[this.trackValues[i]] = false;
  }
};

YtTracking.prototype.onVideoStateChange = function(state) {
  switch(state) {
    case YT.PlayerState.PLAYING:
      this.startVideoTimer();
      break;
    case YT.PlayerState.ENDED:
      this.verifyVideoTime();
      this.stopVideoTimer();
      break;
    default:
      this.stopVideoTimer();
      break;
  }
};

YtTracking.prototype.startVideoTimer = function() {
  var _self = this;
  this.videoTimer = setInterval( function() {
    _self.verifyVideoTime();
  }, 1000);
};

YtTracking.prototype.stopVideoTimer = function() {
  clearInterval(this.videoTimer);
};

YtTracking.prototype.verifyVideoTime = function() {
  var totalTime, elapsedTime, type, currentValue, percentage = 0;

  totalTime = this.player.getDuration();
  elapsedTime = Math.round( this.player.getCurrentTime() );

  for(var i = 0, j = this.trackValues.length; i < j; i++) {

    type = this.trackValues[i].substr( this.trackValues[i].length -1 );
    currentValue = this.trackValues[i].replace(/[a-z]/g,"");

    if (type === 'p') {

      // tracking by percentage
      percentage = Math.round( ((100 * elapsedTime) / totalTime) );

      if ( (percentage >= currentValue) && (this.trackList[this.trackValues[i]] === false) ) {
        this.refreshTrackList(this.trackValues[i]);
      }

    } else if (type === 's') {

      // tracking by seconds
      if ( (elapsedTime >= currentValue) && (this.trackList[this.trackValues[i]] === false) ) {
        this.refreshTrackList(this.trackValues[i]);
      }

    }
  }
};

YtTracking.prototype.refreshTrackList = function(track_value) {
  this.trackList[track_value] = true;
  this.publish(track_value);
}

YtTracking.prototype.publish = function(trackValue) {
  if ( (this.callback) && (typeof this.callback === 'function') ) {
    this.callback(trackValue);
  }
};

export default YtTracking;