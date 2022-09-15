Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C05B9E33
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIOPG2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiIOPFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:05:47 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04075EDC6
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:03 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so7695020ejc.13
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PTsTfo/gJDV7iQzWmhln0w3yo3kBxDNSc9M3IZOTBoE=;
        b=JPgXbB5IFWEFHgGxJgBDcBqsn7OA+OOmod3TkAJCtmEW3tmDIEAaPKco4V3rSfeVUT
         GdXM8f5AP9MppFWIxBTCdhy9ugH7naOnesHXUn34A53RkPodiqw3X1l45i+8mKggb98k
         Rfas/CBCSU/l2+KKyy5Yy+k2HFZReEtFK6RUw8luzU4yWnpDATvBrwpXvH5uKPEFz/CY
         fMEUsRqiEpjIjSm6svk+PcgL/IEq9k1aaJenW+l4RBh8IWYn4eFeXv42PrPIL6LXSCM+
         D6Wc5KgbtUAixY99TEj/8stcJrQCa9sE6zMp90t6pz7+Avl4xRSk9+TMfjnHy6he5k4v
         4d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PTsTfo/gJDV7iQzWmhln0w3yo3kBxDNSc9M3IZOTBoE=;
        b=heVmeSrPuHzOLWUyPddC1IZHk+ZyqzX/xq4IzD6sAA9FVWUj2sAAE4uhj+XoWGRmvJ
         N57iytwKrVo0d8bHg4ejBmhzB7juTHtm9yI2g1zNPJuSo5NwNH/DuMMmDXIgS3GPrnBk
         4u4Oq3jc87lPlvbvo7lIIgPLRHRz4ybYP1/Jwr3+OXllFD2CXoBIONHZdaHp3ifgzB6P
         YBJJN09S1uBfH1GUa/ltH72oMFAIShVGvFDjGU76sLWS1Rbs9x6wfrlhMgsYpEID7j0X
         G0S4G/LJcdkf+Ln6YJmcUjaafcDJy8mh5YtDGnhQljMhPqgnOcIl1uKs2gasTGJHKkEZ
         x/jw==
X-Gm-Message-State: ACrzQf3q4Nmvi15N1WmcbJDwr2HWgg9+F0+wXNROIBZ1qxnNV6hZ4mvX
        4JD44HmE5JyHvFD97tko1zHstmOFqRc=
X-Google-Smtp-Source: AMsMyM4p6KqskMugQKLr3d2QoJoMFJ9ItcCVTDioHI8BQ0089p953E4XlBHrGmtCk9sUiS5VpTwgREGXwKI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:2cce:b0:77a:6958:5aaa with SMTP id
 hg14-20020a1709072cce00b0077a69585aaamr280253ejc.245.1663254303074; Thu, 15
 Sep 2022 08:05:03 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:43 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-10-glider@google.com>
Subject: [PATCH v7 09/43] x86: kmsan: pgtable: reduce vmalloc space
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
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN is going to use 3/4 of existing vmalloc space to hold the
metadata, therefore we lower VMALLOC_END to make sure vmalloc() doesn't
allocate past the first 1/4.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- added x86: to the title

v5:
 -- add comment for VMEMORY_END

Link: https://linux-review.googlesource.com/id/I9d8b7f0a88a639f1263bc693cbd5c136626f7efd
---
 arch/x86/include/asm/pgtable_64_types.h | 47 ++++++++++++++++++++++++-
 arch/x86/mm/init_64.c                   |  2 +-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 70e360a2e5fb7..04f36063ad546 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -139,7 +139,52 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
-#define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
+/*
+ * End of the region for which vmalloc page tables are pre-allocated.
+ * For non-KMSAN builds, this is the same as VMALLOC_END.
+ * For KMSAN builds, VMALLOC_START..VMEMORY_END is 4 times bigger than
+ * VMALLOC_START..VMALLOC_END (see below).
+ */
+#define VMEMORY_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
+
+#ifndef CONFIG_KMSAN
+#define VMALLOC_END		VMEMORY_END
+#else
+/*
+ * In KMSAN builds vmalloc area is four times smaller, and the remaining 3/4
+ * are used to keep the metadata for virtual pages. The memory formerly
+ * belonging to vmalloc area is now laid out as follows:
+ *
+ * 1st quarter: VMALLOC_START to VMALLOC_END - new vmalloc area
+ * 2nd quarter: KMSAN_VMALLOC_SHADOW_START to
+ *              VMALLOC_END+KMSAN_VMALLOC_SHADOW_OFFSET - vmalloc area shadow
+ * 3rd quarter: KMSAN_VMALLOC_ORIGIN_START to
+ *              VMALLOC_END+KMSAN_VMALLOC_ORIGIN_OFFSET - vmalloc area origins
+ * 4th quarter: KMSAN_MODULES_SHADOW_START to KMSAN_MODULES_ORIGIN_START
+ *              - shadow for modules,
+ *              KMSAN_MODULES_ORIGIN_START to
+ *              KMSAN_MODULES_ORIGIN_START + MODULES_LEN - origins for modules.
+ */
+#define VMALLOC_QUARTER_SIZE	((VMALLOC_SIZE_TB << 40) >> 2)
+#define VMALLOC_END		(VMALLOC_START + VMALLOC_QUARTER_SIZE - 1)
+
+/*
+ * vmalloc metadata addresses are calculated by adding shadow/origin offsets
+ * to vmalloc address.
+ */
+#define KMSAN_VMALLOC_SHADOW_OFFSET	VMALLOC_QUARTER_SIZE
+#define KMSAN_VMALLOC_ORIGIN_OFFSET	(VMALLOC_QUARTER_SIZE << 1)
+
+#define KMSAN_VMALLOC_SHADOW_START	(VMALLOC_START + KMSAN_VMALLOC_SHADOW_OFFSET)
+#define KMSAN_VMALLOC_ORIGIN_START	(VMALLOC_START + KMSAN_VMALLOC_ORIGIN_OFFSET)
+
+/*
+ * The shadow/origin for modules are placed one by one in the last 1/4 of
+ * vmalloc space.
+ */
+#define KMSAN_MODULES_SHADOW_START	(VMALLOC_END + KMSAN_VMALLOC_ORIGIN_OFFSET + 1)
+#define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
+#endif /* CONFIG_KMSAN */
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0fe690ebc269b..39b6bfcaa0ed4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1287,7 +1287,7 @@ static void __init preallocate_vmalloc_pages(void)
 	unsigned long addr;
 	const char *lvl;
 
-	for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+	for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
 		pgd_t *pgd = pgd_offset_k(addr);
 		p4d_t *p4d;
 		pud_t *pud;
-- 
2.37.2.789.g6183377224-goog

