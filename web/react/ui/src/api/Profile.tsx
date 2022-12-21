import { useQuery } from "@tanstack/react-query";
import axios from "axios";
import { z } from "zod";

const zProfile = z.object({
  name: z.string(),
});

export type Profile = z.infer<typeof zProfile>;

const zComment = z.object({
  id: z.number(),
  postId: z.number(),
  body: z.string(),
});
const zComments = z.array(zComment);

export type Comment = z.infer<typeof zComment>;

const zPost = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
  author: z.string(),
});

const zPosts = z.array(zPost);

export type Post = z.infer<typeof zPost>;

type apiResult<T> = {
  status: "loading" | "success" | "error";
  data: T | undefined;
  error: Error | null;
};

export function useProfile(): apiResult<Profile> {
  return useQuery<Profile, any>(["profile"], () =>
    get<Profile>("/profile", zProfile.parse)
  );
}

export function useComments(): apiResult<Comment[]> {
  return useQuery<Comment[], Error>(["comments"], () =>
    get<Comment[]>("/comments", zComments.parse)
  );
}

export function useComment(id: number): apiResult<Comment> {
  return useQuery<Comment, Error>(["comment"], () =>
    get<Comment[]>(`/comments/${id}`, zComment.parse)
  );
}

export function usePosts(): apiResult<Post[]> {
  return useQuery<Post[], Error>(["posts"], () =>
    get<Post[]>(`/posts`, zPosts.parse)
  );
}

export function usePost(id: number): apiResult<Post> {
  return useQuery<Post, Error>(["post"], () =>
    get<Post>(`/posts/${id}`, zPost.parse)
  );
}

async function get<T>(path: string, validate: Function): Promise<T | any> {
  const response = await axios.get<T>(path, {
    // TODO: make base URL configurable
    baseURL: "http://localhost:3000",
  });

  const data = response.data;
  // TODO: error could be more descriptive
  validate(data); // throw error if invalid response
  return data;
}
