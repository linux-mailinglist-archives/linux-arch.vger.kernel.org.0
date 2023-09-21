Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722157A9EFC
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjIUUQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIUUPl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:15:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8032B585C1;
        Thu, 21 Sep 2023 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UZPFE2ZScTicMie2LbY/rLHSb/ea3l5YRQ8Geimizx8=; b=D2+0fnUyypGBp3tmehpApHtBuE
        RnJo83xqyajrpKhjalpbKvZ+nGASRjTehHdoMNEhFFbTcsMZXNEJLm5K1AwRxz7Hx/fTASdxtRhBO
        zohke4ebc70ACqv8Bs7aQndNOXz9ac9ZANpPzFBrOQ+RyKLLvLq/F29cabLPlXJbmlNe4x7U3YzAj
        CxhoAB6qRbKq148GeIUfQzuoCLGewVVsVQtiU45YMCM4+B7uyU9yU2RrlLxkSF/Fj0+YTFgao96V8
        1zSsgA3Ssz8jktwFUDjRfiOf68jkKJufk5rw+2mIG7SIRiJkGC5VD+RKhcC+J5orR8ZLAEtgTlYUz
        zhFFmjAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvt-1M;
        Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 058B53005B2; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105248.282857501@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:13 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 08/15] futex: Propagate flags into get_futex_key()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-get_futex_key-flags.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of only passing FLAGS_SHARED as a boolean, pass down flags as
a whole.

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/core.c     |    5 ++++-
 kernel/futex/futex.h    |    2 +-
 kernel/futex/pi.c       |    4 ++--
 kernel/futex/requeue.c  |    6 +++---
 kernel/futex/waitwake.c |   14 +++++++-------
 5 files changed, 17 insertions(+), 14 deletions(-)

Index: linux-2.6/kernel/futex/core.c
===================================================================
--- linux-2.6.orig/kernel/futex/core.c
+++ linux-2.6/kernel/futex/core.c
@@ -193,7 +193,7 @@ static u64 get_inode_sequence_number(str
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
+ * @flags:	FLAGS_*
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -217,7 +217,7 @@ static u64 get_inode_sequence_number(str
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -226,6 +226,9 @@ int get_futex_key(u32 __user *uaddr, boo
 	struct folio *folio;
 	struct address_space *mapping;
 	int err, ro = 0;
+	bool fshared;
+
+	fshared = flags & FLAGS_SHARED;
 
 	/*
 	 * The futex address must be "naturally" aligned.
Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -184,7 +184,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *
Index: linux-2.6/kernel/futex/pi.c
===================================================================
--- linux-2.6.orig/kernel/futex/pi.c
+++ linux-2.6/kernel/futex/pi.c
@@ -933,7 +933,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -1129,7 +1129,7 @@ retry:
 	if ((uval & FUTEX_TID_MASK) != vpid)
 		return -EPERM;
 
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;
 
Index: linux-2.6/kernel/futex/requeue.c
===================================================================
--- linux-2.6.orig/kernel/futex/requeue.c
+++ linux-2.6/kernel/futex/requeue.c
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
 
Index: linux-2.6/kernel/futex/waitwake.c
===================================================================
--- linux-2.6.orig/kernel/futex/waitwake.c
+++ linux-2.6/kernel/futex/waitwake.c
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
 
@@ -248,10 +248,10 @@ int futex_wake_op(u32 __user *uaddr1, un
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
 
@@ -426,7 +426,7 @@ retry:
 			continue;
 
 		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
-				    vs[i].w.flags & FLAGS_SHARED,
+				    vs[i].w.flags,
 				    &vs[i].q.key, FUTEX_READ);
 
 		if (unlikely(ret))
@@ -438,7 +438,7 @@ retry:
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
 		struct futex_q *q = &vs[i].q;
-		u32 val = (u32)vs[i].w.val;
+		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
 		ret = futex_get_value_locked(&uval, uaddr);
@@ -602,7 +602,7 @@ int futex_wait_setup(u32 __user *uaddr,
 	 * while the syscall executes.
 	 */
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	ret = get_futex_key(uaddr, flags, &q->key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
 


