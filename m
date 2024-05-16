Return-Path: <linux-arch+bounces-4453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8048C7968
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C51BB21BAE
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D514D2B1;
	Thu, 16 May 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JzU6VQwP"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45F14C5B3;
	Thu, 16 May 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873239; cv=none; b=av5yTqMVOfMd6mTF9LyH438zu5cAnj1g6OQekExyNFk76d1/VLtpVNez3jmX4YS6xF2rpRHkCvzzIIj6T0I+xxMdEZxA6LVoS1IUDzZVF8TlIVl7ufP/1M8V/PhinVIQoq6UFb0NrCs0FzIY7LM/kNHcGG+TXksM04XzBcYBKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873239; c=relaxed/simple;
	bh=BccJ0HF5Illb00Em11qtCvLHarKzg0ooqw7/HcoSL9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPp5X7vOfhikA3TRzw8U6OT8K+VxH/wYJUKa0XDgUshnSnl9o2JRKogaACZOr0hWFQVY2994R6n11WkYwN37MnDVP5UOHKJmh2YgHiEDN2b4oSLqMuos1G/tFV/f72L2HhrLWN7cx9OQpQtDpw5bJ2mcpm6AEWnTzNFuHy0RHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JzU6VQwP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5FC4B20B915A;
	Thu, 16 May 2024 08:27:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FC4B20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715873232;
	bh=VYw2CBFjzoPTujslbESLr1CJ6eokJI9FsmFec2GE+5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JzU6VQwPnDgbMyagVyu7XqnShkR+OoIMv1PiyI6c8vySazBXPTP89U3QX55rMeN9P
	 eiLb6A/YK7IWrQgnf8XdBiCzyCtDgr2Dgi8M/N05AinyH7IlTmsfRCLFfFRAmVOAAt
	 YU54Hr3Y0apONAux+8AwswlIiJfpZ8lltciPPiDc=
Message-ID: <9b216f16-a2ea-48d7-8986-f0c2e3f3d009@linux.microsoft.com>
Date: Thu, 16 May 2024 08:27:12 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, mingo@redhat.com,
 mhklinux@outlook.com, rafael@kernel.org, robh@kernel.org,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-2-romank@linux.microsoft.com>
 <20240515143359142-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240515143359142-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 3:02 PM, Elliot Berman wrote:
> On Tue, May 14, 2024 at 03:43:48PM -0700, Roman Kisel wrote:
>> The Virtual Trust Level platforms rely on DeviceTree, and the
>> arm64/hyperv code supports ACPI only. Update the logic to
>> support DeviceTree on boot as well as ACPI.
> 
> Could you use Call UID query from SMCCC? KVM [1] and Gunyah [2] have
> been using this to identify if guest is running under those respective
> hypervisors. This works in both DT and ACPI cases.
> 
> [1]: https://lore.kernel.org/all/20210330145430.996981-2-maz@kernel.org/
> [2]: https://lore.kernel.org/all/20240222-gunyah-v17-4-1e9da6763d38@quicinc.com/

That would be very neat indeed, thanks! Talking to the hypervisor folks.

>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index b1a4de4eee29..208a3bcb9686 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -15,6 +15,9 @@
>>   #include <linux/errno.h>
>>   #include <linux/version.h>
>>   #include <linux/cpuhotplug.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>>   #include <asm/mshyperv.h>
>>   
>>   static bool hyperv_initialized;
>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>   	return 0;
>>   }
>>   
>> +static bool hyperv_detect_fdt(void)
>> +{
>> +#ifdef CONFIG_OF
>> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>> +			of_get_flat_dt_root(), "hypervisor");
>> +
>> +	return (hyp_node != -FDT_ERR_NOTFOUND) &&
>> +			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static bool hyperv_detect_acpi(void)
>> +{
>> +#ifdef CONFIG_ACPI
>> +	return !acpi_disabled &&
>> +			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>   static int __init hyperv_init(void)
>>   {
>>   	struct hv_get_vp_registers_output	result;
>> @@ -35,13 +61,11 @@ static int __init hyperv_init(void)
>>   
>>   	/*
>>   	 * Allow for a kernel built with CONFIG_HYPERV to be running in
>> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
>> +	 * a non-Hyper-V environment.
>> +	 *
>>   	 * In such cases, do nothing and return success.
>>   	 */
>> -	if (acpi_disabled)
>> -		return 0;
>> -
>> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
>> +	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
>>   		return 0;
>>   
>>   	/* Setup the guest ID */
>> -- 
>> 2.45.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Thank you,
Roman

