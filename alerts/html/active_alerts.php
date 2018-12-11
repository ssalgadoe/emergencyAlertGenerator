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
    <table border="2" style= "background-color: #f7ed34; color: #155681; margin: 0 auto;" >
      <thead>
        <tr>
          <th>Alert ID</th>
	  <th>Original ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Score</th>
          <th>Order</th>
          <th>Action</th>
          <th>Published Time</th>
          <th>Keywords</th>
	  <th>Initial Rating</th>
          <td>Classification</td>
        </tr>
      </thead>
      <tbody>
      <script>
         function deActivateAlert(pos) {
	     document.getElementById("deActivateId").value = pos;
	     document.saveForm.submit();
	  }

      </script>      
      <form name='saveForm' method='post' >
	<input type="hidden" id="deActivateId" name="deActivateId">
        <?php
   		while($row = pg_fetch_row($ret)){
	        $pos = $row[0];
                $finalOrder = $row[8];
		echo
            	"<tr>
                    <td>$row[0]</td>
		    <td>$row[12]</td>
                    <td>$row[2]</td>
                    <td>$row[4]</td>
                    <td>$row[11]</td>
                    <td>$finalOrder</td>
                    <td><input type='submit' value='DeActivate' onClick='return deActivateAlert($pos)'></td>		
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


function displayRecordSetReferenced($db,$sql) {
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
          <th>Order</th>
	  <th>Action</th>
          <th>Published Time</th>
          <th>Keywords</th>
	  <th>Initial Rating</th>
          <td>Classification</td>
        </tr>
      </thead>
      <tbody>
      <script>
         function activateAlert(pos) {
	     document.getElementById("activateId").value = pos;
	     document.saveForm.submit();
	  }

      </script>      
      <form name='saveForm' method='post' >
	<input type="hidden" id="activateId" name="activateId">
        <?php
   		while($row = pg_fetch_row($ret)){
	        $pos = $row[0];
                $orderValue = $row[8];
		echo
            	"<tr>
                    <td>$row[0]</td>
                    <td>$row[2]</td>
                    <td>$row[4]</td>
                    <td>$row[11]</td>
                    <td><input type='text' size='2' name='order_$pos' value=$orderValue ></td>
                    <td><input type='submit' value='Activate' onClick='return activateAlert($pos)'></td>		
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
  if (isset($_REQUEST['activateId'])) {
     $activateId = $_REQUEST['activateId'];
     $orderId = "order_" . $activateId;
     if (isset($_REQUEST[$orderId])) {
        $orderValue = $_REQUEST[$orderId];
        if ($orderValue =="") 
	    $orderValue = 10;
     }
     //echo($orderId);
     //echo($orderValue);
     if (is_numeric($orderValue) &&  ($orderValue !="") && ($activateId !="")) {
	     //$sql = "UPDATE public.rawalerts set finalRating ='$orderValue' where ID=$activateId";
             $sql = "INSERT INTO public.filteredalerts (name, title,alertsource, rawData, timestamp,keywords,orderNr, classification, initialRating, finalRating, originalId) SELECT name, title,alertsource, rawData, timestamp,keywords,$orderValue, classification, initialRating, finalRating, id FROM public.rawalerts where ID=$activateId";
	     //echo($sql);
	     //$db = openDatabase($host,$port,$dbname,$credentials);
             updateRecordSet($db,$sql);
             header("Location: active_alerts.php");
     }
  }

  if (isset($_REQUEST['deActivateId'])) {
    $deActivateId = $_REQUEST['deActivateId'];	
    $sql ="DELETE from public.filteredalerts where id=$deActivateId";
    updateRecordSet($db,$sql);
    //echo($deActivateId);
  }

  $sql ="SELECT * from public.filteredalerts order by orderNr";
  displayRecordSet($db,$sql);
 
  $sql ="SELECT * from public.rawalerts where finalRating IS NOT NULL order by id DESC";
  displayRecordSetReferenced($db,$sql);
  pg_close($db);
?>
  </body>
</html>


