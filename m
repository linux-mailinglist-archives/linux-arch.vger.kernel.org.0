Return-Path: <linux-arch+bounces-5833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AFD944547
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08771C22072
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41285157E62;
	Thu,  1 Aug 2024 07:17:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A6158219;
	Thu,  1 Aug 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496629; cv=none; b=TOW4k96aPe04g9P6uJ7T1KUOo+gPS370HxxAxU5DUpzc3keNXZCUGi9SIdUj08NO0j1Um0K1x6XZiI3etsEq2H9NEBJeMl+G4wolae4WkdzoK4EodF2KRcY+28mReXDrJ6yIYQT+cPuq7Aw1szjcP72JeZUKQ+gpxfRyt5s8gwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496629; c=relaxed/simple;
	bh=qqjftvWxtSMvNLDG28PttSQy2YcANG4yqZsJe6TwPUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKpem1SN4D0J+P06mT1lFjRhK1chPhkP4k3TtpT3Fg/NYo9bX7nICcyE+nYqYwyqPl0yFSZ+M3Q2/D4vwppxeUwqBS2E3u1Ux8vjCvKI9cJYgyABFoTotaCpnitnNlZoNgRhlTDwxbwapKl0qajdrNCuEC4QC/3PNfTb/Azj3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22D321007;
	Thu,  1 Aug 2024 00:17:32 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E8F23F766;
	Thu,  1 Aug 2024 00:17:03 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	ardb@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH V3 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Date: Thu,  1 Aug 2024 12:46:46 +0530
Message-Id: <20240801071646.682731-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801071646.682731-1-anshuman.khandual@arm.com>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
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
 lib/test_bits.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 01313980f175..d3d858b24e02 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -39,6 +39,26 @@ static void genmask_ull_test(struct kunit *test)
 #endif
 }
 
+static void genmask_u128_test(struct kunit *test)
+{
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+	/* Tests mask generation only when the mask width is within 64 bits */
+	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
+	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
+	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
+	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
+
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
@@ -56,12 +76,15 @@ static void genmask_input_check_test(struct kunit *test)
 	/* Valid input */
 	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
 	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
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


