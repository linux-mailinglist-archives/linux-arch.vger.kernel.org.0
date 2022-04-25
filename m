Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4050E894
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiDYStw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiDYStu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 14:49:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7918E6F9D2;
        Mon, 25 Apr 2022 11:46:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7795520E8CB0;
        Mon, 25 Apr 2022 11:46:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7795520E8CB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650912404;
        bh=Yas84WJ4NXuOO1nmdoxbY/IEroFAtoghAgKJn/H+CD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jd/ZmzQF7E0HrpKZRTpBHi3yx04sc+A0TkV2kSU6FQ06l2E4Fs583mGy+343tDAbH
         Gx1P/rrJGoPOBocqCB0gwmnduvaoK+gN4koNDGm+Xu387L/Otm3+ZlcxNHUh44ItR0
         0veSKqJpPS6rkgpXabewqi1RyNQt6THtmJXuw2bo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v2 5/7] tracing/user_events: Use refcount instead of atomic for ref tracking
Date:   Mon, 25 Apr 2022 11:46:29 -0700
Message-Id: <20220425184631.2068-6-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425184631.2068-1-beaub@linux.microsoft.com>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

User processes could open up enough event references to cause rollovers.
These could cause use after free scenarios, which we do not want.
Switching to refcount APIs prevent this, but will leak memory once
saturated.

Once saturated, user processes can still use the events. This prevents
a bad user process from stopping existing telemetry from being emitted.

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 53 +++++++++++++++-----------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f9bb7d37d76f..2bcae7abfa81 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -14,6 +14,7 @@
 #include <linux/uio.h>
 #include <linux/ioctl.h>
 #include <linux/jhash.h>
+#include <linux/refcount.h>
 #include <linux/trace_events.h>
 #include <linux/tracefs.h>
 #include <linux/types.h>
@@ -57,7 +58,7 @@ static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
  * within a file a user_event might be created if it does not
  * already exist. These are globally used and their lifetime
  * is tied to the refcnt member. These cannot go away until the
- * refcnt reaches zero.
+ * refcnt reaches one.
  */
 struct user_event {
 	struct tracepoint tracepoint;
@@ -67,7 +68,7 @@ struct user_event {
 	struct hlist_node node;
 	struct list_head fields;
 	struct list_head validators;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	int index;
 	int flags;
 	int min_size;
@@ -105,6 +106,12 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static __always_inline __must_check
+bool user_event_last_ref(struct user_event *user)
+{
+	return refcount_read(&user->refcnt) == 1;
+}
+
 static __always_inline __must_check
 size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -662,7 +669,7 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 
 	hash_for_each_possible(register_table, user, node, key)
 		if (!strcmp(EVENT_NAME(user), name)) {
-			atomic_inc(&user->refcnt);
+			refcount_inc(&user->refcnt);
 			return user;
 		}
 
@@ -876,12 +883,12 @@ static int user_event_reg(struct trace_event_call *call,
 
 	return ret;
 inc:
-	atomic_inc(&user->refcnt);
+	refcount_inc(&user->refcnt);
 	update_reg_page_for(user);
 	return 0;
 dec:
 	update_reg_page_for(user);
-	atomic_dec(&user->refcnt);
+	refcount_dec(&user->refcnt);
 	return 0;
 }
 
@@ -907,7 +914,7 @@ static int user_event_create(const char *raw_command)
 	ret = user_event_parse_cmd(name, &user);
 
 	if (!ret)
-		atomic_dec(&user->refcnt);
+		refcount_dec(&user->refcnt);
 
 	mutex_unlock(&reg_mutex);
 
@@ -951,14 +958,14 @@ static bool user_event_is_busy(struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
 
-	return atomic_read(&user->refcnt) != 0;
+	return !user_event_last_ref(user);
 }
 
 static int user_event_free(struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
 
-	if (atomic_read(&user->refcnt) != 0)
+	if (!user_event_last_ref(user))
 		return -EBUSY;
 
 	return destroy_user_event(user);
@@ -1137,8 +1144,8 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	user->index = index;
 
-	/* Ensure we track ref */
-	atomic_inc(&user->refcnt);
+	/* Ensure we track self ref and caller ref (2) */
+	refcount_set(&user->refcnt, 2);
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
@@ -1164,29 +1171,17 @@ static int user_event_parse(char *name, char *args, char *flags,
 static int delete_user_event(char *name)
 {
 	u32 key;
-	int ret;
 	struct user_event *user = find_user_event(name, &key);
 
 	if (!user)
 		return -ENOENT;
 
-	/* Ensure we are the last ref */
-	if (atomic_read(&user->refcnt) != 1) {
-		ret = -EBUSY;
-		goto put_ref;
-	}
-
-	ret = destroy_user_event(user);
+	refcount_dec(&user->refcnt);
 
-	if (ret)
-		goto put_ref;
-
-	return ret;
-put_ref:
-	/* No longer have this ref */
-	atomic_dec(&user->refcnt);
+	if (!user_event_last_ref(user))
+		return -EBUSY;
 
-	return ret;
+	return destroy_user_event(user);
 }
 
 /*
@@ -1314,7 +1309,7 @@ static int user_events_ref_add(struct file *file, struct user_event *user)
 
 	new_refs->events[i] = user;
 
-	atomic_inc(&user->refcnt);
+	refcount_inc(&user->refcnt);
 
 	rcu_assign_pointer(file->private_data, new_refs);
 
@@ -1374,7 +1369,7 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 	ret = user_events_ref_add(file, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
-	atomic_dec(&user->refcnt);
+	refcount_dec(&user->refcnt);
 
 	/* Positive number is index and valid */
 	if (ret < 0)
@@ -1464,7 +1459,7 @@ static int user_events_release(struct inode *node, struct file *file)
 		user = refs->events[i];
 
 		if (user)
-			atomic_dec(&user->refcnt);
+			refcount_dec(&user->refcnt);
 	}
 out:
 	file->private_data = NULL;
-- 
2.25.1

