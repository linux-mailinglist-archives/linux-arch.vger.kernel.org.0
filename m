Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38AAFCCA5
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfKNSEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 13:04:22 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:34199 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfKNSEV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 13:04:21 -0500
Received: by mail-wr1-f73.google.com with SMTP id c16so4906815wro.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nw4zt5zoe17M5yj/GBdsGwidr+1rdIV8qoHlTzgx1R4=;
        b=IgFzATzyy0L23kNBAmeMccvD0A0gwK0nhbw2INiPUzpci4c42e8mm++oXOlPsmUVJJ
         AyQJDLFkhAdnpuYtBLBSo8metnHOknHmAOl1i0A+J3g+tiAeXXP0xESGC42F82sXGheE
         Jzi8j9OfaEgGF5hrjFw8jihn3szNbtaOB+g8d/uDCEqdj3t8mvFO/Qs+GJoLxO8N4G4I
         OksaO1b2u+Y7COI4D2VKO06Y5i03gSe1lWbiDmRZls/LQXdqjhjOYU6SplisqNI6Pi2U
         4GM2qMtuW5KCUyk5I5DggraxsTDj1ujpRRCA1RP59f6gSXaRhpZNlb+7wPjjNHcBz9AK
         1QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nw4zt5zoe17M5yj/GBdsGwidr+1rdIV8qoHlTzgx1R4=;
        b=a6086z0hduwOnKU0NrgUyNLJA0/oC7h3KQHan2evAREKHl0h4/LHER5ucTl6JaeuGf
         geGEmksfeaBXBo+FK1UOZ+NLk/RQO7olivLEq9l0bH1Uk24OfgZMImC6elUjbdTRoNkc
         UmYGdl1g0FVO2RW+MJmi5ez7/Ykd4icuXpao2nzMJH8UUTpVOolOv4PZUq6my9fzpGjB
         wHsF4+ulmoa/42Uk+HpwnIo73at1gA1ogCDkChOPXCYYzH14/Cd1TL8N8S1L3z+2iQXP
         nAjastjxXqnK942m8lzJLM1xlRqquLggQXmeGXuXJ2u1JMjNZRSrV61YHRCfJQWF3pn7
         jgTg==
X-Gm-Message-State: APjAAAUIeshA7mneI3Zq/gFdE/SvS/lSkDRk7xsrEQ3mTWW7y6pD8+3d
        0Q7znObbTK+fFPkKkQ/8agw1ZeV8Qw==
X-Google-Smtp-Source: APXvYqyq+G3s/mweVViFx0LakXKfUyQ0F+KgtAGize+q9yiibcEFweFX+FGpI2K9Qqq+qlKbPiHDVVkVZA==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr9236334wrf.34.1573754657049;
 Thu, 14 Nov 2019 10:04:17 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:02:59 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-7-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 06/10] seqlock, kcsan: Add annotations for KCSAN
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
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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

=== Commentary on design around absence of clear begin/end markings ===
Seqlock usage via seqlock_t follows a predictable usage pattern, where
clear critical section begin/end is enforced. With subtle special cases
for readers needing to be flat atomic regions, e.g. because usage such
as in:
  - fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
  - fs/dcache.c:d_walk - unbalanced need_seqretry

But, anything directly accessing seqcount_t seems to be unpredictable.
Filtering for usage of read_seqcount_retry not following 'do { .. }
while (read_seqcount_retry(..));':

  $ git grep 'read_seqcount_retry' | grep -Ev 'while \(|seqlock.h|Doc|\* '
  => about 1/3 of the total read_seqcount_retry usage.

Just looking at fs/namei.c, we conclude that it is non-trivial to
prescribe and migrate to an interface that would force clear begin/end
seqlock markings for critical sections.

As such, we concluded that the best design currently, is to simply
ensure that KCSAN works well with the existing code.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
v3:
* Remove comment from raw_seqcount_barrier that should have been in next
  patch.
* Renamed kcsan_{nestable,flat}_atomic_{begin,end}
* Elaborate why clear begin/end cannot be enforced easily.
---
 include/linux/seqlock.h | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf26b8c8..61232bc223fd 100644
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
+ * As a consequence, we take the following best-effort approach for raw usage
+ * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
+ * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * atomics; if there is a matching read_seqcount_retry() call, no following
+ * memory operations are considered atomic. Usage of seqlocks via seqlock_t
+ * interface is not affected.
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
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
@@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 /**
@@ -271,9 +293,11 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
@@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
+	kcsan_nestable_atomic_begin();
 	s->sequence+=2;
+	kcsan_nestable_atomic_end();
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
+	kcsan_flat_atomic_begin();
+	return ret;
 }
 
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
+	/*
+	 * Assume not nested: read_seqretry may be called multiple times when
+	 * completing read critical section.
+	 */
+	kcsan_flat_atomic_end();
+
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

