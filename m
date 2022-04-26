Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C55103E7
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353126AbiDZQrv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353134AbiDZQrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:48 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFC191C6C
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:32 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id dp12-20020a170906c14c00b006e7e8234ae2so9349286ejc.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jT7N8sHbqw5Bt63XokggrytDJOztxBUcMGiWNZUZnNs=;
        b=socyW/SWH6WVUElWDQ9so0Jec6CqBHZso2QGVjaGlPPUu+vTsdFC6iZP42U1gWVUW8
         lw5Omaj6xQ6NIAx4hEPTVPQZVPhUnOOdq2KiTARpdZyQ3LitifZ9pKoTzPHYkhsda4Rc
         I3/96cm8sYfgVBN9+zu56yewNbGMMZugG3lvIt1FRn+zBDIMu2owM5cLnh00hlx9RTgJ
         2Z6YBAV3FKrKFXGf4sOcstHFSQon+8TmbuzAsNLmJ8iTodBN45fyl/KZmz89vwrBf1cr
         dJFUsGH8Xd4MrMUpg558yBB4sq9J25PoMnfrF15rZOAHy5XHDqKNCFXnOKuvMldOAx0v
         Xc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jT7N8sHbqw5Bt63XokggrytDJOztxBUcMGiWNZUZnNs=;
        b=7MmBvjHYQwbNAj0yZuexCLOfMGId4PRyXLeYicvwIcNwsnkvHLCAdy37cktjexlbEi
         zxdpdj5ushCqlbVMyx7SzILCxTW2QgmL7otOkIaLIlqmNz+xPGF5HmAUhant+Xtia+eW
         bh69FFslkujdwQwuqJI5bMxDc27vnJQ9Mx2dme2sUZLGJZGEhT6muQho29aQzUsF97ez
         sWoOKtqkyFN33er5SfrzApssXRb4QikJui7Ba3+MNrnPrTIfKazFHyOIowg7nhMClO9S
         gZPu0Vwh9gSJUXSyrgQ0T4G0tqtwBGeNKzKnPosIziHr0RCR3pB7PmFZ1s/xN/FbJXH2
         +8EA==
X-Gm-Message-State: AOAM533Z3mmNpn3oP/lrwYVrNXn9EuJ9JrUcVPTQvtH/1b2hXZIsdaTa
        4ppftnkGzw8UV/yc+r4BkCaiD1CkzX8=
X-Google-Smtp-Source: ABdhPJzVoY4VqalpQr3d8BPXtD+NaAh71WbLc1nD76HvvUm8mcb7U8Xkr1TFGyyyj1Et3ec1q26DZC4DL3U=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:3593:b0:425:dfd4:2947 with SMTP id
 y19-20020a056402359300b00425dfd42947mr14309082edc.137.1650991470646; Tue, 26
 Apr 2022 09:44:30 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:33 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-5-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 04/46] instrumented.h: allow instrumenting both sides of copy_from_user()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce instrument_copy_from_user_before() and
instrument_copy_from_user_after() hooks to be invoked before and after
the call to copy_from_user().

KASAN and KCSAN will be only using instrument_copy_from_user_before(),
but for KMSAN we'll need to insert code after copy_from_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I855034578f0b0f126734cbd734fb4ae1d3a6af99
---
 include/linux/instrumented.h | 21 +++++++++++++++++++--
 include/linux/uaccess.h      | 19 ++++++++++++++-----
 lib/iov_iter.c               |  9 ++++++---
 lib/usercopy.c               |  3 ++-
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 42faebbaa202a..ee8f7d17d34f5 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -120,7 +120,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 
 /**
- * instrument_copy_from_user - instrument writes of copy_from_user
+ * instrument_copy_from_user_before - add instrumentation before copy_from_user
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted before the accesses.
@@ -130,10 +130,27 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
  * @n number of bytes to copy
  */
 static __always_inline void
-instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
+instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
 {
 	kasan_check_write(to, n);
 	kcsan_check_write(to, n);
 }
 
+/**
+ * instrument_copy_from_user_after - add instrumentation after copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants). The instrumentation should be inserted after the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ * @left number of bytes not copied (as returned by copy_from_user)
+ */
+static __always_inline void
+instrument_copy_from_user_after(const void *to, const void __user *from,
+				unsigned long n, unsigned long left)
+{
+}
+
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 546179418ffa2..079bdea3b9dcd 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -58,20 +58,28 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	instrument_copy_from_user(to, from, n);
+	unsigned long res;
+
+	instrument_copy_from_user_before(to, from, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
+	instrument_copy_from_user_before(to, from, n);
 	if (should_fail_usercopy())
 		return n;
-	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, res);
+	return res;
 }
 
 /**
@@ -115,8 +123,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		instrument_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a995..fb19401c29c4f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -159,13 +159,16 @@ static int copyout(void __user *to, const void *from, size_t n)
 
 static int copyin(void *to, const void __user *from, size_t n)
 {
+	size_t res = n;
+
 	if (should_fail_usercopy())
 		return n;
 	if (access_ok(from, n)) {
-		instrument_copy_from_user(to, from, n);
-		n = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
+		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
-	return n;
+	return res;
 }
 
 static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7413dd300516e..1505a52f23a01 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -12,8 +12,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		instrument_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

