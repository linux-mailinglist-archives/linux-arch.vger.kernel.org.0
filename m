Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD575C54A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGULBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGUK7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEB30E6;
        Fri, 21 Jul 2023 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SORtMlf6AQ8aFXAtXEB5iMu/bkrYMuTpcyv7hAzIkB0=; b=C7i2naEtXB9PgOtkFyyD1IzI3C
        9aIziC4VcH7AzunWf3zawU5TgSmHegDHfjYHDsdbBOcybREbz8Vrrl3Kx3BYHtkrHQOT3GioEQXD6
        2WnojWFweddsKJprJPiwjRyQfQhZLIrKa67xiG11UAG694EvfKe1sc9LOCMpLy9j3rO7Wug//JpRq
        rVdiqDTuEXeRA84KUzdCYKCOx2oxkRZlk06UU5uzIwLog5GZ3QLxrGqlua8XmcAyzilhwndfdboRy
        03qi9MYO17P+6tvHDsLaUzB5cwRNOKIgebn1XXInDS7DudxcciIQmX98jPfajh2nGdyjCRzC31eR3
        jsJPM9ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMnqK-0000Ky-0r;
        Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33B583008AC;
        Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F190A3157E61C; Fri, 21 Jul 2023 12:58:37 +0200 (CEST)
Message-ID: <20230721105743.887106899@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 03/14] futex: Flag conversion
References: <20230721102237.268073801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/futex/futex.h    |   64 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/futex/syscalls.c |   24 ++++++------------
 kernel/futex/waitwake.c |    4 +--
 3 files changed, 72 insertions(+), 20 deletions(-)

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
@@ -25,8 +33,58 @@
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
+	unsigned int flags = flags2 & FUTEX2_64;
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
+	unsigned int size = flags & FLAGS_SIZE_MASK;
+	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
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
 
 		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
-			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
-				return -EINVAL;
-		}
-
-		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
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


