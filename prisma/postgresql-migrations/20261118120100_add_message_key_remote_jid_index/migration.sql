-- Same as the key id index, for the per-chat lookups that run on each incoming message and read receipt
-- (updateMessagesReadedByTimestamp, updateChatUnreadMessages), which filter on "key"->>'remoteJid'.
--
-- Single statement on purpose: CONCURRENTLY cannot run inside a transaction block. If the build fails:
-- DROP INDEX CONCURRENTLY "Message_instanceId_keyRemoteJid_idx", then
-- prisma migrate resolve --rolled-back 20261118120100_add_message_key_remote_jid_index and deploy again.
CREATE INDEX CONCURRENTLY IF NOT EXISTS "Message_instanceId_keyRemoteJid_idx" ON "Message"("instanceId", ("key" ->> 'remoteJid'));
