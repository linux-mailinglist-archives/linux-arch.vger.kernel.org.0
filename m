Return-Path: <linux-arch+bounces-9227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E60E9DF880
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22376161691
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A2745F2;
	Mon,  2 Dec 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mew14CNy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE517081B;
	Mon,  2 Dec 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102492; cv=none; b=rpJwpqshmaCAXXaCDCNUnslBsPmCbnqf1X+HfPSRb1vQ1Vj4n3CXt48NBD2NkLSCeG23KNsn3rR/ZPHapbJG7KqUDbRaX66HHITmuL85mXC+aTcb673PnktpoAqun/AfxyePmIXwWKi49Zk+PaDdFpiJKeugnjDpXSdbZbxgHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102492; c=relaxed/simple;
	bh=KUxurPuR7tri/rWwkEp1MLHm/TOAuwD8O1Sn0i1uUzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itxs0x3ti80t/oxSWkGlvCAd2hnlvunZ+wyUzbKZVmrLjMsXGVxsbcIkqORQn//IDhth7DiqLdw/pqqAqDjd0Ki8ZiY55yItNQpjVH6zB4tPHdWso8NhJpSlgWInNxYypHw5Nuu99TLwcYkyhEQypwVfKv0oRAXkVUH/9clH6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mew14CNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3605C4CEE3;
	Mon,  2 Dec 2024 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733102492;
	bh=KUxurPuR7tri/rWwkEp1MLHm/TOAuwD8O1Sn0i1uUzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mew14CNy1lCNG18pX6nCOSSUkM7sygXeFSyi8VPEzxe0yG/lP4DT+LFSNqYSQxMuX
	 5YhWQKvo9kdFy7jfWeRaMniXZoL9OzFPxmY9ovzXID0IKWZHzVmQio0O71xHl7S4xo
	 nmtwrG5cg+yha+fcT2o1jO8G5NM/OosgTXW30Mr0bxe+uZnU1k9jZXex8oBObAmKBp
	 fP0pN6NFW/CC8jEMKWDX63y7UEwISw8y4Pt8kB7SNJLnmFLf/0rBTS0ztTlM3EkJZ5
	 ZGQUoS2SoQtEZyqDJ3yYGSCVbxe9iPu1hfdsQy4D7vBFFXM8GP/4reSAm9OnbDZuXb
	 yMkp5GgBA1IQA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>
Subject: [PATCH v2 09/12] lib/crc16_kunit: delete obsolete crc16_kunit.c
Date: Sun,  1 Dec 2024 17:20:53 -0800
Message-ID: <20241202012056.209768-10-ebiggers@kernel.org>
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

This new test showed up in v6.13-rc1.  Delete it since it is being
superseded by crc_kunit.c, which is more comprehensive (tests multiple
CRC variants without duplicating code, includes a benchmark, etc.).

Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/Kconfig.debug |   9 ---
 lib/Makefile      |   1 -
 lib/crc16_kunit.c | 155 ----------------------------------------------
 3 files changed, 165 deletions(-)
 delete mode 100644 lib/crc16_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d9b89dd3f6a0..688dace36f36 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2876,19 +2876,10 @@ config USERCOPY_KUNIT_TEST
 	help
 	  This builds the "usercopy_kunit" module that runs sanity checks
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
-config CRC16_KUNIT_TEST
-	tristate "KUnit tests for CRC16"
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-	select CRC16
-	help
-	  Enable this option to run unit tests for the kernel's CRC16
-	  implementation (<linux/crc16.h>).
-
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
 	  This builds the "udelay_test" module that helps to make sure
 	  that udelay() is working properly.
diff --git a/lib/Makefile b/lib/Makefile
index ccd803d03e58..34f4d61e3cf7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -392,11 +392,10 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
-obj-$(CONFIG_CRC16_KUNIT_TEST) += crc16_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
 
diff --git a/lib/crc16_kunit.c b/lib/crc16_kunit.c
deleted file mode 100644
index 0918c98a96d2..000000000000
--- a/lib/crc16_kunit.c
+++ /dev/null
@@ -1,155 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * KUnits tests for CRC16.
- *
- * Copyright (C) 2024, LKCAMP
- * Author: Vinicius Peixoto <vpeixoto@lkcamp.dev>
- * Author: Fabricio Gasperin <fgasperin@lkcamp.dev>
- * Author: Enzo Bertoloti <ebertoloti@lkcamp.dev>
- */
-#include <kunit/test.h>
-#include <linux/crc16.h>
-#include <linux/prandom.h>
-
-#define CRC16_KUNIT_DATA_SIZE 4096
-#define CRC16_KUNIT_TEST_SIZE 100
-#define CRC16_KUNIT_SEED 0x12345678
-
-/**
- * struct crc16_test - CRC16 test data
- * @crc: initial input value to CRC16
- * @start: Start index within the data buffer
- * @length: Length of the data
- */
-static struct crc16_test {
-	u16 crc;
-	u16 start;
-	u16 length;
-} tests[CRC16_KUNIT_TEST_SIZE];
-
-u8 data[CRC16_KUNIT_DATA_SIZE];
-
-
-/* Naive implementation of CRC16 for validation purposes */
-static inline u16 _crc16_naive_byte(u16 crc, u8 data)
-{
-	u8 i = 0;
-
-	crc ^= (u16) data;
-	for (i = 0; i < 8; i++) {
-		if (crc & 0x01)
-			crc = (crc >> 1) ^ 0xa001;
-		else
-			crc = crc >> 1;
-	}
-
-	return crc;
-}
-
-
-static inline u16 _crc16_naive(u16 crc, u8 *buffer, size_t len)
-{
-	while (len--)
-		crc = _crc16_naive_byte(crc, *buffer++);
-	return crc;
-}
-
-
-/* Small helper for generating pseudorandom 16-bit data */
-static inline u16 _rand16(void)
-{
-	static u32 rand = CRC16_KUNIT_SEED;
-
-	rand = next_pseudo_random32(rand);
-	return rand & 0xFFFF;
-}
-
-
-static int crc16_init_test_data(struct kunit_suite *suite)
-{
-	size_t i;
-
-	/* Fill the data buffer with random bytes */
-	for (i = 0; i < CRC16_KUNIT_DATA_SIZE; i++)
-		data[i] = _rand16() & 0xFF;
-
-	/* Generate random test data while ensuring the random
-	 * start + length values won't overflow the 4096-byte
-	 * buffer (0x7FF * 2 = 0xFFE < 0x1000)
-	 */
-	for (size_t i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
-		tests[i].crc = _rand16();
-		tests[i].start = _rand16() & 0x7FF;
-		tests[i].length = _rand16() & 0x7FF;
-	}
-
-	return 0;
-}
-
-static void crc16_test_empty(struct kunit *test)
-{
-	u16 crc;
-
-	/* The result for empty data should be the same as the
-	 * initial crc
-	 */
-	crc = crc16(0x00, data, 0);
-	KUNIT_EXPECT_EQ(test, crc, 0);
-	crc = crc16(0xFF, data, 0);
-	KUNIT_EXPECT_EQ(test, crc, 0xFF);
-}
-
-static void crc16_test_correctness(struct kunit *test)
-{
-	size_t i;
-	u16 crc, crc_naive;
-
-	for (i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
-		/* Compare results with the naive crc16 implementation */
-		crc = crc16(tests[i].crc, data + tests[i].start,
-			    tests[i].length);
-		crc_naive = _crc16_naive(tests[i].crc, data + tests[i].start,
-					 tests[i].length);
-		KUNIT_EXPECT_EQ(test, crc, crc_naive);
-	}
-}
-
-
-static void crc16_test_combine(struct kunit *test)
-{
-	size_t i, j;
-	u16 crc, crc_naive;
-
-	/* Make sure that combining two consecutive crc16 calculations
-	 * yields the same result as calculating the crc16 for the whole thing
-	 */
-	for (i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
-		crc_naive = crc16(tests[i].crc, data + tests[i].start, tests[i].length);
-		for (j = 0; j < tests[i].length; j++) {
-			crc = crc16(tests[i].crc, data + tests[i].start, j);
-			crc = crc16(crc, data + tests[i].start + j, tests[i].length - j);
-			KUNIT_EXPECT_EQ(test, crc, crc_naive);
-		}
-	}
-}
-
-
-static struct kunit_case crc16_test_cases[] = {
-	KUNIT_CASE(crc16_test_empty),
-	KUNIT_CASE(crc16_test_combine),
-	KUNIT_CASE(crc16_test_correctness),
-	{},
-};
-
-static struct kunit_suite crc16_test_suite = {
-	.name = "crc16",
-	.test_cases = crc16_test_cases,
-	.suite_init = crc16_init_test_data,
-};
-kunit_test_suite(crc16_test_suite);
-
-MODULE_AUTHOR("Fabricio Gasperin <fgasperin@lkcamp.dev>");
-MODULE_AUTHOR("Vinicius Peixoto <vpeixoto@lkcamp.dev>");
-MODULE_AUTHOR("Enzo Bertoloti <ebertoloti@lkcamp.dev>");
-MODULE_DESCRIPTION("Unit tests for crc16");
-MODULE_LICENSE("GPL");
-- 
2.47.1


