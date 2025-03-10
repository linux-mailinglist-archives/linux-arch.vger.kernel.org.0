Return-Path: <linux-arch+bounces-10641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20BA59B7B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3796F1888CE6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC52343C1;
	Mon, 10 Mar 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="adolExQz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76946233D64;
	Mon, 10 Mar 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624938; cv=none; b=TugWc3TQ9qRr15FZWa+LA2pVsW44kiMsxIXwKjx+7ucD9qc/Zv2BUjViEyliOMoJfUhI6KZ1RNgengWFlrjuErsh5snvcVDooGiKyBxDfwI+cprwrAAdXUajSgJj1xJyzp6QnZjeXVTFCJbmBhjpHzj8YeGaMQTR2TSAk6AGuKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624938; c=relaxed/simple;
	bh=8rHmoCDx9SLU3IG4xkAenK09evGQcGUPBC/dfid1nr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBpwTa/HeBaKx0dXaPVC8rtk8EgFiTPKmhHbF6vWha+jg3bmHu1ETLCk1wxhoSDAz6VJs+P4i1TYGzMKY04GdZ3uT4ojXcBIJX9r6WNNols0iCIwphgLu+J4EMyLFH0+2QyLoEuO6uvNhqGDB1PB2h8m1r5nCrbIPk8oVYFfgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=adolExQz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 917D62038F31;
	Mon, 10 Mar 2025 09:42:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 917D62038F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741624935;
	bh=LN1XhlPdMhhUKdLiwgvqjrH33le8Y4pxVH3hP74M9b0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=adolExQzIdiGiIImUNH8PIT6jUYPIx/W+TATHEWLnINgGBwZ6f1UJ6VLPct8eOZG1
	 QWxNjZnyTJVqsNRH80CF3UdDcU3vx6TIUod2y01uAqFHvYQ2H224pVoGrzHDj5UdK0
	 NOQoc/qdsXI7/FognyHzoybGrl/nnp4HVU46HlNk=
Message-ID: <2342dda1-2976-4506-ab68-640739a1bd5b@linux.microsoft.com>
Date: Mon, 10 Mar 2025 09:42:15 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
To: Wei Liu <wei.liu@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-7-romank@linux.microsoft.com>
 <Z84yyAqkqJ2ZyAd-@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z84yyAqkqJ2ZyAd-@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/9/2025 5:31 PM, Wei Liu wrote:
> On Fri, Mar 07, 2025 at 02:02:58PM -0800, Roman Kisel wrote:
>> The hyperv guest code might run in various Virtual Trust Levels.
>>
>> Report the level when the kernel boots in the non-default (0)
>> one.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/mshyperv.c | 2 ++
>>   arch/x86/hyperv/hv_vtl.c     | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index a7db03f5413d..3bc16dbee758 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -108,6 +108,8 @@ static int __init hyperv_init(void)
>>   	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>>   		hv_get_partition_id();
>>   	ms_hyperv.vtl = get_vtl();
>> +	if (ms_hyperv.vtl > 0) /* non default VTL */
> 
> "non-default".
> 

Thanks, will fix that!

>> +		pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
>>   
>>   	ms_hyperv_late_init();
>>   
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 4e1b1e3b5658..c21bee7e8ff3 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -24,7 +24,7 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
>>   
>>   void __init hv_vtl_init_platform(void)
>>   {
>> -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
> 
> Where isn't there a check for ms_hyperv.vtl > 0 here?
> 

On x86, there is

#ifdef CONFIG_HYPERV_VTL_MODE
void __init hv_vtl_init_platform(void);
int __init hv_vtl_early_init(void);
#else
static inline void __init hv_vtl_init_platform(void) {}
static inline int __init hv_vtl_early_init(void) { return 0; }
#endif

> Please be consistent across different architectures.
> 

In the earlier versions of the patch series, I had that piece
from the above mirrored in the arm64, and there was advice on
removing the function as it contained just one statement.
I'll revisit the approach, thanks for your help!

>>   
>>   	x86_platform.realmode_reserve = x86_init_noop;
>>   	x86_platform.realmode_init = x86_init_noop;
>> -- 
>> 2.43.0
>>
>>

-- 
Thank you,
Roman


