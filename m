Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE753CE7
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjGNOQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjGNOQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B730C0;
        Fri, 14 Jul 2023 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=98fwNtpV0Bbvya3mBoauq7smkVWN16/6yjAoJPAxLCQ=; b=k0AkkJTwfkefz5URce2ntHKAIC
        6CkN91KKm1sEDmU8seNl1uV4Im1FILXye+5BHlydSaZELYf9BNA3/k7+QifPdr1WwzxLzYcvHvf6T
        P1AJrThlTJ4nWZgI8kec0ij5yNMrSO/t5B/BJ5VDAX+AR7E+PAaN9ykyCq7vT6csjBMqdhA19nELp
        lEz1sIwnXytxoy8hFGNf0qkpI0+Ch+wz56SHgu5eT13eNOFZ9pHKXoHl5VNSgkeZfGyJrfRhvnzkm
        2UMzg2C3u8KfvGSkocm2zB5m0xp474j8eyUMo0BZX3hXkqvYrbCtZ7F7zHwbFS4yTB9IgE5FV80uX
        dly3b80w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJah-006Iiw-21;
        Fri, 14 Jul 2023 14:16:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0834300362;
        Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 691B3213728B7; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141218.813185695@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 03/10] futex: Flag conversion
References: <20230714133859.305719029@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/futex/futex.h    |   48 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/futex/syscalls.c |   21 +++++++++++++--------
 kernel/futex/waitwake.c |    4 ++--
 3 files changed, 60 insertions(+), 13 deletions(-)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -16,8 +16,15 @@
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
@@ -25,8 +32,43 @@
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
+static inline unsigned int futex_size(unsigned int flags)
+{
+	unsigned int size = flags & FLAGS_SIZE_MASK;
+	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
+}
 
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -85,15 +85,12 @@ SYSCALL_DEFINE3(get_robust_list, int, pi
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
@@ -201,6 +198,8 @@ static int futex_parse_waitv(struct fute
 	unsigned int i;
 
 	for (i = 0; i < nr_futexes; i++) {
+		unsigned int bits, flags;
+
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
 
@@ -210,7 +209,13 @@ static int futex_parse_waitv(struct fute
 		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
 			return -EINVAL;
 
-		futexv[i].w.flags = aux.flags;
+		flags = futex2_to_flags(aux.flags);
+		bits = 8 * futex_size(flags);
+
+		if (bits < 64 && aux.val >> bits)
+			return -EINVAL;
+
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


