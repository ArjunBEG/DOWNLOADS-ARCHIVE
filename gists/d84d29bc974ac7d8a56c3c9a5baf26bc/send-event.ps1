function Send-Event {
    [cmdletbinding()]
    Param (
        [string]
        [parameter(ValueFromPipeline)]
        $Message
    )

    $SanitizedMessage = $Message | ConvertTo-Json
    $SanitizedMessage = $SanitizedMessage.Replace('"', '\\\"')

    $EventEnvelope = @"
    [
        {
            \"Source\":\"PowerShellScript\",
            \"Resources\":[],
            \"DetailType\":\"ScriptStatusChanged\",
            \"Detail\":\"{\\\"exit-code\\\":\\\"$($LastExitCode)\\\",\\\"message\\\":$($SanitizedMessage)}\",
            \"EventBusName\":\"default\"
        }
    ]
"@

    aws events put-events --entries $EventEnvelope
}