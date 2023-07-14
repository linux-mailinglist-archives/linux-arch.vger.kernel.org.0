Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B0753CDA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjGNOQh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjGNOQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8E30C0;
        Fri, 14 Jul 2023 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JH41pDo7+Jk4qffVzaO2p6sCO6Nd3BbMmWUDDzgZdtk=; b=svWkhtHF2Xpvm5S2/jG0ESgpOR
        TrBT7MXzx1VRkZJl6Z6JFy0pTLtfdLkAEIKsOMTFwQdkIcyy7ECVjFqE40I2iJe1vrTASfja+qtM8
        WDZzYWTGTFQE6iD8ojO/zPWX2v5OoL4npt+I6MnajImZXMT3MMTG8Etf217dclTq1BWGZGQyPj8vI
        cckrPl4lyNHyA0T5FPLyqSrU5OeSoDbhmhEhc3Q+AzAlgex4F5uq1gNKB6i32P1QVfvRGn5o+/Qo9
        SmMRrS031NkgiHkFCkG/Lg0t6+kVO2fNi2Q9P/DCCL+60sQ/32+jDCeaEmgLQ+HU5c+7wxd2+P8im
        H4FxABfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJah-0016z2-4F; Fri, 14 Jul 2023 14:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3DB730057E;
        Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 60EA0213728AD; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141218.746077262@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 02/10] futex: Extend the FUTEX2 flags
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

Add the definition for the missing but always intended extra sizes,
and add a NUMA flag for the planned numa extention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/futex.h |    7 ++++---
 kernel/futex/syscalls.c    |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -46,10 +46,11 @@
 /*
  * Flags for futex2 syscalls.
  */
-			/*	0x00 */
-			/*	0x01 */
+#define FUTEX2_8		0x00
+#define FUTEX2_16		0x01
 #define FUTEX2_32		0x02
-			/*	0x04 */
+#define FUTEX2_64		0x03
+#define FUTEX2_NUMA		0x04
 			/*	0x08 */
 			/*	0x10 */
 			/*	0x20 */
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
+#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -207,7 +207,7 @@ static int futex_parse_waitv(struct fute
 		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX2_32))
+		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


