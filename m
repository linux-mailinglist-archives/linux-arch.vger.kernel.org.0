Return-Path: <linux-arch+bounces-9226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D49DF87A
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C626E281636
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8B6A009;
	Mon,  2 Dec 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp++4JFM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE04D9FE;
	Mon,  2 Dec 2024 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102492; cv=none; b=Pss+AgqgO0rWzT0vGAlMmtDjxXWnVf8VK+btpIDkjKZV3i1DLS6dcJiYe93w6NMf2qtBEASK2ivT/N1ZPVU1bXb7CXENFgL9a3ihjPfy4RMYgHFW5Ga156iDe3m42X/eZdOyKcUX+F6qvcK7WqftslOWQhZTpCUwFswr51/+uwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102492; c=relaxed/simple;
	bh=Dn8OPUmqXUFgSm05sfdBrF0SgZxvdAisWASqU8n0vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKFzRRNXiCysj+ITCga6i6yKAJ+iu4RGvnAvGHGbLHlD6Y13fDmLrgKLr5fX56TizvImOCcLmvDva7lGCPvrxzQxzt7UrsNCik8lmOnj3t10nqlUjrb111EVlp3DZqsGo6OHkWzi30fxcBdI0m6yqSzj/+EW7s1hltUlZ30df/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp++4JFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991DC4CEDC;
	Mon,  2 Dec 2024 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733102491;
	bh=Dn8OPUmqXUFgSm05sfdBrF0SgZxvdAisWASqU8n0vXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lp++4JFMLpH9I3j+N7X4mGk7IqNihJXyaZu8ZxseII6cgqU/oa/cZydjo8LsAZA1N
	 Ncf9fvNYIv07qT7jj+WAJHn6aheiDtAYmCFHYNsDddnRfucJyWytkPhNgypU3yekoj
	 jZnFC6NSqWH5T4RnVRG0G6W684Bs9zCyCsQ3alqDUffE989GndMjvLultW6liuFeZ6
	 LGTdR2Gy+IybesqZswEm1OKj6xgou9Dmzrc6/lia+r+L3AyV7jumuH7g48i79Ygg/F
	 F/E0DKnuu1FNZveiMF5Epqf06vY23um9/j6SBIQ7AwdcI+tVYWqxLwyUwIx2nnXlVh
	 2UOrFtl+wevkA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC library functions
Date: Sun,  1 Dec 2024 17:20:52 -0800
Message-ID: <20241202012056.209768-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202012056.209768-1-ebiggers@kernel.org>
References: <20241202012056.209768-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add a KUnit test suite for the crc16, crc_t10dif, crc32_le, crc32_be,
crc32c, and crc64_be library functions.  It avoids code duplication by
sharing most logic among all CRC variants.  The test suite includes:

- Differential fuzz test of each CRC function against a simple
  bit-at-a-time reference implementation.
- Test for CRC combination, when implemented by a CRC variant.
- Optional benchmark of each CRC function with various data lengths.

This is intended as a replacement for crc32test and crc16_kunit, as well
as a new test for CRC variants which didn't previously have a test.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/Kconfig.debug |  20 +++
 lib/Makefile      |   1 +
 lib/crc_kunit.c   | 435 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 456 insertions(+)
 create mode 100644 lib/crc_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..d9b89dd3f6a0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2836,10 +2836,30 @@ config HW_BREAKPOINT_KUNIT_TEST
 	help
 	  Tests for hw_breakpoint constraints accounting.
 
 	  If unsure, say N.
 
+config CRC_KUNIT_TEST
+	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select CRC16
+	select CRC_T10DIF
+	select CRC32
+	select CRC64
+	help
+	  Unit tests for the CRC library functions.
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
+config CRC_BENCHMARK
+	bool "Benchmark for the CRC functions"
+	depends on CRC_KUNIT_TEST
+	help
+	  Include benchmarks in the KUnit test suite for the CRC functions.
+
 config SIPHASH_KUNIT_TEST
 	tristate "Perform selftest on siphash functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 6573163d24e4..ccd803d03e58 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,10 +389,11 @@ obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
+obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_CRC16_KUNIT_TEST) += crc16_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/crc_kunit.c b/lib/crc_kunit.c
new file mode 100644
index 000000000000..6a61d4b5fd45
--- /dev/null
+++ b/lib/crc_kunit.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Unit tests and benchmarks for the CRC library functions
+ *
+ * Copyright 2024 Google LLC
+ *
+ * Author: Eric Biggers <ebiggers@google.com>
+ */
+#include <kunit/test.h>
+#include <linux/crc16.h>
+#include <linux/crc-t10dif.h>
+#include <linux/crc32.h>
+#include <linux/crc32c.h>
+#include <linux/crc64.h>
+#include <linux/prandom.h>
+#include <linux/vmalloc.h>
+
+#define CRC_KUNIT_SEED			42
+#define CRC_KUNIT_MAX_LEN		16384
+#define CRC_KUNIT_NUM_TEST_ITERS	1000
+
+static struct rnd_state rng;
+static u8 *test_buffer;
+static size_t test_buflen;
+
+/**
+ * struct crc_variant - describes a CRC variant
+ * @bits: Number of bits in the CRC, 1 <= @bits <= 64.
+ * @le: true if it's a "little endian" CRC (reversed mapping between bits and
+ *	polynomial coefficients in each byte), false if it's a "big endian" CRC
+ *	(natural mapping between bits and polynomial coefficients in each byte)
+ * @poly: The generator polynomial with the highest-order term omitted.
+ *	  Bit-reversed if @le is true.
+ * @func: The function to compute a CRC.  The type signature uses u64 so that it
+ *	  can fit any CRC up to CRC-64.
+ * @combine_func: Optional function to combine two CRCs.
+ */
+struct crc_variant {
+	int bits;
+	bool le;
+	u64 poly;
+	u64 (*func)(u64 crc, const u8 *p, size_t len);
+	u64 (*combine_func)(u64 crc1, u64 crc2, size_t len2);
+};
+
+static u32 rand32(void)
+{
+	return prandom_u32_state(&rng);
+}
+
+static u64 rand64(void)
+{
+	u32 n = rand32();
+
+	return ((u64)n << 32) | rand32();
+}
+
+static u64 crc_mask(const struct crc_variant *v)
+{
+	return (u64)-1 >> (64 - v->bits);
+}
+
+/* Reference implementation of any CRC variant */
+static u64 crc_ref(const struct crc_variant *v,
+		   u64 crc, const u8 *p, size_t len)
+{
+	size_t i, j;
+
+	for (i = 0; i < len; i++) {
+		for (j = 0; j < 8; j++) {
+			if (v->le) {
+				crc ^= (p[i] >> j) & 1;
+				crc = (crc >> 1) ^ ((crc & 1) ? v->poly : 0);
+			} else {
+				crc ^= (u64)((p[i] >> (7 - j)) & 1) <<
+				       (v->bits - 1);
+				if (crc & (1ULL << (v->bits - 1)))
+					crc = ((crc << 1) ^ v->poly) &
+					      crc_mask(v);
+				else
+					crc <<= 1;
+			}
+		}
+	}
+	return crc;
+}
+
+static int crc_suite_init(struct kunit_suite *suite)
+{
+	/*
+	 * Allocate the test buffer using vmalloc() with a page-aligned length
+	 * so that it is immediately followed by a guard page.  This allows
+	 * buffer overreads to be detected, even in assembly code.
+	 */
+	test_buflen = round_up(CRC_KUNIT_MAX_LEN, PAGE_SIZE);
+	test_buffer = vmalloc(test_buflen);
+	if (!test_buffer)
+		return -ENOMEM;
+
+	prandom_seed_state(&rng, CRC_KUNIT_SEED);
+	prandom_bytes_state(&rng, test_buffer, test_buflen);
+	return 0;
+}
+
+static void crc_suite_exit(struct kunit_suite *suite)
+{
+	vfree(test_buffer);
+	test_buffer = NULL;
+}
+
+/* Generate a random initial CRC. */
+static u64 generate_random_initial_crc(const struct crc_variant *v)
+{
+	switch (rand32() % 4) {
+	case 0:
+		return 0;
+	case 1:
+		return crc_mask(v); /* All 1 bits */
+	default:
+		return rand64() & crc_mask(v);
+	}
+}
+
+/* Generate a random length, preferring small lengths. */
+static size_t generate_random_length(size_t max_length)
+{
+	size_t len;
+
+	switch (rand32() % 3) {
+	case 0:
+		len = rand32() % 128;
+		break;
+	case 1:
+		len = rand32() % 3072;
+		break;
+	default:
+		len = rand32();
+		break;
+	}
+	return len % (max_length + 1);
+}
+
+/* Test that v->func gives the same CRCs as a reference implementation. */
+static void crc_main_test(struct kunit *test, const struct crc_variant *v)
+{
+	size_t i;
+
+	for (i = 0; i < CRC_KUNIT_NUM_TEST_ITERS; i++) {
+		u64 init_crc, expected_crc, actual_crc;
+		size_t len, offset;
+		bool nosimd;
+
+		init_crc = generate_random_initial_crc(v);
+		len = generate_random_length(CRC_KUNIT_MAX_LEN);
+
+		/* Generate a random offset. */
+		if (rand32() % 2 == 0) {
+			/* Use a random alignment mod 64 */
+			offset = rand32() % 64;
+			offset = min(offset, CRC_KUNIT_MAX_LEN - len);
+		} else {
+			/* Go up to the guard page, to catch buffer overreads */
+			offset = test_buflen - len;
+		}
+
+		if (rand32() % 8 == 0)
+			/* Refresh the data occasionally. */
+			prandom_bytes_state(&rng, &test_buffer[offset], len);
+
+		nosimd = rand32() % 8 == 0;
+
+		/*
+		 * Compute the CRC, and verify that it equals the CRC computed
+		 * by a simple bit-at-a-time reference implementation.
+		 */
+		expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
+		if (nosimd)
+			local_irq_disable();
+		actual_crc = v->func(init_crc, &test_buffer[offset], len);
+		if (nosimd)
+			local_irq_enable();
+		KUNIT_EXPECT_EQ_MSG(test, expected_crc, actual_crc,
+				    "Wrong result with len=%zu offset=%zu nosimd=%d",
+				    len, offset, nosimd);
+	}
+}
+
+/* Test that CRC(concat(A, B)) == combine_CRCs(CRC(A), CRC(B), len(B)). */
+static void crc_combine_test(struct kunit *test, const struct crc_variant *v)
+{
+	int i;
+
+	for (i = 0; i < 100; i++) {
+		u64 init_crc = generate_random_initial_crc(v);
+		size_t len1 = generate_random_length(CRC_KUNIT_MAX_LEN);
+		size_t len2 = generate_random_length(CRC_KUNIT_MAX_LEN - len1);
+		u64 crc1, crc2, expected_crc, actual_crc;
+
+		prandom_bytes_state(&rng, test_buffer, len1 + len2);
+		crc1 = v->func(init_crc, test_buffer, len1);
+		crc2 = v->func(0, &test_buffer[len1], len2);
+		expected_crc = v->func(init_crc, test_buffer, len1 + len2);
+		actual_crc = v->combine_func(crc1, crc2, len2);
+		KUNIT_EXPECT_EQ_MSG(test, expected_crc, actual_crc,
+				    "CRC combination gave wrong result with len1=%zu len2=%zu\n",
+				    len1, len2);
+	}
+}
+
+static void crc_test(struct kunit *test, const struct crc_variant *v)
+{
+	crc_main_test(test, v);
+	if (v->combine_func)
+		crc_combine_test(test, v);
+}
+
+static __always_inline void
+crc_benchmark(struct kunit *test,
+	      u64 (*crc_func)(u64 crc, const u8 *p, size_t len))
+{
+	static const size_t lens_to_test[] = {
+		1, 16, 64, 127, 128, 200, 256, 511, 512, 1024, 3173, 4096, 16384,
+	};
+	size_t len, i, j, num_iters;
+	/*
+	 * Some of the CRC library functions are marked as __pure, so use
+	 * volatile to ensure that all calls are really made as intended.
+	 */
+	volatile u64 crc = 0;
+	u64 t;
+
+	if (!IS_ENABLED(CONFIG_CRC_BENCHMARK))
+		kunit_skip(test, "not enabled");
+
+	/* warm-up */
+	for (i = 0; i < 10000000; i += CRC_KUNIT_MAX_LEN)
+		crc = crc_func(crc, test_buffer, CRC_KUNIT_MAX_LEN);
+
+	for (i = 0; i < ARRAY_SIZE(lens_to_test); i++) {
+		len = lens_to_test[i];
+		KUNIT_ASSERT_LE(test, len, CRC_KUNIT_MAX_LEN);
+		num_iters = 10000000 / (len + 128);
+		preempt_disable();
+		t = ktime_get_ns();
+		for (j = 0; j < num_iters; j++)
+			crc = crc_func(crc, test_buffer, len);
+		t = ktime_get_ns() - t;
+		preempt_enable();
+		kunit_info(test, "len=%zu: %llu MB/s\n",
+			   len, div64_u64((u64)len * num_iters * 1000, t));
+	}
+}
+
+/* crc16 */
+
+static u64 crc16_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc16(crc, p, len);
+}
+
+static const struct crc_variant crc_variant_crc16 = {
+	.bits = 16,
+	.le = true,
+	.poly = 0xa001,
+	.func = crc16_wrapper,
+};
+
+static void crc16_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc16);
+}
+
+static void crc16_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc16_wrapper);
+}
+
+/* crc_t10dif */
+
+static u64 crc_t10dif_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc_t10dif_update(crc, p, len);
+}
+
+static const struct crc_variant crc_variant_crc_t10dif = {
+	.bits = 16,
+	.le = false,
+	.poly = 0x8bb7,
+	.func = crc_t10dif_wrapper,
+};
+
+static void crc_t10dif_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc_t10dif);
+}
+
+static void crc_t10dif_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc_t10dif_wrapper);
+}
+
+/* crc32_le */
+
+static u64 crc32_le_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc32_le(crc, p, len);
+}
+
+static u64 crc32_le_combine_wrapper(u64 crc1, u64 crc2, size_t len2)
+{
+	return crc32_le_combine(crc1, crc2, len2);
+}
+
+static const struct crc_variant crc_variant_crc32_le = {
+	.bits = 32,
+	.le = true,
+	.poly = 0xedb88320,
+	.func = crc32_le_wrapper,
+	.combine_func = crc32_le_combine_wrapper,
+};
+
+static void crc32_le_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc32_le);
+}
+
+static void crc32_le_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc32_le_wrapper);
+}
+
+/* crc32_be */
+
+static u64 crc32_be_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc32_be(crc, p, len);
+}
+
+static const struct crc_variant crc_variant_crc32_be = {
+	.bits = 32,
+	.le = false,
+	.poly = 0x04c11db7,
+	.func = crc32_be_wrapper,
+};
+
+static void crc32_be_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc32_be);
+}
+
+static void crc32_be_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc32_be_wrapper);
+}
+
+/* crc32c */
+
+static u64 crc32c_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc32c(crc, p, len);
+}
+
+static u64 crc32c_combine_wrapper(u64 crc1, u64 crc2, size_t len2)
+{
+	return __crc32c_le_combine(crc1, crc2, len2);
+}
+
+static const struct crc_variant crc_variant_crc32c = {
+	.bits = 32,
+	.le = true,
+	.poly = 0x82f63b78,
+	.func = crc32c_wrapper,
+	.combine_func = crc32c_combine_wrapper,
+};
+
+static void crc32c_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc32c);
+}
+
+static void crc32c_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc32c_wrapper);
+}
+
+/* crc64_be */
+
+static u64 crc64_be_wrapper(u64 crc, const u8 *p, size_t len)
+{
+	return crc64_be(crc, p, len);
+}
+
+static const struct crc_variant crc_variant_crc64_be = {
+	.bits = 64,
+	.le = false,
+	.poly = 0x42f0e1eba9ea3693,
+	.func = crc64_be_wrapper,
+};
+
+static void crc64_be_test(struct kunit *test)
+{
+	crc_test(test, &crc_variant_crc64_be);
+}
+
+static void crc64_be_benchmark(struct kunit *test)
+{
+	crc_benchmark(test, crc64_be_wrapper);
+}
+
+static struct kunit_case crc_test_cases[] = {
+	KUNIT_CASE(crc16_test),
+	KUNIT_CASE(crc16_benchmark),
+	KUNIT_CASE(crc_t10dif_test),
+	KUNIT_CASE(crc_t10dif_benchmark),
+	KUNIT_CASE(crc32_le_test),
+	KUNIT_CASE(crc32_le_benchmark),
+	KUNIT_CASE(crc32_be_test),
+	KUNIT_CASE(crc32_be_benchmark),
+	KUNIT_CASE(crc32c_test),
+	KUNIT_CASE(crc32c_benchmark),
+	KUNIT_CASE(crc64_be_test),
+	KUNIT_CASE(crc64_be_benchmark),
+	{},
+};
+
+static struct kunit_suite crc_test_suite = {
+	.name = "crc",
+	.test_cases = crc_test_cases,
+	.suite_init = crc_suite_init,
+	.suite_exit = crc_suite_exit,
+};
+kunit_test_suite(crc_test_suite);
+
+MODULE_DESCRIPTION("Unit tests and benchmarks for the CRC library functions");
+MODULE_LICENSE("GPL");
-- 
2.47.1


