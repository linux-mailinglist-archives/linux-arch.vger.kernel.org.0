Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39631772433
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjHGMhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHGMhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735BD10F7;
        Mon,  7 Aug 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=q2JUuQQkf4QJ5HlnBdmZO9ANv9VK51IAZht4p6DhAtU=; b=X2O67bPGappPJwoyYOLJli/2uq
        GGSmNYvPLgZVt2/X3Hmrqu1CS1Zl85dYxPspA117dnFShAiy3LcGcjLWdXZTycTNRrU1JneiRVLRn
        tF26dsEBGwIqCOIot1HFOrI/Fk0gDY8+KE/QG3B9WI9TIXDwsOozljsjh74EFJdAZuM4h9/nbE9Vh
        o24zKa2EFC2UIQkKpr0RLuefzcIEbbl+sipU4Ta6NRRJkYkadodRotAl0POJj4WwsxnQYnjlHSVmi
        cOmGBvprufkD87jLIhKiDB9kt5z1Z/WQKyHaXTVD1+6Jkq1ILqtyz/ZnZFh/da1aKf1GrYhBTezjK
        bl271Qeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSzTl-00AxGL-Gr; Mon, 07 Aug 2023 12:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37457303463;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C5FE42021B5CF; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.641470179@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 13/14] futex: Enable FUTEX2_{8,16}
References: <20230807121843.710612856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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


