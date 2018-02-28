defmodule TasktrackerWeb.ManagerControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Managers

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:manager) do
    {:ok, manager} = Managers.create_manager(@create_attrs)
    manager
  end

  describe "index" do
    test "lists all managers", %{conn: conn} do
      conn = get conn, manager_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Managers"
    end
  end

  describe "new manager" do
    test "renders form", %{conn: conn} do
      conn = get conn, manager_path(conn, :new)
      assert html_response(conn, 200) =~ "New Manager"
    end
  end

  describe "create manager" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, manager_path(conn, :create), manager: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == manager_path(conn, :show, id)

      conn = get conn, manager_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Manager"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, manager_path(conn, :create), manager: @invalid_attrs
      assert html_response(conn, 200) =~ "New Manager"
    end
  end

  describe "edit manager" do
    setup [:create_manager]

    test "renders form for editing chosen manager", %{conn: conn, manager: manager} do
      conn = get conn, manager_path(conn, :edit, manager)
      assert html_response(conn, 200) =~ "Edit Manager"
    end
  end

  describe "update manager" do
    setup [:create_manager]

    test "redirects when data is valid", %{conn: conn, manager: manager} do
      conn = put conn, manager_path(conn, :update, manager), manager: @update_attrs
      assert redirected_to(conn) == manager_path(conn, :show, manager)

      conn = get conn, manager_path(conn, :show, manager)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, manager: manager} do
      conn = put conn, manager_path(conn, :update, manager), manager: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Manager"
    end
  end

  describe "delete manager" do
    setup [:create_manager]

    test "deletes chosen manager", %{conn: conn, manager: manager} do
      conn = delete conn, manager_path(conn, :delete, manager)
      assert redirected_to(conn) == manager_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, manager_path(conn, :show, manager)
      end
    end
  end

  defp create_manager(_) do
    manager = fixture(:manager)
    {:ok, manager: manager}
  end
end
