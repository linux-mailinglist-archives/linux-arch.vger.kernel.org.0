Return-Path: <linux-arch+bounces-11666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB8A9F95B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 21:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A51117730B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53992957CB;
	Mon, 28 Apr 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fbo+7dHL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9618DB0A;
	Mon, 28 Apr 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868187; cv=none; b=oZ9tDkqDGFHw7rfIYWxX7GUOwkPnpJCWXE057Pvltv2kYme9dVpGG+1q+62bA0fONVwGj+9pqmlHpy5tXtKqvTmRqjdVZ1PRlXyZ3uLw7BqjQ3KbnjiYwWEzLK7lFwKpIp75jcEQ31vBp1DU7OGKbm6w8Pud0YCePOS42PiMvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868187; c=relaxed/simple;
	bh=ZvDoC81kFt4cDoyxtRck1vxVOGNhZRLiwTxrGEZGnvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZjBUQdduy/LR9nOMvcW0JnoCBgfJtFRqtRMzXKQEFGW5MqLlDKVUTfCc042luLJHfQYFX681vC0C9Y+i8LGJCVSjVxojObE6V/vImGa0rC7Q78acOERynFE3dxAfWBSm8OvFJ0COUJEneUYoPo04OhjIecPcnI8mVLSGLS/zXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fbo+7dHL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 698AE211AD01;
	Mon, 28 Apr 2025 12:23:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 698AE211AD01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745868184;
	bh=jGVkN1hybuqThviIpy5Yd0rlklDTmHHqQY1gOTTQ/aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fbo+7dHLY2ZtqfyjtlaCC5jw3uqw6PD289mAPFW3y9leIqksoAj8pWNCIrbN3bTir
	 t8IVF7ly+J9ECgXB/qJQ+LMth9i++CMUSEVRhbLOpC8MUWohTAzFbArmXIyjUraZ4l
	 Qq5vCgAWx1+qCJmiI7PVXDfKUtWQvPmpyy6Pg9L8=
Message-ID: <5cdb2703-2b94-4f38-a440-8f5c9a4c66be@linux.microsoft.com>
Date: Mon, 28 Apr 2025 12:23:04 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v8 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
To: Michael Kelley <mhklinux@outlook.com>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "maz@kernel.org" <maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "rafael.j.wysocki@intel.com"
 <rafael.j.wysocki@intel.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-3-romank@linux.microsoft.com>
 <SN6PR02MB41576A5C3C0F5911A308E804D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576A5C3C0F5911A308E804D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/2025 8:27 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 14, 2025 3:47 PM
[...]
> I had previously given my Reviewed-by: on v5 of this patch. But
> looking at it again, it would be nice if this UUID were defined in
> include/linux/arm-smccc.h alongside the definition of
> ARM_SMCCC_VENDOR_HYP_UID_KVM. The UUID values are
> are independent of each other, but it's a bit asymmetric to have
> the KVM UUID defined centrally while the Hyper-V UUID is
> buried in Hyper-V specific code. But I'm OK with the current code
> if there's nothing else to respin for.
> 

As I saw that, KVM is special in the kernel as the kernel provides
both the host side code and the kernel side code so the UUID has
to be shared in the header file.

In the Hyper-V case, we have only the guest side code so it seemed
more economical to have that tucked into the function rather than
adding to the arch-wide header and including the header.


>> +
>> +	return arm_smccc_hypervisor_has_uuid(&hyperv_uuid);
>> +}
>> +
>>   static int __init hyperv_init(void)
>>   {
>>   	struct hv_get_vp_registers_output	result;
>> @@ -36,13 +78,11 @@ static int __init hyperv_init(void)
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
>> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>>   		return 0;
>>
>>   	/* Setup the guest ID */
>> --
>> 2.43.0
>>
> 
> My UUID comment notwithstanding,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> 

-- 
Thank you,
Roman


