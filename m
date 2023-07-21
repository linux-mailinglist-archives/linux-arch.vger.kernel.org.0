Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7575C544
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGULBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGUK7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC830DF;
        Fri, 21 Jul 2023 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0OvZxrAbgKVueqnrMDc9zKBhn7N/Qfvk936XgBKJyzg=; b=i2Up1YJcKcROlG2uFhIm/PX3JM
        XmlM0nBGqzdATbwc0H09VZ4Cnh28vJg3gQOTltByte8iuH6Doc2RaXszR9lHG4kvFIGJJ7W8H5u/e
        bFZXkUBflexyC8HwKIqTbUu/hCXdg+ZR4N7D+3IhTuTXVMXpw/H5F+Y4sFf3mGjPs8gV+Wg/wXPQU
        auZ5VYpTsbYWOiqTa9O8AQdfIMeuFhCgw0ckRubRkc2RdCsKMQJOvA8lWutJRkeIHIFfq+UWvjmHB
        WRe2YxzC3uS4F95VTLdcSyWaobmiuIWCw3CI75xItB4KbRIk0Bx9vSmZ7/5xQGQg6WGzQCoDF2zPY
        PznX7d1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMnqK-0000Kz-0r;
        Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31D30300886;
        Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB8D2314E02F2; Fri, 21 Jul 2023 12:58:37 +0200 (CEST)
Message-ID: <20230721105743.819362688@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
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

Add the definition for the missing but always intended extra sizes,
and add a NUMA flag for the planned numa extention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/futex.h |    7 ++++---
 kernel/futex/syscalls.c    |    9 +++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

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
@@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
 		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX2_32))
+		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
+				return -EINVAL;
+		}
+
+		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;


