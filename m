Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC15563587
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiGAOaL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGAO3I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:08 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C46B83B
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m8-20020a056402430800b00435cfa7c6d1so1889155edc.9
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=auy4Z9/QbdBH93W7clb5ShO/bvtQNUkdCMoxr4yxtk4=;
        b=TJFxAn5Ss516YvoMDGVEwjUVJwMCvGA1uys6DFajPPpbZIMmu2QzyGWPOotDWBpn+r
         rgIkzih/ujs5bTKljPLwUBtpQa/dNgrfp0MBxT1kb+eKYfRAVyELcJtbxVB7958xF9rm
         Zk0fIJMREitsgbyi1gy837q4R1mHa+3JGBT6oi1Hs5AApXttsWy/csNFxBANvSau0uZu
         me+bQ66jrcYrfHdDel7oJAdmULEw4S6O18cufBNY46EF+SYvAbZhuw7DOE9ygaIc+DUH
         epOsUEkbVsljZQLqnxiEbG1wf8XSFU+0Q/2K/o1oN5f4fsTtQ+6GgHHmMLvBksi3ftZb
         I9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=auy4Z9/QbdBH93W7clb5ShO/bvtQNUkdCMoxr4yxtk4=;
        b=dVbjNQRx/hxVgm/ThdYPMqHSaxdNuEhQw9tcnWRsWNGeANzWttxen2eFL3Dq63HLND
         9HeQRDmU+DUO2Apry4pizPpCF5QcJ0AYJadoqSulQ5ME+tDqabPhiVjkik+fW3o4sSqU
         t+Mbo7rGhw4r5pxZezwlg0ns7DlhFM7OYT5W+Qd+nHJ6fe5bYei8DA3JX1YPlYk9O/Mr
         2cl1y420Kl+8U9Wdu3QCmaiUjZ1DwLRngoBAUZZzZexshgGCqd8K3EuKrJ1m5fRvdsA4
         Bqn/Op1dzyhNRujcI4vNm0JI5Cnm8J0e3FUo9GAjDqPaBdhYzRXrYB29j2A9tocAf94M
         QuVQ==
X-Gm-Message-State: AJIora/VB1Womj99t0K/vN+exVcftcFa4IiTx/BYdCvnAhAZ3peBosG6
        mnzj1CUWsx7xw5ffltUTA8tTdT8WIsk=
X-Google-Smtp-Source: AGRyM1sPr6BbVcj2G+ZB+lPBZAJjGton9fbZSyRJE7DwNhWSxx5v5nK5h5ZIpUkHajs/dx3CGzAw9kjasBQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:4408:b0:435:9ed2:9be with SMTP id
 y8-20020a056402440800b004359ed209bemr18990092eda.81.1656685521229; Fri, 01
 Jul 2022 07:25:21 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:10 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-46-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 45/45] x86: kmsan: enable KMSAN builds for x86
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make KMSAN usable by adding the necessary Kconfig bits.

Also declare x86-specific functions checking address validity
in arch/x86/include/asm/kmsan.h.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v4:
 -- per Marco Elver's request, create arch/x86/include/asm/kmsan.h
    and move arch-specific inline functions there.

Link: https://linux-review.googlesource.com/id/I1d295ce8159ce15faa496d20089d953a919c125e
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/kmsan.h | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/x86/include/asm/kmsan.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aadbb16a59f01..d1a601111b277 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -169,6 +169,7 @@ config X86
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
new file mode 100644
index 0000000000000..a790b865d0a68
--- /dev/null
+++ b/arch/x86/include/asm/kmsan.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * x86 KMSAN support.
+ *
+ * Copyright (C) 2022, Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ */
+
+#ifndef _ASM_X86_KMSAN_H
+#define _ASM_X86_KMSAN_H
+
+#ifndef MODULE
+
+#include <asm/processor.h>
+#include <linux/mmzone.h>
+
+/*
+ * Taken from arch/x86/mm/physaddr.h to avoid using an instrumented version.
+ */
+static inline bool kmsan_phys_addr_valid(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		return !(addr >> boot_cpu_data.x86_phys_bits);
+	else
+		return true;
+}
+
+/*
+ * Taken from arch/x86/mm/physaddr.c to avoid using an instrumented version.
+ */
+static inline bool kmsan_virt_addr_valid(void *addr)
+{
+	unsigned long x = (unsigned long)addr;
+	unsigned long y = x - __START_KERNEL_map;
+
+	/* use the carry flag to determine if x was < __START_KERNEL_map */
+	if (unlikely(x > y)) {
+		x = y + phys_base;
+
+		if (y >= KERNEL_IMAGE_SIZE)
+			return false;
+	} else {
+		x = y + (__START_KERNEL_map - PAGE_OFFSET);
+
+		/* carry flag will be set if starting x was >= PAGE_OFFSET */
+		if ((x > y) || !kmsan_phys_addr_valid(x))
+			return false;
+	}
+
+	return pfn_valid(x >> PAGE_SHIFT);
+}
+
+#endif /* !MODULE */
+
+#endif /* _ASM_X86_KMSAN_H */
-- 
2.37.0.rc0.161.g10f37bed90-goog

