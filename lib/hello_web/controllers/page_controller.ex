defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do


started_trace = MyApp.Tracer.start_trace("foo")
IO.inspect(started_trace, label: "started_trace")

updated_span = MyApp.Tracer.update_span(service: :my_service, type: :web, resource: "/bar")
IO.inspect(updated_span, label: "updated_span")


    render conn, "index.html"


finished_span = MyApp.Tracer.finish_span()
IO.inspect(finished_span, label: "finished_span")

finished_trace = MyApp.Tracer.finish_trace()
IO.inspect(finished_trace, label: "finished_trace")


  end
end
