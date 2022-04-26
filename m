Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9E510421
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbiDZQtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353209AbiDZQsn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:43 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDB197D55
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:55 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hs26-20020a1709073e9a00b006f3b957ebb4so837338ejc.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W9bLVQHqrvNNLkakI5+eXR9eCGhjUZBWMw6dTDyY1eM=;
        b=BgZrayGSuVAfOhwVEgizv3zHVLAes+gixFFwYt44q0Anb09MOHmi4/yqVFg0co0xDn
         meP8eUM1Y1cp68Fqnny0uLKF0Qtln5gmkU4uSohGMZYlVmXcU+el8E0u30FueVIIajUM
         fV0/mRhuiJoD20Efo5TORsSuNROVI//1ETGTAUMCg4QXyCvHkSNJh0BZuJ+MEW//jk5W
         5zxE3TyPvfyC/+M++78ZImLJvn13Sy60BHii4QN5AI+ODEg/JVu9RvQCDCnkT/RTmnsc
         5z+2AC9k9WCqo7Z5jf84941KD9T2VCauRnuI4Jr4yEj//ttB99vhdrJTx2BaTgdSpkdR
         nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W9bLVQHqrvNNLkakI5+eXR9eCGhjUZBWMw6dTDyY1eM=;
        b=BtZQK3oXqd1VxHJBHQ63uwoaQ6mK/dpaqigoJTzK9kNy7OiHzR6nGgQZICj9TDv2EG
         EdSmL9iDY8wcQKKAGlcnVUfhJmuFBmxDHj+IdIuv1r5n5wR8DEtOwM+iruc9fyohxHri
         4StrfzH7D9nvK3WQ0bm3IqUKtb6LiifZ+Vc75peQVFuTz8L4hVlbIlKJJZt9ZtNqGf+y
         xAAo+9q/J5dewPporYO9t5zttXDXwMuuZEoLSTYU+7SD+IOhXiBO+vewGkfot6ZFX1WN
         X4kkR7J/07zURhWA7inicrYhtIqyya3sfoRHZzt/S6H95+fUL1Hd+k/NCysGiQlDdwGt
         Sdvg==
X-Gm-Message-State: AOAM530/gWdLbBwf0kh9YPm+lF7WAahFlIbQXV4kWRmeausBppyabNGk
        gFIM/qtdObStBpcIGKyzgNaSWTW5yKk=
X-Google-Smtp-Source: ABdhPJwCG6zbeNkNwZsSEqpPcp6mObXzGX3q9XLvEMJvGGRoqht5Amkh6vhwVXvGFlIqKIoGDyBdhsZSVt0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id
 b10-20020a056402084a00b00423fe998c53mr25379562edz.195.1650991494081; Tue, 26
 Apr 2022 09:44:54 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:42 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-14-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 13/46] kmsan: implement kmsan_init(), initialize READ_ONCE_NOCHECK()
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kmsan_init() is a macro that takes a possibly uninitialized value and
returns an initialized value of the same type. It can be used e.g. in
cases when a value comes from non-instrumented code to avoid false
positive reports.

In particular, we use kmsan_init() in READ_ONCE_NOCHECK() so that it
returns initialized values. This helps defeat false positives e.g. from
leftover stack contents accessed by stack unwinders.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Icd1260073666f944922f031bfb6762379ba1fa38
---
 include/asm-generic/rwonce.h |  5 +++--
 include/linux/kmsan-checks.h | 40 ++++++++++++++++++++++++++++++++++++
 mm/kmsan/Makefile            |  5 ++++-
 mm/kmsan/annotations.c       | 28 +++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 mm/kmsan/annotations.c

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e9824..7cf993af8e1ea 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -25,6 +25,7 @@
 #include <linux/compiler_types.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
+#include <linux/kmsan-checks.h>
 
 /*
  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
@@ -69,14 +70,14 @@ unsigned long __read_once_word_nocheck(const void *addr)
 
 /*
  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
- * word from memory atomically but without telling KASAN/KCSAN. This is
+ * word from memory atomically but without telling KASAN/KCSAN/KMSAN. This is
  * usually used by unwinding code when walking the stack of a running process.
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
 	compiletime_assert(sizeof(x) == sizeof(unsigned long),		\
 		"Unsupported access size for READ_ONCE_NOCHECK().");	\
-	(typeof(x))__read_once_word_nocheck(&(x));			\
+	kmsan_init((typeof(x))__read_once_word_nocheck(&(x)));		\
 })
 
 static __no_kasan_or_inline
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index a6522a0c28df9..ecd8336190fc0 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -14,6 +14,44 @@
 
 #ifdef CONFIG_KMSAN
 
+/*
+ * Helper functions that mark the return value initialized.
+ * See mm/kmsan/annotations.c.
+ */
+u8 kmsan_init_1(u8 value);
+u16 kmsan_init_2(u16 value);
+u32 kmsan_init_4(u32 value);
+u64 kmsan_init_8(u64 value);
+
+static inline void *kmsan_init_ptr(void *ptr)
+{
+	return (void *)kmsan_init_8((u64)ptr);
+}
+
+static inline char kmsan_init_char(char value)
+{
+	return (u8)kmsan_init_1((u8)value);
+}
+
+#define __decl_kmsan_init_type(type, fn) unsigned type : fn, signed type : fn
+
+/**
+ * kmsan_init - Make the value initialized.
+ * @val: 1-, 2-, 4- or 8-byte integer that may be treated as uninitialized by
+ *       KMSAN.
+ *
+ * Return: value of @val that KMSAN treats as initialized.
+ */
+#define kmsan_init(val)                                                        \
+	(							\
+	(typeof(val))(_Generic((val),				\
+		__decl_kmsan_init_type(char, kmsan_init_1),	\
+		__decl_kmsan_init_type(short, kmsan_init_2),	\
+		__decl_kmsan_init_type(int, kmsan_init_4),	\
+		__decl_kmsan_init_type(long, kmsan_init_8),	\
+		char : kmsan_init_char,				\
+		void * : kmsan_init_ptr)(val)))
+
 /**
  * kmsan_poison_memory() - Mark the memory range as uninitialized.
  * @address: address to start with.
@@ -48,6 +86,8 @@ void kmsan_check_memory(const void *address, size_t size);
 
 #else
 
+#define kmsan_init(value) (value)
+
 static inline void kmsan_poison_memory(const void *address, size_t size,
 				       gfp_t flags)
 {
diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
index a80dde1de7048..73b705cbf75b9 100644
--- a/mm/kmsan/Makefile
+++ b/mm/kmsan/Makefile
@@ -1,9 +1,11 @@
-obj-y := core.o instrumentation.o hooks.o report.o shadow.o
+obj-y := core.o instrumentation.o hooks.o report.o shadow.o annotations.o
 
 KMSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
+KMSAN_SANITIZE_kmsan_annotations.o := y
+
 # Disable instrumentation of KMSAN runtime with other tools.
 CC_FLAGS_KMSAN_RUNTIME := -fno-stack-protector
 CC_FLAGS_KMSAN_RUNTIME += $(call cc-option,-fno-conserve-stack)
@@ -11,6 +13,7 @@ CC_FLAGS_KMSAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
 
 CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
 
+CFLAGS_annotations.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_instrumentation.o := $(CC_FLAGS_KMSAN_RUNTIME)
diff --git a/mm/kmsan/annotations.c b/mm/kmsan/annotations.c
new file mode 100644
index 0000000000000..8ccde90bcd12b
--- /dev/null
+++ b/mm/kmsan/annotations.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN annotations.
+ *
+ * The kmsan_init_SIZE functions reside in a separate translation unit to
+ * prevent inlining them. Clang may inline functions marked with
+ * __no_sanitize_memory attribute into functions without it, which effectively
+ * results in ignoring the attribute.
+ *
+ * Copyright (C) 2017-2022 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <linux/export.h>
+#include <linux/kmsan-checks.h>
+
+#define DECLARE_KMSAN_INIT(size, t)                                            \
+	__no_sanitize_memory t kmsan_init_##size(t value)                      \
+	{                                                                      \
+		return value;                                                  \
+	}                                                                      \
+	EXPORT_SYMBOL(kmsan_init_##size)
+
+DECLARE_KMSAN_INIT(1, u8);
+DECLARE_KMSAN_INIT(2, u16);
+DECLARE_KMSAN_INIT(4, u32);
+DECLARE_KMSAN_INIT(8, u64);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

