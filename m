Return-Path: <linux-arch+bounces-6349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9626957BF0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 05:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AF0B226CB
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 03:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB56482FF;
	Tue, 20 Aug 2024 03:36:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8122E3FE;
	Tue, 20 Aug 2024 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124985; cv=none; b=tz/L6dmJiI91ne3i23bvdUQVw/sYuCUX4ny5DUKq+CRZcBPbKoKKEUBhRtlpPBNwjLPIINvxLP9LTJSWpYSTZP2beyPDNOOgNwJFLu51/FyfrQiWfJatgoAFTEZLEwMW2F1/+PLNKqLb1idYXOk/lKyk4wNkNZODBQMZpzyDONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124985; c=relaxed/simple;
	bh=gCyc87iUvhgXGQNxBVQ7W1PV+msAIbDuV9bl+be86/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0h/cZR8PgN08VQO/b4OE+Br0nGu5/sJudW47E/J8n2qy9F27qpt8awktRC+7fYMyCQ+O+hd5VpGjqwbD1FuOQMMzEPK2D01Zr6B+4lUSMZDP83blDVCewnXd2wSaYKWF6oMSFQDf/+iUjB2Ni17MPNn4AmnXdOQlZ+mKXIQW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191F0339;
	Mon, 19 Aug 2024 20:36:42 -0700 (PDT)
Received: from [10.163.58.147] (unknown [10.163.58.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63873F58B;
	Mon, 19 Aug 2024 20:36:13 -0700 (PDT)
Message-ID: <e452648d-fbbd-475d-b8e5-a199f56dfd98@arm.com>
Date: Tue, 20 Aug 2024 09:06:10 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
To: linux-kernel@vger.kernel.org
Cc: ardb@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-3-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240801071646.682731-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/1/24 12:46, Anshuman Khandual wrote:
> This adds GENMASK_U128() tests although currently only 64 bit wide masks
> are being tested.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  lib/test_bits.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/lib/test_bits.c b/lib/test_bits.c
> index 01313980f175..d3d858b24e02 100644
> --- a/lib/test_bits.c
> +++ b/lib/test_bits.c
> @@ -39,6 +39,26 @@ static void genmask_ull_test(struct kunit *test)
>  #endif
>  }
>  
> +static void genmask_u128_test(struct kunit *test)
> +{
> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
> +	/* Tests mask generation only when the mask width is within 64 bits */
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
> +	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
> +
> +#ifdef TEST_GENMASK_FAILURES
> +	/* these should fail compilation */
> +	GENMASK_U128(0, 1);
> +	GENMASK_U128(0, 10);
> +	GENMASK_U128(9, 10);
> +#endif /* TEST_GENMASK_FAILURES */
> +#endif /* CONFIG_ARCH_SUPPORTS_INT128 */
> +}
> +
>  static void genmask_input_check_test(struct kunit *test)
>  {
>  	unsigned int x, y;
> @@ -56,12 +76,15 @@ static void genmask_input_check_test(struct kunit *test)
>  	/* Valid input */
>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
>  }
>  
>  
>  static struct kunit_case bits_test_cases[] = {
>  	KUNIT_CASE(genmask_test),
>  	KUNIT_CASE(genmask_ull_test),
> +	KUNIT_CASE(genmask_u128_test),
>  	KUNIT_CASE(genmask_input_check_test),
>  	{}
>  };

Here is the updated test case to cover some more corner cases. Please
do let me know if something more can be added here to the list.

--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -39,6 +39,36 @@ static void genmask_ull_test(struct kunit *test)
 #endif
 }
 
+static void genmask_u128_test(struct kunit *test)
+{
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+       /* Below 64 bit masks */
+       KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(0, 0));
+       KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(1, 0));
+       KUNIT_EXPECT_EQ(test, 0x0000000000000006ull, GENMASK_U128(2, 1));
+       KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(31, 0));
+       KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_U128(39, 21));
+       KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(63, 0));
+
+       /* Above 64 bit masks - only 64 bit portion can be validated once */
+       KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(64, 0) >> 1);
+       KUNIT_EXPECT_EQ(test, 0x00000000ffffffffull, GENMASK_U128(81, 50) >> 50);
+       KUNIT_EXPECT_EQ(test, 0x0000000000ffffffull, GENMASK_U128(87, 64) >> 64);
+       KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ull, GENMASK_U128(87, 80) >> 64);
+
+       KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_U128(127, 0) >> 64);
+       KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, (u64)GENMASK_U128(127, 0));
+       KUNIT_EXPECT_EQ(test, 0x0000000000000003ull, GENMASK_U128(127, 126) >> 126);
+       KUNIT_EXPECT_EQ(test, 0x0000000000000001ull, GENMASK_U128(127, 127) >> 127);
+#ifdef TEST_GENMASK_FAILURES
+       /* these should fail compilation */
+       GENMASK_U128(0, 1);
+       GENMASK_U128(0, 10);
+       GENMASK_U128(9, 10);
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
+       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
+       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
+       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0));
 }
 
 
 static struct kunit_case bits_test_cases[] = {
        KUNIT_CASE(genmask_test),
        KUNIT_CASE(genmask_ull_test),
+       KUNIT_CASE(genmask_u128_test),
        KUNIT_CASE(genmask_input_check_test),
        {}
 };
(END)
 

