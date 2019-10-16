Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E506CD8B63
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391759AbfJPIlf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 04:41:35 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:55008 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404085AbfJPIlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:35 -0400
Received: by mail-wm1-f73.google.com with SMTP id g67so665180wmg.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IDVIC90B7deb/e6uaad7u5W6ZhJTt8Unq43HHY6F/0o=;
        b=B48NK8czs5mL7Jz23z3XCebfdb1jfyzrXWmx4EWF2gEAqJj7blYVSv3jlAUFNC2M0o
         aNYgBe0mbgRY7x60tChQQzaO1r9onFU6qqmTaAH+Kiqf7ZwZ+v4V82RMZFvonlxRN5lo
         z3iOQ7BBh2Wh5sJdJuFckd0GqUlc0/BNM/ThVEyMH1gWwBHnh9Kw1MXbo+zysfaP63vp
         SZfWRd/cnNMjZXdnZWj+I235a7ZS5gWNltQf09Be8tlfoF2kpQI7ydW31jArorA6/1CA
         ZCEyhmR/1Zn9n+SgHg+K2omLsX9WwCLv6rCUFf+2qaqSpe4kJxyT2qIpzEeT3pu6BOci
         JKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IDVIC90B7deb/e6uaad7u5W6ZhJTt8Unq43HHY6F/0o=;
        b=EiqTJCrU6vEvMRi/mEe1pmM5TJMnYzIiM9ZsqMjwF0p4T6ufNQiZYEZDJy1VDfxCsE
         eXAHDkEYHjHWc2y9/bgEk4adOg+OEzpS0D+JS6MnrQTbbYJBm6OOee8sYoqLom0uI5a0
         kVAXCfbBXcdyRhzKZVBnco5M9TYlYy9zG1IENeBDnw9SWaKyWZu4v0hSisrZkCgORHRF
         ltUiRQtBD9iW0N9UJ/rGkD068eRg2MHYZaoAZCPKze6BfKupG5yO3tnARVrzRO4pHXCJ
         YsYUE5JFtL7xZI0Hl9yCJjA89c3kLKrIjLbwJacJqykh6FPm203F/vBmVTOGqkeaRW98
         53yQ==
X-Gm-Message-State: APjAAAUn/v6vfS/AkfUprMP/Zu1sQgXS6QhZdMzYcqcJKvGVWz6bDxuO
        iC2sa0wDAKXZo6aCl+4JyXeUYXsByw==
X-Google-Smtp-Source: APXvYqy5ZSOYixRtRwgdHuvLT68MYB1ByHEYhJQhc7Zecnm8JYv3A2UF+MTj0RjeAfiYFBMDoUWhkOGBaA==
X-Received: by 2002:a05:6000:1190:: with SMTP id g16mr1576051wrx.133.1571215291051;
 Wed, 16 Oct 2019 01:41:31 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:58 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-8-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 7/8] locking/atomics, kcsan: Add KCSAN instrumentation
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

This adds KCSAN instrumentation to atomic-instrumented.h.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/atomic-instrumented.h | 192 +++++++++++++++++++++-
 scripts/atomic/gen-atomic-instrumented.sh |   9 +-
 2 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index e8730c6b9fe2..9e487febc610 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -19,11 +19,13 @@
 
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 static inline int
 atomic_read(const atomic_t *v)
 {
 	kasan_check_read(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), false);
 	return arch_atomic_read(v);
 }
 #define atomic_read atomic_read
@@ -33,6 +35,7 @@ static inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	kasan_check_read(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), false);
 	return arch_atomic_read_acquire(v);
 }
 #define atomic_read_acquire atomic_read_acquire
@@ -42,6 +45,7 @@ static inline void
 atomic_set(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_set(v, i);
 }
 #define atomic_set atomic_set
@@ -51,6 +55,7 @@ static inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_set_release(v, i);
 }
 #define atomic_set_release atomic_set_release
@@ -60,6 +65,7 @@ static inline void
 atomic_add(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
@@ -69,6 +75,7 @@ static inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
@@ -79,6 +86,7 @@ static inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
@@ -89,6 +97,7 @@ static inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
@@ -99,6 +108,7 @@ static inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
@@ -109,6 +119,7 @@ static inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
@@ -119,6 +130,7 @@ static inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
@@ -129,6 +141,7 @@ static inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
@@ -139,6 +152,7 @@ static inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
@@ -148,6 +162,7 @@ static inline void
 atomic_sub(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
@@ -157,6 +172,7 @@ static inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
@@ -167,6 +183,7 @@ static inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
@@ -177,6 +194,7 @@ static inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
@@ -187,6 +205,7 @@ static inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
@@ -197,6 +216,7 @@ static inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
@@ -207,6 +227,7 @@ static inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
@@ -217,6 +238,7 @@ static inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
@@ -227,6 +249,7 @@ static inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
@@ -237,6 +260,7 @@ static inline void
 atomic_inc(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
@@ -247,6 +271,7 @@ static inline int
 atomic_inc_return(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
@@ -257,6 +282,7 @@ static inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
@@ -267,6 +293,7 @@ static inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
@@ -277,6 +304,7 @@ static inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
@@ -287,6 +315,7 @@ static inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
@@ -297,6 +326,7 @@ static inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
@@ -307,6 +337,7 @@ static inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
@@ -317,6 +348,7 @@ static inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
@@ -327,6 +359,7 @@ static inline void
 atomic_dec(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
@@ -337,6 +370,7 @@ static inline int
 atomic_dec_return(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
@@ -347,6 +381,7 @@ static inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
@@ -357,6 +392,7 @@ static inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
@@ -367,6 +403,7 @@ static inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
@@ -377,6 +414,7 @@ static inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
@@ -387,6 +425,7 @@ static inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
@@ -397,6 +436,7 @@ static inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
@@ -407,6 +447,7 @@ static inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
@@ -416,6 +457,7 @@ static inline void
 atomic_and(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
@@ -425,6 +467,7 @@ static inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
@@ -435,6 +478,7 @@ static inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
@@ -445,6 +489,7 @@ static inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
@@ -455,6 +500,7 @@ static inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
@@ -465,6 +511,7 @@ static inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
@@ -475,6 +522,7 @@ static inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
@@ -485,6 +533,7 @@ static inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
@@ -495,6 +544,7 @@ static inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
@@ -505,6 +555,7 @@ static inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
@@ -514,6 +565,7 @@ static inline void
 atomic_or(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
@@ -523,6 +575,7 @@ static inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
@@ -533,6 +586,7 @@ static inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
@@ -543,6 +597,7 @@ static inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
@@ -553,6 +608,7 @@ static inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
@@ -562,6 +618,7 @@ static inline void
 atomic_xor(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
@@ -571,6 +628,7 @@ static inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
@@ -581,6 +639,7 @@ static inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
@@ -591,6 +650,7 @@ static inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
@@ -601,6 +661,7 @@ static inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
@@ -611,6 +672,7 @@ static inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
@@ -621,6 +683,7 @@ static inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
@@ -631,6 +694,7 @@ static inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
@@ -641,6 +705,7 @@ static inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
@@ -651,6 +716,7 @@ static inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
@@ -661,6 +727,7 @@ static inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
@@ -671,6 +738,7 @@ static inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
@@ -681,6 +749,7 @@ static inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
@@ -691,7 +760,9 @@ static inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #define atomic_try_cmpxchg atomic_try_cmpxchg
@@ -702,7 +773,9 @@ static inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
@@ -713,7 +786,9 @@ static inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 #define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
@@ -724,7 +799,9 @@ static inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
@@ -735,6 +812,7 @@ static inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
@@ -745,6 +823,7 @@ static inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
@@ -755,6 +834,7 @@ static inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
@@ -765,6 +845,7 @@ static inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
@@ -775,6 +856,7 @@ static inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
@@ -785,6 +867,7 @@ static inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
@@ -795,6 +878,7 @@ static inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
@@ -805,6 +889,7 @@ static inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
@@ -815,6 +900,7 @@ static inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
@@ -825,6 +911,7 @@ static inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
@@ -834,6 +921,7 @@ static inline s64
 atomic64_read(const atomic64_t *v)
 {
 	kasan_check_read(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), false);
 	return arch_atomic64_read(v);
 }
 #define atomic64_read atomic64_read
@@ -843,6 +931,7 @@ static inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	kasan_check_read(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), false);
 	return arch_atomic64_read_acquire(v);
 }
 #define atomic64_read_acquire atomic64_read_acquire
@@ -852,6 +941,7 @@ static inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_set(v, i);
 }
 #define atomic64_set atomic64_set
@@ -861,6 +951,7 @@ static inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_set_release(v, i);
 }
 #define atomic64_set_release atomic64_set_release
@@ -870,6 +961,7 @@ static inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
@@ -879,6 +971,7 @@ static inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
@@ -889,6 +982,7 @@ static inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
@@ -899,6 +993,7 @@ static inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
@@ -909,6 +1004,7 @@ static inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
@@ -919,6 +1015,7 @@ static inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
@@ -929,6 +1026,7 @@ static inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
@@ -939,6 +1037,7 @@ static inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
@@ -949,6 +1048,7 @@ static inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
@@ -958,6 +1058,7 @@ static inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
@@ -967,6 +1068,7 @@ static inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
@@ -977,6 +1079,7 @@ static inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
@@ -987,6 +1090,7 @@ static inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
@@ -997,6 +1101,7 @@ static inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
@@ -1007,6 +1112,7 @@ static inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
@@ -1017,6 +1123,7 @@ static inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
@@ -1027,6 +1134,7 @@ static inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
@@ -1037,6 +1145,7 @@ static inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
@@ -1047,6 +1156,7 @@ static inline void
 atomic64_inc(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
@@ -1057,6 +1167,7 @@ static inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
@@ -1067,6 +1178,7 @@ static inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
@@ -1077,6 +1189,7 @@ static inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
@@ -1087,6 +1200,7 @@ static inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
@@ -1097,6 +1211,7 @@ static inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
@@ -1107,6 +1222,7 @@ static inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
@@ -1117,6 +1233,7 @@ static inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
@@ -1127,6 +1244,7 @@ static inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
@@ -1137,6 +1255,7 @@ static inline void
 atomic64_dec(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
@@ -1147,6 +1266,7 @@ static inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
@@ -1157,6 +1277,7 @@ static inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
@@ -1167,6 +1288,7 @@ static inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
@@ -1177,6 +1299,7 @@ static inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
@@ -1187,6 +1310,7 @@ static inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
@@ -1197,6 +1321,7 @@ static inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
@@ -1207,6 +1332,7 @@ static inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
@@ -1217,6 +1343,7 @@ static inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
@@ -1226,6 +1353,7 @@ static inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
@@ -1235,6 +1363,7 @@ static inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
@@ -1245,6 +1374,7 @@ static inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
@@ -1255,6 +1385,7 @@ static inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
@@ -1265,6 +1396,7 @@ static inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
@@ -1275,6 +1407,7 @@ static inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
@@ -1285,6 +1418,7 @@ static inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
@@ -1295,6 +1429,7 @@ static inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
@@ -1305,6 +1440,7 @@ static inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
@@ -1315,6 +1451,7 @@ static inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
@@ -1324,6 +1461,7 @@ static inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
@@ -1333,6 +1471,7 @@ static inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
@@ -1343,6 +1482,7 @@ static inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
@@ -1353,6 +1493,7 @@ static inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
@@ -1363,6 +1504,7 @@ static inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
@@ -1372,6 +1514,7 @@ static inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
@@ -1381,6 +1524,7 @@ static inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
@@ -1391,6 +1535,7 @@ static inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
@@ -1401,6 +1546,7 @@ static inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
@@ -1411,6 +1557,7 @@ static inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
@@ -1421,6 +1568,7 @@ static inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
@@ -1431,6 +1579,7 @@ static inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
@@ -1441,6 +1590,7 @@ static inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
@@ -1451,6 +1601,7 @@ static inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
@@ -1461,6 +1612,7 @@ static inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
@@ -1471,6 +1623,7 @@ static inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
@@ -1481,6 +1634,7 @@ static inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
@@ -1491,6 +1645,7 @@ static inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
@@ -1501,7 +1656,9 @@ static inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
@@ -1512,7 +1669,9 @@ static inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
@@ -1523,7 +1682,9 @@ static inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 #define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
@@ -1534,7 +1695,9 @@ static inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	kasan_check_write(old, sizeof(*old));
+	kcsan_check_atomic(old, sizeof(*old), true);
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
@@ -1545,6 +1708,7 @@ static inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
@@ -1555,6 +1719,7 @@ static inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
@@ -1565,6 +1730,7 @@ static inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
@@ -1575,6 +1741,7 @@ static inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
@@ -1585,6 +1752,7 @@ static inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
@@ -1595,6 +1763,7 @@ static inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
@@ -1605,6 +1774,7 @@ static inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
@@ -1615,6 +1785,7 @@ static inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
@@ -1625,6 +1796,7 @@ static inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
@@ -1635,6 +1807,7 @@ static inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
+	kcsan_check_atomic(v, sizeof(*v), true);
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1645,6 +1818,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_xchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1654,6 +1828,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1663,6 +1838,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1672,6 +1848,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1681,6 +1858,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1690,6 +1868,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1699,6 +1878,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1708,6 +1888,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1717,6 +1898,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1726,6 +1908,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1735,6 +1918,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1744,6 +1928,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1752,6 +1937,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1759,6 +1945,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1766,6 +1953,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, sizeof(*__ai_ptr), true);	\
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1773,6 +1961,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, 2 * sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1781,8 +1970,9 @@ atomic64_dec_if_positive(atomic64_t *v)
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
 	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	kcsan_check_atomic(__ai_ptr, 2 * sizeof(*__ai_ptr), true);	\
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// b29b625d5de9280f680e42c7be859b55b15e5f6a
+// 09d5dce9b60c034fcc1edcf5c84a6bbf71988d9c
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index e09812372b17..c0553743a6f4 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -12,15 +12,20 @@ gen_param_check()
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
 	local rw="write"
+	local is_write="true"
 
 	case "${type#c}" in
 	i) return;;
 	esac
 
 	# We don't write to constant parameters
-	[ ${type#c} != ${type} ] && rw="read"
+	if [ ${type#c} != ${type} ]; then
+		rw="read"
+		is_write="false"
+	fi
 
 	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tkcsan_check_atomic(${name}, sizeof(*${name}), ${is_write});\n"
 }
 
 #gen_param_check(arg...)
@@ -108,6 +113,7 @@ cat <<EOF
 ({									\\
 	typeof(ptr) __ai_ptr = (ptr);					\\
 	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
+	kcsan_check_atomic(__ai_ptr, ${mult}sizeof(*__ai_ptr), true);	\\
 	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
 })
 EOF
@@ -148,6 +154,7 @@ cat << EOF
 
 #include <linux/build_bug.h>
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 EOF
 
-- 
2.23.0.700.g56cf767bdb-goog

