import io
import os
import json
import oci
from fdk import response
from base64 import b64decode, b64encode


def handler(ctx, data: io.BytesIO=None):
    iot_key = "mykey"
    iot_data = "mydata"
    stream_ocid = "ocid1.stream.oc1.phx.amaaaaaaak7gbria6br67yo57iawmrxwho6gbzdmqopvs6sxvdnrairaj45a"
    stream_endpoint = "cell-1.streaming.us-phoenix-1.oci.oraclecloud.com"	

    fnErrors = "No Error"     
    try:
        body = json.loads(data.getvalue())
        iot_key = str(body.get("iot_key"))
        iot_data = str(body.get("iot_data"))
        signer = oci.auth.signers.get_resource_principals_signer()
        stream_client = oci.streaming.StreamClient({}, str("https://" + stream_endpoint), signer=signer)
        msg_entry = oci.streaming.models.PutMessagesDetailsEntry()
        msg_entry.key = b64encode(bytes(str(iot_key), 'utf-8')).decode('utf-8')
        msg_entry.value = b64encode(bytes(str(iot_data), 'utf-8')).decode('utf-8')
        msgs = oci.streaming.models.PutMessagesDetails()
        msgs.messages = [msg_entry]
        stream_client.put_messages(stream_ocid, msgs)
    except (Exception, ValueError) as ex:
        fnErrors = str(ex)

    return response.Response(
        ctx, response_data=json.dumps(
            {"message": "Message sent to the OCI Stream (iot_key={}, iot_data={}, fnErrors={})".format(iot_key, iot_data, fnErrors)}),
        headers={"Content-Type": "application/json"}
        )