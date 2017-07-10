#-*-coding=utf-8-*-


RABBIT_URL = 'amqp://192.168.220.181:5672;amqp://192.168.220.182:5672;amqp://192.168.220.183:5672;'
#RABBIT_URL = 'amqp://192.168.220.182:5672;amqp://192.168.220.183:5672;'

EXCHANGE_NAME = 'nova-exchange'
QUEUE_NAME = 'nova-queue'
ROUTING_KEY = 'nova'
