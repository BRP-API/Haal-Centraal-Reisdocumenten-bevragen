#!/bin/bash

nswag run src/ReisdocumentService/Server.nswag /runtime:Net60
nswag run src/ReisdocumentProxy/DataTransferObjects.nswag /runtime:Net60
nswag run src/ReisdocumentProxy/GbaDataTransferObjects.nswag /runtime:Net60
