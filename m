Return-Path: <linux-arch+bounces-4431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803B38C6B8B
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6E1F228C6
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD65DF3B;
	Wed, 15 May 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EplThCPg"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603C3EA7B;
	Wed, 15 May 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794434; cv=none; b=G7EM+/367FMRXjvJRNpE8YGWlvpRJRta3z+FufFNsTnnmK9SBV/R8iokpZdFAvlJ0MAjrcqlbisMyo1JKZxnny4xAkamfKTi/OmcdjPus2/CT04kTyjs2cfrZAt7hD0LoLYATSgbtg6Z+Vq2DXu4WxzVE3EZMQv3QxUSFEc47h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794434; c=relaxed/simple;
	bh=VdtVLFpZYA4b3uZzQCUTGVxEaXrt+6asF5DBt0OQKLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6400zXRHfiTZoZSC5xHdgV9OdltxWFNBNECK/RuaN/dRINmxDJJKJ2TQ2ma7fk1AuBpPm4Cdar9BBQfLPZSEaDp/B9Ek8ZUSdNOrs4spddbX4FpKi4d2BJvZycXpRln9Ith/Xo8/3w0XDARPChh0pd9c/xlSgmS2qFC94Pwmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EplThCPg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60AFD20BE570;
	Wed, 15 May 2024 10:33:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60AFD20BE570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715794426;
	bh=6znshs1azYcVfLPlekdOCordB4FAVfBn0O3niN9s+zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EplThCPgxf2K/F8p5LTNBB2FpK+/bTpXukCuYhXyOYYlCqRIQfd1AiYryJzcSEWgl
	 do+VYONXpz2SmVJUnMOFCJEWS/WmfZ+cUgYk3Rc9B+4zraitQvTQHirrfupbFHpAS6
	 qeNcZTp64f+P2tdvuN9exTKusSQCv8GS8E4jKlCM=
Message-ID: <267ef0e2-2384-44bd-81f9-f33dda7bb9d2@linux.microsoft.com>
Date: Wed, 15 May 2024 10:33:46 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-2-romank@linux.microsoft.com>
 <1766fc9a-1d10-4c93-a9db-a7e0db8b01e7@linaro.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1766fc9a-1d10-4c93-a9db-a7e0db8b01e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 12:45 AM, Krzysztof Kozlowski wrote:
> On 15/05/2024 00:43, Roman Kisel wrote:
>> The Virtual Trust Level platforms rely on DeviceTree, and the
>> arm64/hyperv code supports ACPI only. Update the logic to
>> support DeviceTree on boot as well as ACPI.
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
> 
> Why do you add an ABI for node name? Although name looks OK, but is it
> really described in the spec that you depend on it? I really do not like
> name dependencies...

Followed the existing DeviceTree's of naming and approaches in the 
kernel to surprise less and "invent" even less. As for the spec, the 
Hyper-V TLFS'es part discussing Hypervisor Discovery talks about x86 
(https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/feature-discovery) 
only and via the ISA-provided means only. For arm64, Hyper-V code 
discovers the hypervisor presence via ACPI. Felt only natural to do the 
same for DeviceTree and arm64.

> 
> Where is the binding for this?
> 
Have not added, my mistake. Will place under 
Documentation/devicetree/bindings/bus/microsoft,hyperv.yaml

> Best regards,
> Krzysztof

-- 
Thank you,
Roman

