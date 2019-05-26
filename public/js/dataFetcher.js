var impactApp = new Vue({
	el: '#aggregatorDiv',
	data : {
			formQueries: [],
			firstName: '',
			lastName: '',
			email: '',
			queryType: '',
			queryMessage: ''
		},
	  methods: {
			fetchQueries() {
				// console.log(document.getElementById("feedbackComment").value);
	      fetch('http://35.196.103.174/api/formQueries.php')
	      .then(response => response.json())
	      .then (json => {
					impactApp.formQueries = json;
					console.log(impactApp.formQueries);
				})
	      .catch( function(err){
	        console.log(err)
	      })
	    },
			submitFormResponse() {
				alert(impactApp.queryType);
				fetch('http://35.196.103.174/api/submitFormQuery.php', {
				  method: 'POST',
				  body: JSON.stringify(
						
					),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					alert("Thank You! We'll get back to you shortly!")
				})
				.catch(error => console.error('Error:', error));
			}
	  },
		created() {
			this.fetchQueries()
		}
	})
