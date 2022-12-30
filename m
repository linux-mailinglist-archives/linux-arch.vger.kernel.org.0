Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14D659566
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 07:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiL3G0V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 01:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiL3G0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 01:26:16 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5806B8FD9;
        Thu, 29 Dec 2022 22:26:10 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:42306.1270225902
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 24B861002F2;
        Fri, 30 Dec 2022 14:26:08 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-srhz2 with ESMTP id 46261d7f23bf482098c75bff3e657875 for rostedt@goodmis.org;
        Fri, 30 Dec 2022 14:26:09 CST
X-Transaction-ID: 46261d7f23bf482098c75bff3e657875
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 2/3] kernel/trace: Provide default impelentations defined in trace_probe_tmpl.h
Date:   Fri, 30 Dec 2022 14:33:38 +0800
Message-Id: <1672382018-18347-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are 6 function definitions in trace_probe_tmpl.h, they are:

1, fetch_store_strlen
2, fetch_store_string
3, fetch_store_strlen_user
4, fetch_store_string_user
5, probe_mem_read
6, probe_mem_read_user

Every C file which includes trace_probe_tmpl.h has to implement them,
otherwise it gets warnings and errors. However, some of them are identical,
like kprobe and eprobe, as a result, there is a lot redundant code in those
2 files.

This patch would like to provide default behaviors for those functions
which kprobe and eprobe can share by just including trace_probe_kernel.h
with trace_probe_tmpl.h together.

It removes redundant code, increases readability, and more importantly,
makes it easier to introduce a new feature based on trace probe
(it's possible).

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reported-by: kernel test robot <lkp@intel.com>

---
v2:
1, reorganize patchset

v3:
1, mark nokprobe_inline for get_event_field
2, remove warnings reported from kernel test robot
3, fix errors reported from kernel test robot

v4:
1, reset changes in v3(2) and v3(3), they are not reasonable fix.
2, fixed errors by adding "#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API".

v5:
1, move process_fetch_insn to trace_probe_tmpl.h in another patch.
---
 kernel/trace/trace_eprobe.c       | 55 ++-----------------------------
 kernel/trace/trace_events_synth.c |  6 ++--
 kernel/trace/trace_kprobe.c       | 54 ------------------------------
 kernel/trace/trace_probe_kernel.h | 30 +++++++++++++----
 4 files changed, 29 insertions(+), 116 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index bdb26eee7a0c..ca5d097eec4f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -319,7 +319,8 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-static unsigned long get_event_field(struct fetch_insn *code, void *rec)
+static nokprobe_inline unsigned long
+get_event_field(struct fetch_insn *code, void *rec)
 {
 	struct ftrace_event_field *field = code->data;
 	unsigned long val;
@@ -453,58 +454,6 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen_user(unsigned long addr)
-{
-	return kern_fetch_store_strlen_user(addr);
-}
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen(unsigned long addr)
-{
-	return kern_fetch_store_strlen(addr);
-}
-
-/*
- * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
- * with max length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string_user(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string_user(addr, dest, base);
-}
-
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
- * length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string(addr, dest, base);
-}
-
-static nokprobe_inline int
-probe_mem_read_user(void *dest, void *src, size_t size)
-{
-	const void __user *uaddr =  (__force const void __user *)src;
-
-	return copy_from_user_nofault(dest, uaddr, size);
-}
-
-static nokprobe_inline int
-probe_mem_read(void *dest, void *src, size_t size)
-{
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)src < TASK_SIZE)
-		return probe_mem_read_user(dest, src, size);
-#endif
-	return copy_from_kernel_nofault(dest, src, size);
-}
-
 /* eprobe handler */
 static inline void
 __eprobe_trace_func(struct eprobe_data *edata, void *rec)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e310052dc83c..d72916c91e24 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -420,12 +420,12 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 		data_offset += event->n_u64 * sizeof(u64);
 		data_offset += data_size;
 
-		len = kern_fetch_store_strlen((unsigned long)str_val);
+		len = fetch_store_strlen((unsigned long)str_val);
 
 		data_offset |= len << 16;
 		*(u32 *)&entry->fields[*n_u64] = data_offset;
 
-		ret = kern_fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
+		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
 		(*n_u64)++;
 	} else {
@@ -473,7 +473,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		val_idx = var_ref_idx[field_pos];
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
-		len = kern_fetch_store_strlen((unsigned long)str_val);
+		len = fetch_store_strlen((unsigned long)str_val);
 
 		fields_size += len;
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a4ffa864dbb7..714fe9c04eb6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1218,60 +1218,6 @@ static const struct file_operations kprobe_profile_ops = {
 	.release        = seq_release,
 };
 
-/* Kprobe specific fetch functions */
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen_user(unsigned long addr)
-{
-	return kern_fetch_store_strlen_user(addr);
-}
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen(unsigned long addr)
-{
-	return kern_fetch_store_strlen(addr);
-}
-
-/*
- * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
- * with max length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string_user(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string_user(addr, dest, base);
-}
-
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
- * length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string(addr, dest, base);
-}
-
-static nokprobe_inline int
-probe_mem_read_user(void *dest, void *src, size_t size)
-{
-	const void __user *uaddr =  (__force const void __user *)src;
-
-	return copy_from_user_nofault(dest, uaddr, size);
-}
-
-static nokprobe_inline int
-probe_mem_read(void *dest, void *src, size_t size)
-{
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)src < TASK_SIZE)
-		return probe_mem_read_user(dest, src, size);
-#endif
-	return copy_from_kernel_nofault(dest, src, size);
-}
-
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 77dbd9ff9782..c4e1d4c03a85 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -12,7 +12,7 @@
  */
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
-kern_fetch_store_strlen_user(unsigned long addr)
+fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
 	int ret;
@@ -29,14 +29,14 @@ kern_fetch_store_strlen_user(unsigned long addr)
 
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
-kern_fetch_store_strlen(unsigned long addr)
+fetch_store_strlen(unsigned long addr)
 {
 	int ret, len = 0;
 	u8 c;
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	if (addr < TASK_SIZE)
-		return kern_fetch_store_strlen_user(addr);
+		return fetch_store_strlen_user(addr);
 #endif
 
 	do {
@@ -63,7 +63,7 @@ static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void
  * with max length and relative data location.
  */
 static nokprobe_inline int
-kern_fetch_store_string_user(unsigned long addr, void *dest, void *base)
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
 	int maxlen = get_loc_len(*(u32 *)dest);
@@ -86,7 +86,7 @@ kern_fetch_store_string_user(unsigned long addr, void *dest, void *base)
  * length and relative data location.
  */
 static nokprobe_inline int
-kern_fetch_store_string(unsigned long addr, void *dest, void *base)
+fetch_store_string(unsigned long addr, void *dest, void *base)
 {
 	int maxlen = get_loc_len(*(u32 *)dest);
 	void *__dest;
@@ -94,7 +94,7 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	if ((unsigned long)addr < TASK_SIZE)
-		return kern_fetch_store_string_user(addr, dest, base);
+		return fetch_store_string_user(addr, dest, base);
 #endif
 
 	if (unlikely(!maxlen))
@@ -112,4 +112,22 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	const void __user *uaddr =  (__force const void __user *)src;
+
+	return copy_from_user_nofault(dest, uaddr, size);
+}
+
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if ((unsigned long)src < TASK_SIZE)
+		return probe_mem_read_user(dest, src, size);
+#endif
+	return copy_from_kernel_nofault(dest, src, size);
+}
+
 #endif /* __TRACE_PROBE_KERNEL_H_ */
-- 
2.25.1

