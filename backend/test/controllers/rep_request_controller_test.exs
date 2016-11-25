defmodule CongressNinja.RepRequestControllerTest do
  use CongressNinja.ConnCase
  import Mock

  test "#create successfully creates a rep request" do
    conn         = build_conn()
    rep          = insert(:rep)
    insert(:zip_district, %{ zip: 19122, rep_id: rep.id })

    conn = post conn, rep_request_path(conn, :create), rep_request: %{ zip: 19122 }

    json = json_response(conn, 200)
    assert length(json["rep_request"]["reps"]) == 1
    [r] = json["rep_request"]["reps"]
    assert r["name"] == rep.name
  end

  test "#update successfully updates the rep request stub" do
    rep_request = insert(:rep_request, %{ reps: [insert(:rep)], slug: "old_slug" })
    conn = build_conn()

    conn = put conn, rep_request_path(conn, :update, rep_request.id), rep_request: %{ slug: "new_stub" }

    json = json_response(conn, 200)
    assert json["rep_request"]["slug"] == "new_stub"
  end

  test "#update successfully updates the reps with an address" do
    actual_rep = insert(:rep, district: 1, state: "AZ")
    rep_request = insert(:rep_request, %{ reps: [insert(:rep), actual_rep], slug: "a_slug" })
    conn = build_conn()

    with_mock HTTPotion, [get: fn(_url) ->
      Poison.encode(%{
        results: %{
          address_components: %{
            state: actual_rep.state
          },
          fields: %{
            congressional_district: %{
              district_number: actual_rep.district
            }
          }
        }
      })
    end] do
      conn = put conn, rep_request_path(conn, :update, rep_request.id), rep_request: %{ address: "123 W Main St, Phila PA, 19122" }

      json = json_response(conn, 200)
      assert length(json["rep_request"]["reps"]) == 1
      [r] = assert json["rep_request"]["reps"]
      assert(r["name"]) == actual_rep.name
    end
  end

  test "#show gets a previously existing rep request by stub" do
    rep = insert(:rep)
    insert(:rep_request, %{ reps: [rep], slug: "a_slug" })
    conn = build_conn()

    conn = get conn, rep_request_path(conn, :show, "a_slug")

    json = json_response(conn, 200)
    assert length(json["rep_request"]["reps"]) == 1
    [r] = json["rep_request"]["reps"]
    assert r["name"] == rep.name
  end

  test "#show returns 404 when an existing rep request does not exist" do
    insert(:rep_request, %{ reps: [insert(:rep)], slug: "a_slug" })
    conn = build_conn()

    conn = get conn, rep_request_path(conn, :show, "another_slug")

    json_response(conn, 404)
  end
end
