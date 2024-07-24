Return-Path: <linux-arch+bounces-5613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128693B0CB
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 14:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6D21F21EBA
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D7156862;
	Wed, 24 Jul 2024 12:00:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DD36B0D;
	Wed, 24 Jul 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822426; cv=none; b=hfXoFwKNg1M6Cmol/k3N9m8AiAEBm1M/YG4l/UdZvJQSWD8HGXzx0FBP4eZTD+O/siEANHNEp7NlY7QI3fdoVBc2lhxxEnBe12qtsQpuhxk5DX7e+x6Avq+yUBXkDCtZMokmU9XVc/IaLnZR2td29tCujIi+YJF1hC3DKQaFnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822426; c=relaxed/simple;
	bh=z1njJFVrm0sRoBuTFhIuZJ7Xkft2hv3GnmSjswlFsU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXtDpzqyG3qvmhk4fKsQOtLmG+KiZ+o68hj6AAfT+pxutwqUCRfSDtYvSR9ONpKZJdFCSdP4Sy3NYkXM0ppSQRpmZHpGemTuigqaEJuAS3CZTm2a/L3UepvP1GydpayyDLB1DlRX/9o75KBytWIlsQsDHuEE+IZiDudN4EJPF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5362A106F;
	Wed, 24 Jul 2024 05:00:49 -0700 (PDT)
Received: from [10.163.54.221] (unknown [10.163.54.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9285B3F5A1;
	Wed, 24 Jul 2024 05:00:20 -0700 (PDT)
Message-ID: <f1c8ba93-f490-47ca-a2ea-74bb1e3c7ffd@arm.com>
Date: Wed, 24 Jul 2024 17:30:16 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
 <20240724103142.165693-3-anshuman.khandual@arm.com>
 <83972212-c8b6-4888-8574-4eb153008109@app.fastmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <83972212-c8b6-4888-8574-4eb153008109@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/24 16:15, Arnd Bergmann wrote:
> On Wed, Jul 24, 2024, at 12:31, Anshuman Khandual wrote:
>> This adds GENMASK_U128() tests although currently only 64 bit wide masks
>> are being tested.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  lib/test_bits.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/lib/test_bits.c b/lib/test_bits.c
>> index 01313980f175..2515ddc34409 100644
>> --- a/lib/test_bits.c
>> +++ b/lib/test_bits.c
>> @@ -39,6 +39,24 @@ static void genmask_ull_test(struct kunit *test)
>>  #endif
>>  }
>>
>> +static void genmask_u128_test(struct kunit *test)
>> +{
>> +	/* Tests mask generation only when the mask width is within 64 bits */
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
>> +	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
> 
> This looks like it would need an #ifdef check for either
> __SIZEOF_INT128__ or CONFIG_ARCH_SUPPORTS_INT128, otherwise
> it will fail to build on all 32-bit architectures and possibly
> old compiler versions on some 64-bit ones. I think I checked
> in the past which targets support __u128, but I don't remember
> the result.

Sure, will go with CONFIG_ARCH_SUPPORTS_INT128 and add required #ifdefs here.

