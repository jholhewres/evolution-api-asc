-- "Message" only had "instanceId" indexed, so every lookup by key id (getMessage on retry receipts and
-- quotes, messages.update on each status) read all messages of the instance. The raw queries filter on
-- "key"->>'id', and PostgreSQL uses an expression index only for that same expression.
--
-- CONCURRENTLY keeps writes to "Message" going while the index builds. It cannot run inside a transaction
-- block, and Prisma sends a multi-statement file as one, so keep this file to this single statement.
-- If the build fails it leaves an INVALID index: DROP INDEX CONCURRENTLY "Message_instanceId_keyId_idx",
-- then prisma migrate resolve --rolled-back 20261118120000_add_message_key_id_index and deploy again.
CREATE INDEX CONCURRENTLY IF NOT EXISTS "Message_instanceId_keyId_idx" ON "Message"("instanceId", ("key" ->> 'id'));
