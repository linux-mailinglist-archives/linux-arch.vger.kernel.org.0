Return-Path: <linux-arch+bounces-5212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D198691D57C
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2024 02:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BF9B21182
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2024 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AB22CA5;
	Mon,  1 Jul 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUf+DTTS"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CEB10FF
	for <linux-arch@vger.kernel.org>; Mon,  1 Jul 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719793058; cv=none; b=A8CesFpBb+k7gdTLvvQlNHLb7B9gqHsuKwythGX4LwifzSPP1JpyGldjHipTYozy4SyQQy9YYPhYemO9Z+IHYvagON7DiQfDrkWqdYyguhdEiYqH+RI9iChWYHaRjhBMEafvNR01dCXghnscb8K/MRdKw+MUqPnvo79dX46zSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719793058; c=relaxed/simple;
	bh=QaN9gni6DBgvdeYW+GJEmKIW3k11vr5L6sk+8si7MuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPVsEU4Z1/sPSn362DHPcwzCYfuHuajdgcZ1MkxNSv6PiBoIoVD4a4zSwzRszgGDe5ElIWC5XS9XT62JbkjtBxTZ9RA3ehbGX4RUQ+HnBbDsAKHsl67pxVkZNgElMvYVadNc2Ovd70wyRkFYHvJBnd9uPJfam0kaw7R3Oj3MgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUf+DTTS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719793055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM4N7GR2BG5LIn+6MSOyJKM/XymBQm17tFxWvcJSyZA=;
	b=PUf+DTTSuhEukNVg/uGxmAsM+0DzXCCuWsSyAIFNtq/BiJ3V4Gxin/w7eQjEsZVqIof/Di
	iQD2AbfNTOMBx6trcvuzP+ZzaqnK3fNIBV+Z6rcJaUnYBavw47/bPFtQPSKz05c3jULBei
	CCICSIcqhvJP9iy1+13zRWwhMOfwsRs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-c5NmjpKmPaq07KUxYjgFNw-1; Sun, 30 Jun 2024 20:17:33 -0400
X-MC-Unique: c5NmjpKmPaq07KUxYjgFNw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e73d656bd0so1331139a12.1
        for <linux-arch@vger.kernel.org>; Sun, 30 Jun 2024 17:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719793053; x=1720397853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM4N7GR2BG5LIn+6MSOyJKM/XymBQm17tFxWvcJSyZA=;
        b=bdljfkUydT6vG4o7zNGwd+C9w5qSujJQ9gqKhqtgZL2CyuU4er7a2fXcT/S2PvcEA5
         PAL/yJxuyjfh720c5RawbHIHIfseeZkp+1t/4meD9Old3xnpgUR+Vo4DXwnQuLMslZcd
         zjvMu+1IF4JPmaR2oJVnSwRCPWxzQwiG2pzF3eoGG9xo/hIhNuJDQozXCLa4Q8WaGXHz
         74omBsxWtaWlLlr8jfHSn3k0XZRD+t9RgyzmjzwkFIoxWMiLpCALq1cI1NYIunO+UvS5
         eCXBpWGao6bCgoLKr0p/dYfSOO4e9i/Nq+30drzfDZcZgsv8Oi2osnXLT/GZpLY7xEsC
         jrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUomoa9Gs7V9WtghUDLJ3gdEGI4Y1Ty4rMgpZ/ERFQw/E/lRF3+Nk2SoCmHcfFKrgI7TZazrlfPvIGsf2gJUIg58giCo3bTISADmg==
X-Gm-Message-State: AOJu0YzQ3i0EC3Zp/5y75AEqMpzmL4AMQJBg1pa4urVas/0RYD5IXlEu
	diEoCJQoE6Gd5PdkWmgqOsA+DBV9pdF8G2HYTy+6lmpcU3tSBGlpZK29pHf7cHY0kmwgzrvFjuo
	Z1erd6BIPoMlf6dI7Y284qKuvnouhXXy02ljKmTQ4pmgKSb8bCJr1m6P/3zo=
X-Received: by 2002:a05:6a20:8422:b0:1b5:fd58:30e8 with SMTP id adf61e73a8af0-1bef6140771mr3102507637.18.1719793052832;
        Sun, 30 Jun 2024 17:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV87JbqD0DsihOx5ZuGLa4+/4zwRBogo0J72ZOMm/cMfn9jliB3oM03TcsWl+71BSax9Qkzw==
X-Received: by 2002:a05:6a20:8422:b0:1b5:fd58:30e8 with SMTP id adf61e73a8af0-1bef6140771mr3102480637.18.1719793052446;
        Sun, 30 Jun 2024 17:17:32 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535d1fsm51606915ad.144.2024.06.30.17.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 17:17:31 -0700 (PDT)
Message-ID: <fb6ec18c-143f-4fb2-8ca6-c3e425864e63@redhat.com>
Date: Mon, 1 Jul 2024 10:17:20 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
 <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
 <47a261e0-006d-4c64-9c9b-bc73797b8d6b@redhat.com> <ZoEk2mfQkIhLuh-8@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZoEk2mfQkIhLuh-8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Catalin,

On 6/30/24 7:26 PM, Catalin Marinas wrote:
> On Sun, Jun 30, 2024 at 10:39:04AM +1000, Gavin Shan wrote:
>> On 5/29/24 11:34 PM, Jonathan Cameron wrote:
>>> In order to move arch_register_cpu() to be called via the same path
>>> for initially present CPUs described by ACPI and hotplugged CPUs
>>> ACPI_HOTPLUG_CPU needs to be enabled.
>>>
>>> The protection against invalid IDs in acpi_map_cpu() is needed as
>>> at least one production BIOS is in the wild which reports entries
>>> in DSDT (with no _STA method, so assumed enabled and present)
>>> that don't match MADT.
>>>
>>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    arch/arm64/Kconfig       |  1 +
>>>    arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
>>>    2 files changed, 23 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 5d91259ee7b5..e8f2ef2312db 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -5,6 +5,7 @@ config ARM64
>>>    	select ACPI_CCA_REQUIRED if ACPI
>>>    	select ACPI_GENERIC_GSI if ACPI
>>>    	select ACPI_GTDT if ACPI
>>> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
>>
>> ACPI_HOTPLUG_CPU depends on (ACPI_PROCESSOR && HOTPLUG_CPU). It needs to be:
>>
>> 	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>>
>> Otherwise, we can have compiling error with the following configurations.
>>
>> CONFIG_ACPI_PROCESSOR=y
>> CONFIG_HOTPLUG_CPU=n
>> CONFIG_ACPI_HOTPLUG_CPU=y
>>
>> arch/arm64/kernel/smp.c: In function ‘arch_unregister_cpu’:
>> arch/arm64/kernel/smp.c:563:9: error: implicit declaration of function ‘unregister_cpu’; did you mean ‘register_cpu’? [-Werror=implicit-function-declaration]
>>    563 |         unregister_cpu(c);
>>        |         ^~~~~~~~~~~~~~
>>        |         register_cpu
> 
> Ah, I thought that in addition to the warning for unmet dependencies,
> kbuild would also leave the option off. I need to add SUSPEND=n and
> HIBERNATE=n to my build scripts.
> 
> The fix matches what x86 does, so I'm ok with it.
> 

Ok, thanks for your confirm.

>> Since the series has been queued to Catalin's "for-next/vcpu-hotplug" branch, I
>> guess the easiest way would be to fix it in place with Catalin's help.
> 
> I wasn't planning to rebase the branch unless there's something major.
> Since the doesn't happen with defconfig, it's doesn't affect bisection
> that much, so my preference would be for a fix on top of this branch
> (and with a Fixes: tag since the branch is stable).
> 

Sure, I've posted a fix, applicable to branch 'for-next/vcpu-hotplug'.

https://lists.infradead.org/pipermail/linux-arm-kernel/2024-June/939690.html

Thanks,
Gavin


