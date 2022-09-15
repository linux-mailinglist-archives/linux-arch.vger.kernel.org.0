Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B05B9E0B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIOPFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIOPEt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:04:49 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F820BDE
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so7603803ejc.6
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=msgzHzsxvMZcLqG5jRq1WtDuSKgOL7FjSU3mDqU1uyE=;
        b=OJ1zZnEDisYf20/w2ufGsvf/4BmFJL6F+ZhkDMO9RSLgOWaUeOqgIZIEGBcs1xvjyE
         Vhi8oq1M5fuOo1BqRow0T2kkjWn7MFIiDl4Vxh0JvAvzMUcoBFNGV5OjD/1YNXh8Cb3e
         yBOZYjRifZkg/DWICVkMAwQ0rJNw34aIbPzK0IaH5U++++uKm/Nb/YWU7DG9jJPbW4je
         c+0D9D8GEACiFbk4kbys72G+E4/BBC6t7mtRJi/G2Ikv3nyuJnt9d8HjxthckZDQoevO
         /FUhBUjORIPB01uQTITnhxROg/kQNGDd3OFt2E1ajNcLp0VYOYpj5PP8IggJI7JbIss8
         fOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=msgzHzsxvMZcLqG5jRq1WtDuSKgOL7FjSU3mDqU1uyE=;
        b=Ouh9+iSOK1+Gn9Z6tOjhK+yISMvn6k0Gu/nf/bfeOF2poUpu9FOqLpFw4VwqIrIddJ
         APkFbEG1lTspOEO73dDoouSjgG145fS8LfnZxlrxcCCpYHxLFMoz8siiyEovRkex20eo
         3ZyQyn+/1/v0foy6PzoGgyfobKLe78LEV6TNKYsKyDWNScbrD/rzY3l04B4d4O9ob9V1
         mrjojCuswt3pzCm6LFgjRiHzbrCVYgWTtW3gWT7h8rzS06ttinwNlVNVHWp7nl8WJzGn
         TN6bppCxyrwbuyQfF+aqgHDoFWJgwaWDkTl0ocxWpQebRnCeQV8H+mtA6Ex1bxWJsEeu
         gtHg==
X-Gm-Message-State: ACrzQf1lqB0ojSTUIz4ZCwHI1szpFq0P5Ng/7aAMLeWcygll8qKVhVEg
        OCTkC8wrdhphsIXP6WmVQ26hj/EcuwM=
X-Google-Smtp-Source: AMsMyM5UV2lppQQoT85C2x0ZnCpLHOXrW/G23K2oT1zkSuuxsEEabT6dnZVkKB+qN2mRnFLrLNuGLySnQgE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:7612:b0:771:db66:7b77 with SMTP id
 jx18-20020a170907761200b00771db667b77mr309998ejc.228.1663254286414; Thu, 15
 Sep 2022 08:04:46 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:37 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-4-glider@google.com>
Subject: [PATCH v7 03/43] instrumented.h: allow instrumenting both sides of copy_from_user()
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

Introduce instrument_copy_from_user_before() and
instrument_copy_from_user_after() hooks to be invoked before and after
the call to copy_from_user().

KASAN and KCSAN will be only using instrument_copy_from_user_before(),
but for KMSAN we'll need to insert code after copy_from_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v4:
 -- fix _copy_from_user_key() in arch/s390/lib/uaccess.c (Reported-by:
    kernel test robot <lkp@intel.com>)

Link: https://linux-review.googlesource.com/id/I855034578f0b0f126734cbd734fb4ae1d3a6af99
---
 arch/s390/lib/uaccess.c      |  3 ++-
 include/linux/instrumented.h | 21 +++++++++++++++++++--
 include/linux/uaccess.h      | 19 ++++++++++++++-----
 lib/iov_iter.c               |  9 ++++++---
 lib/usercopy.c               |  3 ++-
 5 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index d7b3b193d1088..58033dfcb6d45 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -81,8 +81,9 @@ unsigned long _copy_from_user_key(void *to, const void __user *from,
 
 	might_fault();
 	if (!should_fail_usercopy()) {
-		instrument_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user_key(to, from, n, key);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
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
index 47e5d374c7ebe..afb18f198843b 100644
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
index 4b7fce72e3e52..c3ca28ca68a65 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -174,13 +174,16 @@ static int copyout(void __user *to, const void *from, size_t n)
 
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
 
 static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info *pipe,
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
2.37.2.789.g6183377224-goog

