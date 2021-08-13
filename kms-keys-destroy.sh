export LOCATION="europe-west4"
for keyring in $(gcloud kms keyrings list --location=$LOCATION --format="value(NAME)")
do  
    for key in $(gcloud kms keys list --location=$LOCATION --keyring=$keyring --filter='PRIMARY_STATE!~DESTROY' --format="value(NAME)")
    do
        echo $keyring
        echo $key
        for version in $(gcloud kms keys versions list --location=$LOCATION --keyring=$keyring --key=$key --filter='STATE!~DESTROY' --format="value(NAME)")
        do
            gcloud kms keys versions destroy $version --location=$LOCATION --keyring=$keyring --key=$key
        done
    done
    
done
