Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B104657376
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 08:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiL1HBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 02:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiL1HA7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 02:00:59 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F26B62B0;
        Tue, 27 Dec 2022 23:00:56 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:60298.401377448
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 2517B10029D;
        Wed, 28 Dec 2022 15:00:55 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-srhz2 with ESMTP id 9b7ed7b5b3124d83b36a3212303ad65b for rostedt@goodmis.org;
        Wed, 28 Dec 2022 15:00:56 CST
X-Transaction-ID: 9b7ed7b5b3124d83b36a3212303ad65b
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v4 2/2] kernel/trace: Provide default impelentations defined in trace_probe_tmpl.h
Date:   Wed, 28 Dec 2022 15:08:25 +0800
Message-Id: <1672211305-31482-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are 7 function definitions in trace_probe_tmpl.h, they are:

1, process_fetch_insn
2, fetch_store_strlen
3, fetch_store_string
4, fetch_store_strlen_user
5, fetch_store_string_user
6, probe_mem_read
7, probe_mem_read_user

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
2, I intended to introduce a new header file to exclude
trace_events_synth.c out of the patch. However, after looking
further, i found the errors in [1] are introduced by this patch,
but the warning in [1] are not. The errors can be fixed by adding
"#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API".

[1]:https://lore.kernel.org/lkml/202211301946.pkLE4PDp-lkp@intel.com/
---
 kernel/trace/trace_eprobe.c       | 144 ------------------------------
 kernel/trace/trace_events_synth.c |   7 +-
 kernel/trace/trace_kprobe.c       | 102 ---------------------
 kernel/trace/trace_probe_kernel.h | 143 +++++++++++++++++++++++++++--
 4 files changed, 141 insertions(+), 255 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index bdb26eee7a0c..60ced4a7a25d 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -319,64 +319,6 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-static unsigned long get_event_field(struct fetch_insn *code, void *rec)
-{
-	struct ftrace_event_field *field = code->data;
-	unsigned long val;
-	void *addr;
-
-	addr = rec + field->offset;
-
-	if (is_string_field(field)) {
-		switch (field->filter_type) {
-		case FILTER_DYN_STRING:
-			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
-			break;
-		case FILTER_RDYN_STRING:
-			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
-			break;
-		case FILTER_STATIC_STRING:
-			val = (unsigned long)addr;
-			break;
-		case FILTER_PTR_STRING:
-			val = (unsigned long)(*(char *)addr);
-			break;
-		default:
-			WARN_ON_ONCE(1);
-			return 0;
-		}
-		return val;
-	}
-
-	switch (field->size) {
-	case 1:
-		if (field->is_signed)
-			val = *(char *)addr;
-		else
-			val = *(unsigned char *)addr;
-		break;
-	case 2:
-		if (field->is_signed)
-			val = *(short *)addr;
-		else
-			val = *(unsigned short *)addr;
-		break;
-	case 4:
-		if (field->is_signed)
-			val = *(int *)addr;
-		else
-			val = *(unsigned int *)addr;
-		break;
-	default:
-		if (field->is_signed)
-			val = *(long *)addr;
-		else
-			val = *(unsigned long *)addr;
-		break;
-	}
-	return val;
-}
-
 static int get_eprobe_size(struct trace_probe *tp, void *rec)
 {
 	struct fetch_insn *code;
@@ -419,92 +361,6 @@ static int get_eprobe_size(struct trace_probe *tp, void *rec)
 	return ret;
 }
 
-/* Kprobe specific fetch functions */
-
-/* Note that we don't verify it, since the code does not come from user space */
-static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
-{
-	unsigned long val;
-
- retry:
-	switch (code->op) {
-	case FETCH_OP_TP_ARG:
-		val = get_event_field(code, rec);
-		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
-	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
-		code++;
-		goto retry;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-	return process_fetch_insn_bottom(code, val, dest, base);
-}
-NOKPROBE_SYMBOL(process_fetch_insn)
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
 /* eprobe handler */
 static inline void
 __eprobe_trace_func(struct eprobe_data *edata, void *rec)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e310052dc83c..7460f18ba973 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -18,6 +18,7 @@
 #include <linux/trace_events.h>
 #include <trace/events/mmflags.h>
 #include "trace_probe.h"
+#include "trace_probe_tmpl.h"
 #include "trace_probe_kernel.h"
 
 #include "trace_synth.h"
@@ -420,12 +421,12 @@ static unsigned int trace_string(struct synth_trace_event *entry,
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
@@ -473,7 +474,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		val_idx = var_ref_idx[field_pos];
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
-		len = kern_fetch_store_strlen((unsigned long)str_val);
+		len = fetch_store_strlen((unsigned long)str_val);
 
 		fields_size += len;
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a4ffa864dbb7..c2e0b741ae82 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1218,108 +1218,6 @@ static const struct file_operations kprobe_profile_ops = {
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
-/* Note that we don't verify it, since the code does not come from user space */
-static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
-{
-	struct pt_regs *regs = rec;
-	unsigned long val;
-
-retry:
-	/* 1st stage: get value from context */
-	switch (code->op) {
-	case FETCH_OP_REG:
-		val = regs_get_register(regs, code->param);
-		break;
-	case FETCH_OP_STACK:
-		val = regs_get_kernel_stack_nth(regs, code->param);
-		break;
-	case FETCH_OP_STACKP:
-		val = kernel_stack_pointer(regs);
-		break;
-	case FETCH_OP_RETVAL:
-		val = regs_return_value(regs);
-		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
-#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	case FETCH_OP_ARG:
-		val = regs_get_kernel_argument(regs, code->param);
-		break;
-#endif
-	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
-		code++;
-		goto retry;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-
-	return process_fetch_insn_bottom(code, val, dest, base);
-}
-NOKPROBE_SYMBOL(process_fetch_insn)
 
 /* Kprobe handler */
 static nokprobe_inline void
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 77dbd9ff9782..39f44513ec4e 100644
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
@@ -112,4 +112,135 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
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
+static nokprobe_inline unsigned long
+get_event_field(struct fetch_insn *code, void *rec)
+{
+	struct ftrace_event_field *field = code->data;
+	unsigned long val;
+	void *addr;
+
+	addr = rec + field->offset;
+
+	if (is_string_field(field)) {
+		switch (field->filter_type) {
+		case FILTER_DYN_STRING:
+			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_RDYN_STRING:
+			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_STATIC_STRING:
+			val = (unsigned long)addr;
+			break;
+		case FILTER_PTR_STRING:
+			val = (unsigned long)(*(char *)addr);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return 0;
+		}
+		return val;
+	}
+
+	switch (field->size) {
+	case 1:
+		if (field->is_signed)
+			val = *(char *)addr;
+		else
+			val = *(unsigned char *)addr;
+		break;
+	case 2:
+		if (field->is_signed)
+			val = *(short *)addr;
+		else
+			val = *(unsigned short *)addr;
+		break;
+	case 4:
+		if (field->is_signed)
+			val = *(int *)addr;
+		else
+			val = *(unsigned int *)addr;
+		break;
+	default:
+		if (field->is_signed)
+			val = *(long *)addr;
+		else
+			val = *(unsigned long *)addr;
+		break;
+	}
+	return val;
+}
+
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
+		   void *base)
+{
+	struct pt_regs *regs = rec;
+	unsigned long val;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+	case FETCH_OP_REG:
+		val = regs_get_register(regs, code->param);
+		break;
+	case FETCH_OP_STACK:
+		val = regs_get_kernel_stack_nth(regs, code->param);
+		break;
+	case FETCH_OP_STACKP:
+		val = kernel_stack_pointer(regs);
+		break;
+	case FETCH_OP_RETVAL:
+		val = regs_return_value(regs);
+		break;
+#endif
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	case FETCH_OP_ARG:
+		val = regs_get_kernel_argument(regs, code->param);
+		break;
+#endif
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	case FETCH_OP_TP_ARG:
+		val = get_event_field(code, rec);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
 #endif /* __TRACE_PROBE_KERNEL_H_ */
-- 
2.25.1

