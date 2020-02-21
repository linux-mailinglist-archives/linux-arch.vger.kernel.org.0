Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933B5167F34
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgBUNvE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45630 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgBUNur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3BKzyRHK/V7AEA5pztGIER3Yft8rw9QQ8KBAFI9UtAI=; b=0wBU01/u/KrXS1IaAvfh6w/XIe
        GCV6Sa96S0Z9uX98Pj31lzvsXcmb8eCgvmFSuh+wPXZ7CYBLpxdqv4WETb9naqdSy1Zqg4D8sgVGo
        tAbZzLiAGaIfyU2vtYWxnpFMHHKIlWFon6Sk2l6VLk5RCmEcIQdrs94VUMbwgmgs3ufzBNcEnoR0V
        +117R9JDXowdtAlrqEHrQ7MfRvkks/VV4/+qxz5imIK7dFm8pyaRkwD4im/1LWoIUzQmdtmNDgcrl
        nL7bETpijPUJnE0U2dBNBlcNE+5IPAfmyiE5Y8H6vGX+gGg/i1YFAPcYEnHJpggmVEZEaIFYxcTNr
        wIWpWp3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0006VJ-L2; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A630C307938;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 124A929D740B2; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.350533580@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 19/27] locking/atomics, kcsan: Add KCSAN instrumentation
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

This adds KCSAN instrumentation to atomic-instrumented.h.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[peterz: removed the actual kcsan hooks]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 include/asm-generic/atomic-instrumented.h |  390 +++++++++++++++---------------
 scripts/atomic/gen-atomic-instrumented.sh |   14 -
 2 files changed, 212 insertions(+), 192 deletions(-)

--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -20,10 +20,20 @@
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
 
+static inline void __atomic_check_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+}
+
+static inline void __atomic_check_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+}
+
 static inline int
 atomic_read(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
 #define atomic_read atomic_read
@@ -32,7 +42,7 @@ atomic_read(const atomic_t *v)
 static inline int
 atomic_read_acquire(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic_read_acquire(v);
 }
 #define atomic_read_acquire atomic_read_acquire
@@ -41,7 +51,7 @@ atomic_read_acquire(const atomic_t *v)
 static inline void
 atomic_set(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
 #define atomic_set atomic_set
@@ -50,7 +60,7 @@ atomic_set(atomic_t *v, int i)
 static inline void
 atomic_set_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_set_release(v, i);
 }
 #define atomic_set_release atomic_set_release
@@ -59,7 +69,7 @@ atomic_set_release(atomic_t *v, int i)
 static inline void
 atomic_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
@@ -68,7 +78,7 @@ atomic_add(int i, atomic_t *v)
 static inline int
 atomic_add_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
@@ -78,7 +88,7 @@ atomic_add_return(int i, atomic_t *v)
 static inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
@@ -88,7 +98,7 @@ atomic_add_return_acquire(int i, atomic_
 static inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
@@ -98,7 +108,7 @@ atomic_add_return_release(int i, atomic_
 static inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
@@ -108,7 +118,7 @@ atomic_add_return_relaxed(int i, atomic_
 static inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
@@ -118,7 +128,7 @@ atomic_fetch_add(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
@@ -128,7 +138,7 @@ atomic_fetch_add_acquire(int i, atomic_t
 static inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
@@ -138,7 +148,7 @@ atomic_fetch_add_release(int i, atomic_t
 static inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
@@ -147,7 +157,7 @@ atomic_fetch_add_relaxed(int i, atomic_t
 static inline void
 atomic_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
@@ -156,7 +166,7 @@ atomic_sub(int i, atomic_t *v)
 static inline int
 atomic_sub_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
@@ -166,7 +176,7 @@ atomic_sub_return(int i, atomic_t *v)
 static inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
@@ -176,7 +186,7 @@ atomic_sub_return_acquire(int i, atomic_
 static inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
@@ -186,7 +196,7 @@ atomic_sub_return_release(int i, atomic_
 static inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
@@ -196,7 +206,7 @@ atomic_sub_return_relaxed(int i, atomic_
 static inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
@@ -206,7 +216,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 static inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
@@ -216,7 +226,7 @@ atomic_fetch_sub_acquire(int i, atomic_t
 static inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
@@ -226,7 +236,7 @@ atomic_fetch_sub_release(int i, atomic_t
 static inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
@@ -236,7 +246,7 @@ atomic_fetch_sub_relaxed(int i, atomic_t
 static inline void
 atomic_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
@@ -246,7 +256,7 @@ atomic_inc(atomic_t *v)
 static inline int
 atomic_inc_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
@@ -256,7 +266,7 @@ atomic_inc_return(atomic_t *v)
 static inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
@@ -266,7 +276,7 @@ atomic_inc_return_acquire(atomic_t *v)
 static inline int
 atomic_inc_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
@@ -276,7 +286,7 @@ atomic_inc_return_release(atomic_t *v)
 static inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
@@ -286,7 +296,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 static inline int
 atomic_fetch_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
@@ -296,7 +306,7 @@ atomic_fetch_inc(atomic_t *v)
 static inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
@@ -306,7 +316,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 static inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
@@ -316,7 +326,7 @@ atomic_fetch_inc_release(atomic_t *v)
 static inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
@@ -326,7 +336,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 static inline void
 atomic_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
@@ -336,7 +346,7 @@ atomic_dec(atomic_t *v)
 static inline int
 atomic_dec_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
@@ -346,7 +356,7 @@ atomic_dec_return(atomic_t *v)
 static inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
@@ -356,7 +366,7 @@ atomic_dec_return_acquire(atomic_t *v)
 static inline int
 atomic_dec_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
@@ -366,7 +376,7 @@ atomic_dec_return_release(atomic_t *v)
 static inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
@@ -376,7 +386,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 static inline int
 atomic_fetch_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
@@ -386,7 +396,7 @@ atomic_fetch_dec(atomic_t *v)
 static inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
@@ -396,7 +406,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 static inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
@@ -406,7 +416,7 @@ atomic_fetch_dec_release(atomic_t *v)
 static inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
@@ -415,7 +425,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 static inline void
 atomic_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
@@ -424,7 +434,7 @@ atomic_and(int i, atomic_t *v)
 static inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
@@ -434,7 +444,7 @@ atomic_fetch_and(int i, atomic_t *v)
 static inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
@@ -444,7 +454,7 @@ atomic_fetch_and_acquire(int i, atomic_t
 static inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
@@ -454,7 +464,7 @@ atomic_fetch_and_release(int i, atomic_t
 static inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
@@ -464,7 +474,7 @@ atomic_fetch_and_relaxed(int i, atomic_t
 static inline void
 atomic_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
@@ -474,7 +484,7 @@ atomic_andnot(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
@@ -484,7 +494,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 static inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
@@ -494,7 +504,7 @@ atomic_fetch_andnot_acquire(int i, atomi
 static inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
@@ -504,7 +514,7 @@ atomic_fetch_andnot_release(int i, atomi
 static inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
@@ -513,7 +523,7 @@ atomic_fetch_andnot_relaxed(int i, atomi
 static inline void
 atomic_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
@@ -522,7 +532,7 @@ atomic_or(int i, atomic_t *v)
 static inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
@@ -532,7 +542,7 @@ atomic_fetch_or(int i, atomic_t *v)
 static inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
@@ -542,7 +552,7 @@ atomic_fetch_or_acquire(int i, atomic_t
 static inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
@@ -552,7 +562,7 @@ atomic_fetch_or_release(int i, atomic_t
 static inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
@@ -561,7 +571,7 @@ atomic_fetch_or_relaxed(int i, atomic_t
 static inline void
 atomic_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
@@ -570,7 +580,7 @@ atomic_xor(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
@@ -580,7 +590,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 static inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
@@ -590,7 +600,7 @@ atomic_fetch_xor_acquire(int i, atomic_t
 static inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
@@ -600,7 +610,7 @@ atomic_fetch_xor_release(int i, atomic_t
 static inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
@@ -610,7 +620,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t
 static inline int
 atomic_xchg(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
@@ -620,7 +630,7 @@ atomic_xchg(atomic_t *v, int i)
 static inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
@@ -630,7 +640,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 static inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
@@ -640,7 +650,7 @@ atomic_xchg_release(atomic_t *v, int i)
 static inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
@@ -650,7 +660,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
 static inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
@@ -660,7 +670,7 @@ atomic_cmpxchg(atomic_t *v, int old, int
 static inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
@@ -670,7 +680,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int
 static inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
@@ -680,7 +690,7 @@ atomic_cmpxchg_release(atomic_t *v, int
 static inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
@@ -690,8 +700,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int
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
@@ -701,8 +711,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old
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
@@ -712,8 +722,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v,
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
@@ -723,8 +733,8 @@ atomic_try_cmpxchg_release(atomic_t *v,
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
@@ -734,7 +744,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v,
 static inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
@@ -744,7 +754,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 static inline bool
 atomic_dec_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
@@ -754,7 +764,7 @@ atomic_dec_and_test(atomic_t *v)
 static inline bool
 atomic_inc_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
@@ -764,7 +774,7 @@ atomic_inc_and_test(atomic_t *v)
 static inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
@@ -774,7 +784,7 @@ atomic_add_negative(int i, atomic_t *v)
 static inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
@@ -784,7 +794,7 @@ atomic_fetch_add_unless(atomic_t *v, int
 static inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
@@ -794,7 +804,7 @@ atomic_add_unless(atomic_t *v, int a, in
 static inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
@@ -804,7 +814,7 @@ atomic_inc_not_zero(atomic_t *v)
 static inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
@@ -814,7 +824,7 @@ atomic_inc_unless_negative(atomic_t *v)
 static inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
@@ -824,7 +834,7 @@ atomic_dec_unless_positive(atomic_t *v)
 static inline int
 atomic_dec_if_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
@@ -833,7 +843,7 @@ atomic_dec_if_positive(atomic_t *v)
 static inline s64
 atomic64_read(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
 #define atomic64_read atomic64_read
@@ -842,7 +852,7 @@ atomic64_read(const atomic64_t *v)
 static inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	__atomic_check_read(v, sizeof(*v));
 	return arch_atomic64_read_acquire(v);
 }
 #define atomic64_read_acquire atomic64_read_acquire
@@ -851,7 +861,7 @@ atomic64_read_acquire(const atomic64_t *
 static inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
 #define atomic64_set atomic64_set
@@ -860,7 +870,7 @@ atomic64_set(atomic64_t *v, s64 i)
 static inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_set_release(v, i);
 }
 #define atomic64_set_release atomic64_set_release
@@ -869,7 +879,7 @@ atomic64_set_release(atomic64_t *v, s64
 static inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
@@ -878,7 +888,7 @@ atomic64_add(s64 i, atomic64_t *v)
 static inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
@@ -888,7 +898,7 @@ atomic64_add_return(s64 i, atomic64_t *v
 static inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
@@ -898,7 +908,7 @@ atomic64_add_return_acquire(s64 i, atomi
 static inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
@@ -908,7 +918,7 @@ atomic64_add_return_release(s64 i, atomi
 static inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
@@ -918,7 +928,7 @@ atomic64_add_return_relaxed(s64 i, atomi
 static inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
@@ -928,7 +938,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
@@ -938,7 +948,7 @@ atomic64_fetch_add_acquire(s64 i, atomic
 static inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
@@ -948,7 +958,7 @@ atomic64_fetch_add_release(s64 i, atomic
 static inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
@@ -957,7 +967,7 @@ atomic64_fetch_add_relaxed(s64 i, atomic
 static inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
@@ -966,7 +976,7 @@ atomic64_sub(s64 i, atomic64_t *v)
 static inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
@@ -976,7 +986,7 @@ atomic64_sub_return(s64 i, atomic64_t *v
 static inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
@@ -986,7 +996,7 @@ atomic64_sub_return_acquire(s64 i, atomi
 static inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
@@ -996,7 +1006,7 @@ atomic64_sub_return_release(s64 i, atomi
 static inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
@@ -1006,7 +1016,7 @@ atomic64_sub_return_relaxed(s64 i, atomi
 static inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
@@ -1016,7 +1026,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
@@ -1026,7 +1036,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic
 static inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
@@ -1036,7 +1046,7 @@ atomic64_fetch_sub_release(s64 i, atomic
 static inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
@@ -1046,7 +1056,7 @@ atomic64_fetch_sub_relaxed(s64 i, atomic
 static inline void
 atomic64_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
@@ -1056,7 +1066,7 @@ atomic64_inc(atomic64_t *v)
 static inline s64
 atomic64_inc_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
@@ -1066,7 +1076,7 @@ atomic64_inc_return(atomic64_t *v)
 static inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
@@ -1076,7 +1086,7 @@ atomic64_inc_return_acquire(atomic64_t *
 static inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
@@ -1086,7 +1096,7 @@ atomic64_inc_return_release(atomic64_t *
 static inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
@@ -1096,7 +1106,7 @@ atomic64_inc_return_relaxed(atomic64_t *
 static inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
@@ -1106,7 +1116,7 @@ atomic64_fetch_inc(atomic64_t *v)
 static inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
@@ -1116,7 +1126,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v
 static inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
@@ -1126,7 +1136,7 @@ atomic64_fetch_inc_release(atomic64_t *v
 static inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
@@ -1136,7 +1146,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v
 static inline void
 atomic64_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
@@ -1146,7 +1156,7 @@ atomic64_dec(atomic64_t *v)
 static inline s64
 atomic64_dec_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
@@ -1156,7 +1166,7 @@ atomic64_dec_return(atomic64_t *v)
 static inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
@@ -1166,7 +1176,7 @@ atomic64_dec_return_acquire(atomic64_t *
 static inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
@@ -1176,7 +1186,7 @@ atomic64_dec_return_release(atomic64_t *
 static inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
@@ -1186,7 +1196,7 @@ atomic64_dec_return_relaxed(atomic64_t *
 static inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
@@ -1196,7 +1206,7 @@ atomic64_fetch_dec(atomic64_t *v)
 static inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
@@ -1206,7 +1216,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v
 static inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
@@ -1216,7 +1226,7 @@ atomic64_fetch_dec_release(atomic64_t *v
 static inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
@@ -1225,7 +1235,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v
 static inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
@@ -1234,7 +1244,7 @@ atomic64_and(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
@@ -1244,7 +1254,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
@@ -1254,7 +1264,7 @@ atomic64_fetch_and_acquire(s64 i, atomic
 static inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
@@ -1264,7 +1274,7 @@ atomic64_fetch_and_release(s64 i, atomic
 static inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
@@ -1274,7 +1284,7 @@ atomic64_fetch_and_relaxed(s64 i, atomic
 static inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
@@ -1284,7 +1294,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
@@ -1294,7 +1304,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t
 static inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
@@ -1304,7 +1314,7 @@ atomic64_fetch_andnot_acquire(s64 i, ato
 static inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
@@ -1314,7 +1324,7 @@ atomic64_fetch_andnot_release(s64 i, ato
 static inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
@@ -1323,7 +1333,7 @@ atomic64_fetch_andnot_relaxed(s64 i, ato
 static inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
@@ -1332,7 +1342,7 @@ atomic64_or(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
@@ -1342,7 +1352,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
@@ -1352,7 +1362,7 @@ atomic64_fetch_or_acquire(s64 i, atomic6
 static inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
@@ -1362,7 +1372,7 @@ atomic64_fetch_or_release(s64 i, atomic6
 static inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
@@ -1371,7 +1381,7 @@ atomic64_fetch_or_relaxed(s64 i, atomic6
 static inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
@@ -1380,7 +1390,7 @@ atomic64_xor(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
@@ -1390,7 +1400,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 static inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
@@ -1400,7 +1410,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic
 static inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
@@ -1410,7 +1420,7 @@ atomic64_fetch_xor_release(s64 i, atomic
 static inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
@@ -1420,7 +1430,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic
 static inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
@@ -1430,7 +1440,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 static inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
@@ -1440,7 +1450,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64
 static inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
@@ -1450,7 +1460,7 @@ atomic64_xchg_release(atomic64_t *v, s64
 static inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
@@ -1460,7 +1470,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64
 static inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
@@ -1470,7 +1480,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old,
 static inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
@@ -1480,7 +1490,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v,
 static inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
@@ -1490,7 +1500,7 @@ atomic64_cmpxchg_release(atomic64_t *v,
 static inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
@@ -1500,8 +1510,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v,
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
@@ -1511,8 +1521,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64
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
@@ -1522,8 +1532,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t
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
@@ -1533,8 +1543,8 @@ atomic64_try_cmpxchg_release(atomic64_t
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
@@ -1544,7 +1554,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t
 static inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
@@ -1554,7 +1564,7 @@ atomic64_sub_and_test(s64 i, atomic64_t
 static inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
@@ -1564,7 +1574,7 @@ atomic64_dec_and_test(atomic64_t *v)
 static inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
@@ -1574,7 +1584,7 @@ atomic64_inc_and_test(atomic64_t *v)
 static inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
@@ -1584,7 +1594,7 @@ atomic64_add_negative(s64 i, atomic64_t
 static inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
@@ -1594,7 +1604,7 @@ atomic64_fetch_add_unless(atomic64_t *v,
 static inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
@@ -1604,7 +1614,7 @@ atomic64_add_unless(atomic64_t *v, s64 a
 static inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
@@ -1614,7 +1624,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 static inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
@@ -1624,7 +1634,7 @@ atomic64_inc_unless_negative(atomic64_t
 static inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
@@ -1634,7 +1644,7 @@ atomic64_dec_unless_positive(atomic64_t
 static inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	__atomic_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1644,7 +1654,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1653,7 +1663,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1662,7 +1672,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1671,7 +1681,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1680,7 +1690,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1689,7 +1699,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1698,7 +1708,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1707,7 +1717,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1716,7 +1726,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1725,7 +1735,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1734,7 +1744,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1743,7 +1753,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1751,28 +1761,28 @@ atomic64_dec_if_positive(atomic64_t *v)
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
 
@@ -1780,9 +1790,9 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_double_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	__atomic_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// b29b625d5de9280f680e42c7be859b55b15e5f6a
+// aa929c117bdd954a0957b91fe509f118ca8b9707
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
@@ -149,6 +149,16 @@ cat << EOF
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
 
+static inline void __atomic_check_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+}
+
+static inline void __atomic_check_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+}
+
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do


