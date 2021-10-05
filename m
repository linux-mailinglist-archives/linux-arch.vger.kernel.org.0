Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B276422446
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhJELCg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhJELCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:02:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7AC0617A4
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u13-20020ad45aad000000b003829b9760b8so13613091qvg.18
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rJFOB4F2I3Uhw/IG/H4qYMYPgwEvxNpylG6MakN87zU=;
        b=VqUHau3tp8S/srrbCcE7sDSQdUlERKQHPnririg4TcJtNPikiJctVLPLHxbbLPOEGk
         ix7C/oQHZ7x9CfMPwQ616lL1QXThsPphbb+TYiAC7sVrbkR/LHUSsmNTkKvnh8h6bAJZ
         vUlaCh+R1qD1dV/9/GlD/upY0FMODU8ugujEEXPA7dJzlEBOxhnfVeLROB0XF6n1bdkv
         eO948IRqF8Kuw74NWrCZeqENcAZHaPqib3RHLJBsesYKKhj2iiq8+wEMyHWo996rPyTH
         ZYmRsqYz79lD+tOaE7TINqgf1sT53hvqkIatynMlQB4P1EeYzO8mS+00nKcdviDzLSsF
         AkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rJFOB4F2I3Uhw/IG/H4qYMYPgwEvxNpylG6MakN87zU=;
        b=Cv/pkmLZuT89zEfODE/kkmr2k0KfvbjAHSTkXjpoCBQT5RaOpUQ5PSQ6xLyWtjVqDW
         gMkpenuFxp1ztWgr6szZAuOPWM5uIf2GH0j6gWY1+FGvpW8eXNXxaiyyRVfk4+l4wOJ2
         WzhH5W79Tjd+mgF8cKXvmk6UWUL9sNOxylwnc822KIKJ9Qe5bzVMylE02vWHVU0QkEEj
         qpbx3xik6urTaT4cTLVMoSFxeO4Q7riRFMxYwIphYq1o2mbf/Spb+4Gf8/bt0bVoDOY9
         pNxq5fmq4kye6ylJf7KpRaHK9nEKIi64a+4EVEqyZ1JmqW5ohT6A9T6uvDHki09929cC
         Ji8A==
X-Gm-Message-State: AOAM530xL+CUCj+pp8GmDjrTAVl/HS328N4FqkA7o+SKz+ntHh1xo6eb
        NxBNonYa/CHXste/iIscDIY5R9JE9g==
X-Google-Smtp-Source: ABdhPJy3BsDKQ+AY9cSYFCLsMVdTybXuqqN2zKFCxs7txWXmI/mDw3rr3ePJHL6v07J0TeeBT24h0LMjXA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:3ea:: with SMTP id
 cf10mr27289434qvb.53.1633431606422; Tue, 05 Oct 2021 04:00:06 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:52 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-11-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 10/23] kcsan: test: Match reordered or normal accesses
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

Due to reordering accesses with weak memory modeling, any access can now
appear as "(reordered)".

Match any permutation of accesses if CONFIG_KCSAN_WEAK_MEMORY=y, so that
we effectively match an access if it is denoted "(reordered)" or not.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 92 +++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 6e3c2b8bc608..ec054879201b 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -151,7 +151,7 @@ struct expect_report {
 
 /* Check observed report matches information in @r. */
 __no_kcsan
-static bool report_matches(const struct expect_report *r)
+static bool __report_matches(const struct expect_report *r)
 {
 	const bool is_assert = (r->access[0].type | r->access[1].type) & KCSAN_ACCESS_ASSERT;
 	bool ret = false;
@@ -253,6 +253,40 @@ static bool report_matches(const struct expect_report *r)
 	return ret;
 }
 
+static __always_inline const struct expect_report *
+__report_set_scoped(struct expect_report *r, int accesses)
+{
+	BUILD_BUG_ON(accesses > 3);
+
+	if (accesses & 1)
+		r->access[0].type |= KCSAN_ACCESS_SCOPED;
+	else
+		r->access[0].type &= ~KCSAN_ACCESS_SCOPED;
+
+	if (accesses & 2)
+		r->access[1].type |= KCSAN_ACCESS_SCOPED;
+	else
+		r->access[1].type &= ~KCSAN_ACCESS_SCOPED;
+
+	return r;
+}
+
+__no_kcsan
+static bool report_matches_any_reordered(struct expect_report *r)
+{
+	return __report_matches(__report_set_scoped(r, 0)) ||
+	       __report_matches(__report_set_scoped(r, 1)) ||
+	       __report_matches(__report_set_scoped(r, 2)) ||
+	       __report_matches(__report_set_scoped(r, 3));
+}
+
+#ifdef CONFIG_KCSAN_WEAK_MEMORY
+/* Due to reordering accesses, any access may appear as "(reordered)". */
+#define report_matches report_matches_any_reordered
+#else
+#define report_matches __report_matches
+#endif
+
 /* ===== Test kernels ===== */
 
 static long test_sink;
@@ -438,13 +472,13 @@ static noinline void test_kernel_xor_1bit(void)
 __no_kcsan
 static void test_basic(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_write, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
-	static const struct expect_report never = {
+	struct expect_report never = {
 		.access = {
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
@@ -469,14 +503,14 @@ static void test_basic(struct kunit *test)
 __no_kcsan
 static void test_concurrent_races(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			/* NULL will match any address. */
 			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
 			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(0) },
 		},
 	};
-	static const struct expect_report never = {
+	struct expect_report never = {
 		.access = {
 			{ test_kernel_rmw_array, NULL, 0, 0 },
 			{ test_kernel_rmw_array, NULL, 0, 0 },
@@ -498,13 +532,13 @@ static void test_concurrent_races(struct kunit *test)
 __no_kcsan
 static void test_novalue_change(struct kunit *test)
 {
-	const struct expect_report expect_rw = {
+	struct expect_report expect_rw = {
 		.access = {
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
-	const struct expect_report expect_ww = {
+	struct expect_report expect_ww = {
 		.access = {
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
@@ -530,13 +564,13 @@ static void test_novalue_change(struct kunit *test)
 __no_kcsan
 static void test_novalue_change_exception(struct kunit *test)
 {
-	const struct expect_report expect_rw = {
+	struct expect_report expect_rw = {
 		.access = {
 			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
-	const struct expect_report expect_ww = {
+	struct expect_report expect_ww = {
 		.access = {
 			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
@@ -556,7 +590,7 @@ static void test_novalue_change_exception(struct kunit *test)
 __no_kcsan
 static void test_unknown_origin(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 			{ NULL },
@@ -578,7 +612,7 @@ static void test_unknown_origin(struct kunit *test)
 __no_kcsan
 static void test_write_write_assume_atomic(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_write, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
@@ -604,7 +638,7 @@ static void test_write_write_assume_atomic(struct kunit *test)
 __no_kcsan
 static void test_write_write_struct(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
@@ -626,7 +660,7 @@ static void test_write_write_struct(struct kunit *test)
 __no_kcsan
 static void test_write_write_struct_part(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write_struct_part, &test_struct.val[3], sizeof(test_struct.val[3]), KCSAN_ACCESS_WRITE },
@@ -658,7 +692,7 @@ static void test_read_atomic_write_atomic(struct kunit *test)
 __no_kcsan
 static void test_read_plain_atomic_write(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 			{ test_kernel_write_atomic, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC },
@@ -679,7 +713,7 @@ static void test_read_plain_atomic_write(struct kunit *test)
 __no_kcsan
 static void test_read_plain_atomic_rmw(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 			{ test_kernel_atomic_rmw, &test_var, sizeof(test_var),
@@ -701,13 +735,13 @@ static void test_read_plain_atomic_rmw(struct kunit *test)
 __no_kcsan
 static void test_zero_size_access(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
 		},
 	};
-	const struct expect_report never = {
+	struct expect_report never = {
 		.access = {
 			{ test_kernel_write_struct, &test_struct, sizeof(test_struct), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read_struct_zero_size, &test_struct.val[3], 0, 0 },
@@ -741,7 +775,7 @@ static void test_data_race(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_writer(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_assert_writer, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
@@ -759,7 +793,7 @@ static void test_assert_exclusive_writer(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_access(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_assert_access, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
@@ -777,19 +811,19 @@ static void test_assert_exclusive_access(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_access_writer(struct kunit *test)
 {
-	const struct expect_report expect_access_writer = {
+	struct expect_report expect_access_writer = {
 		.access = {
 			{ test_kernel_assert_access, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
 			{ test_kernel_assert_writer, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
 		},
 	};
-	const struct expect_report expect_access_access = {
+	struct expect_report expect_access_access = {
 		.access = {
 			{ test_kernel_assert_access, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
 			{ test_kernel_assert_access, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
 		},
 	};
-	const struct expect_report never = {
+	struct expect_report never = {
 		.access = {
 			{ test_kernel_assert_writer, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
 			{ test_kernel_assert_writer, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
@@ -813,7 +847,7 @@ static void test_assert_exclusive_access_writer(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_bits_change(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_assert_bits_change, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
 			{ test_kernel_change_bits, &test_var, sizeof(test_var),
@@ -844,13 +878,13 @@ static void test_assert_exclusive_bits_nochange(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_writer_scoped(struct kunit *test)
 {
-	const struct expect_report expect_start = {
+	struct expect_report expect_start = {
 		.access = {
 			{ test_kernel_assert_writer_scoped, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_SCOPED },
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 		},
 	};
-	const struct expect_report expect_inscope = {
+	struct expect_report expect_inscope = {
 		.access = {
 			{ test_enter_scope, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_SCOPED },
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
@@ -871,16 +905,16 @@ static void test_assert_exclusive_writer_scoped(struct kunit *test)
 __no_kcsan
 static void test_assert_exclusive_access_scoped(struct kunit *test)
 {
-	const struct expect_report expect_start1 = {
+	struct expect_report expect_start1 = {
 		.access = {
 			{ test_kernel_assert_access_scoped, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_SCOPED },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
-	const struct expect_report expect_start2 = {
+	struct expect_report expect_start2 = {
 		.access = { expect_start1.access[0], expect_start1.access[0] },
 	};
-	const struct expect_report expect_inscope = {
+	struct expect_report expect_inscope = {
 		.access = {
 			{ test_enter_scope, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_SCOPED },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
@@ -985,7 +1019,7 @@ static void test_atomic_builtins(struct kunit *test)
 __no_kcsan
 static void test_1bit_value_change(struct kunit *test)
 {
-	const struct expect_report expect = {
+	struct expect_report expect = {
 		.access = {
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 			{ test_kernel_xor_1bit, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
-- 
2.33.0.800.g4c38ced690-goog

