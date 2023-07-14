Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260D753CD6
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjGNOQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNOQf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852912E;
        Fri, 14 Jul 2023 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GuDJ92pMIScKKU1gBauDG1HK4VUsLXyIVGMSjzGcY4Y=; b=vBKCfPzsXlmZQm0fbY9sm4XN73
        kHbqhYPRg24KF+nwElURpqsTJDlryKmDUOG3hRkpWvd0PhoT+M+UUAAfZagygwwYN+EQF96rxRzwh
        y6Ksh55FaQO2qES2eZnYAQMF0W7I/N7hS39vamjL/ghCgcLWgEwlM2yccrC8KGWmH4aRt4oV3JFNS
        hotzaBdyxJlbgmQPxYdyPurXiCwYhcjscrxIqsdlOamEmJ65hOEFV33r2X0xNYQURheEouIYUgXH7
        LZl2gTROHDF1JASKWhc+5uERTwqfjo5eGhlgZOjCV9CM0JpWWZtTMWyghP3XtRYjLU3AJZkGy2PqC
        A1aFb12A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJah-0016z8-NN; Fri, 14 Jul 2023 14:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B952E301A2F;
        Fri, 14 Jul 2023 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8BA61245EFFAB; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141219.282650897@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [HACK][PATCH 10/10] futex: Munge size and numa into the legacy interface
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

Avert your eyes...

Arguably just the NUMA thing wouldn't be too bad.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/futex.h |   15 ++++++++++++---
 kernel/futex/futex.h       |    9 ++++++++-
 kernel/futex/syscalls.c    |   18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -23,9 +23,18 @@
 #define FUTEX_CMP_REQUEUE_PI	12
 #define FUTEX_LOCK_PI2		13
 
-#define FUTEX_PRIVATE_FLAG	128
-#define FUTEX_CLOCK_REALTIME	256
-#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+#define FUTEX_PRIVATE_FLAG	(1 << 7)
+#define FUTEX_CLOCK_REALTIME	(1 << 8)
+#define FUTEX_NUMA		(1 << 9)
+#define FUTEX_SIZE_32		(0 << 10) /* backwards compat */
+#define FUTEX_SIZE_64		(1 << 10)
+#define FUTEX_SIZE_8		(2 << 10)
+#define FUTEX_SIZE_16		(3 << 10)
+
+#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG	|	\
+				  FUTEX_CLOCK_REALTIME	|	\
+				  FUTEX_NUMA		|	\
+				  FUTEX_SIZE_16)
 
 #define FUTEX_WAIT_PRIVATE	(FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
 #define FUTEX_WAKE_PRIVATE	(FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -39,7 +39,7 @@
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
 {
-	unsigned int flags = FLAGS_SIZE_32;
+	unsigned int sz, flags = 0;
 
 	if (!(op & FUTEX_PRIVATE_FLAG))
 		flags |= FLAGS_SHARED;
@@ -47,6 +47,13 @@ static inline unsigned int futex_to_flag
 	if (op & FUTEX_CLOCK_REALTIME)
 		flags |= FLAGS_CLOCKRT;
 
+	if (op & FUTEX_NUMA)
+		flags |= FLAGS_NUMA;
+
+	/* { 2,3,0,1 } -> { 0,1,2,3 } */
+	sz = ((op + FUTEX_SIZE_8) & FUTEX_SIZE_16) >> 10;
+	flags |= sz;
+
 	return flags;
 }
 
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -95,6 +95,24 @@ long do_futex(u32 __user *uaddr, int op,
 			return -ENOSYS;
 	}
 
+	/* can't support u64 with a u32 based interface */
+	if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
+		return -ENOSYS;
+
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAKE:
+	case FUTEX_WAKE_BITSET:
+		/* u8, u16, u32 */
+		break;
+
+	default:
+		/* only u32 for now */
+		if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+			return -ENOSYS;
+	}
+
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;


