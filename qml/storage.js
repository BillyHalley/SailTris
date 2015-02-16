function getDatabase() {
     return LocalStorage.openDatabaseSync("SailTris", "0.1", "Database", 10000);
}

function set(setting, value) {
   var db = getDatabase();
   var res = "";
   db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
              if (rs.rowsAffected > 0) {
                res = "OK";
              } else {
                res = "Error";
              }
        }
  );
  return res;
}

function get(setting) {
    var db = getDatabase();
    var res="";
    db.transaction(function(tx) {
      var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
      if (rs.rows.length > 0) {
           res = rs.rows.item(0).value;
      } else {
          res = 0;
      }
   })
   // The function returns “Unknown” if the setting was not found in the database
   // For more advanced projects, this should probably be handled through error codes
   return res
}
