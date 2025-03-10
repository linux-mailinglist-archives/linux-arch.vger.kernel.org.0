Return-Path: <linux-arch+bounces-10648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A4AA59F0D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F641701D1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B9233D7C;
	Mon, 10 Mar 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eN2UJ3y3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4B233155;
	Mon, 10 Mar 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628184; cv=none; b=WuISTSx9u3Yg0xLIjBbLUerGf41Yvul0Qf48OpNQQjBxR5R+a5SNqi7Lrj9rbnnW+25n/4pv6ON3SXWJA37YC4cf+NRBV6GgwqMdOEgyJZW+1PYfRsYzAT8H7B3tn+5M1S3YmVyZLHEia+Am3Ehw37D7PXn22bouTsSyfDmc1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628184; c=relaxed/simple;
	bh=vkV3yV+zbwQIpGXrfh8VQUyHDFkE7/JX95cxpROdv/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0QzllmMqARFsTYRlfNXCmXK+hS6XOKyHUfIoFiQAwfpy+QWgmBnvwqzWFHFGMQFH9rMdcImZKn0tujZ7gxh+WwJZzf+QHdWHkNkzK8MVNZgTLWnmnBLL5YvN3eyvAS/p+q2sWsh+Jsp3JDZB4cfuOicxPLuWa4ViYnGP9d4l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eN2UJ3y3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1DFE72038F33;
	Mon, 10 Mar 2025 10:36:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DFE72038F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741628182;
	bh=iZEKwdOofjp6NDR+2hlCzSLPGInK74STCfZGhKf2O+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eN2UJ3y3nG1bAmMoF3LcnG5o5qMeihqJMUFoq8f8VQkTQKjrwMphlZxBpakvB6lYA
	 cSNptejg8D34S3125VES0nI3+8se2yDSJeQJmJrUFy33o/Z7zwGERJrRVw8E/zoDSv
	 1g3S3ylZGCNVS7jCVQd173bGvBEvgxrxkXMhTQwI=
Message-ID: <b3d1609e-4f64-4a88-b453-cb79936cb469@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 08/11] Drivers: hv: vmbus: Get the IRQ
 number from DeviceTree
To: Arnd Bergmann <arnd@arndb.de>, bhelgaas@google.com,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Conor Dooley <conor+dt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Joey Gouly <joey.gouly@arm.com>, krzk+dt@kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 ssengar@linux.microsoft.com, Sudeep Holla <sudeep.holla@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-9-romank@linux.microsoft.com>
 <29bb5b7a-b31f-4b32-92c6-e2588a0f965a@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <29bb5b7a-b31f-4b32-92c6-e2588a0f965a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/2025 1:11 PM, Arnd Bergmann wrote:
> On Fri, Mar 7, 2025, at 23:03, Roman Kisel wrote:
>>
>> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
> 
> Instead of the __maybe_unused annotation here
> 
>>
>> +#ifndef HYPERVISOR_CALLBACK_VECTOR
>> +	ret = vmbus_set_irq(pdev);
>> +	if (ret)
>> +		return ret;
>> +#endif
>> +
> 
> you can use
> 
>         if (!__is_defined(HYPERVISOR_CALLBACK_VECTOR))
>                    ret = vmbus_set_irq(pdev);
> 
> and make it a little more readable.
> 

Thanks you very much, will update! Very neat :)

>      Arnd

-- 
Thank you,
Roman


