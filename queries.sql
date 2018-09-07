--- 1. List all organization `name`s.
SELECT name FROM organization;

--- 2. List all channel `name`s.
SELECT name FROM channel;

-- 3. List all channels in a specific organization by organization `name`.
SELECT o.name, c.name FROM channel AS c, organization AS o
GROUP BY c.name;

-- 4. List all messages in a specific channel by channel `name` `#general` in
--    order of `post_time`, descending.
SELECT m.timestamp, m.body, c.name
FROM channel AS c, messages AS m
ORDER BY m.timestamp DESC
GROUP BY c.name;