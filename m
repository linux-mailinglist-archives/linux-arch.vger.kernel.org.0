Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90C5B9E0E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiIOPFT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiIOPFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:05:15 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0B2CDFC
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:53 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id oz30-20020a1709077d9e00b0077239b6a915so7798606ejc.11
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=fFq4uMFAQOrpNZLU6ydmQ4L19fVmnSZ8zUbgI7i1GQ4=;
        b=cYFC7xgwkG3gs04oiPHichqf/b1cFGgnshWpci997Y8A5dmNKzM9GLf1pSniU9D5ku
         Hu0GNNgLGKOuCAjrWJaXT+n9N89m2OxLOF0aOwdMyJRfQdseBJiGghcUNTQyFs/ZUubo
         G0Bq2nmYZaMX470D+dLwGf+5tXv+CdH3F2TMy+uDbAiFguTk8zqG98QgRczskOtYOVDt
         jAjc9/Nvo2lVMh0sB6dJ8QlQ6FSwdkrIQtBbc5j54TAMFUpg1fazPK6geXTDbKZa+hK/
         CtUyiXzLrd1aFajhJlu7Z3AG5P4f56KCWQ3N8ixK5cFk+NBX9dXK5inzenk1xXL3SCUs
         gf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=fFq4uMFAQOrpNZLU6ydmQ4L19fVmnSZ8zUbgI7i1GQ4=;
        b=HF3oXWrKpxmZwsXPuEqqvIoivBkyrBZ/5o+ZAUfVLEenJejOMO2mpR42VgwXATg69v
         MPaHUUShtqi+5wJXm4f7uHXd+4AGQMud5/KJy8urzghjQP22Pdmha3t1eTuJhzpXWFvt
         N5HX0FdWQkgCKyaRhdrveSc5NwwCr7ld4KPVzADD0o78QnG4l2wAyPAKXG/kLgV6PWwh
         eM1+14JHrhvcVfuNNnCf07gvzj+YGGaxLbJP7JW2kqe/arNQfU/RaDoA3rYb8VGXbpc5
         rKoIHYytR8mhL0vGBqhovw8DOVbTYCRsvGllghk2X3r8ul7LpiyvKF6LdKaTJ8RLiBEa
         gITQ==
X-Gm-Message-State: ACrzQf1Ht/WNFfNBYCFGveOzEBFwf67CB1P4iofb5P7mpYm9YnGO62dP
        WWA2yRqYaGLEMwwDElmVV+xfSvQNWI4=
X-Google-Smtp-Source: AMsMyM6nb4U8HQAI/T9hvY7h7118sHc1IkAnGq/cw4fx9f/IsFE0PzlQ/IJC4zd5NEMJksDjOy7tAJB6OCw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:272a:b0:77c:d7df:c9da with SMTP id
 d10-20020a170907272a00b0077cd7dfc9damr318116ejl.332.1663254291795; Thu, 15
 Sep 2022 08:04:51 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:39 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-6-glider@google.com>
Subject: [PATCH v7 05/43] asm-generic: instrument usercopy in cacheflush.h
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
2.37.2.789.g6183377224-goog

