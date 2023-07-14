Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296AB753CF1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjGNOQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjGNOQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7230C8;
        Fri, 14 Jul 2023 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=50j8lu0fq8DZ70IkYc8oVFT5B2TMdBpxV7U6GuBpl7Q=; b=RAyQOPIKt+lXLX555aDpPJzUC9
        L7EOxKUfSVd10nX0K16zDGniwOxKc30Cd/+xG8LzFUBBkCLdSF5xP40Cevv5Y/l6dyWqJa+dVphas
        6Gr3l8Rz6zoUJVtRlBiLy943qRAqpj/vIhSitOCh6gTyqaAbRgo3JiXP+Dc7K9WePvtmFiCyQfKj8
        RCN4PcykMUeb1gdeFB8LRCRweSK248CKdk4wGCboxrybdoWYOf/v45Z/R/lBU7b2/xNeycJx/kjtz
        pIi/tFYgUgJFMSvi1VEusccqOJXl+n6NkSpusiNz4nBzjjmriQXxNwJcJZ5QOUmUYPapDvpPLr6Ya
        W0DmGT1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJah-006Iix-2B;
        Fri, 14 Jul 2023 14:16:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B27AC300E86;
        Fri, 14 Jul 2023 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8732D245EFFAA; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141219.215288670@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 09/10] futex: Enable FUTEX2_{8,16}
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

When futexes are no longer u32 aligned, the lower offset bits are no
longer available to put type info in. However, since offset is the
offset within a page, there are plenty bits available on the top end.

After that, pass flags into futex_get_value_locked() for WAIT and
disallow FUTEX2_64 instead of mandating FUTEX2_32.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/futex.h   |   11 ++++++-----
 kernel/futex/syscalls.c |    4 ++--
 kernel/futex/waitwake.c |    4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

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
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -206,7 +206,7 @@ static int futex_parse_waitv(struct fute
 		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
+		if ((aux.flags & FUTEX2_64) == FUTEX2_64)
 			return -EINVAL;
 
 		flags = futex2_to_flags(aux.flags);
@@ -334,7 +334,7 @@ SYSCALL_DEFINE4(futex_wake,
 	if (flags & ~FUTEX2_MASK)
 		return -EINVAL;
 
-	if ((flags & FUTEX2_64) != FUTEX2_32)
+	if ((flags & FUTEX2_64) == FUTEX2_64)
 		return -EINVAL;
 
 	flags = futex2_to_flags(flags);
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -439,7 +439,7 @@ static int futex_wait_multiple_setup(str
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+		ret = futex_get_value_locked(&uval, uaddr, flags);
 
 		if (!ret && uval == val) {
 			/*
@@ -607,7 +607,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+	ret = futex_get_value_locked(&uval, uaddr, flags);
 
 	if (ret) {
 		futex_q_unlock(*hb);


