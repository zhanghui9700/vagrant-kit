#-*-coding=utf-8-*-

import sys
import socket
import time

from kombu import Connection, Exchange, Queue, Producer

import config


def run(rabbit_url):
    print rabbit_url
    conn = Connection(rabbit_url)
    conn.ensure_connection()
    conn.connect()
    channel = conn.channel()
    exchange = Exchange(config.EXCHANGE_NAME, type='direct')

    producer = Producer(exchange=exchange, channel=channel, routing_key=config.ROUTING_KEY)

    queue = Queue(name=config.QUEUE_NAME,
                    exchange=exchange,
                    routing_key=config.ROUTING_KEY)
    queue.maybe_bind(conn)
    queue.declare()

    index = 0
    while True:
        try:
            time.sleep(1)
            print 'producer'
            index += 1
            producer.publish("send message -- %s" % index)
        except socket.timeout:
            pass



if __name__ == "__main__":
    print 'python x_producer "amqp://localhost:5672/;amqp://localhost:5672/"'
    if len(sys.argv) > 1:
        rabbit_url = sys.argv[1]
    else:
        rabbit_url = config.RABBIT_URL
    run(rabbit_url)
