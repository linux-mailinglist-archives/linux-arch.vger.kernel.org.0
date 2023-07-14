Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC7753CE9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjGNOQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjGNOQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068430C6;
        Fri, 14 Jul 2023 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QqRA1A/aeG7Vp+frAisWOweSXHDCgPVqvl/Ov07GdYA=; b=keXvIPEO22MCTYT4gVabzMzK4E
        7zZ4B7VY3kbDqlVMOrYGQfJiEOSPC6TYRJwwLI4z77Mas0c6YAf8GNXbwWcnhfyKRjasvonlAqnBW
        +mJC9B+tXoPm19KZVSUqRxMF7xg73W6zJrsVfUwVqdzrEHWjFQnujsu33OkbGmCFyJwnz5GZzDle7
        H9739utpS0sI3pEmgP1kgng0pbxnX6+lYHnPrWYSOAAt7it9tZSJbJHoOuUD8hx0g3LLH0uPTvNvE
        LhxvjVH8fIzku5xDR10iHOMR6yvT3U+fPYGSL56BOtfdNaCpQgl9mBurFiJ50dh/4e4oPwLfZQc2k
        fcIiaoxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJah-006Iiv-21;
        Fri, 14 Jul 2023 14:16:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A22C4300513;
        Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5EA7E200D83A3; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141218.679746713@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 01/10] futex: Clarify FUTEX2 flags
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

sys_futex_waitv() is part of the futex2 series (the first and only so
far) of syscalls and has a flags field per futex (as opposed to flags
being encoded in the futex op).

This new flags field has a new namespace, which unfortunately isn't
super explicit. Notably it currently takes FUTEX_32 and
FUTEX_PRIVATE_FLAG.

Introduce the FUTEX2 namespace to clarify this

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/futex.h |   16 +++++++++++++---
 kernel/futex/syscalls.c    |    7 +++----
 2 files changed, 16 insertions(+), 7 deletions(-)

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -44,10 +44,20 @@
 					 FUTEX_PRIVATE_FLAG)
 
 /*
- * Flags to specify the bit length of the futex word for futex2 syscalls.
- * Currently, only 32 is supported.
+ * Flags for futex2 syscalls.
  */
-#define FUTEX_32		2
+			/*	0x00 */
+			/*	0x01 */
+#define FUTEX2_32		0x02
+			/*	0x04 */
+			/*	0x08 */
+			/*	0x10 */
+			/*	0x20 */
+			/*	0x40 */
+#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
+
+/* do not use */
+#define FUTEX_32		FUTEX2_32 /* historical accident :-( */
 
 /*
  * Max numbers of elements in a futex_waitv array
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,8 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-/* Mask of available flags for each futex in futex_waitv list */
-#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
+#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -205,10 +204,10 @@ static int futex_parse_waitv(struct fute
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
 
-		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
+		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX_32))
+		if (!(aux.flags & FUTEX2_32))
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


