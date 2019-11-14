Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A396AFCCB2
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKNSEd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 13:04:33 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:57171 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfKNSEb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 13:04:31 -0500
Received: by mail-wr1-f74.google.com with SMTP id m17so4837878wrn.23
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q8LRYTZHb8f6gAcyfckd2Vi+tmpZ+GaFgHUp3Cn6+f0=;
        b=VssIRr/LCE0G2YQeQ/fbMiVEmaEscBycKJ82YmNDJKvasAhquptar6ZAMnEjhwGsIj
         /xpq3oOnqU8oRK5VJIJahUsY4oVpS+ii5Tpfyxy3hr1gCnR/IJFPzTyWvVR0otLBS4uo
         SXPn/mMwpHJxNYd04hu90a3DGb9J21JdtFAQZWXdawCv06xxQ+U5WkqRFdfdORyelatl
         ZTSYq6LQUcFUe4B/jKwIp00bZKIirkQ7PJb5rtuwnaMMCoOmn0kbPQQtxlTv13FKnZgv
         Un0QvYpBfLQRjOzXC/3aMxusMU+owg1QBl5NMHRJhIHA444sD/cFhaBqvKxqcbnRJWdF
         Ygng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q8LRYTZHb8f6gAcyfckd2Vi+tmpZ+GaFgHUp3Cn6+f0=;
        b=K/14fI4ucEurrY8Z0vo/hq1VaRKXQ7xuHuMH9qK8+PSEbziNw/iYhQpL7m40NcpufQ
         z4TxriX68Sulcss6sY+6ouK8dxskIvZQaZl7+rNsYD/t0JUPK+yvh5D4zdpcSEyNJPio
         px7ndxh8oAY2fToVOxke2nAOWpa7B65Ea9XoOr2uIaz4z6vnmnbK00W9t0/w51HFogNZ
         6gJGrQYQ04e2dxROMLjGGVVFcXWUoErcRXDRc8ocsrCCxjwrTGxy0fw/xTDZVep/UE0u
         ANu8InKkij8ITH4tRmIGSB+J+QCkQ6edjgj7v+mUFELzQTeQg2KRxN9aqLeavapSCt6f
         ZA4g==
X-Gm-Message-State: APjAAAXOIEMfAs7gDvb6AowFBYKG7O9aOttSrJ9JnBY1XFiY4A40cQQG
        EbR3LQUnaHOikfThqzeEg/4Md5vi4g==
X-Google-Smtp-Source: APXvYqwojQj1GCS4ayt4pGEdWs6GL3Jc5z17yxjZyFpjIqeVFEW4vZ9/XREInAACE1otrk3ExkbTIkCpgw==
X-Received: by 2002:adf:f987:: with SMTP id f7mr9439504wrr.284.1573754667302;
 Thu, 14 Nov 2019 10:04:27 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:03:02 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-10-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 09/10] locking/atomics, kcsan: Add KCSAN instrumentation
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

This adds KCSAN instrumentation to atomic-instrumented.h.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
v2:
* Use kcsan_check{,_atomic}_{read,write} instead of
  kcsan_check_{access,atomic}.
* Introduce __atomic_check_{read,write} [Suggested by Mark Rutland].
---
 include/asm-generic/atomic-instrumented.h | 393 +++++++++++-----------
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 2 files changed, 218 insertions(+), 192 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index e8730c6b9fe2..3dc0f38544f6 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -19,11 +19,24 @@
 
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
+static inline void __atomic_check_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+static inline void __atomic_check_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
 
 static inline int
 atomic_read(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
 #define atomic_read atomic_read
@@ -32,7 +45,7 @@ atomic_read(const atomic_t *v)
 static inline int
 atomic_read_acquire(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic_read_acquire(v);
 }
 #define atomic_read_acquire atomic_read_acquire
@@ -41,7 +54,7 @@ atomic_read_acquire(const atomic_t *v)
 static inline void
 atomic_set(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
 #define atomic_set atomic_set
@@ -50,7 +63,7 @@ atomic_set(atomic_t *v, int i)
 static inline void
 atomic_set_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_set_release(v, i);
 }
 #define atomic_set_release atomic_set_release
@@ -59,7 +72,7 @@ atomic_set_release(atomic_t *v, int i)
 static inline void
 atomic_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
@@ -68,7 +81,7 @@ atomic_add(int i, atomic_t *v)
 static inline int
 atomic_add_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
@@ -78,7 +91,7 @@ atomic_add_return(int i, atomic_t *v)
 static inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
@@ -88,7 +101,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 static inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
@@ -98,7 +111,7 @@ atomic_add_return_release(int i, atomic_t *v)
 static inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
@@ -108,7 +121,7 @@ atomic_add_return_relaxed(int i, atomic_t *v)
 static inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
@@ -118,7 +131,7 @@ atomic_fetch_add(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
@@ -128,7 +141,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
@@ -138,7 +151,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
@@ -147,7 +160,7 @@ atomic_fetch_add_relaxed(int i, atomic_t *v)
 static inline void
 atomic_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
@@ -156,7 +169,7 @@ atomic_sub(int i, atomic_t *v)
 static inline int
 atomic_sub_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
@@ -166,7 +179,7 @@ atomic_sub_return(int i, atomic_t *v)
 static inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
@@ -176,7 +189,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 static inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
@@ -186,7 +199,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 static inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
@@ -196,7 +209,7 @@ atomic_sub_return_relaxed(int i, atomic_t *v)
 static inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
@@ -206,7 +219,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 static inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
@@ -216,7 +229,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
@@ -226,7 +239,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
@@ -236,7 +249,7 @@ atomic_fetch_sub_relaxed(int i, atomic_t *v)
 static inline void
 atomic_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
@@ -246,7 +259,7 @@ atomic_inc(atomic_t *v)
 static inline int
 atomic_inc_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
@@ -256,7 +269,7 @@ atomic_inc_return(atomic_t *v)
 static inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
@@ -266,7 +279,7 @@ atomic_inc_return_acquire(atomic_t *v)
 static inline int
 atomic_inc_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
@@ -276,7 +289,7 @@ atomic_inc_return_release(atomic_t *v)
 static inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
@@ -286,7 +299,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 static inline int
 atomic_fetch_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
@@ -296,7 +309,7 @@ atomic_fetch_inc(atomic_t *v)
 static inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
@@ -306,7 +319,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 static inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
@@ -316,7 +329,7 @@ atomic_fetch_inc_release(atomic_t *v)
 static inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
@@ -326,7 +339,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 static inline void
 atomic_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
@@ -336,7 +349,7 @@ atomic_dec(atomic_t *v)
 static inline int
 atomic_dec_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
@@ -346,7 +359,7 @@ atomic_dec_return(atomic_t *v)
 static inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
@@ -356,7 +369,7 @@ atomic_dec_return_acquire(atomic_t *v)
 static inline int
 atomic_dec_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
@@ -366,7 +379,7 @@ atomic_dec_return_release(atomic_t *v)
 static inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
@@ -376,7 +389,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 static inline int
 atomic_fetch_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
@@ -386,7 +399,7 @@ atomic_fetch_dec(atomic_t *v)
 static inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
@@ -396,7 +409,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 static inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
@@ -406,7 +419,7 @@ atomic_fetch_dec_release(atomic_t *v)
 static inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
@@ -415,7 +428,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 static inline void
 atomic_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
@@ -424,7 +437,7 @@ atomic_and(int i, atomic_t *v)
 static inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
@@ -434,7 +447,7 @@ atomic_fetch_and(int i, atomic_t *v)
 static inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
@@ -444,7 +457,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
@@ -454,7 +467,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
@@ -464,7 +477,7 @@ atomic_fetch_and_relaxed(int i, atomic_t *v)
 static inline void
 atomic_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
@@ -474,7 +487,7 @@ atomic_andnot(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
@@ -484,7 +497,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
@@ -494,7 +507,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
@@ -504,7 +517,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
@@ -513,7 +526,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 static inline void
 atomic_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
@@ -522,7 +535,7 @@ atomic_or(int i, atomic_t *v)
 static inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
@@ -532,7 +545,7 @@ atomic_fetch_or(int i, atomic_t *v)
 static inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
@@ -542,7 +555,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
@@ -552,7 +565,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
@@ -561,7 +574,7 @@ atomic_fetch_or_relaxed(int i, atomic_t *v)
 static inline void
 atomic_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
@@ -570,7 +583,7 @@ atomic_xor(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
@@ -580,7 +593,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
@@ -590,7 +603,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
@@ -600,7 +613,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
@@ -610,7 +623,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
 static inline int
 atomic_xchg(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
@@ -620,7 +633,7 @@ atomic_xchg(atomic_t *v, int i)
 static inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
@@ -630,7 +643,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 static inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
@@ -640,7 +653,7 @@ atomic_xchg_release(atomic_t *v, int i)
 static inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
@@ -650,7 +663,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
 static inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
@@ -660,7 +673,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 static inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
@@ -670,7 +683,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 static inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
@@ -680,7 +693,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 static inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
@@ -690,8 +703,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 static inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #define atomic_try_cmpxchg atomic_try_cmpxchg
@@ -701,8 +714,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 static inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
@@ -712,8 +725,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 static inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 #define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
@@ -723,8 +736,8 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 static inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
@@ -734,7 +747,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 static inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
@@ -744,7 +757,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 static inline bool
 atomic_dec_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
@@ -754,7 +767,7 @@ atomic_dec_and_test(atomic_t *v)
 static inline bool
 atomic_inc_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
@@ -764,7 +777,7 @@ atomic_inc_and_test(atomic_t *v)
 static inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
@@ -774,7 +787,7 @@ atomic_add_negative(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
@@ -784,7 +797,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
 static inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
@@ -794,7 +807,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
 static inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
@@ -804,7 +817,7 @@ atomic_inc_not_zero(atomic_t *v)
 static inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
@@ -814,7 +827,7 @@ atomic_inc_unless_negative(atomic_t *v)
 static inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
@@ -824,7 +837,7 @@ atomic_dec_unless_positive(atomic_t *v)
 static inline int
 atomic_dec_if_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
@@ -833,7 +846,7 @@ atomic_dec_if_positive(atomic_t *v)
 static inline s64
 atomic64_read(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
 #define atomic64_read atomic64_read
@@ -842,7 +855,7 @@ atomic64_read(const atomic64_t *v)
 static inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic64_read_acquire(v);
 }
 #define atomic64_read_acquire atomic64_read_acquire
@@ -851,7 +864,7 @@ atomic64_read_acquire(const atomic64_t *v)
 static inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
 #define atomic64_set atomic64_set
@@ -860,7 +873,7 @@ atomic64_set(atomic64_t *v, s64 i)
 static inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_set_release(v, i);
 }
 #define atomic64_set_release atomic64_set_release
@@ -869,7 +882,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 static inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
@@ -878,7 +891,7 @@ atomic64_add(s64 i, atomic64_t *v)
 static inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
@@ -888,7 +901,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 static inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
@@ -898,7 +911,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
@@ -908,7 +921,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
@@ -918,7 +931,7 @@ atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
@@ -928,7 +941,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
@@ -938,7 +951,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
@@ -948,7 +961,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
@@ -957,7 +970,7 @@ atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 static inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
@@ -966,7 +979,7 @@ atomic64_sub(s64 i, atomic64_t *v)
 static inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
@@ -976,7 +989,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 static inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
@@ -986,7 +999,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
@@ -996,7 +1009,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
@@ -1006,7 +1019,7 @@ atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
@@ -1016,7 +1029,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
@@ -1026,7 +1039,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
@@ -1036,7 +1049,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
@@ -1046,7 +1059,7 @@ atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 static inline void
 atomic64_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
@@ -1056,7 +1069,7 @@ atomic64_inc(atomic64_t *v)
 static inline s64
 atomic64_inc_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
@@ -1066,7 +1079,7 @@ atomic64_inc_return(atomic64_t *v)
 static inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
@@ -1076,7 +1089,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 static inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
@@ -1086,7 +1099,7 @@ atomic64_inc_return_release(atomic64_t *v)
 static inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
@@ -1096,7 +1109,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 static inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
@@ -1106,7 +1119,7 @@ atomic64_fetch_inc(atomic64_t *v)
 static inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
@@ -1116,7 +1129,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 static inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
@@ -1126,7 +1139,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 static inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
@@ -1136,7 +1149,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 static inline void
 atomic64_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
@@ -1146,7 +1159,7 @@ atomic64_dec(atomic64_t *v)
 static inline s64
 atomic64_dec_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
@@ -1156,7 +1169,7 @@ atomic64_dec_return(atomic64_t *v)
 static inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
@@ -1166,7 +1179,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 static inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
@@ -1176,7 +1189,7 @@ atomic64_dec_return_release(atomic64_t *v)
 static inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
@@ -1186,7 +1199,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 static inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
@@ -1196,7 +1209,7 @@ atomic64_fetch_dec(atomic64_t *v)
 static inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
@@ -1206,7 +1219,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 static inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
@@ -1216,7 +1229,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 static inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
@@ -1225,7 +1238,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 static inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
@@ -1234,7 +1247,7 @@ atomic64_and(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
@@ -1244,7 +1257,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
@@ -1254,7 +1267,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
@@ -1264,7 +1277,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
@@ -1274,7 +1287,7 @@ atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 static inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
@@ -1284,7 +1297,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
@@ -1294,7 +1307,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
@@ -1304,7 +1317,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
@@ -1314,7 +1327,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
@@ -1323,7 +1336,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 static inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
@@ -1332,7 +1345,7 @@ atomic64_or(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
@@ -1342,7 +1355,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
@@ -1352,7 +1365,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
@@ -1362,7 +1375,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
@@ -1371,7 +1384,7 @@ atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 static inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
@@ -1380,7 +1393,7 @@ atomic64_xor(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
@@ -1390,7 +1403,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
@@ -1400,7 +1413,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
@@ -1410,7 +1423,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
@@ -1420,7 +1433,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 static inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
@@ -1430,7 +1443,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 static inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
@@ -1440,7 +1453,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 static inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
@@ -1450,7 +1463,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 static inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
@@ -1460,7 +1473,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 static inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
@@ -1470,7 +1483,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 static inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
@@ -1480,7 +1493,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 static inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
@@ -1490,7 +1503,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 static inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
@@ -1500,8 +1513,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 static inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
@@ -1511,8 +1524,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 static inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
@@ -1522,8 +1535,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 static inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 #define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
@@ -1533,8 +1546,8 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 static inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	__atomic_check_write(v, sizeof(*v));
+	__atomic_check_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
@@ -1544,7 +1557,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 static inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
@@ -1554,7 +1567,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
 static inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
@@ -1564,7 +1577,7 @@ atomic64_dec_and_test(atomic64_t *v)
 static inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
@@ -1574,7 +1587,7 @@ atomic64_inc_and_test(atomic64_t *v)
 static inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
@@ -1584,7 +1597,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
@@ -1594,7 +1607,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 static inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
@@ -1604,7 +1617,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 static inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
@@ -1614,7 +1627,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 static inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
@@ -1624,7 +1637,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 static inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
@@ -1634,7 +1647,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 static inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1644,7 +1657,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1653,7 +1666,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1662,7 +1675,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1671,7 +1684,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1680,7 +1693,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1689,7 +1702,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1698,7 +1711,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1707,7 +1720,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1716,7 +1729,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1725,7 +1738,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1734,7 +1747,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1743,7 +1756,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1751,28 +1764,28 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg64_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define sync_cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg_double(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1780,9 +1793,9 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_double_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// b29b625d5de9280f680e42c7be859b55b15e5f6a
+// beea41c2a0f2c69e4958ed71bf26f59740fa4b12
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index e09812372b17..8b8b2a6f8d68 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -20,7 +20,7 @@ gen_param_check()
 	# We don't write to constant parameters
 	[ ${type#c} != ${type} ] && rw="read"
 
-	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\t__atomic_check_${rw}(${name}, sizeof(*${name}));\n"
 }
 
 #gen_param_check(arg...)
@@ -107,7 +107,7 @@ cat <<EOF
 #define ${xchg}(ptr, ...)						\\
 ({									\\
 	typeof(ptr) __ai_ptr = (ptr);					\\
-	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
+	__atomic_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
 	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
 })
 EOF
@@ -148,6 +148,19 @@ cat << EOF
 
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
+static inline void __atomic_check_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+static inline void __atomic_check_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
 
 EOF
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

