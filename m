Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D14747DB
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbhLNQYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhLNQXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:44 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF5FC06139C
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:30 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so8951071lfb.19
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uWmJ4cna30hge0JfJUa8tpBQzN6nH+qPm9bB+RIZvh4=;
        b=gnRo03X1rHbrBeUgP8SbekXfNxzT/s/gLZOQMVuQ98Mcrl1/W3OksXN1PcCbasxeAO
         UcbkG3ew4b8Be17NziHFV8PQdo/AVLvnN1uvzNE+/RCF8Yeo5nZcp8/4xUdImU0Nmub7
         pUp8xOiBFqGYmE6XPUQwL+6h+P0/ZO9EIsfw8OtvYKyScA9IZPLC73pXdRqRDIlAz8Ac
         68riDzHGh1lY5Kf42SDi08qLtAlbv7TaUPzDjvXTJ+J+g1Gk1S+wssewAKw3Q+7ruZI2
         K9XseeVybm7Rc624Ez0X/JuNj+l4qFERRpZ+uevwUrAZ2RpTPmImVr4tiJ3KbMiF/MUH
         F4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uWmJ4cna30hge0JfJUa8tpBQzN6nH+qPm9bB+RIZvh4=;
        b=tMwO54aCHYFW8R9MVWbqbyhirNioXAZXeyQHWynuvlf1VcpE0ANKviehr9ChYgat2O
         8jB1l3sQOroVREhfGENZUe1KRPpaJwPPNgpgYQ4p5iftOvUpbMIXSWckJKEcquLIxmmS
         SOFKYqqqQ3lGzzys4QqBok7R+F1OcMYxLPNikdUKozKX9YrofElIPzl2xY6kb0N2YZ+g
         AaFBqzr5kR1qp8juinP1zK6yzjEnKzwAoEWCXVnn7THeWC/Lh742ByMsPGk4lZHe5eyl
         Gyqz5TZEBInvzk2R1O+9TeXxCpBYZyD1trnT0r62q54drVqwAwco7n3bng78owq+xIJC
         aexw==
X-Gm-Message-State: AOAM5301CMG9lDSM+I6sCCWA/rDbP3Jgj8MrJr5RSUl0rYDjw+hS3RK/
        qXLMwpgpEyOud1RXe66EdRZonYhhCTg=
X-Google-Smtp-Source: ABdhPJxVRSRgL2C45JzlUfnk64Umy5VS7QXVkbIUWGYNVfQ53/NEIAiExfqrIiGa5vb43rmr7CHrDJLiI0s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:6512:3993:: with SMTP id
 j19mr5680886lfu.581.1639499009067; Tue, 14 Dec 2021 08:23:29 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:42 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-36-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 35/43] x86: kmsan: use __msan_ string functions where possible.
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
index a6cd6815f2490..b2c74cb85e20e 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -198,6 +198,7 @@ __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 	return p;
 }
 
+#ifndef CONFIG_KMSAN
 __FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
@@ -240,6 +241,7 @@ __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
 		fortify_panic(__func__);
 	return __underlying_memmove(p, q, size);
 }
+#endif
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
 __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
-- 
2.34.1.173.g76aa8bc2d0-goog

