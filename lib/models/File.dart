/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the File type in your schema. */
@immutable
class File extends Model {
  static const classType = const _FileModelType();
  final String id;
  final String? _name;
  final FileType? _type;
  final String? _category;
  final String? _description;
  final String? _ownerID;
  final int? _grade;
  final String? _s3key;
  final String? _picsS3key;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String? get name {
    return _name;
  }

  FileType? get type {
    return _type;
  }

  String? get category {
    return _category;
  }

  String? get description {
    return _description;
  }

  String? get ownerID {
    return _ownerID;
  }

  int? get grade {
    return _grade;
  }

  String? get s3key {
    return _s3key;
  }

  String? get picsS3key {
    return _picsS3key;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const File._internal({required this.id, name, type, category, description, ownerID, grade, s3key, picsS3key, createdAt, updatedAt})
      : _name = name,
        _type = type,
        _category = category,
        _description = description,
        _ownerID = ownerID,
        _grade = grade,
        _s3key = s3key,
        _picsS3key = picsS3key,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory File(
      {String? id,
        String? name,
        FileType? type,
        String? category,
        String? description,
        String? ownerID,
        int? grade,
        String? s3key,
        String? picsS3key}) {
    return File._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        type: type,
        category: category,
        description: description,
        ownerID: ownerID,
        grade: grade,
        s3key: s3key,
        picsS3key: picsS3key);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is File &&
        id == other.id &&
        _name == other._name &&
        _type == other._type &&
        _category == other._category &&
        _description == other._description &&
        _ownerID == other._ownerID &&
        _grade == other._grade &&
        _s3key == other._s3key &&
        _picsS3key == other._picsS3key;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("File {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("ownerID=" + "$_ownerID" + ", ");
    buffer.write("grade=" + (_grade != null ? _grade!.toString() : "null") + ", ");
    buffer.write("s3key=" + "$_s3key" + ", ");
    buffer.write("picsS3key=" + "$_picsS3key" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  File copyWith(
      {String? id,
        String? name,
        FileType? type,
        String? category,
        String? description,
        String? ownerID,
        int? grade,
        String? s3key,
        String? picsS3key}) {
    return File._internal(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        category: category ?? this.category,
        description: description ?? this.description,
        ownerID: ownerID ?? this.ownerID,
        grade: grade ?? this.grade,
        s3key: s3key ?? this.s3key,
        picsS3key: picsS3key ?? this.picsS3key);
  }

  File.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = json['name'],
        _type = enumFromString<FileType>(json['type'], FileType.values),
        _category = json['category'],
        _description = json['description'],
        _ownerID = json['ownerID'],
        _grade = (json['grade'] as num?)?.toInt(),
        _s3key = json['s3key'],
        _picsS3key = json['picsS3key'],
        _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
        _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': _name,
    'type': enumToString(_type),
    'category': _category,
    'description': _description,
    'ownerID': _ownerID,
    'grade': _grade,
    's3key': _s3key,
    'picsS3key': _picsS3key,
    'createdAt': _createdAt?.format(),
    'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "file.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField OWNERID = QueryField(fieldName: "ownerID");
  static final QueryField GRADE = QueryField(fieldName: "grade");
  static final QueryField S3KEY = QueryField(fieldName: "s3key");
  static final QueryField PICSS3KEY = QueryField(fieldName: "picsS3key");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "File";
    modelSchemaDefinition.pluralName = "Files";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.PUBLIC, operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE, operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.PUBLIC,
          provider: AuthRuleProvider.IAM,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE,
          provider: AuthRuleProvider.IAM,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.GROUPS,
          groupClaim: "cognito:groups",
          groups: ["delete"],
          provider: AuthRuleProvider.USERPOOLS,
          operations: [ModelOperation.READ, ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE]),
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(key: File.NAME, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition
        .addField(ModelFieldDefinition.field(key: File.TYPE, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition
        .addField(ModelFieldDefinition.field(key: File.CATEGORY, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition
        .addField(ModelFieldDefinition.field(key: File.DESCRIPTION, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition
        .addField(ModelFieldDefinition.field(key: File.OWNERID, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(key: File.GRADE, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(key: File.S3KEY, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition
        .addField(ModelFieldDefinition.field(key: File.PICSS3KEY, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt', isRequired: false, isReadOnly: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt', isRequired: false, isReadOnly: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _FileModelType extends ModelType<File> {
  const _FileModelType();

  @override
  File fromJson(Map<String, dynamic> jsonData) {
    return File.fromJson(jsonData);
  }
}
