Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AA510410
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353128AbiDZQrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353148AbiDZQrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:49 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A51968A0
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so2042845ejy.8
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cG4bw4Dybp9do4PvtZBZ2e2ITt4Wsjs9LSUgy4lmV+4=;
        b=RcuVhtgi/Tw1bMDtabWe38GwlUcwg4SUjFJCfkW2os/ElbHByzMYCT2RYzqn62C0bn
         cbc56TqAri4pL54mxEkGuVkiAaJJ9tXSwdeAGi+nY3slj4lCV4ZtmvWqeaNCS3QKANio
         WW7rLfKq9u9Kd3RXcYrkCGHS0aT05KrVMUMkow7J5zXgyXnRiQ3E/SReE2LZFqObeM2p
         smA+CIkkQF6Odog2q36ChSrXewTMVXM+93iY1Gau5URCGueQT5zBnFATmZOSwzbaRVC1
         zWWjq4eJBwkMFtGAv2hVypAFZhEDp0HEN6QVTrNW6nJcUAwldpsVdCTpJbkD3ZSC1KHK
         QTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cG4bw4Dybp9do4PvtZBZ2e2ITt4Wsjs9LSUgy4lmV+4=;
        b=HAoX6GPst1//UBaQqf56Vw+/Pwed5sIwwXxwWZvebnyWKbmWNeciUKYRXai1giVWt6
         AJ3z2AhIJ/rIgkgt1h4kEXtFUl5GPdapRyScH8AwBIbWZfiO791TgLOO7VL/rnoTLB6B
         NUsBx2upx+bARZ9L8/AIh+WYV12x3ce5gmSAJ4VrPx2qBKwk5MsJhZuLG2E02I32l86j
         9P6LOZTxrQPohgif2VON0KZT9xhn9Wagu36rlcvcU+L3folrx6bCIUL1i7HzoXvg+Reh
         Z+C8zVaBncDM2OfiRxTe0xjrFqPkQ0ypPhizWtXW3ScwWABLZkogsnx9WN1EQiPBi5rh
         ByGQ==
X-Gm-Message-State: AOAM530T6SgSCIZmX6WAXzrnaWQyFgAbitkf3wWw9wzckkTnu4cFNO3e
        +MUm2K2SduO1iG6XWq+q3NqywK3Xyp8=
X-Google-Smtp-Source: ABdhPJwJq5G2rpZj9OKDdv47ee+grpfL1muZK+Akh8tj6QCkzJXGooM+Bx/fhzrHXRviMJo4c+0ZnBDuFgY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:2809:b0:423:e123:5e40 with SMTP id
 h9-20020a056402280900b00423e1235e40mr25792114ede.84.1650991475654; Tue, 26
 Apr 2022 09:44:35 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:35 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-7-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 06/46] asm-generic: instrument usercopy in cacheflush.h
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
2.36.0.rc2.479.g8af0fa9b8e-goog

