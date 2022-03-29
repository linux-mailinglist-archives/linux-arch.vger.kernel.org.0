Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E555F4EAD47
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiC2Mmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiC2Mmj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:39 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D220D82B
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:45 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id nd34-20020a17090762a200b006e0ef16745cso2726654ejc.20
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/cngww90lUXjaM8lQFtWcyKhuwI9PqnftLYJV81Lhc=;
        b=ZhkI15SJzz773ZYscrUiWSWJETsRZFPteEYHqIHePZDMxUIF+3PQF+2Fw76owrqA6c
         UPmlNmwXK1Z6638+mZDSIi3ZaYImXqe+Uh0pSLh1rhQp3Xoe7jl74OrGzrvEG7z0eTSq
         o8MSM+eKeJVRDYa5y/OP8y60rroWEDJ8vzz/DDepligD6r9qfkOI3I92z4rW1hHLRtic
         cm0rD0pMAAL/xX1aSmAtPrmorukG9QpyLNGeNh6R44fL+JlPunKHnHJWEF85pS921n3e
         lbvxIMwP6/gs5F0Sdc52ZKShD71Ts7NFaxuC1noz1+PVJK55QErm2j6Lz/PX6SBoULEe
         K4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/cngww90lUXjaM8lQFtWcyKhuwI9PqnftLYJV81Lhc=;
        b=7swRDP05p4cR0pOkV4n/HOL3ND5tji6tTNaTOcUQXdsQgKDvFCSE6TetrGy0wIMzji
         6q7R1tH8YlbjLckeSKPoFvr8kGo1d9iZNmwQZEn2Lka0wHvagWcEq+lcWQTEyZlOB4nI
         R2K5F2vZO3OfTwy7kCnePit/kfujRxPkec/7WaI354MEcBcKaRrqPQHreuOwMsdsWku1
         0b7DHIXpNrjGblq00wHZPl/0+pVW7jMjXhUSPgvEvwX4gcj84uT0y8XtazxcUIXebZO0
         Mqkz+JiLvtAk60Cbd25dIGh1ekgwmFGAntCme8FIGxgvoGSW9ttRyBq9bRYYp2cp/Ito
         27UQ==
X-Gm-Message-State: AOAM533DvfJIuLWo14QfbQituDJExD2h7c87aizpGYDUKFkqSaTM1C73
        BDjbMIk7plFhfs6diZ9QdfEA8eoaXUQ=
X-Google-Smtp-Source: ABdhPJx0Sl5gQKr3lXwaLxCri9MHvRT0DK5gtdgM1us4GPzvAAhQsz1qiosUClgYfwn1c4jOcnHsaUZStL0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:478e:b0:6db:7c67:c7e0 with SMTP id
 cw14-20020a170906478e00b006db7c67c7e0mr34151057ejc.335.1648557643821; Tue, 29
 Mar 2022 05:40:43 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:35 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-7-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 06/48] asm-generic: instrument usercopy in cacheflush.h
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

Notify memory tools about usercopy events in copy_to_user_page() and
copy_from_user_page().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ic1ee8da1886325f46ad67f52176f48c2c836c48f
---
 include/asm-generic/cacheflush.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4f07afacbc239..0f63eb325025f 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
+#include <linux/instrumented.h>
+
 struct mm_struct;
 struct vm_area_struct;
 struct page;
@@ -105,6 +107,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #ifndef copy_to_user_page
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
+		instrument_copy_to_user(dst, src, len); \
 		memcpy(dst, src, len); \
 		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
@@ -112,7 +115,11 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 
 #ifndef copy_from_user_page
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do { \
+		instrument_copy_from_user_before(dst, src, len); \
+		memcpy(dst, src, len); \
+		instrument_copy_from_user_after(dst, src, len, 0); \
+	} while (0)
 #endif
 
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.35.1.1021.g381101b075-goog

