function Push-Message(
    $token,
    $user,
    $message,
    $device = '',
    $title = '',
    $url = '',
    $urlTitle = '',
    $priority = -1,
    $timestamp = ''
){

   Add-Type -AssemblyName System.Web

   $payload = "token=$token&user=$user&message=$([System.Web.HttpUtility]::UrlEncode($message))&priority=$priority"
  
   if(![system.string]::IsNullOrEmpty($device)){
        $payload += "&device=$([System.Web.HttpUtility]::UrlEncode($device))"
   }
   
   if(![system.string]::IsNullOrEmpty($title)){
        $payload += "&title=$([System.Web.HttpUtility]::UrlEncode($title))"
   }
   
   if(![system.string]::IsNullOrEmpty($url)){
        $payload += "&url=$([System.Web.HttpUtility]::UrlEncode($url))"
   }
   
   if(![system.string]::IsNullOrEmpty($urlTitle)){
        $payload += "&url_title=$([System.Web.HttpUtility]::UrlEncode($urlTitle))"
   }
   
   if(![system.string]::IsNullOrEmpty($timestamp)){
        $payload += "&timestamp=$([System.Web.HttpUtility]::UrlEncode($timestamp))"
   }
   
   $payloadBytes = [System.Text.Encoding]::Ascii.GetBytes($payload)
   $client = New-Object System.Net.WebClient
   $result = $client.UploadData("https://api.pushover.net/1/messages.json",$payloadBytes)
   
   return [System.Text.Encoding]::Ascii.GetString($result)
}
