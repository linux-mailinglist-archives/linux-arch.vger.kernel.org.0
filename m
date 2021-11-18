Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B454556A4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbhKRIQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbhKRIPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:15:05 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CBFC061226
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:33 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so877392wrg.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HO2j8fDcTjG33FWF1g1vyRfUzwW+oeuePm13p24Xfnw=;
        b=ao5F3zNvGXxVbqr2Du/zW9wtDIC0MnWhuj3g8RN6FekTYCAm/TIV2DFBPFYh9bRbL2
         r5w3RiwWnR6D5obU2fflsW/ZCWM66Aqzn5TzOS+zu/UAJHqand2uoACrxNqKqat3XZAV
         KoMGsvxNIhJrzm1WnVqgTbJkkj4TXJb72EwbJBGe7NkSD0s/7yOXJr9ILqqN0aHyNa6a
         zKl3aEWbX8EbPCTv1aHZZ3zUZzX3kCxkT5cgVpTZEuwrMnF5OyztgJLey0zd0KccuJzZ
         J62DAuuCuRTz30T+UvkRCvZiU4Zf1LRX+oolLWrm24sOlGI+mDLfBJeYDZa35pYL/tr8
         GM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HO2j8fDcTjG33FWF1g1vyRfUzwW+oeuePm13p24Xfnw=;
        b=cqaFF6KDRevtazEYRzJLm/R4hsEi2hyAnlpt3yY+9QUQvFl1RHEOJH3O3lHk8B8EgB
         9GTGflsFB5t5K7xJDdusPBH9vdyr1hECo+thtfV1CXyfkgiLXX05D56yfI91UyiVKL2M
         Wj+j8Xfj8RnjZECys4SZNoJBHvoUB/qQmKkthMxxkmS4wSWiIsuN8LZT3hLgOxA6PQh5
         t+a3RoJh9bYu7umnXbb/ATjFJ82xt4xeGaayT5P7+SCUOs3N5cJzpWWYKerHI9f3f/G7
         hr0hMgp3boJM0F7q5Vii0CUU0jtykbjToAK9ZvnYyALacgBF7os8ivMuqo0XXXn3IZxn
         dYeg==
X-Gm-Message-State: AOAM532wUB5jC3SPElO7ILRHFfrz7Jtqw4oLBgGxOf/wd6UHs4rN2GE2
        fhC9/7UPVlgLOeitubq3i0EE4XnrKQ==
X-Google-Smtp-Source: ABdhPJxksiSN8tufizdjFZL4xtcYBdfWZ9cx8tN8NGNKYPnH4et+mkDmYt47SvSibdw6UtKtmx9wVCWV6w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:4149:: with SMTP id
 h9mr7592130wmm.100.1637223092073; Thu, 18 Nov 2021 00:11:32 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:18 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-15-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 14/23] locking/barriers, kcsan: Add instrumentation for barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adds the required KCSAN instrumentation for barriers if CONFIG_SMP.
KCSAN supports modeling the effects of:

	smp_mb()
	smp_rmb()
	smp_wmb()
	smp_store_release()

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/barrier.h | 29 +++++++++++++++--------------
 include/linux/spinlock.h      |  2 +-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 640f09479bdf..27a9c9edfef6 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -14,6 +14,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <linux/kcsan-checks.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
@@ -62,15 +63,15 @@
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
-#define smp_mb()	__smp_mb()
+#define smp_mb()	do { kcsan_mb(); __smp_mb(); } while (0)
 #endif
 
 #ifndef smp_rmb
-#define smp_rmb()	__smp_rmb()
+#define smp_rmb()	do { kcsan_rmb(); __smp_rmb(); } while (0)
 #endif
 
 #ifndef smp_wmb
-#define smp_wmb()	__smp_wmb()
+#define smp_wmb()	do { kcsan_wmb(); __smp_wmb(); } while (0)
 #endif
 
 #else	/* !CONFIG_SMP */
@@ -123,19 +124,19 @@ do {									\
 #ifdef CONFIG_SMP
 
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  __smp_store_mb(var, value)
+#define smp_store_mb(var, value)  do { kcsan_mb(); __smp_store_mb(var, value); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
-#define smp_mb__before_atomic()	__smp_mb__before_atomic()
+#define smp_mb__before_atomic()	do { kcsan_mb(); __smp_mb__before_atomic(); } while (0)
 #endif
 
 #ifndef smp_mb__after_atomic
-#define smp_mb__after_atomic()	__smp_mb__after_atomic()
+#define smp_mb__after_atomic()	do { kcsan_mb(); __smp_mb__after_atomic(); } while (0)
 #endif
 
 #ifndef smp_store_release
-#define smp_store_release(p, v) __smp_store_release(p, v)
+#define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
 #endif
 
 #ifndef smp_load_acquire
@@ -178,13 +179,13 @@ do {									\
 #endif	/* CONFIG_SMP */
 
 /* Barriers for virtual machine guests when talking to an SMP host */
-#define virt_mb() __smp_mb()
-#define virt_rmb() __smp_rmb()
-#define virt_wmb() __smp_wmb()
-#define virt_store_mb(var, value) __smp_store_mb(var, value)
-#define virt_mb__before_atomic() __smp_mb__before_atomic()
-#define virt_mb__after_atomic()	__smp_mb__after_atomic()
-#define virt_store_release(p, v) __smp_store_release(p, v)
+#define virt_mb() do { kcsan_mb(); __smp_mb(); } while (0)
+#define virt_rmb() do { kcsan_rmb(); __smp_rmb(); } while (0)
+#define virt_wmb() do { kcsan_wmb(); __smp_wmb(); } while (0)
+#define virt_store_mb(var, value) do { kcsan_mb(); __smp_store_mb(var, value); } while (0)
+#define virt_mb__before_atomic() do { kcsan_mb(); __smp_mb__before_atomic(); } while (0)
+#define virt_mb__after_atomic()	do { kcsan_mb(); __smp_mb__after_atomic(); } while (0)
+#define virt_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
 #define virt_load_acquire(p) __smp_load_acquire(p)
 
 /**
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b4e5ca23f840..5c0c5174155d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -171,7 +171,7 @@ do {									\
  * Architectures that can implement ACQUIRE better need to take care.
  */
 #ifndef smp_mb__after_spinlock
-#define smp_mb__after_spinlock()	do { } while (0)
+#define smp_mb__after_spinlock()	kcsan_mb()
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-- 
2.34.0.rc2.393.gf8c9666880-goog

