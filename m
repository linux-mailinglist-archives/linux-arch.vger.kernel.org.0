Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD950E89A
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiDYStz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 14:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiDYStu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 14:49:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792416F9D3;
        Mon, 25 Apr 2022 11:46:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id B442220E8CB3;
        Mon, 25 Apr 2022 11:46:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B442220E8CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650912404;
        bh=ajevIs95ENFLnsELFSTB6AMvBG1b7Z0g03qm2SuwDa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxBpEyGuHfs2LZ3K5yn6RLo0vMYHXO0yqzxnary6G+7TSNJfwLUq6GZFsyNVC49Bb
         vU9N2A10duHEC5cvB0JFKyTrJxEwhYb81VfqEby8MphVm6Ut01HDjAtGELLKKjjNjG
         80C9nNc/W4TqVFI5+VapEYBvkU3fpY7YzLWQQYgk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v2 6/7] tracing/user_events: Use bits vs bytes for enabled status page data
Date:   Mon, 25 Apr 2022 11:46:30 -0700
Message-Id: <20220425184631.2068-7-beaub@linux.microsoft.com>
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

User processes may require many events and when they do the cache
performance of a byte index status check is less ideal than a bit index.
The previous event limit per-page was 4096, the new limit is 32,768.

This change adds a bitwise index to the user_reg struct. Programs check
that the bit at status_bit has a bit set within the status page(s).

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h                   | 15 +----
 kernel/trace/trace_events_user.c              | 57 ++++++++++++++++---
 samples/user_events/example.c                 | 25 +++++---
 .../selftests/user_events/ftrace_test.c       | 47 ++++++++++++---
 .../testing/selftests/user_events/perf_test.c | 11 +++-
 5 files changed, 117 insertions(+), 38 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 736e05603463..592a3fbed98e 100644
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
 
@@ -45,12 +36,12 @@ struct user_reg {
 	/* Input: Pointer to string with event name, description and flags */
 	__u64 name_args;
 
-	/* Output: Byte index of the event within the status page */
-	__u32 status_index;
+	/* Output: Bitwise index of the event within the status page */
+	__u32 status_bit;
 
 	/* Output: Index of the event to use when writing data */
 	__u32 write_index;
-};
+} __attribute__((__packed__));
 
 #define DIAG_IOC_MAGIC '*'
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2bcae7abfa81..4afc41e321ac 100644
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
@@ -1376,7 +1417,7 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 		return ret;
 
 	put_user((u32)ret, &ureg->write_index);
-	put_user(user->index, &ureg->status_index);
+	put_user(user->index, &ureg->status_bit);
 
 	return 0;
 }
@@ -1485,7 +1526,7 @@ static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
 
-	if (size != MAX_EVENTS)
+	if (size != MAX_BYTES)
 		return -EINVAL;
 
 	return remap_pfn_range(vma, vma->vm_start,
@@ -1520,7 +1561,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	mutex_lock(&reg_mutex);
 
 	hash_for_each(register_table, i, user, node) {
-		status = register_page_data[user->index];
+		status = user->status;
 		flags = user->flags;
 
 		seq_printf(m, "%d:%s", user->index, EVENT_NAME(user));
diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index 4f5778e441c0..d06dc24156ec 100644
--- a/samples/user_events/example.c
+++ b/samples/user_events/example.c
@@ -12,13 +12,21 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <asm/bitsperlong.h>
+#include <endian.h>
 #include <linux/user_events.h>
 
+#if __BITS_PER_LONG == 64
+#define endian_swap(x) htole64(x)
+#else
+#define endian_swap(x) htole32(x)
+#endif
+
 /* Assumes debugfs is mounted */
 const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
 const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
 
-static int event_status(char **status)
+static int event_status(long **status)
 {
 	int fd = open(status_file, O_RDONLY);
 
@@ -33,7 +41,8 @@ static int event_status(char **status)
 	return 0;
 }
 
-static int event_reg(int fd, const char *command, int *status, int *write)
+static int event_reg(int fd, const char *command, long *index, long *mask,
+		     int *write)
 {
 	struct user_reg reg = {0};
 
@@ -43,7 +52,8 @@ static int event_reg(int fd, const char *command, int *status, int *write)
 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
 		return -1;
 
-	*status = reg.status_index;
+	*index = reg.status_bit / __BITS_PER_LONG;
+	*mask = endian_swap(1L << (reg.status_bit % __BITS_PER_LONG));
 	*write = reg.write_index;
 
 	return 0;
@@ -51,8 +61,9 @@ static int event_reg(int fd, const char *command, int *status, int *write)
 
 int main(int argc, char **argv)
 {
-	int data_fd, status, write;
-	char *status_page;
+	int data_fd, write;
+	long index, mask;
+	long *status_page;
 	struct iovec io[2];
 	__u32 count = 0;
 
@@ -61,7 +72,7 @@ int main(int argc, char **argv)
 
 	data_fd = open(data_file, O_RDWR);
 
-	if (event_reg(data_fd, "test u32 count", &status, &write) == -1)
+	if (event_reg(data_fd, "test u32 count", &index, &mask, &write) == -1)
 		return errno;
 
 	/* Setup iovec */
@@ -75,7 +86,7 @@ int main(int argc, char **argv)
 	getchar();
 
 	/* Check if anyone is listening */
-	if (status_page[status]) {
+	if (status_page[index] & mask) {
 		/* Yep, trace out our data */
 		writev(data_fd, (const struct iovec *)io, 2);
 
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index a80fb5ef61d5..404a2713dcae 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -22,6 +22,11 @@ const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_e
 const char *trace_file = "/sys/kernel/debug/tracing/trace";
 const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
 
+static inline int status_check(char *status_page, int status_bit)
+{
+	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
+}
+
 static int trace_bytes(void)
 {
 	int fd = open(trace_file, O_RDONLY);
@@ -197,12 +202,12 @@ TEST_F(user, register_events) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_NE(0, reg.status_bit);
 
 	/* Multiple registers should result in same index */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_NE(0, reg.status_bit);
 
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
@@ -212,15 +217,15 @@ TEST_F(user, register_events) {
 	/* MMAP should work and be zero'd */
 	ASSERT_NE(MAP_FAILED, status_page);
 	ASSERT_NE(NULL, status_page);
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
 
 	/* Enable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-	ASSERT_EQ(EVENT_STATUS_FTRACE, status_page[reg.status_index]);
+	ASSERT_NE(0, status_check(status_page, reg.status_bit));
 
 	/* Disable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
 
 	/* File still open should return -EBUSY for delete */
 	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
@@ -240,6 +245,8 @@ TEST_F(user, write_events) {
 	struct iovec io[3];
 	__u32 field1, field2;
 	int before = 0, after = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	char *status_page;
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
@@ -254,10 +261,18 @@ TEST_F(user, write_events) {
 	io[2].iov_base = &field2;
 	io[2].iov_len = sizeof(field2);
 
+	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			   self->status_fd, 0);
+
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_NE(0, reg.status_bit);
+
+	/* MMAP should work and be zero'd */
+	ASSERT_NE(MAP_FAILED, status_page);
+	ASSERT_NE(NULL, status_page);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
 
 	/* Write should fail on invalid slot with ENOENT */
 	io[0].iov_base = &field2;
@@ -271,6 +286,9 @@ TEST_F(user, write_events) {
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
 
+	/* Event should now be enabled */
+	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+
 	/* Write should make it out to ftrace buffers */
 	before = trace_bytes();
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
@@ -298,7 +316,7 @@ TEST_F(user, write_fault) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_NE(0, reg.status_bit);
 
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
@@ -315,6 +333,11 @@ TEST_F(user, write_validator) {
 	int loc, bytes;
 	char data[8];
 	int before = 0, after = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	char *status_page;
+
+	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			   self->status_fd, 0);
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
@@ -322,7 +345,12 @@ TEST_F(user, write_validator) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
+	ASSERT_NE(0, reg.status_bit);
+
+	/* MMAP should work and be zero'd */
+	ASSERT_NE(MAP_FAILED, status_page);
+	ASSERT_NE(NULL, status_page);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
 
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
@@ -340,6 +368,9 @@ TEST_F(user, write_validator) {
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
 
+	/* Event should now be enabled */
+	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+
 	/* Full in-bounds write should work */
 	before = trace_bytes();
 	loc = DYN_LOC(0, bytes);
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 26851d51d6bb..8b4c7879d5a7 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -35,6 +35,11 @@ static long perf_event_open(struct perf_event_attr *pe, pid_t pid,
 	return syscall(__NR_perf_event_open, pe, pid, cpu, group_fd, flags);
 }
 
+static inline int status_check(char *status_page, int status_bit)
+{
+	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
+}
+
 static int get_id(void)
 {
 	FILE *fp = fopen(id_file, "r");
@@ -120,8 +125,8 @@ TEST_F(user, perf_write) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_index);
-	ASSERT_EQ(0, status_page[reg.status_index]);
+	ASSERT_NE(0, reg.status_bit);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
 
 	/* Id should be there */
 	id = get_id();
@@ -144,7 +149,7 @@ TEST_F(user, perf_write) {
 	ASSERT_NE(MAP_FAILED, perf_page);
 
 	/* Status should be updated */
-	ASSERT_EQ(EVENT_STATUS_PERF, status_page[reg.status_index]);
+	ASSERT_NE(0, status_check(status_page, reg.status_bit));
 
 	event.index = reg.write_index;
 	event.field1 = 0xc001;
-- 
2.25.1

