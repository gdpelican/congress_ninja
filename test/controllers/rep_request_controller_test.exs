defmodule CongressNinja.RepRequestControllerTest do
  use CongressNinja.ConnCase

  test "#create successfully creates a rep request" do
    conn         = build_conn()
    rep          = insert(:rep, %{ district: 1, state: "AZ" })
    zip_district = insert(:zip_district, %{ district: 1, state: "AZ", zip: 19122 })

    conn = post conn, rep_request_path(conn, :create, zip: "19122")

    json = json_response(conn, 200)
    assert length(json["rep_request"]["reps"]) == 1
    [r] = json["rep_request"]["reps"]
    assert r["name"] == rep.name

  end
end
