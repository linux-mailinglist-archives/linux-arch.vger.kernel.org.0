Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF0510451
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353275AbiDZQvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353270AbiDZQvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:01 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A964838F
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:08 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id dt18-20020a170907729200b006f377ebe5cbso4560356ejc.22
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+FBFHZ/D2CVM8zHnxvAf38XdMkZWjnGIg8UqYOIGTJc=;
        b=eLrL3mhFQT5kOKuWWPsXYa6Om2vKcm1WdEFQHStYaEyvCoapAOY8AFslQqrxPfYmIf
         rXp6G49IKCxSIadhwDU/svB9bjlSTioT2d+8nFtnyoxtGkFZ5hU6IZRnk3EvL9+LHqKl
         YImrZr+ZfLnQxJu37Qjyj/MDxN8AmGTCABbxmGUID5Rdgt4TWVzw9Gx7nZ/Cv3t0o4mj
         7IL5zxZSeAJwNc5HAOQNmnltHzHmQdS3We85em43fb3OAi9L+VU3jozzjW4Z5BOBjLbl
         9zuRJUkSroGkn/RtJMaMYsf10xB5Km6ymFu+cfmKhvrnUfSPObf8M//QzCvTkk4jAHil
         C3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+FBFHZ/D2CVM8zHnxvAf38XdMkZWjnGIg8UqYOIGTJc=;
        b=HMBnWpHfzCSibUO8v2yXARwdawfNLs7Vu/ROmAhshtH0WkBimNpo5NspUCdfnEtQrK
         skwiyXx4Vx+TayVt/3O9gsfB0EZxHtL2uBc0BZhY9A9aGmas4K6WlF/o0KMPq5hVuTdy
         5IRiuIJLXSBr4uC3jHDprK4D8jIqsc3G/+1dryj+ufxhjc1FJ4lqdXm0JXp9LFfc/BO0
         ghdU+WeW47Z1lkOIsQeWZ2mIj68qH5Q3mLPivmZOMfMHHUk/mvNTP8hJh1e9Ov6O6iiu
         teC6zhn5AmCphlJFUUGEX8o8xhu1b8XsUpObE/8AVgCew4fkQGdZEaIlfw/lGPn5aHnN
         fLkQ==
X-Gm-Message-State: AOAM5318QbFLGCWR0T9bg7ofG6PbR3pZ9LP5X3FNfZe1mTDcZo6vxeeC
        mo/IxAALC6PBMZt1fcbUSbAGUNujeZc=
X-Google-Smtp-Source: ABdhPJzl2WkvDMC8oytisA9bFCUfSdKFjxjddbCsinvPLHHRa3ZNDj4UDz7djBQ5AhjJmhi+1lV1TeExHmQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:aa7:c793:0:b0:408:4a69:90b4 with SMTP id
 n19-20020aa7c793000000b004084a6990b4mr25741991eds.58.1650991567128; Tue, 26
 Apr 2022 09:46:07 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:10 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-42-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 41/46] x86: kmsan: use __msan_ string functions where possible.
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
index 295637a66c46b..fe48f77599e04 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -269,8 +269,10 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
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
2.36.0.rc2.479.g8af0fa9b8e-goog

