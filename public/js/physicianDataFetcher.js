var impactApp = new Vue({
	el: '#aggregatorDiv',
	data : {
			patients: []
		},
	  methods: {
			fetchPatients() {
				fetch('http://35.196.103.174/api/fetchPatients.php', {
				  method: 'POST',
				  body: JSON.stringify({
						username: localStorage.getItem("username"),
					}),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					impactApp.patients = response;
				})
				.catch(error => alert('Error:', error));
			}
	  },
		created() {
			this.fetchPatients();
		}
	})
