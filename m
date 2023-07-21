Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649475C54C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGULBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGUK7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9530EA;
        Fri, 21 Jul 2023 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9NhyLnlAfopWgGOSWESIH0/PnobLNBtkaRYsiDDWMnA=; b=h01MkGfWiYpijGplIfpSuhTaay
        R4NdiugUbV+PWB/rXSW9+YSUbaIPv2WnlxJJrr5YIMAmxOzExLKqkEyqymN1nw9mzZjYWXsIDHanC
        Ozfo+c3Ji22VzxtffJVDwAhO/NftW5uSFZDZhV1Vkh3slUUdvKG9SSBL9DSTkm3xCO9zy8l8wb2q1
        bfM7YyS1+B9jy6NKsyhANThpKn2r4NAf3GPXkDstxGzFGNQxy2e24aI4UCmXmH4c/FMgZbHqnHQO6
        d/alwl24Cf/5O0jP3ErAMwjD6uqZSnL7IpHJNauz0+4lU9AFE1TUF2dvNMVXYg5CjSyj6oculDmQQ
        TjOWc8bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMnqL-0000LE-0S;
        Fri, 21 Jul 2023 10:58:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B671301C47;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2507D3157E626; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.503233222@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 12/14] futex: Propagate flags into futex_get_value_locked()
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
@@ -515,12 +515,12 @@ int futex_cmpxchg_value_locked(u32 *curv
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
@@ -218,7 +218,7 @@ extern void futex_wake_mark(struct wake_
 
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
@@ -451,7 +451,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = futex_get_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1, FLAGS_SIZE_32);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -438,7 +438,7 @@ static int futex_wait_multiple_setup(str
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr);
+		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 		if (!ret && uval == val) {
 			/*
@@ -606,7 +606,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 	if (ret) {
 		futex_q_unlock(*hb);


