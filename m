Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34FE753CDF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjGNOQi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjGNOQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255052D51;
        Fri, 14 Jul 2023 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gMJRupFzL+218xO81Os5o1A1M02NMRGWkhUhH51/Eio=; b=nSMf8b1rDj20p7163tEl4RgaYw
        DSLe3ZSkxQr+7VY+r4TGNHy4IKVGgxGwlAnaBfZ1PYxgc+9BuGU4lppaUgLKt/OlT2VI9vmL+gtik
        RUUId1CkI+N7mJbbIBxkpyuDGdUa5aVpvS+Yc8iRIksH5FyqowxzwctWZ66ifZj4zpcRzxA1JwJLi
        xF0TcSWW2JGAR7aiFXIAyNyG7gAGrNLXJTPzDH9o8S5WGUPpfdHzDOaRFWdzQrzyqvi/yLQh8bPzw
        J3JoHmSbBfv75wEYSpd5GgPHirR718Rgz4S1L/+YVHpWN8Rfzc7tvdreKeoz9KiQE8w+Veqj80xY5
        hVMxyKYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJah-0016z7-Me; Fri, 14 Jul 2023 14:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B37713014BF;
        Fri, 14 Jul 2023 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 79A14213728BA; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141219.014386004@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 06/10] futex: Propagate flags into get_futex_key()
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

Instead of only passing FLAGS_SHARED as a boolean, pass down flags as
a whole.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c     |    5 ++++-
 kernel/futex/futex.h    |    2 +-
 kernel/futex/pi.c       |    4 ++--
 kernel/futex/requeue.c  |    6 +++---
 kernel/futex/waitwake.c |   15 ++++++++-------
 5 files changed, 18 insertions(+), 14 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -217,7 +217,7 @@ static u64 get_inode_sequence_number(str
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -225,6 +225,9 @@ int get_futex_key(u32 __user *uaddr, boo
 	struct page *page, *tail;
 	struct address_space *mapping;
 	int err, ro = 0;
+	bool fshared;
+
+	fshared = flags & FLAGS_SHARED;
 
 	/*
 	 * The futex address must be "naturally" aligned.
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -158,7 +158,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -945,7 +945,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -1117,7 +1117,7 @@ int futex_unlock_pi(u32 __user *uaddr, u
 	if ((uval & FUTEX_TID_MASK) != vpid)
 		return -EPERM;
 
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;
 
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -424,10 +424,10 @@ int futex_requeue(u32 __user *uaddr1, un
 	}
 
 retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
+	ret = get_futex_key(uaddr2, flags, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
@@ -789,7 +789,7 @@ int futex_wait_requeue_pi(u32 __user *ua
 	 */
 	rt_mutex_init_waiter(&rt_waiter);
 
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret = get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
 
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -145,13 +145,13 @@ int futex_wake(u32 __user *uaddr, unsign
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
-	int ret;
 	DEFINE_WAKE_Q(wake_q);
+	int ret;
 
 	if (!bitset)
 		return -EINVAL;
 
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -245,10 +245,10 @@ int futex_wake_op(u32 __user *uaddr1, un
 	DEFINE_WAKE_Q(wake_q);
 
 retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret = get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -423,7 +423,7 @@ static int futex_wait_multiple_setup(str
 			continue;
 
 		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
-				    vs[i].w.flags & FLAGS_SHARED,
+				    vs[i].w.flags,
 				    &vs[i].q.key, FUTEX_READ);
 
 		if (unlikely(ret))
@@ -435,7 +435,8 @@ static int futex_wait_multiple_setup(str
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
 		struct futex_q *q = &vs[i].q;
-		u32 val = (u32)vs[i].w.val;
+		unsigned int flags = vs[i].w.flags;
+		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
 		ret = futex_get_value_locked(&uval, uaddr);
@@ -599,7 +600,7 @@ int futex_wait_setup(u32 __user *uaddr,
 	 * while the syscall executes.
 	 */
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	ret = get_futex_key(uaddr, flags, &q->key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
 


