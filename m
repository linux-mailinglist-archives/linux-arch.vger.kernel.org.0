Return-Path: <linux-arch+bounces-14728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581A4C571D5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 12:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864EB3B30F5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936C339B44;
	Thu, 13 Nov 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wkgAbgOj"
X-Original-To: linux-arch@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC4338F26;
	Thu, 13 Nov 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032264; cv=none; b=loKkzvoJ9R+ez66wetbdDbW5ZPAQZwtfgY3yD9VvKJviT+zMluvR0DdDeNHPfyq/7DFjk5cw80O6b3duYgTXJdouF4vGhhrH6J93MElkQCNAvLVkNxK3tkaWRegoVHSdDCcuE7jN1Ory5jnCeJh6l3VIqjNyWniLtR/ZnrktgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032264; c=relaxed/simple;
	bh=urH1pHnaK/uaQl/yo8yiCGx+iorwpacltUVK/RqwjKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SDr1b4hf2WNimT2xugrtodl9pxtoJSkTyECgpR1QWh2+TQMqSPXQSV34Nw12h1T7MeAsvnJ9E3tKOY9PiR05rWwgsf6/sNTpqa5Y3gewDxz2hnqy10D8TAKxbzKcpaxqFg+TCRzpT5X6osnfRVUgMZCdM4mXIUUbywcVbKfXXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wkgAbgOj; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sYdX7jPld9MHxC/2N/BdveINDqwOk1bdDkzTmhtgkOU=;
	b=wkgAbgOj/Uyjk7TB32BI8+jld98422LU2nbkIaBXSanzYHVi6qJph7P+LYaPeIHyxTIgLssdk
	NQu5KsJuHwWmg2eHARW+n+NAqI8UehAXAc67lMDLPw4XFhrBllr1+6vcAwL6U9EC1JXIXpDVMd7
	26SAoBvKW98bxHl/K+3zxXw=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6cwR1YknzKm5S;
	Thu, 13 Nov 2025 19:09:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F095D180044;
	Thu, 13 Nov 2025 19:10:51 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 19:10:51 +0800
Received: from [10.67.120.171] (10.67.120.171) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Nov 2025 19:10:51 +0800
Message-ID: <fb2412cd-7417-4d65-9dea-d166a3bd146f@huawei.com>
Date: Thu, 13 Nov 2025 19:10:50 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] io-128-nonatomic: introduce
 io{read|write}128_{lo_hi|hi_lo}
To: Ben Dooks <ben.dooks@codethink.co.uk>, <arnd@arndb.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<andriy.shevchenko@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
	<linux-api@vger.kernel.org>
CC: <fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
 <20251112015846.1842207-4-huangchenghai2@huawei.com>
 <59f8bc30-c1c6-4f07-87dd-cd2893ae87f7@codethink.co.uk>
From: huangchenghai <huangchenghai2@huawei.com>
Content-Language: en-US
In-Reply-To: <59f8bc30-c1c6-4f07-87dd-cd2893ae87f7@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200001.china.huawei.com (7.202.195.16)


在 2025/11/12 22:48, Ben Dooks 写道:
> On 12/11/2025 01:58, Chenghai Huang wrote:
>> From: Weili Qian <qianweili@huawei.com>
>>
>> In order to provide non-atomic functions for io{read|write}128.
>> We define a number of variants of these functions in the generic
>> iomap that will do non-atomic operations.
>>
>> These functions are only defined if io{read|write}128 are defined.
>> If they are not, then the wrappers that always use non-atomic operations
>> from include/linux/io-128-nonatomic*.h will be used.
>>
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
>> ---
>>   include/linux/io-128-nonatomic-hi-lo.h | 35 ++++++++++++++++++++++++++
>>   include/linux/io-128-nonatomic-lo-hi.h | 34 +++++++++++++++++++++++++
>>   2 files changed, 69 insertions(+)
>>   create mode 100644 include/linux/io-128-nonatomic-hi-lo.h
>>   create mode 100644 include/linux/io-128-nonatomic-lo-hi.h
>>
>> diff --git a/include/linux/io-128-nonatomic-hi-lo.h 
>> b/include/linux/io-128-nonatomic-hi-lo.h
>> new file mode 100644
>> index 000000000000..b5b083a9e81b
>> --- /dev/null
>> +++ b/include/linux/io-128-nonatomic-hi-lo.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_IO_128_NONATOMIC_HI_LO_H_
>> +#define _LINUX_IO_128_NONATOMIC_HI_LO_H_
>> +
>> +#include <linux/io.h>
>> +#include <asm-generic/int-ll64.h>
>> +
>> +static inline u128 ioread128_hi_lo(const void __iomem *addr)
>> +{
>> +    u32 low, high;
>
> did you mean u64 here?
>
Thank you for your reminder, I made a rookie mistake.


Chenghai

>> +    high = ioread64(addr + sizeof(u64));
>> +    low = ioread64(addr);
>> +
>> +    return low + ((u128)high << 64);
>> +}
>> +
>> +static inline void iowrite128_hi_lo(u128 val, void __iomem *addr)
>> +{
>> +    iowrite64(val >> 64, addr + sizeof(u64));
>> +    iowrite64(val, addr);
>> +}
>> +
>

