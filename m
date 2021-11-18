Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC79B45568C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbhKRIOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbhKRIO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:14:26 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AADC06122A
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:23 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so3987959wma.5
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UU4Lhk72EIyuCjy+G0t4z2bUBJwzL7HcimRlPhkjEC4=;
        b=Pl3A/KdXTVZRzmMxgTljKxh/hqM0swD++n3g+bUqL9p+DAaHHbBVtXzulmhpUXx3pF
         tJ7iWzeIZgcjEnsplwVD2EawSylZ8cvf/UOwL/mLQpkP8z0tIeToCOxXGc8FSh2HTSYv
         3JQz32uM3FIbV1weMevwae+3aUTPM43pfkM46DM5lIEbt854F+Zf8SF4Z2OVqnlzxgIg
         dt5J4M3X2skbNq51uvzGx0sjRXFt3V5pbV57qGk9xFURWKDvGDXh/Beti3Yl7hYPAsnv
         BovkQX9lPoGRuO9kIMXyUnSEWbdwc7gbn4zrtACRigRDhcoBQKkD7Cyi0GF37FzMJSTW
         m42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UU4Lhk72EIyuCjy+G0t4z2bUBJwzL7HcimRlPhkjEC4=;
        b=zY/tpEM6xa2DhZfAhPS+gk+5WKdvjqdj1A2J2VCMR2QqydraLXH8OICG89xoXCdHYO
         fiZ7J4aUa4ZpHpqh2ItT2RauR9BvolX7k7k+HQwA6xkmj6Y3sM7KD2zM6Eykv0iOOXBU
         dGu4x/RKMd9K0EUiJzrd12YKam3/33tLX+belnjrlOuSs1W84WsygGAJf1Sa0tz6yblP
         P6iR9dV+oJFoGcz0t2ljC23TqiBNTfK59GVIkWjnhH/tlC/VcA0Y6HwnPDET+/Qh38sw
         gxq+oXXEl8EwaNs6nfQf/AN8OGFpvkBQBHKZKDUA8uLKYfYZ/c9XBkHvexjN1mv41CRh
         fRGQ==
X-Gm-Message-State: AOAM533NpoTlddQ3m0LyRqGCYNcNO6QFzSZevc7Od9XW4MQ4Mko+22vS
        Y9C13E9uv0a1X43cLJuTGt14xjufJQ==
X-Google-Smtp-Source: ABdhPJzbJSgbvNkXYRTtrb2K7aFW3iR9q19u2au2vwCGyMcef1aOTB9mDhygt3i70RxiSOLd/DAEarA2eg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a5d:4443:: with SMTP id x3mr29290572wrr.189.1637223081578;
 Thu, 18 Nov 2021 00:11:21 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:14 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-11-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 10/23] kcsan: test: Match reordered or normal accesses
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
2.34.0.rc2.393.gf8c9666880-goog

