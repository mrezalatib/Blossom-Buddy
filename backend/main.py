from flask import Flask
from flask_restful import Api, Resource, reqparse, abort
from gi.overrides.keysyms import value

# Resource is used to define endpoints
# API adds RESTful support to the Flask App

"""__name__ is passed as an argument to help Flask determine the location of the application,
which is used to resolve templates, static files, and other resources. __name__ represents
the name of the current module and is typically used to initialize Flask."""

app = Flask(__name__) # app is an instance of Flask class, our webapp
api = Api(app) # makes our flask app capable of performing RESTful API requests

video_put_args = reqparse.RequestParser() # RequestParser object used to define and validate the parameters you expect in a request
video_put_args.add_argument("name", type=str, help="Name of the video") # these represent data that we expect users to send in their requests
video_put_args.add_argument("views", type=int, help="Views of the video", required=True) # we're also adding these args to an instance of RequestParser
video_put_args.add_argument("likes", type=int, help="Likes on the video")

videos = {}

def abort_if_video_id_doesnt_exist(video_id):
    if video_id not in videos:
        abort(404, message = "Could not find video...")

def abort_if_video_exists(video_id):
    if video_id in videos:
        abort(409, meassage = "Video already exists with that id...")

class Video(Resource): #inherits from Resource
    def get(self, video_id):
        abort_if_video_id_doesnt_exist(video_id)
        return videos[video_id]

    def put(self, video_id):
        abort_if_video_exists(video_id)
        args = video_put_args.parse_args() # method checks if request contains relevant args of specified type, stores request data in args
        videos[video_id] = args
        return videos[video_id], 201 # 201 = exit code for "created"

    def delete(self, video_id):
        abort_if_video_id_doesnt_exist(video_id) # because you cant delete something that doesn't exist
        del video_id[video_id]
        return '', 204 # status code for deleted successfully


api.add_resource(Video, "/video/<int:video_id>") # this url represents an endpoint (where requests are directed to)

if __name__ == "__main__":
    app.run(debug=True) # only run debug=True while in development