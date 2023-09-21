Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687477A9F14
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjIUUR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjIUURO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:17:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F1580A7;
        Thu, 21 Sep 2023 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fjIRU4T5oPILBU1zZ/wxS7qhPtCXJYxpFVPOgrLAAA0=; b=eBZezOFZ4ppQ3c2LZZFjuO/bD8
        21whfvNIaYL8MbYoA09p6cZMY0xa2zNuISVyyt31TCZQMlOL2jutHZQw5DV0UbkivdgvXS3N35Ecn
        vIbEoK/h0Be5VogafdT0PutUojkgclQdYFKDradWPI5BjIUJG7gRPS3JbBmbctKHbDK2ojQ9dxGgC
        1iteJJ8zhfr+VbGovdVx3usUWCyGC//ajRFV+vQXW/HxStnQ1v8g3S1XR5LaOZrhqhx5Oa0CtmlSl
        qCksmgG5lRBLRCaymIvIwWUXwbSOxPlUU0xV5NxOIlLp8T4G/ARIoWsYIypPd/BkX2MbZ33POQ8YU
        PDpUBtGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvw-1Z;
        Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 0ABA13005F4; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105248.396780136@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:14 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 09/15] futex: Add flags2 argument to futex_requeue()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-requeue-flags.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to support mixed size requeue, add a second flags argument to
the internal futex_requeue() function.

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/futex.h    |    5 +++--
 kernel/futex/requeue.c  |   12 +++++++-----
 kernel/futex/syscalls.c |    6 +++---
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -328,8 +328,9 @@ extern int futex_wait_requeue_pi(u32 __u
 				 val, ktime_t *abs_time, u32 bitset, u32 __user
 				 *uaddr2);
 
-extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
-			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
+extern int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
+			 u32 __user *uaddr2, unsigned int flags2,
+			 int nr_wake, int nr_requeue,
 			 u32 *cmpval, int requeue_pi);
 
 extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
Index: linux-2.6/kernel/futex/requeue.c
===================================================================
--- linux-2.6.orig/kernel/futex/requeue.c
+++ linux-2.6/kernel/futex/requeue.c
@@ -346,8 +346,9 @@ futex_proxy_trylock_atomic(u32 __user *p
 /**
  * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
  * @uaddr1:	source futex user address
- * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @flags1:	futex flags (FLAGS_SHARED, etc.)
  * @uaddr2:	target futex user address
+ * @flags2:	futex flags (FLAGS_SHARED, etc.)
  * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
  * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
  * @cmpval:	@uaddr1 expected value (or %NULL)
@@ -361,7 +362,8 @@ futex_proxy_trylock_atomic(u32 __user *p
  *  - >=0 - on success, the number of tasks requeued or woken;
  *  -  <0 - on error
  */
-int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
+		  u32 __user *uaddr2, unsigned int flags2,
 		  int nr_wake, int nr_requeue, u32 *cmpval, int requeue_pi)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
@@ -424,10 +426,10 @@ int futex_requeue(u32 __user *uaddr1, un
 	}
 
 retry:
-	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags1, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags, &key2,
+	ret = get_futex_key(uaddr2, flags2, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
@@ -459,7 +461,7 @@ retry_private:
 			if (ret)
 				return ret;
 
-			if (!(flags & FLAGS_SHARED))
+			if (!(flags1 & FLAGS_SHARED))
 				goto retry_private;
 
 			goto retry;
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -106,9 +106,9 @@ long do_futex(u32 __user *uaddr, int op,
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, NULL, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, NULL, 0);
 	case FUTEX_CMP_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 0);
 	case FUTEX_WAKE_OP:
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
@@ -125,7 +125,7 @@ long do_futex(u32 __user *uaddr, int op,
 		return futex_wait_requeue_pi(uaddr, flags, val, timeout, val3,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 1);
 	}
 	return -ENOSYS;
 }


