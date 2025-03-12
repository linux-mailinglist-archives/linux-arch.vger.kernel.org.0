Return-Path: <linux-arch+bounces-10684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C22A5E369
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F21897982
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E52257421;
	Wed, 12 Mar 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jYKT7aaV"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357C256C9E;
	Wed, 12 Mar 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802704; cv=none; b=s6PazNnIEa54gWJi0sH5QWweHMuWx+E29brjn4k/kp4PspGCnMKdQRkyKW4/TxHcbNEB3o0NXB/buJvNZkqLdCQCrzb7KsBsn73PKbYihpHMgK4sDTI4qV5sDCwip4/wEhl6yD6aBVBg8oXg+fxZwx0TRAVJpuypR09J2lkNshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802704; c=relaxed/simple;
	bh=YRkqEDAnEJO9uif9D8gYv3G3QiocUg9KYSfoxRMiepo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dX1QvFhfCwvnePpZDqCpbRNUj7skYFkHrAT5EboN8FIQda7LwZ0mHNamJsJ/p1XOgvPvfTsLKYKc7XSmM+7sN7dJkbOtQNZEVlwrkEEtv3veHiz4xBRl+iCVsPNVJrl09EaxBzJEDWRCeCaS0cMctrzQB2h0DfVXDcRMfDnc9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jYKT7aaV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B63C210B155;
	Wed, 12 Mar 2025 11:05:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B63C210B155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741802702;
	bh=3LuHCHpuveXkpSQUcYt/4aNBi7uFbOG/3oEGn8E8LXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jYKT7aaV5gspSop8H5hJDvSoYzQZSeYlg64Ifr722u0Nb9Lg5Imcrfh9r7PIfD5lT
	 6Gx7WdXYzK5Qkk74C6o++r7isZrfq5nwtn1HQ8mbeg+mlVaPIh0Da7Nxn0zjSmQ6i1
	 ISWSMrdAV6mX4SniwmTsX/jUZuFL1ANTVkqQw/UY=
Message-ID: <8520ef42-6cb4-4e14-9700-de7ae8a99ae8@linux.microsoft.com>
Date: Wed, 12 Mar 2025 11:04:37 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157CBBC2D186E1944E6773AD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157CBBC2D186E1944E6773AD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/2025 10:30 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>
>> Extend the "ms_hyperv_info" structure to include a new field,
>> "ext_features", for capturing extended Hyper-V features.
>> Update the "ms_hyperv_init_platform" function to retrieve these features
>> using the cpuid instruction and include them in the informational output.
>>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/x86/kernel/cpu/mshyperv.c | 6 ++++--
>>  include/asm-generic/mshyperv.h | 1 +
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 4f01f424ea5b..2c29dfd6de19 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -434,13 +434,15 @@ static void __init ms_hyperv_init_platform(void)
>>  	 */
>>  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
>>  	ms_hyperv.priv_high = cpuid_ebx(HYPERV_CPUID_FEATURES);
>> +	ms_hyperv.ext_features = cpuid_ecx(HYPERV_CPUID_FEATURES);
>>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>>
>>  	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
>>
>> -	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
>> -		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints 0x%x, misc 0x%x\n",
>> +		ms_hyperv.features, ms_hyperv.priv_high,
>> +		ms_hyperv.ext_features, ms_hyperv.hints,
>>  		ms_hyperv.misc_features);
>>
>>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index dc4729dba9ef..c020d5d0ec2a 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -36,6 +36,7 @@ enum hv_partition_type {
>>  struct ms_hyperv_info {
>>  	u32 features;
>>  	u32 priv_high;
>> +	u32 ext_features;
>>  	u32 misc_features;
>>  	u32 hints;
>>  	u32 nested_features;
>> --
>> 2.34.1
> 
> Are any of the extended features available on arm64? This code is obviously x86 specific,
> so ms_hyperv.ext_features will be zero on arm64. From what I can see, ext_features is
> referenced only in Patch 10 of this series, and in code that is under #ifdef CONFIG_X86_64,
> so that should be OK.

Just checked - yes ARM64 has features in ECX, but they are different to the x86_64 ones.
We can add the ARM64 ones when needed.

Thanks
Nuno

> 
> The pr_info() line will now be slightly different on x86 and arm64 since arm64 won't have
> the "ext" field, but I think that's OK too.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>


