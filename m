Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB364EAD4F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiC2Mmy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiC2Mm0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:26 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A5203A42
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:42 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id u17-20020a05640207d100b00418f00014f8so5707092edy.18
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3RM0qhEhF66BtuM0ZXwaEhPbHnfCR09wU8nC/pTqHi8=;
        b=ZfQ96zQsPsKfBQ/c9B+p0T/40FovJz4CFLCUEiSSbflULpKaBSwZh18ccdw9FjFMR/
         6CL212sJnEyxZj6LrueXeIA3af+ha93f5SXcMHFxIvZ8XcaA3jgjh2CgfsWeI5aC/FoO
         SsZxN2XfUHXoWAeOjgXaOjO75UgBK6Rk75Jr8fIsEu0Ij5ADYX0ek6w89sp3ufSZz+VH
         z3XgZl5AChOAcBCeLORpdjPovuJuV3Q3SgS4VWwGIZ606KqelRUzogETo02XK3PN9Ui9
         gob299cB95qVQVVfrCpMAbauzPoQU2jiYcZtRwKNYM8m/tLM7wpaFE+a7CQHD2mcjmDA
         fVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3RM0qhEhF66BtuM0ZXwaEhPbHnfCR09wU8nC/pTqHi8=;
        b=e0QSBEzkNCSH9kK+to15j+X1nGg9gF3ra6NFiJ+fTL+zGpRyogAAJy/yauMptax4lJ
         UsRsO7xgY9oh3hn0A3fkxGQNyw/uS/51YnJyvAIUHwQrwTVTh4QzmIf+Rfc/deKODi7C
         og9nnVgVt1H2iDJSZuVDtYf5zzYEgQMqXeF7EZZtU4vJTTF+eJaaVAT/dPaBUGliHrZs
         MEq0iMmjrJHafQA2K8HdYTG8VT8eDhqkkKldYc6Gc8v5PGzy4Xu/qHukXYCbKJ5ZAPJi
         UC8Jkj5gxENcTRkUG6O+msHEXMD3rNmLhuzCeINJIhZSgCYkaSDbrIfbaG86BzecHoQ9
         ssGg==
X-Gm-Message-State: AOAM5308/wB54oArKi6EjBmmjJiV3asXyNaKB1yhAXuSKo3zoum6xVB/
        KH+GcHtJtHZV/YTS7B10LHKMaYdnz/k=
X-Google-Smtp-Source: ABdhPJxZVbkRLRuOZHRe+6vIay7XNPuEELMpuQ9mw5W8uiPx5u+x394b7lBiwbP526tqAx4KRk6EWhiX5Zw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:2ce3:b0:6df:d4a8:9039 with SMTP id
 hz3-20020a1709072ce300b006dfd4a89039mr33974181ejc.697.1648557641243; Tue, 29
 Mar 2022 05:40:41 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:34 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-6-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 05/48] x86: asm: instrument usercopy in get_user() and __put_user_size()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use hooks from instrumented.h to notify bug detection tools about
usercopy events in get_user() and put_user_size().

It's still unclear how to instrument put_user(), which assumes that
instrumentation code doesn't clobber RAX.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1859fdf5cc485a2fce
---
 arch/x86/include/asm/uaccess.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b3..e6abe6f27ae99 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -5,6 +5,7 @@
  * User space memory access functions
  */
 #include <linux/compiler.h>
+#include <linux/instrumented.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 #include <asm/asm.h>
@@ -126,11 +127,13 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_from_user_before((void *)&(x), ptr, sizeof(*(ptr))); \
 	asm volatile("call __" #fn "_%P4"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+	instrument_copy_from_user_after((void *)&(x), ptr, sizeof(*(ptr)), 0); \
 	__builtin_expect(__ret_gu, 0);					\
 })
 
@@ -275,7 +278,9 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
+	__typeof__(*(ptr)) __pus_val = x;				\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_to_user(ptr, &(__pus_val), size);		\
 	switch (size) {							\
 	case 1:								\
 		__put_user_goto(x, ptr, "b", "iq", label);		\
@@ -313,6 +318,7 @@ do {									\
 #define __get_user_size(x, ptr, size, label)				\
 do {									\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_from_user_before((void *)&(x), ptr, size);	\
 	switch (size) {							\
 	case 1:	{							\
 		unsigned char x_u8__;					\
@@ -332,6 +338,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_copy_from_user_after((void *)&(x), ptr, size, 0);	\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
-- 
2.35.1.1021.g381101b075-goog

