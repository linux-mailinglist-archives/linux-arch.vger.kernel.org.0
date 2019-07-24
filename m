Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D473F11
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2019 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfGXU3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 16:29:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45554 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389675AbfGXU3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2019 16:29:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so34793625qkj.12
        for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2019 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jMuXZCkU9Ct89wOn6NBnDyHgJz0Yj3VpJrE3krYoMBo=;
        b=Y8l89H10hDJOBdtg0LtWprl/ct7QZfhT5686p+b9YXoN+oy3Eclg3xjZXguHL3KwmO
         abUyx4EoNNPkVVU0UByMLrD6y7rbBUYgi4E3RQTBS+z94H/nZiuLXHMLAIWoui/4bUlG
         PnOwXPkgW2UZbhsNwQW7pkaX5YGilXWuOsloqeV9lUjsAB5aRFrEvXvwgp1wTqFrQ5O5
         g1sz3KrIkBtUt7opmlF21wev+CI73210Iu930+Biwds/yzbhGeNO7TMcZPbQ5q4pZb2A
         WmUz2zd/8AtntvDiB3BIrPjWuzlzNdxRPx/fCF+GhdkaF562DDlA746+0Fk4qMHUBFiJ
         9BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jMuXZCkU9Ct89wOn6NBnDyHgJz0Yj3VpJrE3krYoMBo=;
        b=g/kpjG9Z3ftVZz/ywH7/F7Ya7p/APk3ON53V7I0+DUN2uNhsI0msgT0TA80N8kB6rM
         6+NM7fiEhVmjHXdo3T+ImrFQpMgetjvwPbzg3lQPuSVpepRN59NjVm12/nZYjmhYmWji
         9BS8wENiC7mb2IHycYwBTT3OVH80j1cRCWxFQhHnsU17njvmtnqZuLf2cqUSG1Y5BEis
         8b/545vDX5vqvdX9OCBt/kNHscxeJ3xJxSE2poLhqBag12NqBMvgURjZBu8aIQWqW43F
         n0cseNJKMjVVgu4WXJjUJQzCQJXNAnywJuaoGGBYfyhuYCPBThreMdhYtGTok3KYsayo
         oxGQ==
X-Gm-Message-State: APjAAAW3SDDb36d/ESFmrNz0UZcHSlRVlihixEbykHHglXH2RNEOwDck
        oNCKGZjy4t0p/yCIJg+Y6aveDg==
X-Google-Smtp-Source: APXvYqw9LTSo4+/ExlpXauIFR9jBl5GdjmT+cEkMwOIsoifwY6EF1GRlgatrSdGiKHpe4HSQVmcY2g==
X-Received: by 2002:a05:620a:10bc:: with SMTP id h28mr55522007qkk.289.1564000181815;
        Wed, 24 Jul 2019 13:29:41 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r205sm24529121qke.115.2019.07.24.13.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 13:29:41 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com,
        ndesaulniers@google.com, morbo@google.com, jyknight@google.com,
        natechancellor@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] asm-generic: fix -Wtype-limits compiler warnings
Date:   Wed, 24 Jul 2019 16:29:26 -0400
Message-Id: <1564000166-31428-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
compilation warning because "rx_frag_size" is an "ushort" while
PAGE_SHIFT here is 16. The commit changed the get_order() to be a
multi-line macro where compilers insist to check all statements in the
macro even when __builtin_constant_p(rx_frag_size) will return false as
"rx_frag_size" is a module parameter.

In file included from ./arch/powerpc/include/asm/page_64.h:107,
                 from ./arch/powerpc/include/asm/page.h:242,
                 from ./arch/powerpc/include/asm/mmu.h:132,
                 from ./arch/powerpc/include/asm/lppaca.h:47,
                 from ./arch/powerpc/include/asm/paca.h:17,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./arch/powerpc/include/asm/processor.h:39,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
drivers/net/ethernet/emulex/benet/be_main.c: In function
'be_rx_cqs_create':
./include/asm-generic/getorder.h:54:9: warning: comparison is always
true due to limited range of data type [-Wtype-limits]
   (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
         ^
drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
of macro 'get_order'
  adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
                                 ^~~~~~~~~

Fix it by moving all of this multi-line macro into a proper function,
and killing __get_order() off.

Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Kill off __get_order() per Andrew.
    Update the comments per David.
    Remove a variable "order" to be consistent with the rest of return
    statements.

 include/asm-generic/getorder.h | 50 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index c64bea7a52be..e9f20b813a69 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -7,24 +7,6 @@
 #include <linux/compiler.h>
 #include <linux/log2.h>
 
-/*
- * Runtime evaluation of get_order()
- */
-static inline __attribute_const__
-int __get_order(unsigned long size)
-{
-	int order;
-
-	size--;
-	size >>= PAGE_SHIFT;
-#if BITS_PER_LONG == 32
-	order = fls(size);
-#else
-	order = fls64(size);
-#endif
-	return order;
-}
-
 /**
  * get_order - Determine the allocation order of a memory size
  * @size: The size for which to get the order
@@ -43,19 +25,27 @@ int __get_order(unsigned long size)
  * to hold an object of the specified size.
  *
  * The result is undefined if the size is 0.
- *
- * This function may be used to initialise variables with compile time
- * evaluations of constants.
  */
-#define get_order(n)						\
-(								\
-	__builtin_constant_p(n) ? (				\
-		((n) == 0UL) ? BITS_PER_LONG - PAGE_SHIFT :	\
-		(((n) < (1UL << PAGE_SHIFT)) ? 0 :		\
-		 ilog2((n) - 1) - PAGE_SHIFT + 1)		\
-	) :							\
-	__get_order(n)						\
-)
+static inline __attribute_const__ int get_order(unsigned long size)
+{
+	if (__builtin_constant_p(size)) {
+		if (!size)
+			return BITS_PER_LONG - PAGE_SHIFT;
+
+		if (size < (1UL << PAGE_SHIFT))
+			return 0;
+
+		return ilog2((size) - 1) - PAGE_SHIFT + 1;
+	}
+
+	size--;
+	size >>= PAGE_SHIFT;
+#if BITS_PER_LONG == 32
+	return fls(size);
+#else
+	return fls64(size);
+#endif
+}
 
 #endif	/* __ASSEMBLY__ */
 
-- 
1.8.3.1

