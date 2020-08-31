Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBCA2580C6
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgHaSS7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgHaSSK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F3321473;
        Mon, 31 Aug 2020 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=yCprzMuBeCYtuNHEhQg+3jKCFTKnal7UGYAg1mVLu4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQc4+n/m7r2Uni8aup8dzGtgCqUvDSVteztKAmqVU2qx2BkYSzXM5CgDMAtbshxbo
         2KdNSIcL2VnZhNkGfF3DAYLf9P98eYaM9kaZ4u/PDRToIz4CWD0pelCKYH/ljzph1A
         CMz7oQAPU7ZgglfDroRNIf2H+PpNAtFGoyu+ANCI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 11/19] locking/atomics: Use read-write instrumentation for atomic RMWs
Date:   Mon, 31 Aug 2020 11:17:57 -0700
Message-Id: <20200831181805.1833-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

Use instrument_atomic_read_write() for atomic RMW ops.

Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 330 +++++++++++++++---------------
 scripts/atomic/gen-atomic-instrumented.sh |  21 +-
 2 files changed, 180 insertions(+), 171 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 379986e..cd223b6 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -60,7 +60,7 @@ atomic_set_release(atomic_t *v, int i)
 static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
@@ -69,7 +69,7 @@ atomic_add(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
@@ -79,7 +79,7 @@ atomic_add_return(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
@@ -89,7 +89,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
@@ -99,7 +99,7 @@ atomic_add_return_release(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
@@ -109,7 +109,7 @@ atomic_add_return_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
@@ -119,7 +119,7 @@ atomic_fetch_add(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
@@ -129,7 +129,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
@@ -139,7 +139,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
@@ -148,7 +148,7 @@ atomic_fetch_add_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
@@ -157,7 +157,7 @@ atomic_sub(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
@@ -167,7 +167,7 @@ atomic_sub_return(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
@@ -177,7 +177,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
@@ -187,7 +187,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
@@ -197,7 +197,7 @@ atomic_sub_return_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
@@ -207,7 +207,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
@@ -217,7 +217,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
@@ -227,7 +227,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
@@ -237,7 +237,7 @@ atomic_fetch_sub_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_inc(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
@@ -247,7 +247,7 @@ atomic_inc(atomic_t *v)
 static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
@@ -257,7 +257,7 @@ atomic_inc_return(atomic_t *v)
 static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
@@ -267,7 +267,7 @@ atomic_inc_return_acquire(atomic_t *v)
 static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
@@ -277,7 +277,7 @@ atomic_inc_return_release(atomic_t *v)
 static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
@@ -287,7 +287,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
@@ -297,7 +297,7 @@ atomic_fetch_inc(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
@@ -307,7 +307,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
@@ -317,7 +317,7 @@ atomic_fetch_inc_release(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
@@ -327,7 +327,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 static __always_inline void
 atomic_dec(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
@@ -337,7 +337,7 @@ atomic_dec(atomic_t *v)
 static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
@@ -347,7 +347,7 @@ atomic_dec_return(atomic_t *v)
 static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
@@ -357,7 +357,7 @@ atomic_dec_return_acquire(atomic_t *v)
 static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
@@ -367,7 +367,7 @@ atomic_dec_return_release(atomic_t *v)
 static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
@@ -377,7 +377,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
@@ -387,7 +387,7 @@ atomic_fetch_dec(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
@@ -397,7 +397,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
@@ -407,7 +407,7 @@ atomic_fetch_dec_release(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
@@ -416,7 +416,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
@@ -425,7 +425,7 @@ atomic_and(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
@@ -435,7 +435,7 @@ atomic_fetch_and(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
@@ -445,7 +445,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
@@ -455,7 +455,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
@@ -465,7 +465,7 @@ atomic_fetch_and_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
@@ -475,7 +475,7 @@ atomic_andnot(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
@@ -485,7 +485,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
@@ -495,7 +495,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
@@ -505,7 +505,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
@@ -514,7 +514,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
@@ -523,7 +523,7 @@ atomic_or(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
@@ -533,7 +533,7 @@ atomic_fetch_or(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
@@ -543,7 +543,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
@@ -553,7 +553,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
@@ -562,7 +562,7 @@ atomic_fetch_or_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
@@ -571,7 +571,7 @@ atomic_xor(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
@@ -581,7 +581,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
@@ -591,7 +591,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
@@ -601,7 +601,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
@@ -611,7 +611,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
@@ -621,7 +621,7 @@ atomic_xchg(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
@@ -631,7 +631,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
@@ -641,7 +641,7 @@ atomic_xchg_release(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
@@ -651,7 +651,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
 static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
@@ -661,7 +661,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
@@ -671,7 +671,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
@@ -681,7 +681,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
@@ -691,8 +691,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #define atomic_try_cmpxchg atomic_try_cmpxchg
@@ -702,8 +702,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
@@ -713,8 +713,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 #define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
@@ -724,8 +724,8 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
@@ -735,7 +735,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
@@ -745,7 +745,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
@@ -755,7 +755,7 @@ atomic_dec_and_test(atomic_t *v)
 static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
@@ -765,7 +765,7 @@ atomic_inc_and_test(atomic_t *v)
 static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
@@ -775,7 +775,7 @@ atomic_add_negative(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
@@ -785,7 +785,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
 static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
@@ -795,7 +795,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
 static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
@@ -805,7 +805,7 @@ atomic_inc_not_zero(atomic_t *v)
 static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
@@ -815,7 +815,7 @@ atomic_inc_unless_negative(atomic_t *v)
 static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
@@ -825,7 +825,7 @@ atomic_dec_unless_positive(atomic_t *v)
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
@@ -870,7 +870,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
@@ -879,7 +879,7 @@ atomic64_add(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
@@ -889,7 +889,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
@@ -899,7 +899,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
@@ -909,7 +909,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
@@ -919,7 +919,7 @@ atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
@@ -929,7 +929,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
@@ -939,7 +939,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
@@ -949,7 +949,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
@@ -958,7 +958,7 @@ atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
@@ -967,7 +967,7 @@ atomic64_sub(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
@@ -977,7 +977,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
@@ -987,7 +987,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
@@ -997,7 +997,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
@@ -1007,7 +1007,7 @@ atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
@@ -1017,7 +1017,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
@@ -1027,7 +1027,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
@@ -1037,7 +1037,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
@@ -1047,7 +1047,7 @@ atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
@@ -1057,7 +1057,7 @@ atomic64_inc(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
@@ -1067,7 +1067,7 @@ atomic64_inc_return(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
@@ -1077,7 +1077,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
@@ -1087,7 +1087,7 @@ atomic64_inc_return_release(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
@@ -1097,7 +1097,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
@@ -1107,7 +1107,7 @@ atomic64_fetch_inc(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
@@ -1117,7 +1117,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
@@ -1127,7 +1127,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
@@ -1137,7 +1137,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
@@ -1147,7 +1147,7 @@ atomic64_dec(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
@@ -1157,7 +1157,7 @@ atomic64_dec_return(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
@@ -1167,7 +1167,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
@@ -1177,7 +1177,7 @@ atomic64_dec_return_release(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
@@ -1187,7 +1187,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
@@ -1197,7 +1197,7 @@ atomic64_fetch_dec(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
@@ -1207,7 +1207,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
@@ -1217,7 +1217,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
@@ -1226,7 +1226,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
@@ -1235,7 +1235,7 @@ atomic64_and(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
@@ -1245,7 +1245,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
@@ -1255,7 +1255,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
@@ -1265,7 +1265,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
@@ -1275,7 +1275,7 @@ atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
@@ -1285,7 +1285,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
@@ -1295,7 +1295,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
@@ -1305,7 +1305,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
@@ -1315,7 +1315,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
@@ -1324,7 +1324,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
@@ -1333,7 +1333,7 @@ atomic64_or(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
@@ -1343,7 +1343,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
@@ -1353,7 +1353,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
@@ -1363,7 +1363,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
@@ -1372,7 +1372,7 @@ atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
@@ -1381,7 +1381,7 @@ atomic64_xor(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
@@ -1391,7 +1391,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
@@ -1401,7 +1401,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
@@ -1411,7 +1411,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
@@ -1421,7 +1421,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
@@ -1431,7 +1431,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
@@ -1441,7 +1441,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
@@ -1451,7 +1451,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
@@ -1461,7 +1461,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
@@ -1471,7 +1471,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
@@ -1481,7 +1481,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
@@ -1491,7 +1491,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
@@ -1501,8 +1501,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
@@ -1512,8 +1512,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
@@ -1523,8 +1523,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 #define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
@@ -1534,8 +1534,8 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
-	instrument_atomic_write(v, sizeof(*v));
-	instrument_atomic_write(old, sizeof(*old));
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
@@ -1545,7 +1545,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
@@ -1555,7 +1555,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
 static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
@@ -1565,7 +1565,7 @@ atomic64_dec_and_test(atomic64_t *v)
 static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
@@ -1575,7 +1575,7 @@ atomic64_inc_and_test(atomic64_t *v)
 static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
@@ -1585,7 +1585,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
@@ -1595,7 +1595,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
@@ -1605,7 +1605,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
@@ -1615,7 +1615,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
@@ -1625,7 +1625,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
@@ -1635,7 +1635,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
-	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1786,4 +1786,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 89bf97f3a7509b740845e51ddf31055b48a81f40
+// 9d5e6a315fb1335d02f0ccd3655a91c3dafcc63e
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 6afadf7..2b7fec7 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
 
 . ${ATOMICDIR}/atomic-tbl.sh
 
-#gen_param_check(arg)
+#gen_param_check(meta, arg)
 gen_param_check()
 {
+	local meta="$1"; shift
 	local arg="$1"; shift
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
@@ -17,17 +18,25 @@ gen_param_check()
 	i) return;;
 	esac
 
-	# We don't write to constant parameters
-	[ ${type#c} != ${type} ] && rw="read"
+	if [ ${type#c} != ${type} ]; then
+		# We don't write to constant parameters.
+		rw="read"
+	elif [ "${meta}" != "s" ]; then
+		# An atomic RMW: if this parameter is not a constant, and this atomic is
+		# not just a 's'tore, this parameter is both read from and written to.
+		rw="read_write"
+	fi
 
 	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
 }
 
-#gen_param_check(arg...)
+#gen_params_checks(meta, arg...)
 gen_params_checks()
 {
+	local meta="$1"; shift
+
 	while [ "$#" -gt 0 ]; do
-		gen_param_check "$1"
+		gen_param_check "$meta" "$1"
 		shift;
 	done
 }
@@ -77,7 +86,7 @@ gen_proto_order_variant()
 
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local params="$(gen_params "${int}" "${atomic}" "$@")"
-	local checks="$(gen_params_checks "$@")"
+	local checks="$(gen_params_checks "${meta}" "$@")"
 	local args="$(gen_args "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
-- 
2.9.5

