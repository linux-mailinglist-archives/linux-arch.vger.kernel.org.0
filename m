Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD85AD2D4
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbiIEMeF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiIEMdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:33:07 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F261B0A
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:27:00 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id i6-20020a05640242c600b00447c00a776aso5852914edc.20
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=qWMR0SPZO0jqHHxoNfMsk5w/9uuaYeqiCUk8OeqbWGY=;
        b=MCXD5lbAQVcPgT/EOdvK/WVt9NS7Tehk6H0aVaS8GX3ikViotqPCRrmdoTTCXIhr5J
         N8bepvbPPvSbhZ8S0DmGK9sFHZlcXZ31hLA7G3xuzIyLsP7X5LFnKWatBqYu/WyuYeav
         k7/a9IJ5CxBv/ClbXm8jzN0Wty3J801Voam2e3glQZTv/b9+9CyLW+e+qo77yLiBc3q4
         tLOthnqhOsLvn/SWDpHT5+mmNbEUNHIB8pgYXGWJNleqraHhVXBzpssmWKCcJwIEj3HJ
         SW6L9kIN8TBi8B5aJM7ga9767Q3PcHiJ21sor8antmuKraDCJSwCtpgLZh65GuT8gSnh
         9ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=qWMR0SPZO0jqHHxoNfMsk5w/9uuaYeqiCUk8OeqbWGY=;
        b=mZxKFdleG/yvUW0ISBt977acyXuq1J2hx55lxreXx28JrUSB42G9wHUrhekUXsjEw+
         ybus2Qji/EeMvZdm+nKSSzmq2+OAiPb6FtPLqwydWYJEqJxxYjtVHL2uhQH9b4Se7vll
         RJ+DzSeCHXucLZTChe5rVe2yRKbWNDQiz6c039Cy3g5y4CwxVwV0tkEOtsmP3qeuFJNf
         L4ShUVnAsCkZS2hfcRQkKeLDcyqgG4IMSaBw8H9S3/+QvZ98FasWX8kgzct8+e9Ta+Ut
         ZLwVaKPASgNEUJUhCbRUWq1Lxx3mbH6wvMZpoaKDQ/u2PJbyRskUM1Xm79gDCkeobHXd
         poIw==
X-Gm-Message-State: ACgBeo2tIr436KOeRQVsB1JYTKwqJlPGebwNcQk6Bdzy+XZc+90F57yn
        UKK4FkEXrnbSST9jnp/ypSAOERgaIWI=
X-Google-Smtp-Source: AA6agR5SRqMCINjkMuIrD7WXHVNS75SNahzGJoh0jVbnVtc6SNEh0M27/BA2cqVS6mxm7vNN9nbOSPJjvGE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:2c74:b0:741:657a:89de with SMTP id
 ib20-20020a1709072c7400b00741657a89demr26824523ejc.58.1662380819269; Mon, 05
 Sep 2022 05:26:59 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:52 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-45-glider@google.com>
Subject: [PATCH v6 44/44] x86: kmsan: enable KMSAN builds for x86
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.37.2.789.g6183377224-goog

