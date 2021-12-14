Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D4474794
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhLNQWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbhLNQWJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:09 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A92C06173F
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:09 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso17492937edc.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fhRGaCnf+TI+rbD6bpipfhwQ2i3ms5pTCBO8ta/qeqc=;
        b=TX0tjjqrzBB5d35hGkn9aTC0IHbiHM4YeZPo6zu9iHoyjh5pzff8ntG2ikksEyhsxp
         b9nT/gLc/VQzP6JS6qUwJ+QbzhuzhgMIvWNBOEOeN6p+rcRZmWrWtrXPxxaEu5LUQIbQ
         48EE6tE7ZO2rspSQQ+VZy+LEZzb3ggEwvRJG9UNMCQeUlACSOtd/TeDDjNtFuv1QcICH
         bCfuFNPc7uAZeTfFVsnvdW+qFpPRdtXGT9vjIBhmiFQYRDQ/Meh6NQu7VI9D7X0DrrE0
         EUebdrP2DhS9uKqyH3c9ZI434APLeaFa52NHNwxzHCLG4S8w83C7hl+DzcqgQfLIwrPV
         ddsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fhRGaCnf+TI+rbD6bpipfhwQ2i3ms5pTCBO8ta/qeqc=;
        b=UynAIUyzsRI9pFgHCLOwlJLKHQDDL+d19lkmsOjAfvcFqnGVwk5FTtaqV/bp3TXKC3
         8axibYW0MxDhvBx2bXsjAzhGuY1q3NLxBiGqq1t0rECG7zmy+CDMtis/17UZFRhCO/jc
         mHMSS77HdpTUjMa79QjFn5QF14qvKe1RYcbYBMCqh26fhq+1E16ASd2P5Psrxn/Qoful
         JenRLENCgvyzZyh8W4V1sG7HE8iU6kFVfBjQ2m8wQW+g7BBgauGBfQocJarj7BwfB3bN
         04pAAgQgUjTlB4AL7FNdGDlg5QyjPMI4rBQHa53+f6n7dYM5aw+dCFizvU4VjrBHwKAi
         lftg==
X-Gm-Message-State: AOAM531gLCl01ZaElMFJaGXNqOYoDzOOTovj48WTjBsLJE8gXTOC3wdL
        p/mUfiEGsGa0JPvE12jJRVVYOR/uXAI=
X-Google-Smtp-Source: ABdhPJy1EVhvr5Fpu/bqGcT/XUVsQ/H9fHi/cHGeda5efKSyOvDHPkyhzWJngRhdjn3oSE6CI+7CDLKD7/I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:906:58d5:: with SMTP id
 e21mr6916439ejs.540.1639498927503; Tue, 14 Dec 2021 08:22:07 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:12 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-6-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 05/43] asm: x86: instrument usercopy in get_user() and __put_user_size()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
index 33a68407def3f..86ad5ab211e97 100644
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
 	unsigned char x_u8__;						\
 	case 1:								\
@@ -331,6 +337,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_copy_from_user_after((void *)&(x), ptr, size, 0);	\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
-- 
2.34.1.173.g76aa8bc2d0-goog

