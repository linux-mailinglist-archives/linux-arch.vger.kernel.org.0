Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C45A2A83
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiHZPJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbiHZPIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:08:45 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFADBDCFEA
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:28 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id nc8-20020a1709071c0800b0073d9044ff27so715423ejc.4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=P3BIEQv1T/KwZafUGZKUBc98ocOSrUKFpAGAcrUMbqQ=;
        b=Gfe3GoUcVz2DJqv+lUhS4wPJK1FSFGYSNmq3/sHYEp2DjOH5v5GNBK/z6hDTUoKcTj
         plBctrN9vrg8FpJag++EbXU4mr1O64PW/1loKp8KRZuDnOsIEMr3eAKPs++1evafDhuT
         A/bg0Xtm8uNzHgCE9+qQSnmN9op+um7DtTIxTFv5pIn/W8yBUx7UfecmpyVTt+dfsVnq
         R6+GNW8d47HlvsNhFF9IMt3QQ4Pdb3IpCNIvyzbkPzXHWf3cKsNzlrqWxpwtGBf+/qyd
         MYf6zzuhfYx17T33BFzvicCgkqik20kUTnJTp2XnCJSTdNO9O0hyzdD6GKvImE6ONG+Q
         idug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=P3BIEQv1T/KwZafUGZKUBc98ocOSrUKFpAGAcrUMbqQ=;
        b=IDzrFVeqfI5e3QsuXksvVjgqg5cbiXzmQ7yO32tOvSVNMs5H6sXm0Hmw28asu90qTf
         nthlWs5kiBbGIn0HxsZSUSIijkaB2QjFVG54FTT/Za8uqhUgc+WmehHgHdOYb32qqCfS
         huczkjBckJk3kIWL9MxGzzZY2Is3NI9tVUj+bkIm8rc5PQYkEZ47+BEVn/IdHPo4mruD
         Z8kt/WPbUkNvqKMCtzc2w4IRpveILux2GXaQS4Ki7Qf3SUmzdQufL7SVeFCgy/wFqjn8
         QvYwvnyeDx09AIhibE9BwEUncL3Fqb1AxoIbYO0oMtyRLRPEvT7xRd4hOKJ5DFdNOQpu
         4pXg==
X-Gm-Message-State: ACgBeo1jyB/3HJw0YB1kidJCBz/Eo2culvl1/v8pmMlScAYQrXgbtr2F
        IOGeg1SvQgBZRS5NTDoUV4k6okqRN3Q=
X-Google-Smtp-Source: AA6agR7pRi8WRPCHvWZyrbJ+uMb1xTdRgH4930Ca34TprE6WyeH/LJquvC2M2sAE+eo6XOjsPj4V5JP8Hdk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id
 ga6-20020a1709070c0600b00701eb600dedmr5913732ejc.178.1661526507100; Fri, 26
 Aug 2022 08:08:27 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:28 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-6-glider@google.com>
Subject: [PATCH v5 05/44] asm-generic: instrument usercopy in cacheflush.h
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

Notify memory tools about usercopy events in copy_to_user_page() and
copy_from_user_page().

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v5:
 -- cast user pointers to `void __user *`

Link: https://linux-review.googlesource.com/id/Ic1ee8da1886325f46ad67f52176f48c2c836c48f
---
 include/asm-generic/cacheflush.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4f07afacbc239..f46258d1a080f 100644
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
@@ -105,14 +107,22 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #ifndef copy_to_user_page
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
+		instrument_copy_to_user((void __user *)dst, src, len); \
 		memcpy(dst, src, len); \
 		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
 #endif
 
+
 #ifndef copy_from_user_page
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len)		  \
+	do {								  \
+		instrument_copy_from_user_before(dst, (void __user *)src, \
+						 len);			  \
+		memcpy(dst, src, len);					  \
+		instrument_copy_from_user_after(dst, (void __user *)src, len, \
+						0);			  \
+	} while (0)
 #endif
 
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.37.2.672.g94769d06f0-goog

