Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50E56357B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiGAO3G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiGAO10 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:27:26 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905B3B02F
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:53 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m8-20020a056402430800b00435cfa7c6d1so1888279edc.9
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CG3pZwK286Wp+stKkliNeTwrORF17cOHhcnhVfCJeQE=;
        b=bYQ2u2U8tj3aHjd9MCtMixUrYfpSQwTg4WPOIoCPEeukhh64yxMHafM5vs/LGNKnzQ
         WbZCO/BXLkzB63X6UKAseam1QIfdrrDcHBVOGpbspRYW0ejgy0BAvw5OVpGh3iBOeZEX
         aaVkXTg3A0tuwa1e18PtKkEW1bZ16MVMyhI4LHrOLoqfrXkdK5JLNMCCXCzP+UqlS+7Y
         jMHKRvPORQSh2gGeBXFyCiEXw+TmFxCdnaNG5nGomGgf7TAWqOwR/NSipZV8JXpF91j0
         T7T+oh1yqE70PVoxhXBFXshJGT1hPLtyEjj27zgL+pSYm9TNfYDnuWL3u/qLN7pkNGWn
         fRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CG3pZwK286Wp+stKkliNeTwrORF17cOHhcnhVfCJeQE=;
        b=r0c6qALfgYS/bgJh7V21Y1LF7BF6TeHvH7NjclrSF2TcD6ZSxYQmdbCdipKbdu1EVa
         aPb6yybrdRtg2/NXVv3lFREw7Ix6epK31Ww9d6PFlzdzumYgxksKb07wRY8YtoAAAHX/
         LhSRgydHVTFR6yJiJo2YjanxhZ9gFK0lI6vW+9ZpqdNGCR/QVsnOBmj1XV6QLzkpYzu0
         Ovmxk4SbHWp+T4KT/Ct+q2HugvFNwa7oaeCXbcveGwMePTsPibFcQXe/3nzuPeIdWv3y
         REfN7+XrrzLfWe6IglW9+g3qM5YluKX0l3zCIn1+2FJXwwNAl67x6CJ+LzPQ8dfNXeMm
         Y5wg==
X-Gm-Message-State: AJIora/+CrmHKIAfd3HGJtf75EjIgZ4wsAojKlXbzjrHvePhp2CURR0l
        evY/Sdt6InbkDlaZ8LVNNWwIbnPku+0=
X-Google-Smtp-Source: AGRyM1vuhrwmXAXJ9wJid3cKYDBtVUPAQNXpJsIZnZORqGteH/3hS1Qh3dFSI+7P2W3d1z7T02mluBgbb3c=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:2403:b0:439:682f:d12c with SMTP id
 t3-20020a056402240300b00439682fd12cmr7312146eda.301.1656685493399; Fri, 01
 Jul 2022 07:24:53 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:00 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-36-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 35/45] x86: kmsan: handle open-coded assembly in lib/iomem.c
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

KMSAN cannot intercept memory accesses within asm() statements.
That's why we add kmsan_unpoison_memory() and kmsan_check_memory() to
hint it how to handle memory copied from/to I/O memory.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Icb16bf17269087e475debf07a7fe7d4bebc3df23
---
 arch/x86/lib/iomem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 3e2f33fc33de2..e0411a3774d49 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
@@ -44,6 +47,8 @@ static void string_memcpy_toio(volatile void __iomem *to, const void *from, size
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
-- 
2.37.0.rc0.161.g10f37bed90-goog

