from os import path
from flask import Flask, send_from_directory, request, json
from diarization.speaker_diarization import diarization
from diarization.preprocess import record, noiseReducer
from werkzeug.utils import secure_filename
import SpeakerIdentification


UPLOAD_FOLDER = 'public'
ALLOWED_EXTENSIONS = {'wav'}

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.run(debug=True)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/public/<path:path>')
def public(path):
    return send_from_directory('public', path)


@app.route('/api/speaker-diarization', methods = ['POST'])
def speaker_diarize():
    audio_file = request.files['audio']
    if audio_file.filename == '':
        data = {
            'error':'no audio file sent'
        }
        response = app.response_class(
            response=json.dumps(data),
            status=400,
            mimetype='application/json'
        )
        return response
        
    if audio_file and allowed_file(audio_file.filename):
        filename = secure_filename('audio-for-diarization.wav')
        filepath = path.join(app.config['UPLOAD_FOLDER'], filename)
        audio_file.save(filepath)
        
        result = diarization(filepath)

        result = list(map(lambda item: request.url_root  + item, result))
        print(result)
        # for item in result:
        #     item = request.url_root  + item
        return {
            'success': '',
            'speaker': result
        }

@app.route('/api/train', methods = ['POST'])
def train_model():
    audio_file = request.files['audio']
    if audio_file.filename == '':
        data = {
            'error':'no audio file sent'
        }
        response = app.response_class(
            response=json.dumps(data),
            status=400,
            mimetype='application/json'
        )
        return response
        
    if audio_file and allowed_file(audio_file.filename):
        filename = secure_filename(request.form['name']+ '-sample.wav')
        filepath = path.join(app.config['UPLOAD_FOLDER'], filename)
        audio_file.save(filepath)
        from pydub import AudioSegment
        audio = AudioSegment.from_file(filepath)
        
        audio_segment_duration_millis = audio.duration_seconds *1000 /10
        print (audio_segment_duration_millis * 100)

        training_file_path = path.join('training_set', filename)
        file_path_list = []
        for i in range(10):
            t1 = i * audio_segment_duration_millis 
            t2 = (i+1) * audio_segment_duration_millis
            newAudio = audio[t1:t2]
            newAudioFilePath = training_file_path.split('.')[0] + str(i) +'.wav'
            newAudio.export(newAudioFilePath, format="wav")
            file_path_list.append(path.basename(newAudioFilePath))

        SpeakerIdentification.train_model(file_path_list)

            
        return {
            'success': 'Model has been trained to recognize ' + "'" + request.form['name'] + "' "
        }


@app.route('/api/test', methods = ['POST'])
def test_model():
    audio_file = request.files['audio']
    if audio_file.filename == '':
        data = {
            'error':'no audio file sent'
        }
        response = app.response_class(
            response=json.dumps(data),
            status=400,
            mimetype='application/json'
        )
        return response
        
    if audio_file and allowed_file(audio_file.filename):
        filename = secure_filename('test_audio.wav')
        filepath = path.join('testing_set', filename)
        audio_file.save(filepath)
        result = SpeakerIdentification.test_model_on_single_file(filepath)

        return {
            'success': 'Model has identified speaker as ' + result,
            'speaker': result
        }