Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5077242A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjHGMhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGMhS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685810F2;
        Mon,  7 Aug 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=53jHvCThY56ekVsZwPC+RAqN66FMg8fPTI36UoUqaKU=; b=eqmLvazGl7vBH7qJgPl+mV8Rn1
        Db9gNWnIQZ6A9f+8x4iCTa3tOp45OF1tMlCfJCzFVwpufed2L7Syzuc7UOY9iih9D4mimwCVtlcDQ
        5FAN+SfFoNcoZgnC0ba/iDFxh6N7opePHRF2GS1XFSgF6jwb1TdsPczXS237JH48Uo2hQM6B4//4N
        5GuRLi7XiTPgNCyPEcQw5aln/fT+PUo0QdWUVkjjAyoUG6MzYF3TqTPqdrdvCZsTN9LYGFKD0FGFf
        TQK0/YtXVD4x9hkj8ivhhhRiVCQ2Rx4zxOsKNOlw0CNxd3aDi11330mX1Q9ng36kvGJP2ha83Y9ht
        EjcAsWdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSzTk-00AxFz-Rv; Mon, 07 Aug 2023 12:36:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D39913005A2;
        Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8A81C2021C3D4; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123322.814039156@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 01/14] futex: Clarify FUTEX2 flags
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

sys_futex_waitv() is part of the futex2 series (the first and only so
far) of syscalls and has a flags field per futex (as opposed to flags
being encoded in the futex op).

This new flags field has a new namespace, which unfortunately isn't
super explicit. Notably it currently takes FUTEX_32 and
FUTEX_PRIVATE_FLAG.

Introduce the FUTEX2 namespace to clarify this

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
+#define FUTEX2_SIZE_U32		0x02
+			/*	0x04 */
+			/*	0x08 */
+			/*	0x10 */
+			/*	0x20 */
+			/*	0x40 */
+#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
+
+/* do not use */
+#define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
 
 /*
  * Max numbers of elements in a futex_waitv array
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,8 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-/* Mask of available flags for each futex in futex_waitv list */
-#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -205,10 +204,10 @@ static int futex_parse_waitv(struct fute
 		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
 			return -EFAULT;
 
-		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
+		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX_32))
+		if (!(aux.flags & FUTEX2_SIZE_U32))
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


