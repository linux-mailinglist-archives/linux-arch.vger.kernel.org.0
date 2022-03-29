Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98964EAD9F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiC2MuA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiC2MsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:48:07 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8D227C5B
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:22 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id i22-20020a508716000000b0041908045af3so10874233edb.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6EKMd0bjP1WkGhZZPkjCgU25E3DWfYJCasURW7mFnYs=;
        b=P1k71GssRqu7HsErV73nnblS85PhkUFheLyBFZgmPWLpl7OKiy1Bqi/JlOtZzfJVPy
         VAc7cvO8fwjHIxHwD4P9pVu2rdNH8e0p6iE439JugyKP3tEZpAogt6YoEY/b5rvhs6YN
         OlYMWP+8vwtXjv8eNiLfoejuKaPkdCuMEozoeNlW8PpIb+edtD9db/0+pmWKLdNhwURR
         5E3Lth/p8S4d05TzSLze03fVsfkwrT++EyTKtUjOhLVyC4kbo3lKGGRltm0PtD2GB/IH
         Q3WE4SbVcH6AFhiknkVN5O3R1HMm1J+ZfOcalpdSexIx4dKDpVcT7q34bBD07dT9kvEi
         C7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6EKMd0bjP1WkGhZZPkjCgU25E3DWfYJCasURW7mFnYs=;
        b=bbUhgkbAsrKgpn0akrqCtnq9B4lfIcl9fV8Z16fO55wMfl44P6nbpCVUKwp1+nbZz/
         NRqN04236l8io3LVVx/efaOxxTG7t7XsPG54wTB0s/X/oncTMOQ0b6PwhSGb+UoAxiDw
         B0tOvR7mLY5q5hd7MRk3LZgxPZqkBdU0gn5fK9W3MXtNX4Inl87mkCybHyNV8Ibh9AT5
         neSPSPrKasvSvXtp+wYeC97HfhRgYKqnjvl4kYJ55KUdXWMmDi/MhNPMGWmoGAaIhZ25
         a/zS/pw/WpT88ae/w7mSijKTYa+WBhg/6JIxnfQGzSLElqRqudWAUxPiNJAkmAQ0n1c7
         zXeg==
X-Gm-Message-State: AOAM531NbMDtkr+IGhcDNDCBMcjNb22LMrp79McauyEOL6uj+VKghn0y
        jD0BtYhjY5tKutlLabP99elbcWEqkO4=
X-Google-Smtp-Source: ABdhPJyN/u61iYoRLkPCDJv7Xs3UegKZjTjkx8b5A87Fx1oaelxWk3uqKnX5mytmcMKvTp7b3Wewv/gEEvA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id
 d2-20020a170906304200b006cd20ed7c5cmr33818169ejd.241.1648557740796; Tue, 29
 Mar 2022 05:42:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:11 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-43-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 42/48] x86: kmsan: handle open-coded assembly in lib/iomem.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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
index df50451d94ef7..2307770f3f4c8 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ void memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 EXPORT_SYMBOL(memcpy_fromio);
 
@@ -45,6 +48,8 @@ void memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
-- 
2.35.1.1021.g381101b075-goog

