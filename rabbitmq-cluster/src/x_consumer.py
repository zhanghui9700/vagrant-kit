#-*-coding=utf-8-*-

import socket
import sys

from kombu import Connection, Exchange, Queue, Consumer

import config

def run(rabbit_url):
    print rabbit_url
    conn = Connection(rabbit_url)
    conn.ensure_connection()
    conn.connect()
    exchange = Exchange(config.EXCHANGE_NAME, type='direct')
    queue = Queue(name=config.QUEUE_NAME,
                    exchange=exchange,
                    routing_key=config.ROUTING_KEY)
    consumer = Consumer(conn, queues=queue, callbacks=[process_message], accept=['text/plain'])
    consumer.consume()

    while True:
        try:
            print 'drain_events'
            conn.drain_events(timeout=2) # timeout
        except socket.timeout:
            pass

def process_message(body, message):
    print('The body is {}'.format(body))
    message.ack()

if __name__ == "__main__":
    print 'python x_consumer "amqp://localhost:5672/;amqp://localhost:5672/"'
    if len(sys.argv) > 1:
        rabbit_url = sys.argv[1]
    else:
        rabbit_url = config.RABBIT_URL
    run(rabbit_url)
