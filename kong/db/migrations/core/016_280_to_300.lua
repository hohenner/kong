return {
  postgres = {
    up = [[
      -- add new hash_on_query_arg field to upstreams
      DO $$
        BEGIN
          ALTER TABLE IF EXISTS ONLY "upstreams" ADD "hash_on_query_arg" TEXT;
        EXCEPTION WHEN DUPLICATE_COLUMN THEN
          -- Do nothing, accept existing state
        END;
      $$;

      -- add new hash_fallback_query_arg field to upstreams
      DO $$
        BEGIN
          ALTER TABLE IF EXISTS ONLY "upstreams" ADD "hash_fallback_query_arg" TEXT;
        EXCEPTION WHEN DUPLICATE_COLUMN THEN
          -- Do nothing, accept existing state
        END;
      $$;

      -- add new hash_on_uri_capture field to upstreams
      DO $$
        BEGIN
          ALTER TABLE IF EXISTS ONLY "upstreams" ADD "hash_on_uri_capture" TEXT;
        EXCEPTION WHEN DUPLICATE_COLUMN THEN
          -- Do nothing, accept existing state
        END;
      $$;

      -- add new hash_fallback_uri_capture field to upstreams
      DO $$
        BEGIN
          ALTER TABLE IF EXISTS ONLY "upstreams" ADD "hash_fallback_uri_capture" TEXT;
        EXCEPTION WHEN DUPLICATE_COLUMN THEN
          -- Do nothing, accept existing state
        END;
      $$;
    ]],
  },

  cassandra = {
    up = [[
      -- add new hash_on_query_arg field to upstreams
      ALTER TABLE upstreams ADD hash_on_query_arg text;

      -- add new hash_fallback_query_arg field to upstreams
      ALTER TABLE upstreams ADD hash_fallback_query_arg text;

      -- add new hash_on_uri_capture field to upstreams
      ALTER TABLE upstreams ADD hash_on_uri_capture text;

      -- add new hash_fallback_uri_capture field to upstreams
      ALTER TABLE upstreams ADD hash_fallback_uri_capture text;
    ]],
  },
}
