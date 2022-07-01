Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824D56352D
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGAOYL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGAOXh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:23:37 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD9396B2
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:31 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sg40-20020a170907a42800b00722faf0aacbso848015ejc.3
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pc6R18JS+sE1u3dlHmLsZDbE6VaTO3tMmut2L/JxCPM=;
        b=S+rhPYqifq/yKHIbjTCu4N0+Z7NmA9VGY0y8mmzTIhWAs4YaTE8GZZ/d43VgjMb7UK
         az5tdkPj9m+23R3TaCa0oezo79iWHEHsoOzkGkp2TjQQUNIdG/x1dKhPZaJZhlGLwZdu
         OjzMamB1js4+neGeWSDKWbw+2TwxoP4epnmauaWHGLcm5vCoQvR64fFA9xoH25lw6mWd
         RLVZUTkg987xWln4gHc8u6k+gTKox0fy6iKvm0z+TJUaI4tHLawej5SvXm+skA79uSIb
         qPS9h+WO1w5qn9e14232gpg/imXEIDcl9Inw5qmcqk5oV1wYuWBucbpYRkDhcT0pyMzj
         XIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pc6R18JS+sE1u3dlHmLsZDbE6VaTO3tMmut2L/JxCPM=;
        b=wAQ/zrtoUsBCG5hfZoyplF7rHM2LvIqr48Pp3d1trqpPqJg9vO6j5lOluitgnbl6nK
         8ODmkxwB1WG7TLgf6XnAEXnLjT+v6sNcs0Jy3U5ZVQS1a3I+JH3vckt9wx3lsoNvXLqR
         62RsEz+Edw9hhkZgmycIjHT+dcZiFqTTRGJLfA6UhIaOsIkhjZ/wjjnOlrodF/A5SHjt
         EmzK7BbJVyqyeLnr+OA4qiLM+VD0CR9aiH77eP06yjvRL0gWfE2vN51IAobwLg99pDAV
         pY7V/Wcycv9IZAawbsE+Tfqk5niA4nxpDbmLAiJpAqQOVqyMHbNM/UamWeNf90kl8tnt
         KroA==
X-Gm-Message-State: AJIora/EocNKkS9nbMegzbq3q7NN8vf0OCusIiRCsDVLLVUenopupDXJ
        lk2Q9IIZHjsDNxi0813tAE0y1HoU3gU=
X-Google-Smtp-Source: AGRyM1tGUA53rIsnnKld405DIJFvq8TS/2FfFMNmonYGXrqujK7Cf69LRpSQi0Bl4dPyssWWDST2mmIbkrQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id
 b20-20020a056402351400b00435f24afbadmr18590781edd.311.1656685409756; Fri, 01
 Jul 2022 07:23:29 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:30 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-6-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 05/45] asm-generic: instrument usercopy in cacheflush.h
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
2.37.0.rc0.161.g10f37bed90-goog

