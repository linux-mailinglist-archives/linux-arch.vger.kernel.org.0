Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F105A2A81
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbiHZPJD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbiHZPIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:08:39 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69192DCFDB
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:26 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id x9-20020a05640226c900b00447e004ea4cso1241400edd.8
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=H9Td7/TMrTAtAVeUrHIrhZSexZsjcdbUinsVZHg+GW4=;
        b=lGhpRwPTwgy57+sACo10KJOabLS+OzoRYCdrY6/DZ69yKQ32Xcl4893L9mHNBXiHX+
         FXTMwAj8o5xEg0UQH1YWvGS2c14JObIHuzS9Q+Cy8Ew9WrtHNB0uH/PCp25eq3/bGv9N
         RyTCwexA+hu/WiPHftg+7pBz23LUJRMDEYENkvxDYKktsmwZX/r78KtNbrMpmA6VSyhx
         v3vpLI2jMLbp9/vcMTRt+gZg2hx0sZJLdiHzG1SemMYm6jlEasuaIKQcHRhO6rJsuS08
         pazvWhVpuAX2fMk3/sVIk0P6SZQRXKcSnn72mVlZhGjEov6c7m3cAMjmVdPIt4SrB+Xp
         EeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=H9Td7/TMrTAtAVeUrHIrhZSexZsjcdbUinsVZHg+GW4=;
        b=HkgfrY5WLvSiDxI/EW3fvSDJ69kIx/ylCkyufpc0ZuZkDtlkclYVGo/RnK87RaWUj1
         XH/MznXZ81iqXIElNcRAaCHaZZ64LzHEg2Ks7gzyXRp/di1dWw17lyDmHDB9nVcA9GI/
         H5fnN4f3G/V9rLGdNbpv8wMnZjUVSUcIJsQ5+cfHLDmtU8NH1II4zLpwZuvAbmn6SSBq
         UtU/s0HG3canDC97FEw8FvVYl6Oo1ayjiIzcVh86IFpa6eCbQYRvmDc6Pvx35wkALBmc
         hJl+vvs7pvf6pY21JwiAPVhLZgIcaV7fLa9LUTmdmvACRGlxBmLjFM6lyoObYTx1eccz
         zP8w==
X-Gm-Message-State: ACgBeo3jp+XxU4TruQtjpmwDgnMDTP/7f7yjZ+4JT5ackngc7s76WfWi
        HBTYAoLkFIFkhnZ4XAn6emCsHMxCTwQ=
X-Google-Smtp-Source: AA6agR74xpTNsjJW4kV3da/I/rAj+tl6NA1SFrgmEnh0B+2JVTsbM1IMY8LB4LV38RhSRb4nx5S5NYcC2Ws=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:7fa5:b0:730:5d54:4c24 with SMTP id
 qk37-20020a1709077fa500b007305d544c24mr5759332ejc.641.1661526504373; Fri, 26
 Aug 2022 08:08:24 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:27 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-5-glider@google.com>
Subject: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
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
usercopy events in variations of get_user() and put_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v5:
 -- handle put_user(), make sure to not evaluate pointer/value twice

Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1859fdf5cc485a2fce
---
 arch/x86/include/asm/uaccess.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

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
-- 
2.37.2.672.g94769d06f0-goog

