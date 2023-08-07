Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C449477242C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjHGMhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHGMhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159A10F3;
        Mon,  7 Aug 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=w9vOIgSzc3lTdvJPA8NMQRoDG93TaTUpiM2kUBnJUKc=; b=HVQVCCwtOi10B4bKYKmHp+D8Xn
        3Mwa7mNyJqgKtoSRW8aoRhg2wTYWEV9bu/9nUYfTmEk+3fz/rBjtI7q1THMC5ThblPseixtBckC3P
        jjsb4x5Dz2mO5rtOJ9ot0TyP3uuCeT8xgf7r1l0LNK1BT5L6Qi6StGFPGzQmtVQY9lWOzBzHyC66H
        q+xN/XwnxvVLzZCjTSvnUwEl4A5jKDjzYcTRry6ZggG2oevtz8yX4SWXiLop/BFRdUUsRCip7yNiw
        js+pcKYQeW/P2tUP49TmzRMkJdXA+QWfsKkYRpUYtcwdtt5yxgOY5SqOCkQ1ofSU6Lq0Uq+3lN0Wc
        sDcW8hMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSzTk-00AxG0-S3; Mon, 07 Aug 2023 12:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D731E30092A;
        Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 95E432029B0A3; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123322.952568452@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 03/14] futex: Flag conversion
References: <20230807121843.710612856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Futex has 3 sets of flags:

 - legacy futex op bits
 - futex2 flags
 - internal flags

Add a few helpers to convert from the API flags into the internal
flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/futex.h    |   63 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/futex/syscalls.c |   24 ++++++------------
 kernel/futex/waitwake.c |    4 +--
 3 files changed, 71 insertions(+), 20 deletions(-)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -5,6 +5,7 @@
 #include <linux/futex.h>
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
+#include <linux/compat.h>
 
 #ifdef CONFIG_PREEMPT_RT
 #include <linux/rcuwait.h>
@@ -16,8 +17,15 @@
  * Futex flags used to encode options to functions and preserve them across
  * restarts.
  */
+#define FLAGS_SIZE_8		0x00
+#define FLAGS_SIZE_16		0x01
+#define FLAGS_SIZE_32		0x02
+#define FLAGS_SIZE_64		0x03
+
+#define FLAGS_SIZE_MASK		0x03
+
 #ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
+# define FLAGS_SHARED		0x10
 #else
 /*
  * NOMMU does not have per process address space. Let the compiler optimize
@@ -25,8 +33,57 @@
  */
 # define FLAGS_SHARED		0x00
 #endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
+#define FLAGS_CLOCKRT		0x20
+#define FLAGS_HAS_TIMEOUT	0x40
+#define FLAGS_NUMA		0x80
+
+/* FUTEX_ to FLAGS_ */
+static inline unsigned int futex_to_flags(unsigned int op)
+{
+	unsigned int flags = FLAGS_SIZE_32;
+
+	if (!(op & FUTEX_PRIVATE_FLAG))
+		flags |= FLAGS_SHARED;
+
+	if (op & FUTEX_CLOCK_REALTIME)
+		flags |= FLAGS_CLOCKRT;
+
+	return flags;
+}
+
+/* FUTEX2_ to FLAGS_ */
+static inline unsigned int futex2_to_flags(unsigned int flags2)
+{
+	unsigned int flags = flags2 & FUTEX2_SIZE_MASK;
+
+	if (!(flags2 & FUTEX2_PRIVATE))
+		flags |= FLAGS_SHARED;
+
+	if (flags2 & FUTEX2_NUMA)
+		flags |= FLAGS_NUMA;
+
+	return flags;
+}
+
+static inline bool futex_flags_valid(unsigned int flags)
+{
+	/* Only 64bit futexes for 64bit code */
+	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+		if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
+			return false;
+	}
+
+	/* Only 32bit futexes are implemented -- for now */
+	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+		return false;
+
+	return true;
+}
+
+static inline unsigned int futex_size(unsigned int flags)
+{
+	return 1 << (flags & FLAGS_SIZE_MASK);
+}
 
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/time_namespace.h>
 
@@ -85,15 +84,12 @@ SYSCALL_DEFINE3(get_robust_list, int, pi
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
+	unsigned int flags = futex_to_flags(op);
 	int cmd = op & FUTEX_CMD_MASK;
-	unsigned int flags = 0;
 
-	if (!(op & FUTEX_PRIVATE_FLAG))
-		flags |= FLAGS_SHARED;
-
-	if (op & FUTEX_CLOCK_REALTIME) {
-		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
+	if (flags & FLAGS_CLOCKRT) {
+		if (cmd != FUTEX_WAIT_BITSET &&
+		    cmd != FUTEX_WAIT_REQUEUE_PI &&
 		    cmd != FUTEX_LOCK_PI2)
 			return -ENOSYS;
 	}
@@ -201,21 +197,19 @@ static int futex_parse_waitv(struct fute
 	unsigned int i;
 
 	for (i = 0; i < nr_futexes; i++) {
+		unsigned int flags;
+
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
 
 		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
-			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_SIZE_U64)
-				return -EINVAL;
-		}
-
-		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_SIZE_U32)
+		flags = futex2_to_flags(aux.flags);
+		if (!futex_flags_valid(flags))
 			return -EINVAL;
 
-		futexv[i].w.flags = aux.flags;
+		futexv[i].w.flags = flags;
 		futexv[i].w.val = aux.val;
 		futexv[i].w.uaddr = aux.uaddr;
 		futexv[i].q = futex_q_init;
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -419,11 +419,11 @@ static int futex_wait_multiple_setup(str
 	 */
 retry:
 	for (i = 0; i < count; i++) {
-		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
+		if (!(vs[i].w.flags & FLAGS_SHARED) && retry)
 			continue;
 
 		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
-				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
+				    vs[i].w.flags & FLAGS_SHARED,
 				    &vs[i].q.key, FUTEX_READ);
 
 		if (unlikely(ret))


