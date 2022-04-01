Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C84EFD31
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353474AbiDAXpW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 19:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353459AbiDAXpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 19:45:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A5742DCA;
        Fri,  1 Apr 2022 16:43:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id D50A820DF56E;
        Fri,  1 Apr 2022 16:43:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D50A820DF56E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648856605;
        bh=R2wmpWeJqkJGpUihjavIWxYmwa4YCuMevl2v9Hn3sEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELVMFzeEFRG66+UxugzKTJfbVUt6Vewyjcwp4JHmR4EnWSEUTnV3NHD/YC+mgaigW
         lMtIO8VhVLoFTnL7M23sa7zI7HQ3v8sIlSPoowvexMtDb7TkMHPsfDQoe1JtS+GCi2
         MNjfd7aj6zN58QGukD4mcrYz6M12U+E6EC3phl0Q=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled status page data
Date:   Fri,  1 Apr 2022 16:43:08 -0700
Message-Id: <20220401234309.21252-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401234309.21252-1-beaub@linux.microsoft.com>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

User processes may require many events and when they do the cache
performance of a byte index status check is less ideal than a bit index.
The previous event limit per-page was 4096, the new limit is 32,768.

This change adds a mask property to the user_reg struct. Programs check
that the byte at status_index has a bit set by ANDing the status_mask.

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h                   | 19 +++---
 kernel/trace/trace_events_user.c              | 58 ++++++++++++++++---
 samples/user_events/example.c                 | 12 ++--
 .../selftests/user_events/ftrace_test.c       | 16 ++---
 .../testing/selftests/user_events/perf_test.c |  6 +-
 5 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 736e05603463..c5051fee26c6 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -20,15 +20,6 @@
 #define USER_EVENTS_SYSTEM "user_events"
 #define USER_EVENTS_PREFIX "u:"
 
-/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
-#define EVENT_BIT_FTRACE 0
-#define EVENT_BIT_PERF 1
-#define EVENT_BIT_OTHER 7
-
-#define EVENT_STATUS_FTRACE (1 << EVENT_BIT_FTRACE)
-#define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
-#define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
-
 /* Create dynamic location entry within a 32-bit value */
 #define DYN_LOC(offset, size) ((size) << 16 | (offset))
 
@@ -48,9 +39,17 @@ struct user_reg {
 	/* Output: Byte index of the event within the status page */
 	__u32 status_index;
 
+	/* Output: Mask for the event within the status page byte */
+	__u32 status_mask;
+
 	/* Output: Index of the event to use when writing data */
 	__u32 write_index;
-};
+} __attribute__((__packed__));
+
+static inline int user_event_enabled(void *status_data, int index, int mask)
+{
+	return status_data && (((const char *)status_data)[index] & mask);
+}
 
 #define DIAG_IOC_MAGIC '*'
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2bcae7abfa81..d960b5ea76c4 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -40,17 +40,26 @@
  */
 #define MAX_PAGE_ORDER 0
 #define MAX_PAGES (1 << MAX_PAGE_ORDER)
-#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
+#define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
+#define MAX_EVENTS (MAX_BYTES * 8)
 
 /* Limit how long of an event name plus args within the subsystem. */
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
 
+#define STATUS_BYTE(bit) ((bit) >> 3)
+#define STATUS_MASK(bit) (1 << ((bit) & 7))
+
+/* Internal bits to keep track of connected probes */
+#define EVENT_STATUS_FTRACE (1 << 0)
+#define EVENT_STATUS_PERF (1 << 1)
+#define EVENT_STATUS_OTHER (1 << 7)
+
 static char *register_page_data;
 
 static DEFINE_MUTEX(reg_mutex);
-static DEFINE_HASHTABLE(register_table, 4);
+static DEFINE_HASHTABLE(register_table, 8);
 static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
 
 /*
@@ -72,6 +81,7 @@ struct user_event {
 	int index;
 	int flags;
 	int min_size;
+	char status;
 };
 
 /*
@@ -106,6 +116,22 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static __always_inline
+void user_event_register_set(struct user_event *user)
+{
+	int i = user->index;
+
+	register_page_data[STATUS_BYTE(i)] |= STATUS_MASK(i);
+}
+
+static __always_inline
+void user_event_register_clear(struct user_event *user)
+{
+	int i = user->index;
+
+	register_page_data[STATUS_BYTE(i)] &= ~STATUS_MASK(i);
+}
+
 static __always_inline __must_check
 bool user_event_last_ref(struct user_event *user)
 {
@@ -648,7 +674,7 @@ static int destroy_user_event(struct user_event *user)
 
 	dyn_event_remove(&user->devent);
 
-	register_page_data[user->index] = 0;
+	user_event_register_clear(user);
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
@@ -827,7 +853,12 @@ static void update_reg_page_for(struct user_event *user)
 		rcu_read_unlock_sched();
 	}
 
-	register_page_data[user->index] = status;
+	if (status)
+		user_event_register_set(user);
+	else
+		user_event_register_clear(user);
+
+	user->status = status;
 }
 
 /*
@@ -1332,7 +1363,17 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (size > PAGE_SIZE)
 		return -E2BIG;
 
-	return copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
+	if (size < offsetofend(struct user_reg, write_index))
+		return -EINVAL;
+
+	ret = copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
+
+	if (ret)
+		return ret;
+
+	kreg->size = size;
+
+	return 0;
 }
 
 /*
@@ -1376,7 +1417,8 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 		return ret;
 
 	put_user((u32)ret, &ureg->write_index);
-	put_user(user->index, &ureg->status_index);
+	put_user(STATUS_BYTE(user->index), &ureg->status_index);
+	put_user(STATUS_MASK(user->index), &ureg->status_mask);
 
 	return 0;
 }
@@ -1485,7 +1527,7 @@ static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
 
-	if (size != MAX_EVENTS)
+	if (size != MAX_BYTES)
 		return -EINVAL;
 
 	return remap_pfn_range(vma, vma->vm_start,
@@ -1520,7 +1562,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	mutex_lock(&reg_mutex);
 
 	hash_for_each(register_table, i, user, node) {
-		status = register_page_data[user->index];
+		status = user->status;
 		flags = user->flags;
 
 		seq_printf(m, "%d:%s", user->index, EVENT_NAME(user));
diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index 4f5778e441c0..e72260bf6e49 100644
--- a/samples/user_events/example.c
+++ b/samples/user_events/example.c
@@ -33,7 +33,8 @@ static int event_status(char **status)
 	return 0;
 }
 
-static int event_reg(int fd, const char *command, int *status, int *write)
+static int event_reg(int fd, const char *command, int *index, int *mask,
+		     int *write)
 {
 	struct user_reg reg = {0};
 
@@ -43,7 +44,8 @@ static int event_reg(int fd, const char *command, int *status, int *write)
 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
 		return -1;
 
-	*status = reg.status_index;
+	*index = reg.status_index;
+	*mask = reg.status_mask;
 	*write = reg.write_index;
 
 	return 0;
@@ -51,7 +53,7 @@ static int event_reg(int fd, const char *command, int *status, int *write)
 
 int main(int argc, char **argv)
 {
-	int data_fd, status, write;
+	int data_fd, index, mask, write;
 	char *status_page;
 	struct iovec io[2];
 	__u32 count = 0;
@@ -61,7 +63,7 @@ int main(int argc, char **argv)
 
 	data_fd = open(data_file, O_RDWR);
 
-	if (event_reg(data_fd, "test u32 count", &status, &write) == -1)
+	if (event_reg(data_fd, "test u32 count", &index, &mask, &write) == -1)
 		return errno;
 
 	/* Setup iovec */
@@ -75,7 +77,7 @@ int main(int argc, char **argv)
 	getchar();
 
 	/* Check if anyone is listening */
-	if (status_page[status]) {
+	if (user_event_enabled(status_page, index, mask)) {
 		/* Yep, trace out our data */
 		writev(data_fd, (const struct iovec *)io, 2);
 
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index a80fb5ef61d5..ba7a2757dcbd 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -197,12 +197,12 @@ TEST_F(user, register_events) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
 
 	/* Multiple registers should result in same index */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
 
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
@@ -212,15 +212,15 @@ TEST_F(user, register_events) {
 	/* MMAP should work and be zero'd */
 	ASSERT_NE(MAP_FAILED, status_page);
 	ASSERT_NE(NULL, status_page);
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_EQ(0, status_page[reg.status_index] & reg.status_mask);
 
 	/* Enable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-	ASSERT_EQ(EVENT_STATUS_FTRACE, status_page[reg.status_index]);
+	ASSERT_NE(0, status_page[reg.status_index] & reg.status_mask);
 
 	/* Disable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_EQ(0, status_page[reg.status_index] & reg.status_mask);
 
 	/* File still open should return -EBUSY for delete */
 	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
@@ -257,7 +257,7 @@ TEST_F(user, write_events) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
 
 	/* Write should fail on invalid slot with ENOENT */
 	io[0].iov_base = &field2;
@@ -298,7 +298,7 @@ TEST_F(user, write_fault) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
 
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
@@ -322,7 +322,7 @@ TEST_F(user, write_validator) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
 
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 26851d51d6bb..81ceaf71e364 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -120,8 +120,8 @@ TEST_F(user, perf_write) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_EQ(0, reg.status_index == 0 && reg.status_mask == 1);
+	ASSERT_EQ(0, status_page[reg.status_index] & reg.status_mask);
 
 	/* Id should be there */
 	id = get_id();
@@ -144,7 +144,7 @@ TEST_F(user, perf_write) {
 	ASSERT_NE(MAP_FAILED, perf_page);
 
 	/* Status should be updated */
-	ASSERT_EQ(EVENT_STATUS_PERF, status_page[reg.status_index]);
+	ASSERT_NE(0, status_page[reg.status_index] & reg.status_mask);
 
 	event.index = reg.write_index;
 	event.field1 = 0xc001;
-- 
2.25.1

