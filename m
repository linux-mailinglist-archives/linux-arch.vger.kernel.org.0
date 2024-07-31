Return-Path: <linux-arch+bounces-5740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D3942542
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1611C214C1
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD118E0E;
	Wed, 31 Jul 2024 04:11:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEB9C8FF;
	Wed, 31 Jul 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399088; cv=none; b=eVGwy1juIHn8umPVOgjoGUJgmbnPsueMTHNvrI6ajULXpfOswP6OlihgqiFWz7sLUpgYvGGz/97JHjap+iYncRs1YoY2Q+g2npApvBtfgsQ/OKYgoKRk05Emnj0/rkxRI6TAeRsy+vfsrTgVDpW2ZUBv/rFArkBbhqK8zQ3PxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399088; c=relaxed/simple;
	bh=C/0wmiana2eUriUmsFxEbhtWvChe43/8d5MMQ4Enqn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3DOKFaDx4s50IW27hc5QyhXMd74c3h/8fCq7dp7qYSfDmzx5Kbl+v0NpT1MWe7vTV8bkl9i3NG9c7fT9zZrc0yTTgcQLA75s4RwK1+DG8HiuRk2fDCiW9xuTANPpoJzT50B8L50j9BpgwmxqSPnzglXB/JKzA1Q0gJWNPU1A54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F951007;
	Tue, 30 Jul 2024 21:11:50 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4920B3F5A1;
	Tue, 30 Jul 2024 21:11:21 -0700 (PDT)
Message-ID: <d94c44df-055b-4fd1-a384-28ce5ce59921@arm.com>
Date: Wed, 31 Jul 2024 09:41:19 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-3-anshuman.khandual@arm.com>
 <Zqku82z-y2fjtIZT@yury-ThinkPad>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zqku82z-y2fjtIZT@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 23:50, Yury Norov wrote:
> On Thu, Jul 25, 2024 at 11:18:08AM +0530, Anshuman Khandual wrote:
>> This adds GENMASK_U128() tests although currently only 64 bit wide masks
>> are being tested.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  lib/test_bits.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/lib/test_bits.c b/lib/test_bits.c
>> index 01313980f175..f0d1033cf3c9 100644
>> --- a/lib/test_bits.c
>> +++ b/lib/test_bits.c
>> @@ -39,6 +39,26 @@ static void genmask_ull_test(struct kunit *test)
>>  #endif
>>  }
>>  
>> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
> 
> Can you move this ifdefery inside the function scope, so that you'll
> not have do it below in tests array declarattion?

Sure, will fold in the following changes in here.

diff --git a/lib/test_bits.c b/lib/test_bits.c
index f0d1033cf3c9..f8b058974d07 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -39,9 +39,9 @@ static void genmask_ull_test(struct kunit *test)
 #endif
 }
 
-#ifdef CONFIG_ARCH_SUPPORTS_INT128
 static void genmask_u128_test(struct kunit *test)
 {
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
        /* Tests mask generation only when the mask width is within 64 bits */
        KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
        KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
@@ -56,8 +56,8 @@ static void genmask_u128_test(struct kunit *test)
        GENMASK_U128(0, 10);
        GENMASK_U128(9, 10);
 #endif
-}
 #endif
+}
 
 static void genmask_input_check_test(struct kunit *test)
 {
@@ -84,9 +84,7 @@ static void genmask_input_check_test(struct kunit *test)
 static struct kunit_case bits_test_cases[] = {
        KUNIT_CASE(genmask_test),
        KUNIT_CASE(genmask_ull_test),
-#ifdef CONFIG_ARCH_SUPPORTS_INT128
        KUNIT_CASE(genmask_u128_test),
-#endif
        KUNIT_CASE(genmask_input_check_test),
        {}
 };


> 
>> +static void genmask_u128_test(struct kunit *test)
>> +{
>> +	/* Tests mask generation only when the mask width is within 64 bits */
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
>> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
>> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
>> +	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
>> +
>> +#ifdef TEST_GENMASK_FAILURES
>> +	/* these should fail compilation */
>> +	GENMASK_U128(0, 1);
>> +	GENMASK_U128(0, 10);
>> +	GENMASK_U128(9, 10);
>> +#endif
>> +}
>> +#endif
>> +
>>  static void genmask_input_check_test(struct kunit *test)
>>  {
>>  	unsigned int x, y;
>> @@ -56,12 +76,17 @@ static void genmask_input_check_test(struct kunit *test)
>>  	/* Valid input */
>>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
>>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
>> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
>> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
>>  }
>>  
>>  
>>  static struct kunit_case bits_test_cases[] = {
>>  	KUNIT_CASE(genmask_test),
>>  	KUNIT_CASE(genmask_ull_test),
>> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
>> +	KUNIT_CASE(genmask_u128_test),
>> +#endif
>>  	KUNIT_CASE(genmask_input_check_test),
>>  	{}
>>  };
>> -- 
>> 2.30.2

