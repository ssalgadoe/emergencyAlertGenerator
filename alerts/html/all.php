<php
session_start();
ob_start();

?>
<!doctype html>
  <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title> Alerts Editor</title>
   </head>
   
   <body>

<?php



$host        = "host=127.0.0.1";
$port        = "port=5432";
$dbname      = "dbname=alerts";
$credentials = "user=alert_user password=ingle@123";


function openDatabase($host, $port, $dbname,$credentials) {
    $db = pg_connect( "$host $port $dbname $credentials"  );
    if(!$db){
        echo "Error : Unable to open database\n";
    } else {
        #echo "Opened database successfully\n";
	return ($db);
    }
 }

function updateRecordSet($db,$sql) {
   $ret = pg_query($db, $sql);
   if(!$ret){
      echo pg_last_error($db);
      exit;
   } 
}

function displayRecordSet($db,$sql) {
   $ret = pg_query($db, $sql);
   if(!$ret){
      echo pg_last_error($db);
      exit;
   } 
   ?>
    <table border="2" style= "background-color: #84ed86; color: #761a9b; margin: 0 auto;" >
      <thead>
        <tr>
          <th>Alert ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Score</th>
          <th>Published Time</th>
          <th>Keywords</th>
	  <th>Initial Rating</th>
          <td>Classification</td>
        </tr>
      </thead>
      <tbody>
      <script>
         function saveScore(pos) {
	     document.getElementById("saveId").value = pos;
	     document.saveForm.submit();
	  }

      </script>      
      <form name='saveForm' method='post' >
	<input type="hidden" id="saveId" name="saveId">
        <?php
   		while($row = pg_fetch_row($ret)){
	        $pos = $row[0];
                $finalRate = $row[11];
		echo
            	"<tr>
                    <td>$row[0]</td>
                    <td>$row[2]</td>
                    <td>$row[4]</td>
                    <td><input type='text' name='score_$pos' value=$finalRate><input type='submit' value='Save' onClick='return saveScore($pos)'></td>
                    <td>$row[5]</td>
                    <td>$row[6]</td>
	            <td>$row[10]</td>		
                    <td>$row[9]</td> 
                </tr>\n";
  		}
        ?>
	
	</form>
      </tbody>
    </table>
<?php
}


  $db = openDatabase($host,$port,$dbname,$credentials);
  if (isset($_REQUEST['saveId'])) {
     $saveId = $_REQUEST['saveId'];
     $scoreId = "score_" . $saveId;
     if (isset($_REQUEST[$scoreId])) {
         $scoreValue = $_REQUEST[$scoreId];
         echo($saveId);
         echo($scoreValue);
         if (is_numeric($scoreValue) &&  ($scoreValue !="") && ($saveId !="")) {
	     $sql = "UPDATE public.rawalerts set finalRating ='$scoreValue' where ID=$saveId";
	     echo($sql);
	     $db = openDatabase($host,$port,$dbname,$credentials);
             updateRecordSet($db,$sql);
             header("Location: all.php");
         }
     }
 }
  $sql ="SELECT * from public.rawalerts order by id desc";
  displayRecordSet($db,$sql);
  pg_close($db);
?>
  </body>
</html>


