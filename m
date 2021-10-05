Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE442244D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhJELCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhJELCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:02:16 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F3C061749
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:10 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id v2-20020ac25582000000b003fd1c161a31so10597122lfg.15
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZtjlTRd9cPGbU2ksHL1X0mLktYMB6yEg4HDsxE/XxIE=;
        b=DKByp7rhVVGn+G+7cpdRuP7Ianaa0r7mtLK+VFL9r5RpHo3iydgXDRTFRz48FGduO0
         mtD8jJ2ACAbsS9HT3HaPp+f33NtX1fJ7tJf8MYiHhrACMUS/A/h3FdPfcunz0HnOnlWC
         WVFB8fLnpexAbBiBwhHdKu4hUCA6qfMzJAQHEF0FLOnbeYtVDVsqTRBrbPEPPOT/+OFO
         Rgm+zGqbtP+mWrn6DPMuSH2/m50x2ApfdzvkGz62+GgLk5c/KPr2AKwNQIm856JH1r9a
         HxbgivYTjuRZeNm1m0B3bb4ElXOdOTPTJ03RJfh7HKpkaVUTuC1dOemc8kNfSCKk/HrU
         KzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZtjlTRd9cPGbU2ksHL1X0mLktYMB6yEg4HDsxE/XxIE=;
        b=lyp9ujIO+Hafp4bqJt3tCoHNycFM79+pXsV2OcPoOvkkHXUQxw9oGod3pkZM6utEWr
         BHjsrYYM1KuQxgsYtGVOXT9Go3VtcdyokWSNmo9URT2I/q3o89zGDGYgrMYK5kV5xjwQ
         5AtQCKj97TnqhyArJjwmsLJDlVh8joWiedNMjZoIOL1hx9aZOPI2ixZv+bgo1/TfteqE
         zw6qCvsg/6Wr6zVx4gnHZRRTCQvAofxA7Ibzc66AIfrS0WS9f/5mOSOH1Ie3DPTzur5e
         A859QOABNkqWbojO+3+IBvaQLuckVHvp5sunbdjiLLDaa4oQsFIr/B8EvZy4A91OHGV5
         bykg==
X-Gm-Message-State: AOAM531EJgNkhRtsdOfeRwBRNPyjpYBMpRDrAr2VnoJOmaiNDc/WwBHM
        gHjgqxowZsTmJrUmc9kwp5U91mP+fg==
X-Google-Smtp-Source: ABdhPJy5EHykNsLsJK40jBXniA9gMVXOMtrUEA2MTw/F7xg13PQuC8CKIubUA9R78D8xX6LS7eXP8LcT+Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6512:b0f:: with SMTP id
 w15mr2729100lfu.164.1633431608867; Tue, 05 Oct 2021 04:00:08 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:53 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-12-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 11/23] kcsan: test: Add test cases for memory
 barrier instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
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

Adds test cases to check that memory barriers are instrumented
correctly, and detection of missing memory barriers is working as
intended if CONFIG_KCSAN_STRICT=y.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 320 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 320 insertions(+)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index ec054879201b..469f3044a5b3 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -16,9 +16,12 @@
 #define pr_fmt(fmt) "kcsan_test: " fmt
 
 #include <kunit/test.h>
+#include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/jiffies.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
@@ -305,6 +308,16 @@ static DEFINE_SEQLOCK(test_seqlock);
 __no_kcsan
 static noinline void sink_value(long v) { WRITE_ONCE(test_sink, v); }
 
+/*
+ * Generates a delay and some accesses that enter the runtime but do not produce
+ * data races.
+ */
+static noinline void test_delay(int iter)
+{
+	while (iter--)
+		sink_value(READ_ONCE(test_sink));
+}
+
 static noinline void test_kernel_read(void) { sink_value(test_var); }
 
 static noinline void test_kernel_write(void)
@@ -466,8 +479,220 @@ static noinline void test_kernel_xor_1bit(void)
 	kcsan_nestable_atomic_end();
 }
 
+#define TEST_KERNEL_LOCKED(name, acquire, release)		\
+	static noinline void test_kernel_##name(void)		\
+	{							\
+		long *flag = &test_struct.val[0];		\
+		long v = 0;					\
+		if (!(acquire))					\
+			return;					\
+		while (v++ < 100) {				\
+			test_var++;				\
+			barrier();				\
+		}						\
+		release;					\
+		test_delay(10);					\
+	}
+
+TEST_KERNEL_LOCKED(with_memorder,
+		   cmpxchg_acquire(flag, 0, 1) == 0,
+		   smp_store_release(flag, 0));
+TEST_KERNEL_LOCKED(wrong_memorder,
+		   cmpxchg_relaxed(flag, 0, 1) == 0,
+		   WRITE_ONCE(*flag, 0));
+TEST_KERNEL_LOCKED(atomic_builtin_with_memorder,
+		   __atomic_compare_exchange_n(flag, &v, 1, 0, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED),
+		   __atomic_store_n(flag, 0, __ATOMIC_RELEASE));
+TEST_KERNEL_LOCKED(atomic_builtin_wrong_memorder,
+		   __atomic_compare_exchange_n(flag, &v, 1, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED),
+		   __atomic_store_n(flag, 0, __ATOMIC_RELAXED));
+
 /* ===== Test cases ===== */
 
+/*
+ * Tests that various barriers have the expected effect on internal state. Not
+ * exhaustive on atomic_t operations. Unlike the selftest, also checks for
+ * too-strict barrier instrumentation; these can be tolerated, because it does
+ * not cause false positives, but at least we should be aware of such cases.
+ */
+__no_kcsan
+static void test_barrier_nothreads(struct kunit *test)
+{
+#ifdef CONFIG_KCSAN_WEAK_MEMORY
+	struct kcsan_scoped_access *reorder_access = &current->kcsan_ctx.reorder_access;
+#else
+	struct kcsan_scoped_access *reorder_access = NULL;
+#endif
+	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
+	DEFINE_SPINLOCK(spinlock);
+	DEFINE_MUTEX(mutex);
+	atomic_t dummy;
+
+	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
+	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
+
+#define __KCSAN_EXPECT_BARRIER(access_type, barrier, order_before, name)			\
+	do {											\
+		reorder_access->type = (access_type) | KCSAN_ACCESS_SCOPED;			\
+		reorder_access->size = sizeof(test_var);					\
+		barrier;									\
+		KUNIT_EXPECT_EQ_MSG(test, reorder_access->size,					\
+				    order_before ? 0 : sizeof(test_var),			\
+				    "improperly instrumented type=(" #access_type "): " name);	\
+	} while (0)
+#define KCSAN_EXPECT_READ_BARRIER(b, o)  __KCSAN_EXPECT_BARRIER(0, b, o, #b)
+#define KCSAN_EXPECT_WRITE_BARRIER(b, o) __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_WRITE, b, o, #b)
+#define KCSAN_EXPECT_RW_BARRIER(b, o)    __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE, b, o, #b)
+
+	/* Force creating a valid entry in reorder_access first. */
+	test_var = 0;
+	while (test_var++ < 1000000 && reorder_access->size != sizeof(test_var))
+		__kcsan_check_read(&test_var, sizeof(test_var));
+	KUNIT_ASSERT_EQ(test, reorder_access->size, sizeof(test_var));
+
+	kcsan_nestable_atomic_begin(); /* No watchpoints in called functions. */
+
+	KCSAN_EXPECT_READ_BARRIER(mb(), true);
+	KCSAN_EXPECT_READ_BARRIER(wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(smp_rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(dma_wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(dma_rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_READ_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_READ_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_READ_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_READ_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_READ_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_READ_BARRIER(mutex_unlock(&mutex), true);
+
+	KCSAN_EXPECT_WRITE_BARRIER(mb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(dma_wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(dma_rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_unlock(&mutex), true);
+
+	KCSAN_EXPECT_RW_BARRIER(mb(), true);
+	KCSAN_EXPECT_RW_BARRIER(wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(dma_wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(dma_rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_RW_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_RW_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_RW_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_RW_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&mutex), true);
+
+	kcsan_nestable_atomic_end();
+}
+
 /* Simple test with normal data race. */
 __no_kcsan
 static void test_basic(struct kunit *test)
@@ -1039,6 +1264,90 @@ static void test_1bit_value_change(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, match);
 }
 
+__no_kcsan
+static void test_correct_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_with_memorder, test_kernel_with_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_missing_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_wrong_memorder, test_kernel_wrong_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	if (IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
+		KUNIT_EXPECT_TRUE(test, match_expect);
+	else
+		KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_atomic_builtins_correct_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_atomic_builtin_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_atomic_builtin_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_atomic_builtin_with_memorder,
+			  test_kernel_atomic_builtin_with_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_atomic_builtins_missing_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_atomic_builtin_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_atomic_builtin_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_atomic_builtin_wrong_memorder,
+			  test_kernel_atomic_builtin_wrong_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	if (IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
+		KUNIT_EXPECT_TRUE(test, match_expect);
+	else
+		KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
 /*
  * Generate thread counts for all test cases. Values generated are in interval
  * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
@@ -1088,6 +1397,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 
 #define KCSAN_KUNIT_CASE(test_name) KUNIT_CASE_PARAM(test_name, nthreads_gen_params)
 static struct kunit_case kcsan_test_cases[] = {
+	KUNIT_CASE(test_barrier_nothreads),
 	KCSAN_KUNIT_CASE(test_basic),
 	KCSAN_KUNIT_CASE(test_concurrent_races),
 	KCSAN_KUNIT_CASE(test_novalue_change),
@@ -1112,6 +1422,10 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	KCSAN_KUNIT_CASE(test_atomic_builtins),
 	KCSAN_KUNIT_CASE(test_1bit_value_change),
+	KCSAN_KUNIT_CASE(test_correct_barrier),
+	KCSAN_KUNIT_CASE(test_missing_barrier),
+	KCSAN_KUNIT_CASE(test_atomic_builtins_correct_barrier),
+	KCSAN_KUNIT_CASE(test_atomic_builtins_missing_barrier),
 	{},
 };
 
@@ -1176,6 +1490,9 @@ static int test_init(struct kunit *test)
 	observed.nlines = 0;
 	spin_unlock_irqrestore(&observed.lock, flags);
 
+	if (strstr(test->name, "nothreads"))
+		return 0;
+
 	if (!torture_init_begin((char *)test->name, 1))
 		return -EBUSY;
 
@@ -1218,6 +1535,9 @@ static void test_exit(struct kunit *test)
 	struct task_struct **stop_thread;
 	int i;
 
+	if (strstr(test->name, "nothreads"))
+		return;
+
 	if (torture_cleanup_begin())
 		return;
 
-- 
2.33.0.800.g4c38ced690-goog

