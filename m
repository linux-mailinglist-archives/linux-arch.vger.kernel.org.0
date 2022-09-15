Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7135B9E0D
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIOPFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiIOPFF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:05:05 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80A25C7C
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:50 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sc31-20020a1709078a1f00b0077ef3eec7d7so5440150ejc.16
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=gSZzwrXvhkj2wpolUx3YVTouxdXHw9PaTEDZ4n2e3I0=;
        b=EznsgfSiy9WifxPdZjYT1Vwj2wYB4AW4etiNBG8scEb5xiAuby2h1T+k5Dja+N3dWf
         S2duxflNmAPHuHcgocbmA96vZwFvrsgfdpnNtgj4uq+eTJxlt5j2bMabt1gCsRhCJDg0
         AzJpKEbhLm7ml6bETgD4W/9UBTpmd8EsT/Am6VtGzrLBUEUuaNnF2fOKbJNN/Aff33pA
         czLuVMpyryuAc03jszny9BsfuzYr+hnv5Q0Y0MfzpdFRm1q9kcGSv2bsQlwBLHtxb+Ub
         wZPRS/RuAFlH1BM4U0m04fB6G24UfKuxoKx9lbER6yfzIS/q5yq4d5MQKvhKRZhxWaXW
         sOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=gSZzwrXvhkj2wpolUx3YVTouxdXHw9PaTEDZ4n2e3I0=;
        b=3NzyWS/zwGQC49WN82hkXf+56OB1saA8oLKBRdnskMzYhmRcM2VHZfXZkZWIMaOkUV
         Xt5fCrX/a9kmnpJ4SzB7rC21S/mAeZYfnDPUXr7ZB6jYpz7Zg4OBEgiDZ8YOqd4d9g6y
         CQB821uBXT4PrR7f4j7SbqhEJd+yWXuFDyrd4s3Gru9vIMHrAINx9odpakWqDw+ixIbE
         royFBY275Vm8L3eim9Z+/pgqdMxoGEFoiEw8kLJNa7omVOlmQFBzEldJKBug/iGgnHRr
         r7+me4g8lj46ecS09D6igNJGwHCHsjq8oRM34Dmowh4R6Y/oiBTKULIbYGEo9m1oIg9V
         7uOA==
X-Gm-Message-State: ACrzQf2TbJPbShsuFOhw3NkaP2lv+hqDkJjOwic9NHLd4aSyIJJ+2BkY
        zkXk54HjFH1N+/PQ5qT1HEDYsextbxQ=
X-Google-Smtp-Source: AMsMyM5aonhljpQzaVwxXn/+2WXKN29fLiAxHjU40s/VJeTy2/yz2WCgfXCD6zZKzAdUnorRQiOSr1kogeM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:c8a:b0:44e:81b3:4b7e with SMTP id
 cm10-20020a0564020c8a00b0044e81b34b7emr256022edb.181.1663254289168; Thu, 15
 Sep 2022 08:04:49 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:38 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-5-glider@google.com>
Subject: [PATCH v7 04/43] x86: asm: instrument usercopy in get_user() and put_user()
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

