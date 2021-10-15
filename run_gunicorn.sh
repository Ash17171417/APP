
NAME="chat"                                           
APP_DIR="$@"                                                  
SOCKFILE=/tmp/chat_project.sock
USER=root                                                     
GROUP=www-data                                                
NUM_WORKERS=5                                                
DJANGO_SETTINGS_MODULE=chat.settings                  
DJANGO_WSGI_MODULE=chat.wsgi                          

echo "Starting $NAME as `whoami`"

cd $APP_DIR
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$APP_DIR:$PYTHONPATH

RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

exec gunicorn ${DJANGO_WSGI_MODULE}:application \
    --daemon \
    --name $NAME \
    --workers $NUM_WORKERS \
    --group $GROUP \
    --bind unix:$SOCKFILE \
    --user $USER
