from flask import Flask
from cadl import charrnn
app = Flask(__name__)

@app.route('/')
def hello_world():
    with open('/usr/share/models/trump.txt', 'r') as fp:
        txt = fp.read()
    # train(txt, ckpt_name='trump.ckpt', max_iter=max_iter)
    # refer to the model downloaded from the Dockerfile
    return "".join(charrnn.infer(txt, ckpt_name='/usr/share/models/trump.ckpt', n_iterations=100))

if __name__ == '__main__':
    app.run()
