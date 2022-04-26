Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB651046B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353356AbiDZQvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353309AbiDZQvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:00 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87ED28E11
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:05 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso10619216edb.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xs3mnLw1SF/DZ/Tq7NTZzrdEtEEoGjj1tkhOxGSNVPQ=;
        b=Dp8fDgewCtm7EfJ+NxSWPaqf4fjHXCb5jsKUHsqjOQlRwQkgkKZ/UWCSiVVrRs/uZW
         OQRNetbiqEwnG85Z0p1Sf25DydKgfbA8aQ0Bsb8u1giNx3oJsml+h06KXd12ZFl+7zlh
         88EaOBCQpujgyWZhEQULbY92x5FazQAo2pGdWFAwltYHX4X7vprtu3R+YlyuxLW4bV7A
         kz4jOXTPx7d0TC785iMRbaV+fkvSej+QsvFkw8jbYuayp+vHkk5UYhSq7fmBnGbZjeRh
         ej2EyGUQvI2W9wRBjeiQzBogyryUJQVM1Tt85ycKl00a26JFtroHDFnq/8e7RZbUcfE0
         4QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xs3mnLw1SF/DZ/Tq7NTZzrdEtEEoGjj1tkhOxGSNVPQ=;
        b=GJ1eJg3QexzKOcjJTvmbP1nSFbXJjATXmiX5B7TEwSIHl9+wtFUUqSgPqi0PZj8+mQ
         07pt71tMwaPAs2n4ttrl/XN4UTmwkwuX/dI+2EDD5bqFhB5wKVyjfJITGPeJKW5L4Dso
         fuuBwBgLMi5MGzH5DzrAcSbOhu4+uuPVNSjzo4m3GpPr1UbbmWhGm//oyLDMi0apP2+e
         s5ULebh0crs/axCEwsSFDTwN8a8RyUwmdzRqtdj0dok1aNDkX8vW2ZZUL/nAag+QC4NJ
         q327zY9o/I72w/47OnpJ+8oJOOWNtVAteeg/OYMT4lFNco7uWVC8VUtOvAtBQGU68c/G
         UWYA==
X-Gm-Message-State: AOAM533uXB4XfU9czhq7GPhqjAd/cuJproklqbnp1VTCr2fnWH1DfIwp
        54O/YV9Vu5+HW2EJJHNDrOA52gqbzMk=
X-Google-Smtp-Source: ABdhPJyVycewaYAOLWq91OXZaqwuaaJYgCPy/6P6fQ6DCJX8eHTBHY2JtlW8ZAI35LArwnFF6hd2OCloeNo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:aa7:c70f:0:b0:425:f70d:b34 with SMTP id
 i15-20020aa7c70f000000b00425f70d0b34mr7131646edq.306.1650991564200; Tue, 26
 Apr 2022 09:46:04 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:09 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-41-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 40/46] x86: kmsan: handle open-coded assembly in lib/iomem.c
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
2.36.0.rc2.479.g8af0fa9b8e-goog

