var impactApp = new Vue({
	el: '#aggregatorDiv',
	data : {

		},
	  methods: {
			fetchCientInfo() {
				// console.log(document.getElementById("feedbackComment").value);
	      fetch('http://ec2-13-233-94-247.ap-south-1.compute.amazonaws.com/api/client.php')
	      .then(response => response.json())
	      .then (json => {
					impactApp.exercises = json;
					console.log(commentsApp.exercises);
				})
	      .catch( function(err){
	        console.log(err)
	      })
	    }
	  },
		created() {
		}
	})
