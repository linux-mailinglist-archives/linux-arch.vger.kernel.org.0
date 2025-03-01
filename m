Return-Path: <linux-arch+bounces-10478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E6A4A735
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 01:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BD2170BCE
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8C524F;
	Sat,  1 Mar 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JxcXei0X"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592602BD11;
	Sat,  1 Mar 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790009; cv=none; b=OuBXAeEEK7/JDWalgfo7wGiPiU7dPHA6UYxvtlqvmROR3E6x2g4+vKPP/kzr1NbH0Bi6Tm0fFLeTtJ0/e8/LTQKjkNT+R108qX12NMFpUOrPwp7Rpwke2oJETTivMqdKr5VFLGKA4gDuENkwPWGPbv/c9fsstIlU0tJSjk4UApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790009; c=relaxed/simple;
	bh=1GcrbKM0W+xco/xPOZwmUuKLn1JfH7TBComa6MgoQuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNmAMOHyLHYKc5tKAQe6NvNzrey1Pz8dVCOyycLCcQVvX7hoHfiM1coWdXdmoQSiJ+5+Wmehvyc2nYHoURs/aBzRB35rBNjLup6iGZ9vQc4BY0nYDkwZRqTzTvkobeEZj31LDSiO8i5kESQ+IYto2sVjqE/6SE/qZjbGf0eHdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JxcXei0X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 368A42038A22;
	Fri, 28 Feb 2025 16:46:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 368A42038A22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740790007;
	bh=oiUqgUon8AD01nBVhduxpuk4xMddkmJW/EZy9Txee9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JxcXei0X7JZ6TPla41vqyX1jd2nfE1hywjtm232onPaWTj6aBvV0wMcfResSE5ynS
	 upSr6tgNMe+F8nhLigKKTq50KQ4Lq5/jzz6O/EG21ZsBG3y1etOHYgc7cGMVYtw9p6
	 UHgZ8oAv3WOM3ws1W4kEO7LnB7Q5jfPS4GC1tnpg=
Message-ID: <8a475342-62b6-4669-8baf-10279cdc3835@linux.microsoft.com>
Date: Fri, 28 Feb 2025 16:46:44 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 mrathor@linux.microsoft.com, ssengar@linux.microsoft.com,
 apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
 stanislav.kinsburskiy@gmail.com, gregkh@linuxfoundation.org,
 vkuznets@redhat.com, prapal@linux.microsoft.com, muislam@microsoft.com,
 anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
 corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
 <Z7-o-VnE6iffOi7Z@skinsburskii.>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Z7-o-VnE6iffOi7Z@skinsburskii.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:51 PM, Stanislav Kinsburskii wrote:
> On Wed, Feb 26, 2025 at 03:08:03PM -0800, Nuno Das Neves wrote:
>> A few additional definitions are required for the mshv driver code
>> (to follow). Introduce those here and clean up a little bit while
>> at it.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  include/hyperv/hvgdk_mini.h |  64 ++++++++++++++++-
>>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>>  3 files changed, 280 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 58895883f636..e4a3cca0cbce 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>  @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /* HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>>  	struct hv_device_interrupt_target int_target;
>>  } __packed __aligned(8);
>>  
>> +enum hv_intercept_type {
>> +#if defined(CONFIG_X86_64)
> 
> Prehaps it would be nice to have per-arch headers for such structures
> instead.
> 
The goal with these files is to reflect the Hyper-V code closely, in order
to make porting the definitions to Linux as easy as possible. Splitting
these into per-arch headers is not my preferred approach because it is
counter to that goal.

>> +	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0x00000000,
>> +	HV_INTERCEPT_TYPE_X64_MSR			= 0x00000001,
>> +	HV_INTERCEPT_TYPE_X64_CPUID			= 0x00000002,
>> +#endif
>> +	HV_INTERCEPT_TYPE_EXCEPTION			= 0x00000003,
>> +	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
>> +	HV_INTERCEPT_TYPE_RESERVED0			= 0x00000004,
>> +	HV_INTERCEPT_TYPE_MMIO				= 0x00000005,
>> +#if defined(CONFIG_X86_64)
>> +	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0x00000006,
>> +	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0x00000007,
>> +#endif
>> +	HV_INTERCEPT_TYPE_HYPERCALL			= 0x00000008,
>> +#if defined(CONFIG_X86_64)
>> +	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0x00000009,
>> +	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0x0000000A,
>> +	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0x0000000B,
>> +	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0x0000000C,
>> +#endif
>> +	HV_INTERCEPT_TYPE_MAX,
>> +	HV_INTERCEPT_TYPE_INVALID			= 0xFFFFFFFF,
>> +};
>> +
>> +union hv_intercept_parameters {
>> +	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
>> +	__u64 as_uint64;
> 
> Should this one be "u64" instead of "__u64" (here and below) ?
> 
Yes, it looks like a few of the uapi types are still lingering, oops!

>> +#if defined(CONFIG_X86_64)
>> +	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
>> +	__u16 io_port;
>> +	/* HV_INTERCEPT_TYPE_X64_CPUID */
>> +	__u32 cpuid_index;
>> +	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
>> +	__u32 apic_write_mask;
>> +	/* HV_INTERCEPT_TYPE_EXCEPTION */
>> +	__u16 exception_vector;
>> +	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
>> +	__u32 msr_index;
>> +#endif
>> +	/* N.B. Other intercept types do not have any parameters. */
>> +};
>> +
>>  /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
>>  #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
>>  
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index 64407c2a3809..1b447155c338 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -19,11 +19,24 @@
>>  
>>  #define HV_VP_REGISTER_PAGE_VERSION_1	1u
>>  
>> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT		7
>> +
>> +union hv_vp_register_page_interrupt_vectors {
>> +	u64 as_uint64;
>> +	struct {
>> +		u8 vector_count;
>> +		u8 vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
>> +	} __packed;
>> +} __packed;
> 
> Packed attribute for the union looks redundant.
> 
Good point, I can remove it in the next version

> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>


