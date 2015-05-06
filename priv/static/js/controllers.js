var app = angular.module('sglobally', ['ui.bootstrap']);

app.factory('sgloballyHomePageService', function ($http) {
	return {		

		getVideosCount: function () {
			//since $http.get returns a promise,
			//and promise.then() also returns a promise
			//that resolves to whatever value is returned in it's
			//callback argument, we can return that.
			return $http.get('/api/videos/count').then(function (result) {
				return result.data.rows;
			});
		},
		getNoneFeaturedVideos: function (videosPerPage, skipValue) {
			return $http.get('/api/videos/featured_none?limit=' + videosPerPage + '&skip=' + skipValue).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		},				
		getHomeVideo: function (category, count, skip){
			return $http.get('/api/videos/home_video?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {				
				return result.data.rows;
			});
		},
		getPopularVideos: function (category, count, skip) {
			return $http.get('/api/videos/popular?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		}
				
	};
});

app.controller('SgloballyHome', function ($scope, sgloballyHomePageService) {
  //the clean and simple way
  //getting current year/month/date
  $scope.currentYear = (new Date).getFullYear();
  var m_names = ['January', 'February', 'March', 
               'April', 'May', 'June', 'July', 
               'August', 'September', 'October', 'November', 'December'];
  d = new Date();
  $scope.currentMonth = m_names[d.getMonth()];
  $scope.currentDate = d.getDate();
  
  //$scope.latestCommonVideo = sgloballyHomePageService.getHomeVideo('by_id_title_video_path',1,0);
  $scope.popularVideos = sgloballyHomePageService.getPopularVideos('by_id_title_desc_thumb_date',4,4);
  $scope.noneFeaturedVideos = sgloballyHomePageService.getNoneFeaturedVideos(42, 1);
  
  });




