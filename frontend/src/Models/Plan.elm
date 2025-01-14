module Models.Plan exposing (Plan, decode, encode, free, full)

import Conf
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value)
import Libs.Json.Decode as Decode
import Libs.Json.Encode as Encode


type alias Plan =
    -- MUST stay in sync with backend/lib/azimutt/organizations/organization_plan.ex
    { id : String
    , name : String
    , layouts : Maybe Int
    , memos : Maybe Int
    , colors : Bool
    , privateLinks : Bool
    , sqlExport : Bool
    , dbAnalysis : Bool
    , dbAccess : Bool
    }


free : Plan
free =
    -- MUST stay in sync with backend/lib/azimutt/organizations/organization_plan.ex#free
    { id = "free"
    , name = "Free plan"
    , layouts = Just Conf.features.layouts.free
    , memos = Just Conf.features.memos.free
    , colors = Conf.features.tableColor.free
    , privateLinks = Conf.features.privateLinks.free
    , sqlExport = Conf.features.sqlExport.free
    , dbAnalysis = Conf.features.dbAnalysis.free
    , dbAccess = Conf.features.dbAnalysis.free
    }


full : Plan
full =
    -- used in tests
    { id = "full"
    , name = "Full plan"
    , layouts = Nothing
    , memos = Nothing
    , colors = True
    , privateLinks = True
    , sqlExport = True
    , dbAnalysis = True
    , dbAccess = True
    }


encode : Plan -> Value
encode value =
    Encode.object
        [ ( "id", value.id |> Encode.string )
        , ( "name", value.name |> Encode.string )
        , ( "layouts", value.layouts |> Encode.maybe Encode.int )
        , ( "memos", value.memos |> Encode.maybe Encode.int )
        , ( "colors", value.colors |> Encode.bool )
        , ( "private_links", value.privateLinks |> Encode.bool )
        , ( "sql_export", value.sqlExport |> Encode.bool )
        , ( "db_analysis", value.dbAnalysis |> Encode.bool )
        , ( "db_access", value.dbAccess |> Encode.bool )
        ]


decode : Decode.Decoder Plan
decode =
    Decode.map9 Plan
        (Decode.field "id" Decode.string)
        (Decode.field "name" Decode.string)
        (Decode.maybeField "layouts" Decode.int)
        (Decode.maybeField "memos" Decode.int)
        (Decode.field "colors" Decode.bool)
        (Decode.field "private_links" Decode.bool)
        (Decode.field "sql_export" Decode.bool)
        (Decode.field "db_analysis" Decode.bool)
        (Decode.field "db_access" Decode.bool)
