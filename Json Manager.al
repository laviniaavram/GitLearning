codeunit 51011 "Json Manager"
{
    procedure ExtractJsonArrayFromJsonObject(var JsonObject: JsonObject; PropertyName: Text[50]; var JsonArray: JsonArray)
    var
        JsonToken: JsonToken;
    begin
        JsonObject.Get(PropertyName, JsonToken);
        JsonArray := JsonToken.AsArray();

        if JsonArray.Count = 0 then
            Message('Empty Array');
    end;

    procedure ExtractJsonObjectFromJsonArray(var JsonArray: JsonArray; var JsonObject: JsonObject; Position: Integer)
    var
        JsonToken: JsonToken;
    begin
        JsonArray.Get(Position, JsonToken);
        JsonObject := JsonToken.AsObject();
       
        if JsonObject.keys.Count = 0 then
            Message('Empty Object');
    end;

    procedure ExtractJsonObjectFromJsonProperty(var JsonObject: JsonObject; PropertyName: Text[50])
    var
        JsonToken: JsonToken;
        CheckIfJsonTokenIsNull: text;
    begin
        JsonObject.Get(PropertyName, JsonToken);
        JsonToken.WriteTo(CheckIfJsonTokenIsNull);
        if CheckIfJsonTokenIsNull = 'null' then
            exit;

        JsonObject := JsonToken.AsObject();

        if JsonObject.keys.Count = 0 then
            exit;
    end;

    procedure ExtractTextValueFromJsonProperty(var JsonObject: JsonObject; PropertyName: Text[50]) TextValue: Text
    var
        JsonToken: JsonToken;
        CheckIfJsonTokenIsNull: Text;
    begin
        if not JsonObject.Get(PropertyName, JsonToken) then
            TextValue := '';

        if not JsonToken.AsValue().IsNull then
            TextValue := JsonToken.AsValue().AsText()
        else
            TextValue := '';
    end;

    procedure ExtractDateValueFromJsonProperty(var JsonObject: JsonObject; PropertyName: Text[50]) DateValue: DateTime
    var
        JsonToken: JsonToken;
    begin
        JsonObject.Get(PropertyName, JsonToken);

        if not JsonToken.AsValue().IsNull then
            DateValue := JsonToken.AsValue().AsDateTime()
        else
            DateValue := CurrentDateTime();
    end;
}