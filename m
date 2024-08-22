Return-Path: <linux-arch+bounces-6489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8B95ACAC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562A72832B4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19AA43146;
	Thu, 22 Aug 2024 04:49:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A0745E4;
	Thu, 22 Aug 2024 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302154; cv=none; b=UA2jYVvTfGNqtH3H8RaO81xNp0sMdKQoDZuOu4tfywiEuKxFu1SqvKl1MPok/OxbekyhtveA5JnxOxcM9yYQJCrcM7g2z4SAdML022GWcabegvo4LKvh3wKPKy4ro0vjoD+4kkaO3LtzpbsTTyN5qr42T9eJ5+I8djY3Np4JlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302154; c=relaxed/simple;
	bh=nCMM0Jr3N8KmORy+hV3mLDyIBIicrV3LxCFkQRoTtJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEVzRSbNfv3+g2RDbcCQlCjfCGb3EEglZmD7wWySi35QLJs3IlsC6jM/AhVMQvz0Gsbr4Jbrl5drgZ/bJ/lDm3YxoWIWIGUmJRNgnEm04pXQoX/dcKmOAtFJx99Rcml1pnjihGRS/YNUt2dXcyuVTxxnGBcWWTwTFzaDeJ7rvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C79152B;
	Wed, 21 Aug 2024 21:49:37 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.59.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D7123F73B;
	Wed, 21 Aug 2024 21:49:08 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	yury.norov@gmail.com,
	arnd@arndb.de
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-arch@vger.kernel.org
Subject: [PATCH V4 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Date: Thu, 22 Aug 2024 10:18:53 +0530
Message-Id: <20240822044853.567386-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822044853.567386-1-anshuman.khandual@arm.com>
References: <20240822044853.567386-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds GENMASK_U128() tests although currently only 64 bit wide masks
are being tested.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 lib/test_bits.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 01313980f175..c7b38d91e1f1 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -39,6 +39,36 @@ static void genmask_ull_test(struct kunit *test)
 #endif
 }
 
+static void genmask_u128_test(struct kunit *test)
+{
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+	/* Below 64 bit masks */
+	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
+	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
+	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(63, 0));
+
+	/* Above 64 bit masks - only 64 bit portion can be validated once */
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(64, 0) >> 1);
+	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(81, 50) >> 50);
+	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffull, GENMASK_U128(87, 64) >> 64);
+	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ull, GENMASK_U128(87, 80) >> 64);
+
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(127, 0) >> 64);
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, (u64)GENMASK_U128(127, 0));
+	KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(127, 126) >> 126);
+	KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(127, 127) >> 127);
+#ifdef TEST_GENMASK_FAILURES
+	/* these should fail compilation */
+	GENMASK_U128(0, 1);
+	GENMASK_U128(0, 10);
+	GENMASK_U128(9, 10);
+#endif /* TEST_GENMASK_FAILURES */
+#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
+}
+
 static void genmask_input_check_test(struct kunit *test)
 {
 	unsigned int x, y;
@@ -56,12 +86,16 @@ static void genmask_input_check_test(struct kunit *test)
 	/* Valid input */
 	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
 	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0));
 }
 
 
 static struct kunit_case bits_test_cases[] = {
 	KUNIT_CASE(genmask_test),
 	KUNIT_CASE(genmask_ull_test),
+	KUNIT_CASE(genmask_u128_test),
 	KUNIT_CASE(genmask_input_check_test),
 	{}
 };
-- 
2.30.2


