Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCF75C547
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGULBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGUK7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C630E8;
        Fri, 21 Jul 2023 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+GPeC+b0X/r2JxaFmk2Vd0m0Q7Mcvnivdsn9xJjP8Rw=; b=UhkHzgo2Hvp0CRLk+p6vRsrvw7
        YgKgzf/XCyoOSRLPIKtpnbjTY6nadJlG2LCSkDKGPR7qb8qcgzOyFbOuaRcYAAaKiLE+s/2Wch+VQ
        egzMeJsCik0LwJptN4u7633AsD1TZrbo6CKJXqjOeIy8/4hE26m1ZmKYamWi7UZxxexcUsslTRml/
        1v13/bZNfkaqUAEObRAD9RWkVA6+HiuEfzeNV118iLAl2qc4vpbNNPPXVPHhKO4TLaLeVwUrWOCmP
        stLfJlSL/fiD3SQ7WN7OuuSX53eIVavOdM2+oaaizUSGHhfpaZS+fWd+w4ZeXu0qnqvhUCB930wgL
        hhHazrSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMnqL-0000LF-0i;
        Fri, 21 Jul 2023 10:58:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 404B3301C81;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 287DF3157E620; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.571094000@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 13/14] futex: Enable FUTEX2_{8,16}
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

When futexes are no longer u32 aligned, the lower offset bits are no
longer available to put type info in. However, since offset is the
offset within a page, there are plenty bits available on the top end.

After that, pass flags into futex_get_value_locked() for WAIT and
disallow FUTEX2_64 instead of mandating FUTEX2_32.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/futex.h   |   11 ++++++-----
 kernel/futex/core.c     |    9 +++++++++
 kernel/futex/futex.h    |    4 ++--
 kernel/futex/waitwake.c |    5 +++--
 4 files changed, 20 insertions(+), 9 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -16,18 +16,19 @@ struct task_struct;
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
  *
- * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
- * We use the two low order bits of offset to tell what is the kind of key :
+ * offset is the position within a page and is in the range [0, PAGE_SIZE).
+ * The high bits of the offset indicate what kind of key this is:
  *  00 : Private process futex (PTHREAD_PROCESS_PRIVATE)
  *       (no reference on an inode or mm)
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
  *       (but private mapping on an mm, and reference taken on it)
-*/
+ */
 
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    (PAGE_SIZE << 0)
+#define FUT_OFF_MMSHARED (PAGE_SIZE << 1)
+#define FUT_OFF_SIZE	 (PAGE_SIZE << 2)
 
 union futex_key {
 	struct {
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -308,6 +308,15 @@ int get_futex_key(void __user *uaddr, un
 	}
 
 	/*
+	 * Encode the futex size in the offset. This makes cross-size
+	 * wake-wait fail -- see futex_match().
+	 *
+	 * NOTE that cross-size wake-wait is fundamentally broken wrt
+	 * FLAGS_NUMA but could possibly work for !NUMA.
+	 */
+	key->both.offset |= FUT_OFF_SIZE * (flags & FLAGS_SIZE_MASK);
+
+	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
 	 * virtual address, we dont even have to find the underlying vma.
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -79,8 +79,8 @@ static inline bool futex_flags_valid(uns
 			return false;
 	}
 
-	/* Only 32bit futexes are implemented -- for now */
-	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+	/* 64bit futexes aren't implemented -- yet */
+	if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
 		return false;
 
 	/*
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -434,11 +434,12 @@ static int futex_wait_multiple_setup(str
 
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
+		unsigned int flags = vs[i].w.flags;
 		struct futex_q *q = &vs[i].q;
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+		ret = futex_get_value_locked(&uval, uaddr, flags);
 
 		if (!ret && uval == val) {
 			/*
@@ -606,7 +607,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+	ret = futex_get_value_locked(&uval, uaddr, flags);
 
 	if (ret) {
 		futex_q_unlock(*hb);


