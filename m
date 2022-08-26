Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC55A2AE5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiHZPQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbiHZPPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:15:42 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E451DCFC5
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:20 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id k13-20020a2ea28d000000b00261d461fad4so661969lja.23
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=fxlXGK8qL+YVfFcW6ClvjL4YS8Ri9qaHIYNR2qoUuzA=;
        b=Q8VLjQ5xsWoRQwcBX26q4ZfJywgvwwYMqm7WRIZT/igOO0C+hQHvWJdj6bKE/htghx
         DrY+lrNXNEbosReTbTCbvhlRqJK2QXAnzf9wyBVGEBrx0xxr82tqOecv4nBtt+ZxQ/yz
         olXwbcf4S8A0zqAksvcEzulatqIcfYttRp+CQJcmIHJmyH6BPQSBoduAFmbbmZi1yVjp
         Tg6Bb8K5bppJxRqKIw0j6if6T//cGZVzeA7QuH2nxxvPggC9uSXoPvQi5rO7W7h+JR7N
         w+bOFVhYur+hDrR+w9sC1KCjIT/m0VnGKDSplsMs4+EUNYFwUHkEBbvxDpMspo6USKZQ
         VmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=fxlXGK8qL+YVfFcW6ClvjL4YS8Ri9qaHIYNR2qoUuzA=;
        b=MufdYJevDtgQL6i7wuHKeH20iDbiJaBriRJg+n6MP2VxLvLWwz/GkBxy6gEloQ9wlv
         a1egaieKHvr8zFceHe0fKDmIFbQUVSkPRjayUCb4LFNTVu22QuZ0/PHJz6MVx/cPGmE0
         Qmd8+gNSTJyVJwCSikrh36P5adGa2t246hOlUC3TwX33hEcSdUXJwX3LWlAPVs0QAot/
         qe+UIgadWkJrG8uYlKsIbQey29YFkoiINhwa3H4R9MHKbWmldkeXNfjypbKKGHerEDR9
         qylz6zcC9aut+HC+XJV8yJ3bK57IyvdNiOKL/Nni5EjbPsFVwDLT8vMqVE2XfWyoMWgG
         rF7A==
X-Gm-Message-State: ACgBeo2hwa2PPjmbM35Zu0+Ol8iR3Y7x9RYsU+ybTkmouf/ReLxbCoVl
        JfSjjvI94tHYA0Nus4TTgRGt/haYnW0=
X-Google-Smtp-Source: AA6agR4ts2QVsl2UWCVwazOIhjWaaZlRudAXUf4/lJNteJtVBKT5mB6+2t9fiOdhKBlLEptewn0gZtbEsjs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a19:e012:0:b0:492:bec1:7f9d with SMTP id
 x18-20020a19e012000000b00492bec17f9dmr2498937lfg.585.1661526615782; Fri, 26
 Aug 2022 08:10:15 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:07 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-45-glider@google.com>
Subject: [PATCH v5 44/44] x86: kmsan: enable KMSAN builds for x86
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
index 697da8dae1418..bd9436cd0f29b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -168,6 +168,7 @@ config X86
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
2.37.2.672.g94769d06f0-goog

