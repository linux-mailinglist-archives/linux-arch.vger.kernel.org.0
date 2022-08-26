Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0D5A2AD5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbiHZPO7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbiHZPNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:13:44 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4213F86
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:53 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s3-20020a056402520300b00446f5068565so1236949edd.7
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=uVzdHqFGYZKd4Qu5GJB2AnYrpVyvjfHfk7LqoEQIkSc=;
        b=BC1C5JPZyis+Kes9Uu/ankA8YmaxeSDQUFcfBHXb3GZVLgly9+DxFLSdN6o6y7p7/P
         zVWe/gK4/+LWKxQGuvyhxewoxvI19U5hTqi2IpBvOJg3uq8Ik8xr0FYeUi72cpJlmij9
         nf0JKqqIO86qyQ9jue4hqNcyWyObBn/CgX3JM/gkgO+Veqds0ttkLZ3Zg/KDXgiSSHRr
         oeNOglxG71/shVVy6M1hhBJW9QDDOpd1SAOcY4gcwkPldDcHeI0LxKdaN/3bAC+XERwl
         jFbWJk+m8LHqzyufpaIWhW/s3AL9MyZZGADD18fKDUyYSRK0x9/0JYGypV1K9dG68puO
         R0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=uVzdHqFGYZKd4Qu5GJB2AnYrpVyvjfHfk7LqoEQIkSc=;
        b=CqlF0Jj5xTEKOiOszIa6EXCDW0ETcd4U7CHqt64qWMIMTQH+5G9MD5airzK8ZnPywO
         l+m0ZKoc38QkK7+LZ1zsgtejjGoa5fRrA2tzaF9e73fbcGLZTnOVPr9KuaEVlyp3qeB4
         Z26NhF9pEhNcXhVlCzNQMEtNy+B0YD7F+imrQJF9ffsVXD234en5NyAUdLlgFz0FrzAm
         k1j1VIndLA74CyVNXi6+67ZdQ3qr8BOxIaKTbzNFXaY83CRamAatYT8OtwIiB9Tc7eCO
         tglJ6mk24wmlIIUvNLvKTECWHe9j3pYOH95yWjal4NM66kTvMbpFKiC2MpGsdJw/Ulqp
         SNlA==
X-Gm-Message-State: ACgBeo3HvTqF5hR1r/Nl+/A8MHKwyiLlGDGUmG24/63bBEdxc/GLPhRb
        39d5bqilFLC4PASvzsuMoD4Sxpm6yMk=
X-Google-Smtp-Source: AA6agR46uXnxQGKu9ULnyAc1BLhctUrVNAcVdLs11pJsS5/NKYX8LczIxzp8tXMl7eS110R8HE5vOzH3J7w=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:368c:b0:446:48d9:2be with SMTP id
 ej12-20020a056402368c00b0044648d902bemr6858842edb.167.1661526593376; Fri, 26
 Aug 2022 08:09:53 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:59 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-37-glider@google.com>
Subject: [PATCH v5 36/44] x86: kmsan: use __msan_ string functions where possible.
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
2.37.2.672.g94769d06f0-goog

