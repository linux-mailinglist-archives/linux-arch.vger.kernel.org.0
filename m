Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129F8DAF65
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439929AbfJQONm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:13:42 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33191 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439887AbfJQONk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:40 -0400
Received: by mail-qt1-f202.google.com with SMTP id k53so2446573qtk.0
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ip3P4i20fQEf4b5wirUedHF2574zJ+yd56tKHujm1bg=;
        b=AgCEZD8UVe6mWYXJb+txOu8iRAlpncqlSJC3w4AIm7e5AqUthlTntb/9CDvD2rB0dW
         a5FPKOjzCIVSVSZjUZMDO3Iad458Xn4cW7enROkYh/uBUhQdsH8m6IBNmVie1+ZoMIxm
         nctxfK0RkfHydReBwe5q1RhO6Tkl9ZNcOqRjsZODJWd5RADfElv2yDMaftj0eecg//jd
         oGXHVtKMwq+vS1cAJH58HLbXwzlMpZ3VpIFmGkphK3Z4W1pls2nsD9bqM8TtdMK0677B
         4Tv6nEw0zI1BAjQLGfp6t0Hrhhb04f32p5H67aN0U+QsDvcmS3cySEvWhTnLlZN5+3lv
         qr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ip3P4i20fQEf4b5wirUedHF2574zJ+yd56tKHujm1bg=;
        b=ekgRp7y3YyjyrDDTHivv7HnKtltdALuN2GEdeA6nN9Dbt6tidU9rc1aOGbLTCODdS2
         cOoJOJAKCWCVdfmZggSYVmLfzCNGCtkebAHXSgAfbmutRUh4Twn8xV5Fw9Kjfbw9cIQa
         Fmgc4FsjyLAhRitXu6HNem7WcHS3xDtLiCNZ52c2O6+64CUvDAJC4hecoda6VyR0RG8n
         dthkRaQslfZbOWAUNxQu8PFUaGEiLMvwiEL7WFdtEnHDJ4WeD4sBHwSSi2KSjoTMz5pr
         RC4jabOISV205N/usY80rqSSQl/ctVrrGzkuc0f4R9exXfkAEPKLhBN7izm99bTfXDUr
         Qxcg==
X-Gm-Message-State: APjAAAVPn8p7i+qrsZ9uDufyeE8MU0cJGMUNx3entWL534lX/xqHoelt
        IrNIkIB8384ujejZR+Vqt+ry7c4Lcg==
X-Google-Smtp-Source: APXvYqzrcnGW1lI+Gxy2rLvKkrrRrqs3J9SSrFvhiW4X6PylUpt1XSF1crDZlHI52IRZwqkUyyn7a2hahw==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr4041664qvr.159.1571321618815;
 Thu, 17 Oct 2019 07:13:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:13:01 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-Id: <20191017141305.146193-5-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 4/8] seqlock, kcsan: Add annotations for KCSAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since seqlocks in the Linux kernel do not require the use of marked
atomic accesses in critical sections, we teach KCSAN to assume such
accesses are atomic. KCSAN currently also pretends that writes to
`sequence` are atomic, although currently plain writes are used (their
corresponding reads are READ_ONCE).

Further, to avoid false positives in the absence of clear ending of a
seqlock reader critical section (only when using the raw interface),
KCSAN assumes a fixed number of accesses after start of a seqlock
critical section are atomic.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 44 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf26b8c8..1e425831a7ed 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,8 +37,24 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
+#include <linux/kcsan.h>
 #include <asm/processor.h>
 
+/*
+ * The seqlock interface does not prescribe a precise sequence of read
+ * begin/retry/end. For readers, typically there is a call to
+ * read_seqcount_begin() and read_seqcount_retry(), however, there are more
+ * esoteric cases which do not follow this pattern.
+ *
+ * As a consequence, we take the following best-effort approach for *raw* usage
+ * of seqlocks under KCSAN: upon beginning a seq-reader critical section,
+ * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * atomics; if there is a matching read_seqcount_retry() call, no following
+ * memory operations are considered atomic. Non-raw usage of seqlocks is not
+ * affected.
+ */
+#define KCSAN_SEQLOCK_REGION_MAX 1000
+
 /*
  * Version using sequence counter only.
  * This can be used when code has its own mutex protecting the
@@ -115,6 +131,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 		cpu_relax();
 		goto repeat;
 	}
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret & ~1;
 }
 
@@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  */
 static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
-	return unlikely(s->sequence != start);
+	kcsan_atomic_next(0);
+	return unlikely(READ_ONCE(s->sequence) != start);
 }
 
 /**
@@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
+	kcsan_begin_atomic(true);
 	s->sequence++;
 	smp_wmb();
 }
@@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
+	kcsan_end_atomic(true);
 }
 
 /**
@@ -262,18 +284,20 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  *      void write(void)
  *      {
- *              Y = true;
+ *              WRITE_ONCE(Y, true);
  *
  *              raw_write_seqcount_barrier(seq);
  *
- *              X = false;
+ *              WRITE_ONCE(X, false);
  *      }
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
+	kcsan_begin_atomic(true);
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
+	kcsan_end_atomic(true);
 }
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
@@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
+	kcsan_begin_atomic(true);
 	s->sequence+=2;
+	kcsan_end_atomic(true);
 }
 
 typedef struct {
@@ -430,11 +456,21 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	return read_seqcount_begin(&sl->seqcount);
+	unsigned ret = read_seqcount_begin(&sl->seqcount);
+
+	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
+	kcsan_begin_atomic(false);
+	return ret;
 }
 
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
+	/*
+	 * Assume not nested: read_seqretry may be called multiple times when
+	 * completing read critical section.
+	 */
+	kcsan_end_atomic(false);
+
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
-- 
2.23.0.866.gb869b98d4c-goog

