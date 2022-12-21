import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import {
  useComment,
  useComments,
  usePost,
  usePosts,
  useProfile,
} from "./api/Profile";

export default App;

const client = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
    },
  },
});

function App() {
  return (
    <QueryClientProvider client={client}>
      <DataView header="Profile" loader={useProfile} />
      <DataView header="Comments" loader={useComments} />
      <DataView header="Comment 1" loader={() => useComment(1)} />
      <DataView header="Posts" loader={usePosts} />
      <DataView header="Post 2" loader={() => usePost(2)} />
    </QueryClientProvider>
  );
}

function DataView({ header, loader }: { header: string; loader: Function }) {
  const { status, error, data } = loader();
  let content;
  switch (status) {
    case "error":
      content = <p>{"ERR: " + error.message}</p>;
      break;
    case "loading":
      content = <p>loading...</p>;
      break;
    case "success":
      content = <p>{JSON.stringify(data, null, 2)}</p>;
    default:
      break;
  }

  return (
    <section>
      <h1>{header}</h1>
      <hr />
      <pre>
        <code>{content}</code>
      </pre>
    </section>
  );
}
