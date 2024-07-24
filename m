Return-Path: <linux-arch+bounces-5607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4B93AFE3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E39285B43
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99A152180;
	Wed, 24 Jul 2024 10:32:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4A156F46;
	Wed, 24 Jul 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817124; cv=none; b=ld47m7t9gyihfnToHcFcky4Fu9LMPI8cfV4lDBcn7gUZY9e+8JdoRs4ZAPfASux9oS8J8VhuhYPS4n6pwEI0EtURCnTwQhShO0rDeP2Dhof5QYb4LzGy/BUPdeqI7wzfMj5P/2pCpMWa0maqndCjLy3jAPFNzQr7XFJDzVTu7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817124; c=relaxed/simple;
	bh=g8sHIDeL3uTMxSqZ0St72BQLRGJcBuGUpfPi4zzlzf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQUqehIpBSKBwKlTkQb5Kxe5ZmKSMLBLExe7ncSHLC+w86tXwbBIOmtwzr2uXBvVsBkWEzAaAWNmVCCgFihAghGOIwoDgs7bzQJ9arFiBc7AT7wcQL+KBU4lBNGMY0eocYPKRIRuKj2v2jt8K7IKKwBhK3nG8U16VFIuC0lTA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50EA106F;
	Wed, 24 Jul 2024 03:32:26 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC1223F5A1;
	Wed, 24 Jul 2024 03:31:58 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Date: Wed, 24 Jul 2024 16:01:42 +0530
Message-Id: <20240724103142.165693-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724103142.165693-1-anshuman.khandual@arm.com>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 lib/test_bits.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 01313980f175..2515ddc34409 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -39,6 +39,24 @@ static void genmask_ull_test(struct kunit *test)
 #endif
 }
 
+static void genmask_u128_test(struct kunit *test)
+{
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
+#endif
+}
+
 static void genmask_input_check_test(struct kunit *test)
 {
 	unsigned int x, y;
@@ -56,12 +74,15 @@ static void genmask_input_check_test(struct kunit *test)
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


