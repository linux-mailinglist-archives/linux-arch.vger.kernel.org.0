Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427477A9F25
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjIUUSZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjIUUSB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:18:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A922585D3;
        Thu, 21 Sep 2023 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=s6qOxGEZJpUErRo7Rj/ShDjtuA5F7i3OQJb+GA/Bkxo=; b=D3oUK/pO445uaPiP0UtrFW7hXa
        oKZz9yxvDNPjaKGxg+tuiKw82E47h3XSx1J1DtEx5/rO/Ue7n1RjsT8ClHfs5ISvz5vNJWJsrkIuA
        0ui4A/To6UDY07L1ltjrTzUwk7nI3WvMdvonqicjSHRMsq5KyZxf0tb6QrOfqs7ZLA//VIXr/9qFW
        cze4siUErqj4DLV5JdF5b/Icns3tEaq1kbYbpCZmyI419v1f7F+4SLOHmrjiK5p3eoVvuUByqPDQz
        eLLWEv5LdNv7XBieo03gAqykd/mkLRixRW1Oph05DbRI73MxCQQfYN3EUx6SKXBr/CbYfTLYJm1Ng
        Gk8gGfng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvy-1Y;
        Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 20ED33006F6; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105249.002168440@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:18 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 13/15] futex: Propagate flags into futex_get_value_locked()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-get_values_locked.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to facilitate variable sized futexes propagate the flags into
futex_get_value_locked().

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/core.c     |    4 ++--
 kernel/futex/futex.h    |    2 +-
 kernel/futex/pi.c       |    8 ++++----
 kernel/futex/requeue.c  |    4 ++--
 kernel/futex/waitwake.c |    4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6/kernel/futex/core.c
===================================================================
--- linux-2.6.orig/kernel/futex/core.c
+++ linux-2.6/kernel/futex/core.c
@@ -516,12 +516,12 @@ int futex_cmpxchg_value_locked(u32 *curv
 	return ret;
 }
 
-int futex_get_value_locked(u32 *dest, u32 __user *from)
+int futex_get_value_locked(u32 *dest, u32 __user *from, unsigned int flags)
 {
 	int ret;
 
 	pagefault_disable();
-	ret = __get_user(*dest, from);
+	ret = futex_get_value(dest, from, flags);
 	pagefault_enable();
 
 	return ret ? -EFAULT : 0;
Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -229,7 +229,7 @@ extern void futex_wake_mark(struct wake_
 
 extern int fault_in_user_writeable(u32 __user *uaddr);
 extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval);
-extern int futex_get_value_locked(u32 *dest, u32 __user *from);
+extern int futex_get_value_locked(u32 *dest, u32 __user *from, unsigned int flags);
 extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *key);
 
 extern void __futex_unqueue(struct futex_q *q);
Index: linux-2.6/kernel/futex/pi.c
===================================================================
--- linux-2.6.orig/kernel/futex/pi.c
+++ linux-2.6/kernel/futex/pi.c
@@ -240,7 +240,7 @@ static int attach_to_pi_state(u32 __user
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -359,7 +359,7 @@ static int handle_exit_race(u32 __user *
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -527,7 +527,7 @@ int futex_lock_pi_atomic(u32 __user *uad
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (futex_get_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -750,7 +750,7 @@ retry:
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
 
-	err = futex_get_value_locked(&uval, uaddr);
+	err = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 	if (err)
 		goto handle_err;
 
Index: linux-2.6/kernel/futex/requeue.c
===================================================================
--- linux-2.6.orig/kernel/futex/requeue.c
+++ linux-2.6/kernel/futex/requeue.c
@@ -273,7 +273,7 @@ futex_proxy_trylock_atomic(u32 __user *p
 	u32 curval;
 	int ret;
 
-	if (futex_get_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -451,7 +451,7 @@ retry_private:
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = futex_get_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1, FLAGS_SIZE_32);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
Index: linux-2.6/kernel/futex/waitwake.c
===================================================================
--- linux-2.6.orig/kernel/futex/waitwake.c
+++ linux-2.6/kernel/futex/waitwake.c
@@ -441,7 +441,7 @@ retry:
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr);
+		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 		if (!ret && uval == val) {
 			/*
@@ -609,7 +609,7 @@ retry:
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 	if (ret) {
 		futex_q_unlock(*hb);


