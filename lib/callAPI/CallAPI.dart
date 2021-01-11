import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/getItemBrand.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

var url_getItemBrand = "http://178.128.211.32/laoshop/api/getItemBrand";

GetItemBrand getItemBrand;
