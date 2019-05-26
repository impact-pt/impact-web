<?php
session_start();
?>

<script>
alert(<?php echo $_SESSION['username']; ?>);
</script>
