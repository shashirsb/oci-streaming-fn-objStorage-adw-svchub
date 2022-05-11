FROM fnproject/python:3.8.5-dev as build-stage

WORKDIR /function

ADD requirements.txt /function/

RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt && \			 
    rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv

ADD . /function/

RUN rm -fr /function/.pip_cache

FROM fnproject/python:3.8.5

WORKDIR /function

COPY --from=build-stage /function /function

COPY --from=build-stage /python /python

ENV PYTHONPATH=/python

ARG ARG_STREAM_OCID="ocid1.stream.oc1.phx.amaaaaaaak7gbria6br67yo57iawmrxwho6gbzdmqopvs6sxvdnrairaj45a"
ENV OCIFN_STREAM_OCID=$ARG_STREAM_OCID

ARG ARG_STREAM_ENDPOINT="cell-1.streaming.us-phoenix-1.oci.oraclecloud.com"
ENV OCIFN_STREAM_ENDPOINT=$ARG_STREAM_ENDPOINT

RUN apt-get install libaio1
RUN "echo $OCIFN_STREAM_OCID $OCIFN_STREAM_ENDPOINT"

ENTRYPOINT ["/python/bin/fdk", "/function/func.py", "handler"]
