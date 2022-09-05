Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60285AD277
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiIEMZY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiIEMZK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:25:10 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2AA183A8
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:08 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso5693878edd.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=gSZzwrXvhkj2wpolUx3YVTouxdXHw9PaTEDZ4n2e3I0=;
        b=tGEGAx8uMhsDCwjOO4YeavI0k5QsjHgjDrM4zDrLN5sS9ToamP5OIkdyf8ZLJoQyOw
         e2LoiIBveMGNkL1Elhx+wY4FUi2lWQYPS946Ofc2zpeiYXDghDghxvMhyBVvvt9lMxWQ
         vgiRcYONLBIiMgCzXeNVdaYQRCNi3V8gspn7+0+/HuYQO9Jmovxsizf4gqTMVYmCS/BT
         3wSbxDLRcA/TelDo7MMeZ9iCCDJ/9i/v/s7AvSw7tPA5gGWT+7eyJ7eSlRgra5ZKcjZj
         wqC4BAaZNeAxQzofrZ1I/wGoXPlrz8wTvBufMgNH8R9/2cyykGlVsTniZ4E04Wlp4Kq1
         6j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=gSZzwrXvhkj2wpolUx3YVTouxdXHw9PaTEDZ4n2e3I0=;
        b=vHAsPitTt7uuF7hgbndBiBBJ5jLSchgZhfdr5jL5ikG7nym2nRNZFprPDS/2xnnZGq
         FBIdy4/p9EAFg/Cxc8G9g2EVRCIHBizuhhp9ZXCA2mYuQ7EMmjcbE2RCRTFxKYut8/72
         Q+RuswyON5AJsYiiiv+hVdJ8p+WhfGl+j8omoINhJtWA0ibmOjmVG5+2psHTEd4q8wJH
         3RQdri3+HeRsDLBjspbITZvjlTpZFMD/MTKDaEBRwndg5i+mNkMsBdgHLV9Y3K/9q0pV
         rda7a2FZQNI2yaEaLKsgqYAMzDgQK67WPa8EzgEIsRZOIexF8FvBm8Hmr99AcM55OQKw
         xwUA==
X-Gm-Message-State: ACgBeo1JqhlWjoIrC8AFrhHj5L4uYrHCWDslkZfr/GtNRHwiAdIxm28b
        ue3+523ObZ2P/zPYW/DgSVfMOerQ0c0=
X-Google-Smtp-Source: AA6agR7uZSb4I8x12+mloMHQ0B/R9zNrKGyUDj6RqUDl0l3ypI90dtuco15DreoHh/j3D7zLcpHmCF1MiQM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6402:4414:b0:434:f58c:ee2e with SMTP id
 y20-20020a056402441400b00434f58cee2emr43097203eda.362.1662380707978; Mon, 05
 Sep 2022 05:25:07 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:12 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-5-glider@google.com>
Subject: [PATCH v6 04/44] x86: asm: instrument usercopy in get_user() and put_user()
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

Use hooks from instrumented.h to notify bug detection tools about
usercopy events in variations of get_user() and put_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v5:
 -- handle put_user(), make sure to not evaluate pointer/value twice

v6:
 -- add missing empty definitions of instrument_get_user() and
    instrument_put_user()

Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1859fdf5cc485a2fce
---
 arch/x86/include/asm/uaccess.h | 22 +++++++++++++++-------
 include/linux/instrumented.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593a3b45f..c1b8982899eca 100644
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
@@ -103,6 +104,7 @@ extern int __get_user_bad(void);
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
+	instrument_get_user(__val_gu);					\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
 	__builtin_expect(__ret_gu, 0);					\
 })
@@ -192,9 +194,11 @@ extern void __put_user_nocheck_8(void);
 	int __ret_pu;							\
 	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
-	__chk_user_ptr(ptr);						\
-	__ptr_pu = (ptr);						\
-	__val_pu = (x);							\
+	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
+	__chk_user_ptr(__ptr);						\
+	__ptr_pu = __ptr;						\
+	__val_pu = __x;							\
 	asm volatile("call __" #fn "_%P[size]"				\
 		     : "=c" (__ret_pu),					\
 			ASM_CALL_CONSTRAINT				\
@@ -202,6 +206,7 @@ extern void __put_user_nocheck_8(void);
 		       "r" (__val_pu),					\
 		       [size] "i" (sizeof(*(ptr)))			\
 		     :"ebx");						\
+	instrument_put_user(__x, __ptr, sizeof(*(ptr)));		\
 	__builtin_expect(__ret_pu, 0);					\
 })
 
@@ -248,23 +253,25 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
+	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__put_user_goto(x, ptr, "b", "iq", label);		\
+		__put_user_goto(__x, ptr, "b", "iq", label);		\
 		break;							\
 	case 2:								\
-		__put_user_goto(x, ptr, "w", "ir", label);		\
+		__put_user_goto(__x, ptr, "w", "ir", label);		\
 		break;							\
 	case 4:								\
-		__put_user_goto(x, ptr, "l", "ir", label);		\
+		__put_user_goto(__x, ptr, "l", "ir", label);		\
 		break;							\
 	case 8:								\
-		__put_user_goto_u64(x, ptr, label);			\
+		__put_user_goto_u64(__x, ptr, label);			\
 		break;							\
 	default:							\
 		__put_user_bad();					\
 	}								\
+	instrument_put_user(__x, ptr, size);				\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
@@ -305,6 +312,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_get_user(x);						\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index ee8f7d17d34f5..9f1dba8f717b0 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -153,4 +153,32 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
 {
 }
 
+/**
+ * instrument_get_user() - add instrumentation to get_user()-like macros
+ *
+ * get_user() and friends are fragile, so it may depend on the implementation
+ * whether the instrumentation happens before or after the data is copied from
+ * the userspace.
+ *
+ * @to destination variable, may not be address-taken
+ */
+#define instrument_get_user(to)                         \
+({                                                      \
+})
+
+/**
+ * instrument_put_user() - add instrumentation to put_user()-like macros
+ *
+ * put_user() and friends are fragile, so it may depend on the implementation
+ * whether the instrumentation happens before or after the data is copied from
+ * the userspace.
+ *
+ * @from source address
+ * @ptr userspace pointer to copy to
+ * @size number of bytes to copy
+ */
+#define instrument_put_user(from, ptr, size)                    \
+({                                                              \
+})
+
 #endif /* _LINUX_INSTRUMENTED_H */
-- 
2.37.2.789.g6183377224-goog

