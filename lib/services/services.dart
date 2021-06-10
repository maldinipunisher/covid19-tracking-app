import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/extensions/extensions.dart';
import 'package:covid_tracking/model/model.dart';
import 'package:covid_tracking/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

part 'api_services.dart';
part 'auth_services.dart';
