Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E454E563528
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGAOX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiGAOXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:23:36 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421332077
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:28 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id r12-20020a05640251cc00b00435afb01d7fso1869700edd.18
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g6pC2DAwiUBeK1TSxgdl5U3IOE2AcDc9FK6KiXQeXic=;
        b=AHKrqjSKbIhFOsa2VQSybdRJw40/76dIOouQ3LxiX50cNdW9EKH77HHDfNAcImNKZf
         GeMQtHcRemc/Cl5NUHQ8aiLcNwc8TpgRsU6Ln8BGBoNJ4WhY8e4fJesF8eINu4Q1m6rE
         894rX+GOm0y1pWTY+02nHyNLuCMkwHH0SiMztDb+tBivwkIU2GyInzjk7TGEmVGfgXT7
         ikUy1pi4Zeduvw3a5o1EtaeInq31rAlsXTucAeSAezlmwAdOugIN+Mt9tp5v0YNDJcZ8
         rg9kw8pUI9ailA5iyfhYRap74iZrdGMioHk8KCDVS57lmwlU8Cc/kwuLKwtlSc7RZkg8
         qAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g6pC2DAwiUBeK1TSxgdl5U3IOE2AcDc9FK6KiXQeXic=;
        b=W/SQZtCrKv0/pNB2DZngMV4gIYtEYeBYurDR5LMCJxPOOXm2k0OqgDXBlkcnGMiyfu
         B8LhMc9gEpJAUB4JW19Wa6p/xZQTO+HLVyQKmiE/QV5QLy0zrflAAEutnDtlEktAEVb5
         WuacJ8v0CWLw1GZ7d6uo41LimAN0IphUr0+Gf+676aceEGQ31OvN/394NcdJPe4YLRBn
         +Clqq1B5vCG3acLZAsd41Ee2cLtSXeJ6pOE5s19dU4QM6pGg1k4BJtPJ7uii3FCQCp4h
         n6VDMx3t/km1xA1POtT5XibfZc+AJZMQ/n+YE7T5sw6mqdp0jitfZzLKMflFFoFJ5atQ
         MDgA==
X-Gm-Message-State: AJIora8rw8wX2csspJdEhwYYW6X6GVNBDQxCLrGtZ//ZJW7T2GK4gsy9
        dFvxfl7lj9GM0KzalZeOqZiNvB06Fng=
X-Google-Smtp-Source: AGRyM1uxLYmWR//LYr+qyE7iiW3wADsN021yfuxu7jUqUOU6cZfOOtwpDxxr6LrgXLqxLicromQ2HETc9Qk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:907:97d1:b0:722:e6fc:a04 with SMTP id
 js17-20020a17090797d100b00722e6fc0a04mr14570630ejc.217.1656685406971; Fri, 01
 Jul 2022 07:23:26 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:29 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-5-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 04/45] x86: asm: instrument usercopy in get_user() and __put_user_size()
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
index 913e593a3b45f..1a8b5a234474f 100644
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
@@ -99,11 +100,13 @@ extern int __get_user_bad(void);
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
 
@@ -248,7 +251,9 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
+	__typeof__(*(ptr)) __pus_val = x;				\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_to_user(ptr, &(__pus_val), size);		\
 	switch (size) {							\
 	case 1:								\
 		__put_user_goto(x, ptr, "b", "iq", label);		\
@@ -286,6 +291,7 @@ do {									\
 #define __get_user_size(x, ptr, size, label)				\
 do {									\
 	__chk_user_ptr(ptr);						\
+	instrument_copy_from_user_before((void *)&(x), ptr, size);	\
 	switch (size) {							\
 	case 1:	{							\
 		unsigned char x_u8__;					\
@@ -305,6 +311,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_copy_from_user_after((void *)&(x), ptr, size, 0);	\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
-- 
2.37.0.rc0.161.g10f37bed90-goog

