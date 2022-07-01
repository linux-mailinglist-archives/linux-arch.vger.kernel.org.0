Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6256355C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiGAO0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiGAOZN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:25:13 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36DE427D9
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:07 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id q22-20020a0565123a9600b0047f6b8e1babso1190350lfu.21
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qRpA/KHLRYdo76YWwE6d04+ye7UN8yXoHeTH9XEwQK0=;
        b=nuIy5sPY97WE4Na2+tDp/B2mAWuutSYXusRYqrf6YxSijHhgLbmnsmS0o2fiYh5/Do
         /09lw8m4SVNKOYmoEK6HMxPLTu1E3kw4LhBcRBfvwY3nS2wLt+OCVSphGAatbhRfsti+
         VVp0F1sWJPyWXiGjZXUPSCQZOElXfKweDeG5Yu1Njxbddsc0VwS3a8L8cZHVuO5Klbj8
         qdZN0ySrNX0MJDuYE65IztkpOKOSP3D6akR5YHdge9pHQKisJPIuL47h4k0Q33mfj/9L
         XeJvoIaLRnLrA4bnmskTdmIuMKwd86AQ7L805VR2oh/iRtOJ1JrzzU9ncKoZ9gIHDb8s
         YLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qRpA/KHLRYdo76YWwE6d04+ye7UN8yXoHeTH9XEwQK0=;
        b=i0NRbCft1nyG2tP2CQceP7li4siyh2e0huW5NEXi1b90qLdeSzpRdAKhb+jmSwsq7v
         sVg0NynE4HKd5GM6juOOMlyEKhV04cLZMegB6slDPSoI4p+i6o1UhV5sDiQxuH58WhdO
         rjFGb7b+bRoGwl/mv2mwWHIZ4RwhRUJTtQfkwfOGvaGPtOsJW3Lu0QVUOFcbH6f2ruNM
         BmcWpYnehOQmbGrmHWe6pqk8WwQia28q0+rCKXdqkve1t8nsfGZj3S/QzoPN275L+nki
         iOt0njplB5eZUtak2bJUDIKfYasaXLmE5tRE7d/Tvm+0UjpsKnZOH9zhkm1DG/2JzNJH
         TN0Q==
X-Gm-Message-State: AJIora+Ezn5rIHWOn+0Eg7LbZ/RzpSn5V8TOnkKucM+dRvFDhC/3iGwE
        6YF5VdxvPaYPV6P8WGDvaQuPyU3W2Ck=
X-Google-Smtp-Source: AGRyM1sty4IKmaztZhJQX9qrKqisLJMfHz0k4hy5dUHdfFpoWKsT1NmFCA9JTdaWQUOqJX7WaPNwfk8uyOs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6512:b9b:b0:47f:6aae:ecc5 with SMTP id
 b27-20020a0565120b9b00b0047f6aaeecc5mr9169900lfv.412.1656685445833; Fri, 01
 Jul 2022 07:24:05 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:43 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-19-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 18/45] instrumented.h: add KMSAN support
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

To avoid false positives, KMSAN needs to unpoison the data copied from
the userspace. To detect infoleaks - check the memory buffer passed to
copy_to_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move implementation of kmsan_copy_to_user() here

Link: https://linux-review.googlesource.com/id/I43e93b9c02709e6be8d222342f1b044ac8bdbaaf
---
 include/linux/instrumented.h |  5 ++++-
 include/linux/kmsan-checks.h | 19 ++++++++++++++++++
 mm/kmsan/hooks.c             | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index ee8f7d17d34f5..c73c1b19e9227 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -2,7 +2,7 @@
 
 /*
  * This header provides generic wrappers for memory access instrumentation that
- * the compiler cannot emit for: KASAN, KCSAN.
+ * the compiler cannot emit for: KASAN, KCSAN, KMSAN.
  */
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
@@ -10,6 +10,7 @@
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
+#include <linux/kmsan-checks.h>
 #include <linux/types.h>
 
 /**
@@ -117,6 +118,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	kcsan_check_read(from, n);
+	kmsan_copy_to_user(to, from, n, 0);
 }
 
 /**
@@ -151,6 +153,7 @@ static __always_inline void
 instrument_copy_from_user_after(const void *to, const void __user *from,
 				unsigned long n, unsigned long left)
 {
+	kmsan_unpoison_memory(to, n - left);
 }
 
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index a6522a0c28df9..c4cae333deec5 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -46,6 +46,21 @@ void kmsan_unpoison_memory(const void *address, size_t size);
  */
 void kmsan_check_memory(const void *address, size_t size);
 
+/**
+ * kmsan_copy_to_user() - Notify KMSAN about a data transfer to userspace.
+ * @to:      destination address in the userspace.
+ * @from:    source address in the kernel.
+ * @to_copy: number of bytes to copy.
+ * @left:    number of bytes not copied.
+ *
+ * If this is a real userspace data transfer, KMSAN checks the bytes that were
+ * actually copied to ensure there was no information leak. If @to belongs to
+ * the kernel space (which is possible for compat syscalls), KMSAN just copies
+ * the metadata.
+ */
+void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
+			size_t left);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -58,6 +73,10 @@ static inline void kmsan_unpoison_memory(const void *address, size_t size)
 static inline void kmsan_check_memory(const void *address, size_t size)
 {
 }
+static inline void kmsan_copy_to_user(void __user *to, const void *from,
+				      size_t to_copy, size_t left)
+{
+}
 
 #endif
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 43a529569053d..1cdb4420977f1 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -212,6 +212,44 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(kmsan_iounmap_page_range);
 
+void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
+			size_t left)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	/*
+	 * At this point we've copied the memory already. It's hard to check it
+	 * before copying, as the size of actually copied buffer is unknown.
+	 */
+
+	/* copy_to_user() may copy zero bytes. No need to check. */
+	if (!to_copy)
+		return;
+	/* Or maybe copy_to_user() failed to copy anything. */
+	if (to_copy <= left)
+		return;
+
+	ua_flags = user_access_save();
+	if ((u64)to < TASK_SIZE) {
+		/* This is a user memory access, check it. */
+		kmsan_internal_check_memory((void *)from, to_copy - left, to,
+					    REASON_COPY_TO_USER);
+		user_access_restore(ua_flags);
+		return;
+	}
+	/* Otherwise this is a kernel memory access. This happens when a compat
+	 * syscall passes an argument allocated on the kernel stack to a real
+	 * syscall.
+	 * Don't check anything, just copy the shadow of the copied bytes.
+	 */
+	kmsan_internal_memmove_metadata((void *)to, (void *)from,
+					to_copy - left);
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(kmsan_copy_to_user);
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

