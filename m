Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815724747B5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhLNQWy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhLNQWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:50 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF519C061757
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:49 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so8114176wmq.9
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L9bpZFAJqwWr0sK9cJmNI2AyaK0oQbsHwHE0NZymKYw=;
        b=psK3I4np4MgxxiZg24Ts6iYYQ66nfNvuOqGX5AV9cqUH1vZZOxWpAWjpD9z7asOJqr
         A4CCuPFhy50SccNFOdcppzE9XFAmI2LJPzFGf5VLD1TaoeUH/M9J/OeKmNVCs56IuPTO
         XgnJfweCAiaABHyvxz7o+vsCL0xBmxUIYsIMueUOq21Wm1yTojJtPI9Z3jNdrAqVvh/q
         69vsjF1Kv8a5bNSD6N7FJS6B4Q4G4OBPOIfQJuhZPf/tLUF3Ro21MZoroHW2P5hUno3R
         jrQ6N6CzhD5gex4V8nbCtj7x715xxTwRuMHnd9Toq71qs921Xei6dnI+DQpnY+bUI0/6
         s/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L9bpZFAJqwWr0sK9cJmNI2AyaK0oQbsHwHE0NZymKYw=;
        b=FeMs7j8IulY7HbSptperGoovWbdhC62Zsy0gj3Xga2zb/rJoyJwuh9K8wQsOpbXm6A
         DO42BfaY1kbR0rYDv0OYF1en8wQNyMxPPg9bBlsF9+bxhdD2HVihCIt3kDIQGknlMQaG
         Vw7dgHuuFNBZKruo8h45raeS0ZCnFjJhN6NkE5hgXRcMaYcU6DD146U8R9BoNCItZ96/
         /sK96tbFjbPdgWsdKOAruyGiiqi+LoNp/QH4lQKjOaEyVSauPVdKf0iqaAFF61aTo3mP
         amyRCJUX6lzOzFq9TDpdXgFKO+W/l858ZBksmnvkdy3Z/AbcCYodEPY+sUUeQ1sw2+P7
         OLUA==
X-Gm-Message-State: AOAM532KoxHbcbltHSavcydhhcvdv4Cs+apGrHsqxamKt4frQaZ/JfAe
        vjIou7aREMiB5qEH6vhmCIneA/aCZIQ=
X-Google-Smtp-Source: ABdhPJzq0aOyE1rk6smoEKoJQb17yWIza1caNiEXRrMx6w9vfjQeetvWU3p7URL7lNRDdTsZsQQeu0EE/T0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:df0b:: with SMTP id y11mr6688786wrl.181.1639498968312;
 Tue, 14 Dec 2021 08:22:48 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:27 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-21-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 20/43] instrumented.h: add KMSAN support
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

To avoid false positives, KMSAN needs to unpoison the data copied from
the userspace. To detect infoleaks - check the memory buffer passed to
copy_to_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I43e93b9c02709e6be8d222342f1b044ac8bdbaaf
---
 include/linux/instrumented.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.34.1.173.g76aa8bc2d0-goog

