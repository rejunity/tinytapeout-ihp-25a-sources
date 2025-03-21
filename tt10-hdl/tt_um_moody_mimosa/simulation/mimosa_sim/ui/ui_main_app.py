# Form implementation generated from reading ui file 'mimosa_sim/ui/app.ui'
#
# Created by: PyQt6 UI code generator 6.4.2
#
# WARNING: Any manual changes made to this file will be lost when pyuic6 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(1219, 630)
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayoutWidget_2 = QtWidgets.QWidget(parent=self.centralwidget)
        self.gridLayoutWidget_2.setGeometry(QtCore.QRect(210, 530, 151, 44))
        self.gridLayoutWidget_2.setObjectName("gridLayoutWidget_2")
        self.gridLayout_2 = QtWidgets.QGridLayout(self.gridLayoutWidget_2)
        self.gridLayout_2.setContentsMargins(0, 0, 0, 0)
        self.gridLayout_2.setObjectName("gridLayout_2")
        self.label = QtWidgets.QLabel(parent=self.gridLayoutWidget_2)
        self.label.setObjectName("label")
        self.gridLayout_2.addWidget(self.label, 0, 0, 1, 1)
        self.led_heartbeat = QtWidgets.QPushButton(parent=self.gridLayoutWidget_2)
        self.led_heartbeat.setMaximumSize(QtCore.QSize(50, 25))
        self.led_heartbeat.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_heartbeat.setText("")
        self.led_heartbeat.setCheckable(True)
        self.led_heartbeat.setChecked(False)
        self.led_heartbeat.setObjectName("led_heartbeat")
        self.gridLayout_2.addWidget(self.led_heartbeat, 0, 1, 1, 1)
        self.gridLayoutWidget_3 = QtWidgets.QWidget(parent=self.centralwidget)
        self.gridLayoutWidget_3.setGeometry(QtCore.QRect(210, 10, 151, 241))
        self.gridLayoutWidget_3.setObjectName("gridLayoutWidget_3")
        self.gridLayout_3 = QtWidgets.QGridLayout(self.gridLayoutWidget_3)
        self.gridLayout_3.setContentsMargins(0, 0, 0, 0)
        self.gridLayout_3.setObjectName("gridLayout_3")
        self.label_3 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_3.setObjectName("label_3")
        self.gridLayout_3.addWidget(self.label_3, 0, 0, 1, 1)
        self.led_emo_happy = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_happy.setMaximumSize(QtCore.QSize(50, 16777215))
        self.led_emo_happy.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_emo_happy.setText("")
        self.led_emo_happy.setCheckable(True)
        self.led_emo_happy.setChecked(False)
        self.led_emo_happy.setObjectName("led_emo_happy")
        self.gridLayout_3.addWidget(self.led_emo_happy, 0, 1, 1, 1)
        self.led_emo_angry = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_angry.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_emo_angry.setText("")
        self.led_emo_angry.setCheckable(True)
        self.led_emo_angry.setChecked(False)
        self.led_emo_angry.setObjectName("led_emo_angry")
        self.gridLayout_3.addWidget(self.led_emo_angry, 5, 1, 1, 1)
        self.led_emo_calm = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_calm.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_emo_calm.setText("")
        self.led_emo_calm.setCheckable(True)
        self.led_emo_calm.setChecked(False)
        self.led_emo_calm.setObjectName("led_emo_calm")
        self.gridLayout_3.addWidget(self.led_emo_calm, 6, 1, 1, 1)
        self.led_emo_nervous = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_nervous.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(252,232,9); /* Background color when checked */\n"
"}")
        self.led_emo_nervous.setText("")
        self.led_emo_nervous.setCheckable(True)
        self.led_emo_nervous.setChecked(False)
        self.led_emo_nervous.setObjectName("led_emo_nervous")
        self.gridLayout_3.addWidget(self.led_emo_nervous, 3, 1, 1, 1)
        self.label_4 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_4.setObjectName("label_4")
        self.gridLayout_3.addWidget(self.label_4, 2, 0, 1, 1)
        self.label_5 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_5.setObjectName("label_5")
        self.gridLayout_3.addWidget(self.label_5, 3, 0, 1, 1)
        self.led_emo_stressed = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_stressed.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_emo_stressed.setText("")
        self.led_emo_stressed.setCheckable(True)
        self.led_emo_stressed.setChecked(False)
        self.led_emo_stressed.setObjectName("led_emo_stressed")
        self.gridLayout_3.addWidget(self.led_emo_stressed, 2, 1, 1, 1)
        self.led_emo_bored = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_bored.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(252,232,9); /* Background color when checked */\n"
"}")
        self.led_emo_bored.setText("")
        self.led_emo_bored.setCheckable(True)
        self.led_emo_bored.setChecked(False)
        self.led_emo_bored.setObjectName("led_emo_bored")
        self.gridLayout_3.addWidget(self.led_emo_bored, 4, 1, 1, 1)
        self.led_emo_excited = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_excited.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_emo_excited.setText("")
        self.led_emo_excited.setCheckable(True)
        self.led_emo_excited.setChecked(False)
        self.led_emo_excited.setObjectName("led_emo_excited")
        self.gridLayout_3.addWidget(self.led_emo_excited, 1, 1, 1, 1)
        self.label_8 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_8.setObjectName("label_8")
        self.gridLayout_3.addWidget(self.label_8, 6, 0, 1, 1)
        self.label_2 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_2.setObjectName("label_2")
        self.gridLayout_3.addWidget(self.label_2, 1, 0, 1, 1)
        self.label_7 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_7.setObjectName("label_7")
        self.gridLayout_3.addWidget(self.label_7, 5, 0, 1, 1)
        self.label_6 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_6.setObjectName("label_6")
        self.gridLayout_3.addWidget(self.label_6, 4, 0, 1, 1)
        self.label_9 = QtWidgets.QLabel(parent=self.gridLayoutWidget_3)
        self.label_9.setObjectName("label_9")
        self.gridLayout_3.addWidget(self.label_9, 7, 0, 1, 1)
        self.led_emo_apathetic = QtWidgets.QPushButton(parent=self.gridLayoutWidget_3)
        self.led_emo_apathetic.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_emo_apathetic.setText("")
        self.led_emo_apathetic.setCheckable(True)
        self.led_emo_apathetic.setChecked(False)
        self.led_emo_apathetic.setObjectName("led_emo_apathetic")
        self.gridLayout_3.addWidget(self.led_emo_apathetic, 7, 1, 1, 1)
        self.plotFrame = QtWidgets.QFrame(parent=self.centralwidget)
        self.plotFrame.setGeometry(QtCore.QRect(400, 10, 801, 561))
        self.plotFrame.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.plotFrame.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.plotFrame.setObjectName("plotFrame")
        self.verticalLayoutWidget = QtWidgets.QWidget(parent=self.centralwidget)
        self.verticalLayoutWidget.setGeometry(QtCore.QRect(10, 80, 111, 171))
        self.verticalLayoutWidget.setObjectName("verticalLayoutWidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout.setObjectName("verticalLayout")
        self.button_act_tickle = QtWidgets.QPushButton(parent=self.verticalLayoutWidget)
        self.button_act_tickle.setMaximumSize(QtCore.QSize(100, 25))
        self.button_act_tickle.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_act_tickle.setCheckable(True)
        self.button_act_tickle.setChecked(False)
        self.button_act_tickle.setObjectName("button_act_tickle")
        self.verticalLayout.addWidget(self.button_act_tickle)
        self.button_act_play_with = QtWidgets.QPushButton(parent=self.verticalLayoutWidget)
        self.button_act_play_with.setMaximumSize(QtCore.QSize(100, 25))
        self.button_act_play_with.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_act_play_with.setCheckable(True)
        self.button_act_play_with.setChecked(False)
        self.button_act_play_with.setObjectName("button_act_play_with")
        self.verticalLayout.addWidget(self.button_act_play_with)
        self.button_act_talk_to = QtWidgets.QPushButton(parent=self.verticalLayoutWidget)
        self.button_act_talk_to.setMaximumSize(QtCore.QSize(100, 25))
        self.button_act_talk_to.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_act_talk_to.setCheckable(True)
        self.button_act_talk_to.setChecked(False)
        self.button_act_talk_to.setObjectName("button_act_talk_to")
        self.verticalLayout.addWidget(self.button_act_talk_to)
        self.button_act_calm_down = QtWidgets.QPushButton(parent=self.verticalLayoutWidget)
        self.button_act_calm_down.setMaximumSize(QtCore.QSize(100, 25))
        self.button_act_calm_down.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_act_calm_down.setCheckable(True)
        self.button_act_calm_down.setChecked(False)
        self.button_act_calm_down.setObjectName("button_act_calm_down")
        self.verticalLayout.addWidget(self.button_act_calm_down)
        self.button_act_feed = QtWidgets.QPushButton(parent=self.verticalLayoutWidget)
        self.button_act_feed.setMaximumSize(QtCore.QSize(100, 25))
        self.button_act_feed.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_act_feed.setCheckable(True)
        self.button_act_feed.setChecked(False)
        self.button_act_feed.setObjectName("button_act_feed")
        self.verticalLayout.addWidget(self.button_act_feed)
        self.slider_sim_speed = QtWidgets.QSlider(parent=self.centralwidget)
        self.slider_sim_speed.setGeometry(QtCore.QRect(10, 510, 141, 16))
        self.slider_sim_speed.setOrientation(QtCore.Qt.Orientation.Horizontal)
        self.slider_sim_speed.setObjectName("slider_sim_speed")
        self.label_15 = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_15.setGeometry(QtCore.QRect(10, 480, 121, 25))
        self.label_15.setObjectName("label_15")
        self.label_16 = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_16.setGeometry(QtCore.QRect(10, 10, 131, 51))
        self.label_16.setWordWrap(True)
        self.label_16.setObjectName("label_16")
        self.pushButton = QtWidgets.QPushButton(parent=self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(30, 550, 80, 22))
        self.pushButton.setObjectName("pushButton")
        self.verticalLayoutWidget_2 = QtWidgets.QWidget(parent=self.centralwidget)
        self.verticalLayoutWidget_2.setGeometry(QtCore.QRect(10, 280, 111, 181))
        self.verticalLayoutWidget_2.setObjectName("verticalLayoutWidget_2")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(self.verticalLayoutWidget_2)
        self.verticalLayout_2.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.button_env_cool = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_cool.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_cool.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_cool.setCheckable(True)
        self.button_env_cool.setChecked(False)
        self.button_env_cool.setObjectName("button_env_cool")
        self.verticalLayout_2.addWidget(self.button_env_cool)
        self.button_env_hot = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_hot.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_hot.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_hot.setCheckable(True)
        self.button_env_hot.setChecked(False)
        self.button_env_hot.setObjectName("button_env_hot")
        self.verticalLayout_2.addWidget(self.button_env_hot)
        self.button_env_quiet = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_quiet.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_quiet.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_quiet.setCheckable(True)
        self.button_env_quiet.setChecked(False)
        self.button_env_quiet.setObjectName("button_env_quiet")
        self.verticalLayout_2.addWidget(self.button_env_quiet)
        self.button_env_loud = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_loud.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_loud.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_loud.setCheckable(True)
        self.button_env_loud.setChecked(False)
        self.button_env_loud.setObjectName("button_env_loud")
        self.verticalLayout_2.addWidget(self.button_env_loud)
        self.button_env_dark = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_dark.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_dark.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_dark.setCheckable(True)
        self.button_env_dark.setChecked(False)
        self.button_env_dark.setObjectName("button_env_dark")
        self.verticalLayout_2.addWidget(self.button_env_dark)
        self.button_env_bright = QtWidgets.QPushButton(parent=self.verticalLayoutWidget_2)
        self.button_env_bright.setMaximumSize(QtCore.QSize(100, 25))
        self.button_env_bright.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.button_env_bright.setCheckable(True)
        self.button_env_bright.setChecked(False)
        self.button_env_bright.setObjectName("button_env_bright")
        self.verticalLayout_2.addWidget(self.button_env_bright)
        self.gridLayoutWidget_4 = QtWidgets.QWidget(parent=self.centralwidget)
        self.gridLayoutWidget_4.setGeometry(QtCore.QRect(210, 270, 151, 241))
        self.gridLayoutWidget_4.setObjectName("gridLayoutWidget_4")
        self.gridLayout_4 = QtWidgets.QGridLayout(self.gridLayoutWidget_4)
        self.gridLayout_4.setContentsMargins(0, 0, 0, 0)
        self.gridLayout_4.setObjectName("gridLayout_4")
        self.label_10 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_10.setObjectName("label_10")
        self.gridLayout_4.addWidget(self.label_10, 0, 0, 1, 1)
        self.led_act_sleep = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_sleep.setMaximumSize(QtCore.QSize(50, 16777215))
        self.led_act_sleep.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_act_sleep.setText("")
        self.led_act_sleep.setCheckable(True)
        self.led_act_sleep.setChecked(False)
        self.led_act_sleep.setObjectName("led_act_sleep")
        self.gridLayout_4.addWidget(self.led_act_sleep, 0, 1, 1, 1)
        self.led_act_kick_legs = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_kick_legs.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_act_kick_legs.setText("")
        self.led_act_kick_legs.setCheckable(True)
        self.led_act_kick_legs.setChecked(False)
        self.led_act_kick_legs.setObjectName("led_act_kick_legs")
        self.gridLayout_4.addWidget(self.led_act_kick_legs, 5, 1, 1, 1)
        self.led_act_idle = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_idle.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_act_idle.setText("")
        self.led_act_idle.setCheckable(True)
        self.led_act_idle.setChecked(False)
        self.led_act_idle.setObjectName("led_act_idle")
        self.gridLayout_4.addWidget(self.led_act_idle, 6, 1, 1, 1)
        self.led_act_smile = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_smile.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(252,232,9); /* Background color when checked */\n"
"}")
        self.led_act_smile.setText("")
        self.led_act_smile.setCheckable(True)
        self.led_act_smile.setChecked(False)
        self.led_act_smile.setObjectName("led_act_smile")
        self.gridLayout_4.addWidget(self.led_act_smile, 3, 1, 1, 1)
        self.label_11 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_11.setObjectName("label_11")
        self.gridLayout_4.addWidget(self.label_11, 2, 0, 1, 1)
        self.label_12 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_12.setObjectName("label_12")
        self.gridLayout_4.addWidget(self.label_12, 3, 0, 1, 1)
        self.led_act_play = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_play.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_act_play.setText("")
        self.led_act_play.setCheckable(True)
        self.led_act_play.setChecked(False)
        self.led_act_play.setObjectName("led_act_play")
        self.gridLayout_4.addWidget(self.led_act_play, 2, 1, 1, 1)
        self.led_act_babble = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_babble.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(252,232,9); /* Background color when checked */\n"
"}")
        self.led_act_babble.setText("")
        self.led_act_babble.setCheckable(True)
        self.led_act_babble.setChecked(False)
        self.led_act_babble.setObjectName("led_act_babble")
        self.gridLayout_4.addWidget(self.led_act_babble, 4, 1, 1, 1)
        self.led_act_eat = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_eat.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(34,177,76); /* Background color when checked */\n"
"}")
        self.led_act_eat.setText("")
        self.led_act_eat.setCheckable(True)
        self.led_act_eat.setChecked(False)
        self.led_act_eat.setObjectName("led_act_eat")
        self.gridLayout_4.addWidget(self.led_act_eat, 1, 1, 1, 1)
        self.label_13 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_13.setObjectName("label_13")
        self.gridLayout_4.addWidget(self.label_13, 6, 0, 1, 1)
        self.label_14 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_14.setObjectName("label_14")
        self.gridLayout_4.addWidget(self.label_14, 1, 0, 1, 1)
        self.label_17 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_17.setObjectName("label_17")
        self.gridLayout_4.addWidget(self.label_17, 5, 0, 1, 1)
        self.label_18 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_18.setObjectName("label_18")
        self.gridLayout_4.addWidget(self.label_18, 4, 0, 1, 1)
        self.label_19 = QtWidgets.QLabel(parent=self.gridLayoutWidget_4)
        self.label_19.setObjectName("label_19")
        self.gridLayout_4.addWidget(self.label_19, 7, 0, 1, 1)
        self.led_act_cry = QtWidgets.QPushButton(parent=self.gridLayoutWidget_4)
        self.led_act_cry.setStyleSheet("QPushButton {\n"
"    background-color: white; /* Normal background color */\n"
"}\n"
"\n"
"QPushButton:checked {\n"
"    background-color: rgb(240,104,6); /* Background color when checked */\n"
"}")
        self.led_act_cry.setText("")
        self.led_act_cry.setCheckable(True)
        self.led_act_cry.setChecked(False)
        self.led_act_cry.setObjectName("led_act_cry")
        self.gridLayout_4.addWidget(self.led_act_cry, 7, 1, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(parent=MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 1219, 19))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(parent=MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.label.setText(_translate("MainWindow", "Heartbeat"))
        self.label_3.setText(_translate("MainWindow", "Happy"))
        self.label_4.setText(_translate("MainWindow", "Stressed"))
        self.label_5.setText(_translate("MainWindow", "Nervous"))
        self.label_8.setText(_translate("MainWindow", "Calm"))
        self.label_2.setText(_translate("MainWindow", "Excited"))
        self.label_7.setText(_translate("MainWindow", "Angry"))
        self.label_6.setText(_translate("MainWindow", "Bored"))
        self.label_9.setText(_translate("MainWindow", "Apathetic"))
        self.button_act_tickle.setText(_translate("MainWindow", "Tickle"))
        self.button_act_play_with.setText(_translate("MainWindow", "Play with"))
        self.button_act_talk_to.setText(_translate("MainWindow", "Talk to"))
        self.button_act_calm_down.setText(_translate("MainWindow", "Calm down"))
        self.button_act_feed.setText(_translate("MainWindow", "Feed"))
        self.label_15.setText(_translate("MainWindow", "Simulation speed"))
        self.label_16.setText(_translate("MainWindow", "Moody Mimosa Simulator"))
        self.pushButton.setText(_translate("MainWindow", "PushButton"))
        self.button_env_cool.setText(_translate("MainWindow", "Cool"))
        self.button_env_hot.setText(_translate("MainWindow", "Hot"))
        self.button_env_quiet.setText(_translate("MainWindow", "Quiet"))
        self.button_env_loud.setText(_translate("MainWindow", "Loud"))
        self.button_env_dark.setText(_translate("MainWindow", "Dark"))
        self.button_env_bright.setText(_translate("MainWindow", "Bright"))
        self.label_10.setText(_translate("MainWindow", "Sleep"))
        self.label_11.setText(_translate("MainWindow", "Play"))
        self.label_12.setText(_translate("MainWindow", "Smile"))
        self.label_13.setText(_translate("MainWindow", "Idle"))
        self.label_14.setText(_translate("MainWindow", "Eat"))
        self.label_17.setText(_translate("MainWindow", "Kick legs"))
        self.label_18.setText(_translate("MainWindow", "Babble"))
        self.label_19.setText(_translate("MainWindow", "Cry"))
