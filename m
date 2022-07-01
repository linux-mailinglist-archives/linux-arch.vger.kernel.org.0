Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD756357F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGAO3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiGAO1f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:27:35 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD53CA4F
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:56 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id e20-20020a170906315400b007262bd0111eso842993eje.9
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y2vNDbHfnK38Naadc3+Fwqq63OR/g0K1wBY1TqEXyAM=;
        b=JFjDqoVxXFGtm201IbbG357skezLd+T04/kWKBQGEughGhugLaopnebvFnawR0Kdsr
         27ps95W+5qwzJFISc09B33+ERrKVXpOpqoMtrCKT/HtJS/mc+Y2T4vZtazhtmZt5dEW/
         6YcV3sK0Awn2rROg1rzXOx4DymiaFx9MNHURtldWEnOEz01PiUXsvdxOa9SJzM6FKaQu
         heiTguJRDqBIlOpunqu4UGMuMlcF9OwwspcMFPk4tB7coqypU57aVRBKufAmVL56Ntdn
         YavSj16XkJUWu5JYiDjJH4XZH6E6lfbc716eCpEJho13ZlQOC3VfHu610QO29KVA6ujZ
         pKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y2vNDbHfnK38Naadc3+Fwqq63OR/g0K1wBY1TqEXyAM=;
        b=xrFl5g+7qCM+ZmywyyF5/FaMEB8b60YVeErUah11vvl4wXXXSD5pNJ0wK45xZajs9s
         RxgB9WgYYH435flwa2k+ozIy9lGSbPz83seffMnj8s/DDSr4XjdtWnD7PpmnnqLVQikp
         iRgcyrxVWlnFlX8Tj0DQ5PhU48uyFodqSQhjUiprip6QbsjhYlthKthMncL+VRa7CDd7
         QvnIGkLCIrluVQY+G6d/yByUzyJrGNGNDA+eL7XJV5hrSCUp9McJic3I+cy7ayZT2yQO
         5epD37AKAJAfZfuq4lmroVrFD2pCWzcGuuaQUwxjbaa4Wj8KZqm9XEFmmT7/dpoF2QBF
         O0fw==
X-Gm-Message-State: AJIora+o0gWccVYBlditXi6v3eJwfEY8msgnMs29Smk5Lnmi9bg+Nd3B
        212if7lZ3c+0rYqnSoTZDCa1N8XYuj4=
X-Google-Smtp-Source: AGRyM1uuNnnM3qssrOrgZOqetYyyDgTLXfrXa0K/82jjlreLIfrHkHYk4kBhmEAowU1mOBxY98uQNMpqi60=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:aa7:c9c9:0:b0:431:962f:f61e with SMTP id
 i9-20020aa7c9c9000000b00431962ff61emr19491774edt.189.1656685496470; Fri, 01
 Jul 2022 07:24:56 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:01 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-37-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 36/45] x86: kmsan: use __msan_ string functions where possible
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

Unless stated otherwise (by explicitly calling __memcpy(), __memset() or
__memmove()) we want all string functions to call their __msan_ versions
(e.g. __msan_memcpy() instead of memcpy()), so that shadow and origin
values are updated accordingly.

Bootloader must still use the default string functions to avoid crashes.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

Link: https://linux-review.googlesource.com/id/I7ca9bd6b4f5c9b9816404862ae87ca7984395f33
---
 arch/x86/include/asm/string_64.h | 23 +++++++++++++++++++++--
 include/linux/fortify-string.h   |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 6e450827f677a..3b87d889b6e16 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -11,11 +11,23 @@
    function. */
 
 #define __HAVE_ARCH_MEMCPY 1
+#if defined(__SANITIZE_MEMORY__)
+#undef memcpy
+void *__msan_memcpy(void *dst, const void *src, size_t size);
+#define memcpy __msan_memcpy
+#else
 extern void *memcpy(void *to, const void *from, size_t len);
+#endif
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
+#if defined(__SANITIZE_MEMORY__)
+extern void *__msan_memset(void *s, int c, size_t n);
+#undef memset
+#define memset __msan_memset
+#else
 void *memset(void *s, int c, size_t n);
+#endif
 void *__memset(void *s, int c, size_t n);
 
 #define __HAVE_ARCH_MEMSET16
@@ -55,7 +67,13 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 }
 
 #define __HAVE_ARCH_MEMMOVE
+#if defined(__SANITIZE_MEMORY__)
+#undef memmove
+void *__msan_memmove(void *dest, const void *src, size_t len);
+#define memmove __msan_memmove
+#else
 void *memmove(void *dest, const void *src, size_t count);
+#endif
 void *__memmove(void *dest, const void *src, size_t count);
 
 int memcmp(const void *cs, const void *ct, size_t count);
@@ -64,8 +82,7 @@ char *strcpy(char *dest, const char *src);
 char *strcat(char *dest, const char *src);
 int strcmp(const char *cs, const char *ct);
 
-#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
-
+#if (defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__))
 /*
  * For files that not instrumented (e.g. mm/slub.c) we
  * should use not instrumented version of mem* functions.
@@ -73,7 +90,9 @@ int strcmp(const char *cs, const char *ct);
 
 #undef memcpy
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
+#undef memmove
 #define memmove(dst, src, len) __memmove(dst, src, len)
+#undef memset
 #define memset(s, c, n) __memset(s, c, n)
 
 #ifndef __NO_FORTIFY
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 3b401fa0f3746..6c8a1a29d0b63 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -285,8 +285,10 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
  * __builtin_object_size() must be captured here to avoid evaluating argument
  * side-effects further into the macro layers.
  */
+#ifndef CONFIG_KMSAN
 #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
 		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
+#endif
 
 /*
  * To make sure the compiler can enforce protection against buffer overflows,
-- 
2.37.0.rc0.161.g10f37bed90-goog

