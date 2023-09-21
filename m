Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC087AA596
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjIUXZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 19:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjIUXZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 19:25:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F4F9;
        Thu, 21 Sep 2023 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9OUktNkwNXjB5runbwWnUkYaH4gkQXyoyA8wphj6CxQ=; b=GGxYiouDxwMhpCaPcVH40k98P/
        XAfPr7EX2gzP8TckrBbk0itBDqh1K7L47qzj5ufg0WUG7Olk8Cby/mGQk/MfSUHpFcAoHFbPrC9vs
        EjyJVceNWZaOGslnAhpSgFyQciPs7Zl7wH+N2XntEXFqDsPfCoE6LiaK/AnohyGjrKsGsSQ089gs3
        hlcFVZvN0eJHab3vYggwHl9ShJvSk4C58uCtLGwBHhEyqjaQe2iX2kH0aoMJkbcnplJDonkvdIIhK
        hXDu6aGgekrKWj5LYF6dmt9W2ciUrqRrAGk+jg2tMV2PEMXwjpNtLXqPV9S9yK+8ASFpo1IaN/Y4q
        uQIXkbmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjHQO-00BTom-U1; Thu, 21 Sep 2023 11:00:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 26D833008D6; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105249.108410391@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:19 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 14/15] futex: Enable FUTEX2_{8,16}
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-small.patch
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When futexes are no longer u32 aligned, the lower offset bits are no
longer available to put type info in. However, since offset is the
offset within a page, there are plenty bits available on the top end.

After that, pass flags into futex_get_value_locked() for WAIT and
disallow FUTEX2_SIZE_U64 instead of mandating FUTEX2_SIZE_U32.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/futex.h   |   11 ++++++-----
 kernel/futex/core.c     |    9 +++++++++
 kernel/futex/futex.h    |    4 ++--
 kernel/futex/waitwake.c |    5 +++--
 4 files changed, 20 insertions(+), 9 deletions(-)

Index: linux-2.6/include/linux/futex.h
===================================================================
--- linux-2.6.orig/include/linux/futex.h
+++ linux-2.6/include/linux/futex.h
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
Index: linux-2.6/kernel/futex/core.c
===================================================================
--- linux-2.6.orig/kernel/futex/core.c
+++ linux-2.6/kernel/futex/core.c
@@ -311,6 +311,15 @@ int get_futex_key(void __user *uaddr, un
 	}
 
 	/*
+	 * Encode the futex size in the offset. This makes cross-size
+	 * wake-wait fail -- see futex_match().
+	 *
+	 * NOTE that cross-size wake-wait is fundamentally broken wrt
+	 * FLAGS_NUMA.
+	 */
+	key->both.offset |= FUT_OFF_SIZE * (flags & FLAGS_SIZE_MASK);
+
+	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
 	 * virtual address, we dont even have to find the underlying vma.
Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -79,8 +79,8 @@ static inline bool futex_flags_valid(uns
 			return false;
 	}
 
-	/* Only 32bit futexes are implemented -- for now */
-	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+	/* 64bit futexes aren't implemented -- yet */
+	if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
 		return false;
 
 	/*
Index: linux-2.6/kernel/futex/waitwake.c
===================================================================
--- linux-2.6.orig/kernel/futex/waitwake.c
+++ linux-2.6/kernel/futex/waitwake.c
@@ -437,11 +437,12 @@ retry:
 
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
@@ -609,7 +610,7 @@ retry:
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+	ret = futex_get_value_locked(&uval, uaddr, flags);
 
 	if (ret) {
 		futex_q_unlock(*hb);


