defmodule CongressNinja.RepresentativeControllerTest do
  use CongressNinja.ConnCase

  test "#show returns a representative based on an address" do
    conn = build_conn()
    representative = insert(:representative)

    conn = get conn, representative_path(conn, :show, "19122")

    assert json_response(conn, 200) == %{
      "representative" => %{
        "name"     => representative.name,
        "phone"    => representative.phone,
        "state"    => representative.state,
        "district" => representative.district
      }
    }
  end
end
