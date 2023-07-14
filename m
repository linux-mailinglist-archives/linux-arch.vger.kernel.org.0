Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD10753CE1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjGNOQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjGNOQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E012E;
        Fri, 14 Jul 2023 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YZtbZT4V1GJ1CVh10G4kmmhbwertk2B4UiVE4SdkC2M=; b=cOl8XfYmCU/a0b/BBC7Nn/k0cT
        jBGUjXr8YbhcZHuC4EI7XNNB/CSbBBJrMRHM1uNNOcQI8p4hKMQuy/VnTzEcSLjV/fzlbhknFLYoC
        dyWPMzFBFHM0hllwEVXnC3zMrQpN8LeZu3QtawgherNAdSWLu/Us8LNZDlNosZz82Qv/54HfQqNRR
        IjvdglEd/PN8ktcC2J5/z4X0KzDvGesqRa/Bq9pZEWVw2PbspvLbdwCABlamLxGYvQxbmNJap4jHU
        Fkt/rlPiR+riomGl78Bo/4NsC2PJtU1xj+JL23YTLLHaFPgeNfUblbA1Oz7pZCRr3CKgStl1nHf3k
        LRhUC0Eg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJah-0016z6-M2; Fri, 14 Jul 2023 14:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B280030114F;
        Fri, 14 Jul 2023 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 82B8B244088B0; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141219.148373175@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 08/10] futex: Propagate flags into futex_get_value_locked()
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

In order to facilitate variable sized futexes propagate the flags into
futex_get_value_locked().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c     |    4 ++--
 kernel/futex/futex.h    |    2 +-
 kernel/futex/pi.c       |    8 ++++----
 kernel/futex/requeue.c  |    4 ++--
 kernel/futex/waitwake.c |    4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -506,12 +506,12 @@ int futex_cmpxchg_value_locked(u32 *curv
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
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -190,7 +190,7 @@ extern void futex_wake_mark(struct wake_
 
 extern int fault_in_user_writeable(u32 __user *uaddr);
 extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval);
-extern int futex_get_value_locked(u32 *dest, u32 __user *from);
+extern int futex_get_value_locked(u32 *dest, u32 __user *from, unsigned int flags);
 extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *key);
 
 extern void __futex_unqueue(struct futex_q *q);
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -239,7 +239,7 @@ static int attach_to_pi_state(u32 __user
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -358,7 +358,7 @@ static int handle_exit_race(u32 __user *
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -526,7 +526,7 @@ int futex_lock_pi_atomic(u32 __user *uad
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (futex_get_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -762,7 +762,7 @@ static int __fixup_pi_state_owner(u32 __
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
 
-	err = futex_get_value_locked(&uval, uaddr);
+	err = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 	if (err)
 		goto handle_err;
 
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -273,7 +273,7 @@ futex_proxy_trylock_atomic(u32 __user *p
 	u32 curval;
 	int ret;
 
-	if (futex_get_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -449,7 +449,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = futex_get_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1, FLAGS_SIZE_32);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -439,7 +439,7 @@ static int futex_wait_multiple_setup(str
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr);
+		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 		if (!ret && uval == val) {
 			/*
@@ -607,7 +607,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 	if (ret) {
 		futex_q_unlock(*hb);


