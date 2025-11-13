Return-Path: <linux-arch+bounces-14731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03500C57EC4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7861C4EBBAA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05B283129;
	Thu, 13 Nov 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IephhnrP"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B923184F;
	Thu, 13 Nov 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043583; cv=none; b=GjYRhqcKEYfP8mRHhznZenlGY98N2+k88xdzlvHj+AiC3+M+wdm8Dd4qODmtPnA+NmzW6jUpYpQF++J+XVWrlo22PAlpvR/jXjXDB/8YfngV9sLBKH1FWyPRFOltt44FDaccwJX/lW364Cet7hki2VdkQA+WU6kAMNb+VwYzZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043583; c=relaxed/simple;
	bh=bs2hLzYFkAifyPHun/4f2kG/5n36uHbTEXjb3QbpsOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kb94KdEwAJmOlfzmYhSSeVSurk5U2OJKZjfMSzi5RIL0ar5Hk2P/Gdm32sSddrZwr/I2ER7EevDvcom7O4bu6kLzmjoZrKOwDhNMlrsEy9v+jOd/3c0KGd3/X5txznr0mNP73MMI3aLzbN4+ru9T5CmQapIGzhK9fN0kPitudnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IephhnrP; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lbaeXo4KE9yMfmuYX6R1L5QpV2vTC1shul/jR3qCbUY=;
	b=IephhnrPjI3WgO4hXW6woAtfholMSI/VQ4vQlLE/hp99p/ay01ajxwAx1BuC2ukiL3J+T+L05
	s73Ob+3z5xfYsdxmiCtyqlKZEUO6+GfkoSL2WopLoIRsjxEzeNkv2X0+meo3uF7TUEY1a+oiEQv
	wdRXrTozJdaCb7nNal9dcVQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d6j6C3sltz1prLD;
	Thu, 13 Nov 2025 22:17:55 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 618A0180B65;
	Thu, 13 Nov 2025 22:19:36 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 22:19:36 +0800
Received: from [10.67.120.171] (10.67.120.171) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 22:19:35 +0800
Message-ID: <017956b9-cb91-4068-b9d0-b54f93d83eeb@huawei.com>
Date: Thu, 13 Nov 2025 22:19:34 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128 support
To: Mark Rutland <mark.rutland@arm.com>
CC: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <andriy.shevchenko@linux.intel.com>,
	<herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
 <20251112015846.1842207-5-huangchenghai2@huawei.com>
 <aRR9UesvUCFLdVoW@J2N7QTR9R3>
From: huangchenghai <huangchenghai2@huawei.com>
Content-Language: en-US
In-Reply-To: <aRR9UesvUCFLdVoW@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200001.china.huawei.com (7.202.195.16)


在 2025/11/12 20:28, Mark Rutland 写道:
> On Wed, Nov 12, 2025 at 09:58:46AM +0800, Chenghai Huang wrote:
>> From: Weili Qian <qianweili@huawei.com>
>>
>> Starting from ARMv8.4, stp and ldp instructions become atomic.
> That's not true for accesses to Device memory types.
>
> Per ARM DDI 0487, L.b, section B2.2.1.1 ("Changes to single-copy atomicity in
> Armv8.4"):
>
>    If FEAT_LSE2 is implemented, LDP, LDNP, and STP instructions that load
>    or store two 64-bit registers are single-copy atomic when all of the
>    following conditions are true:
>    • The overall memory access is aligned to 16 bytes.
>    • Accesses are to Inner Write-Back, Outer Write-Back Normal cacheable memory.
>
> IIUC when used for Device memory types, those can be split, and a part
> of the access could be replayed multiple times (e.g. due to an
> intetrupt).
>
> I don't think we can add this generally. It is not atomic, and not
> generally safe.
>
> Mark.
Thanks for your correction. I misunderstood the behavior of LDP and
STP instructions. So, regarding device memory types, LDP and STP
instructions do not guarantee single-copy atomicity.

For devices that require 128-bit atomic access, is it only possible
to implement this functionality in the driver?

Chenghai
>
>> Currently, device drivers depend on 128-bit atomic memory IO access,
>> but these are implemented within the drivers. Therefore, this introduces
>> generic {__raw_read|__raw_write}128 function for 128-bit memory access.
>>
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
>> ---
>>   arch/arm64/include/asm/io.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 83e03abbb2ca..80430750a28c 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
>> @@ -50,6 +50,17 @@ static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
>>   	asm volatile("str %x0, %1" : : "rZ" (val), "Qo" (*ptr));
>>   }
>>   
>> +#define __raw_write128 __raw_write128
>> +static __always_inline void __raw_write128(u128 val, volatile void __iomem *addr)
>> +{
>> +	u64 low, high;
>> +
>> +	low = val;
>> +	high = (u64)(val >> 64);
>> +
>> +	asm volatile ("stp %x0, %x1, [%2]\n" :: "rZ"(low), "rZ"(high), "r"(addr));
>> +}
>> +
>>   #define __raw_readb __raw_readb
>>   static __always_inline u8 __raw_readb(const volatile void __iomem *addr)
>>   {
>> @@ -95,6 +106,16 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
>>   	return val;
>>   }
>>   
>> +#define __raw_read128 __raw_read128
>> +static __always_inline u128 __raw_read128(const volatile void __iomem *addr)
>> +{
>> +	u64 high, low;
>> +
>> +	asm volatile("ldp %0, %1, [%2]" : "=r" (low), "=r" (high) : "r" (addr));
>> +
>> +	return (((u128)high << 64) | (u128)low);
>> +}
>> +
>>   /* IO barriers */
>>   #define __io_ar(v)							\
>>   ({									\
>> -- 
>> 2.33.0
>>
>>

