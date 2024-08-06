
my_minio<-retrieve_minio()

#' show_bucket_names
#'
#' @param minio an  S3 object for interacting with my bucket
#'
#' @return shows all my current S3 objects
#' @export
#'
#' @examples
show_bucket_names<-function(minio=my_minio)

{
  my_buckets<-my_minio$list_buckets()$Buckets
  n=length(my_buckets)
  if (n>0)
  {
    for (i in 1:n)
    {
    print(paste("mon bucket numéro ",i, "est: ",my_buckets[[i]]$Name))
    }
  }
  else
  {
    print("mon bucket est actuellement vide")
  }

}

show_bucket_names()

#' download_data_from_S3
#'
#' @param data_local_path
#' @param data_path_in_S3
#' @param bucket_name
#' @param minio_object
#'
#' @return
#' @export
#'
#' @examples
download_data_from_S3<-function(data_local_path="C:/Users/DIONE Oumar/Desktop/boston_data.csv",data_path_in_S3='Boston_House_price/Boston-house-price-data.csv',bucket_name='odione',minio_object=my_minio)
{

  reponse<- minio_object$get_object(Bucket =bucket_name ,Key =data_path_in_S3 )
  writeBin(reponse$Body,data_local_path )
  raw_data<-utils::read.csv(data_local_path)
  usethis::use_data(raw_data)
  print(paste("Téléchargement ,depuis S3, réussi et données situées localment à ", data_local_path))
}




# Fonction pour uploader un fichier vers S3
#' upload_data_upon_S3
#'
#' @param data_local_path
#' @param data_path_in_S3
#' @param bucket_name
#' @param minio_object
#'
#' @return
#' @export
#'
#' @examples
upload_data_upon_S3 <- function(data_local_path="C:/Users/DIONE Oumar/Desktop/boston_data.csv",data_path_in_S3='Boston_House_price/data_from_local.csv',bucket_name='odione',minio_object=my_minio)
  {

  my_minio$put_object(
    Bucket = bucket_name,
    Key = data_path_in_S3,
    Body = data_local_path
  )
  print(paste("Upload réussi : ", data_path_in_S3))
}
