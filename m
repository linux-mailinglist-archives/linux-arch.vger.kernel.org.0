Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D2772440
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHGMh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjHGMhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7A10FD;
        Mon,  7 Aug 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VeisDNjC4AzLF+2mqHFPpkzGGrK09hiTJOlUvJPWkc0=; b=Y0Ic2ASPfM4zwCf8njfDLQ9TfI
        OuHwsWViCbzS/XDUIJxYEuz+6570rMjB76ialdlDvBGnoZ5f0lGB/AZPHEL1zLVvE+0SXP3E9NKXG
        aChDsIyEWqNqEjGtk0KBEbmdyoBkO60j1QC7lLf0GPh1j3ArPWtOzZPV1lbRjDAWphs19H93MFN/Y
        TuDXZNeMFZiuB7FXopYB4UqHciRVwN4uVfSTNPU0z/3z4PBBCn6Q/8fMMasBpNmDC+gK3mHnZENIx
        4WJRUxHLhoH2oxp5n9XSV6JwbcpNwv/1h/idKQawLI7xtQnn4TDuz8SQ4B7D5AQpkC0GsM4dn+LC8
        mUPicgtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzTk-003oSe-1T;
        Mon, 07 Aug 2023 12:36:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D56643006F1;
        Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 902A920236021; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123322.883413972@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 02/14] futex: Extend the FUTEX2 flags
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

Add the definition for the missing but always intended extra sizes,
and add a NUMA flag for the planned numa extention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/futex.h |   21 ++++++++++++++++++---
 kernel/futex/syscalls.c    |    9 +++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -45,17 +45,32 @@
 
 /*
  * Flags for futex2 syscalls.
+ *
+ * NOTE: these are not pure flags, they can also be seen as:
+ *
+ *   union {
+ *     u32  flags;
+ *     struct {
+ *       u32 size    : 2,
+ *           numa    : 1,
+ *                   : 4,
+ *           private : 1;
+ *     };
+ *   };
  */
-			/*	0x00 */
-			/*	0x01 */
+#define FUTEX2_SIZE_U8		0x00
+#define FUTEX2_SIZE_U16		0x01
 #define FUTEX2_SIZE_U32		0x02
-			/*	0x04 */
+#define FUTEX2_SIZE_U64		0x03
+#define FUTEX2_NUMA		0x04
 			/*	0x08 */
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
 #define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
 
+#define FUTEX2_SIZE_MASK	0x03
+
 /* do not use */
 #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
 
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
 		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX2_SIZE_U32))
+		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_SIZE_U64)
+				return -EINVAL;
+		}
+
+		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_SIZE_U32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


