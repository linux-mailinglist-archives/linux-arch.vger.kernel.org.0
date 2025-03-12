Return-Path: <linux-arch+bounces-10685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FDA5E3B1
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7E6167716
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D1256C9D;
	Wed, 12 Mar 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K7i2HjPi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7E1D5AD4;
	Wed, 12 Mar 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804393; cv=none; b=d4EpR7u6SGVtWLqrKn5tz4ZstI8teb4CSYeYk2Jx2gsIBExTgU96v6uNJF2Ypq/C4lr+Q93IJ2l2Yjh/t26I4L37yKOrRJxo2L2Z+dYoqhTtJjBvSyZ+AgreGHGtia4fz3MTr7IO8mJtNYH6HzgK5YjaQTcDL0vKFczJKyMmEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804393; c=relaxed/simple;
	bh=aDjm3DkqZDJX85tJ+yrr6P4kwqc9qTDqHn3I2xyYvgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsFrKWW4aEnGmyKZsJyKl7A2NLgf7GB/KNoU0fxhqPtonEg3P1sAA6lkM0e+Gnb50Mvz17bhyvIr5vSy7vxUkvnaG4t83LxJf4GSOTR0BtTe/fBsytTG3KlAZe14q3pCcSAzSFnigiAaw/Byb2AH5MHfINAQioKGDXgTBBUzRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K7i2HjPi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D088210B152;
	Wed, 12 Mar 2025 11:33:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D088210B152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741804391;
	bh=tLT4s8zpi9H4TPqM7ZRQ2exoG2CX0kuuef8GX5dDEHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K7i2HjPigYJ7aN9a1EUjItNpH2ntPinGBEcprbJMoTg/OFVg8DbIOxVuBnx6FYFfN
	 K5b5qmytnGwEBlsnAqGiUVGBg0u5MAgxWBIeolqcOHZEvmGg3xmIyvIkjWszMrFgs3
	 83uRvzX4m0+Ttx01v0EPOiDAQffUDuTKA/HCD8S0=
Message-ID: <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
Date: Wed, 12 Mar 2025 11:33:11 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
To: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Joey Gouly <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 3:18 PM, Michael Kelley wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 10, 2025 2:21 PM
>>
>> On Mon, Mar 10, 2025, at 22:01, Michael Kelley wrote:
>>> From: Arnd Bergmann <arnd@arndb.de> Sent: Saturday, March 8, 2025 1:05 PM
>>>>>   config HYPERV_VTL_MODE
>>>>>   	bool "Enable Linux to boot in VTL context"
>>>>> -	depends on X86_64 && HYPERV
>>>>> +	depends on (X86_64 || ARM64)
>>>>>   	depends on SMP
>>>>> +	select OF_EARLY_FLATTREE
>>>>> +	select OF
>>>>>   	default n
>>>>>   	help
>>>>
>>>> Having the dependency below the top-level Kconfig entry feels a little
>>>> counterintuitive. You could flip that back as it was before by doing
>>>>
>>>>        select HYPERV_VTL_MODE if !ACPI
>>>>        depends on ACPI || SMP
>>>>
>>>> in the HYPERV option, leaving the dependency on HYPERV in
>>>> HYPERV_VTL_MODE.
>>>
>>> I would argue that we don't ever want to implicitly select
>>> HYPERV_VTL_MODE because of some other config setting or
>>> lack thereof.  VTL mode is enough of a special case that it should
>>> only be explicitly selected. If someone omits ACPI, then HYPERV
>>> should not be selectable unless HYPERV_VTL_MODE is explicitly
>>> selected.
>>>
>>> The last line of the comment for HYPERV_VTL_MODE says
>>> "A kernel built with this option must run at VTL2, and will not run
>>> as a normal guest."  In other words, don't choose this unless you
>>> 100% know that VTL2 is what you want.
>>
>> It sounds like the latter is the real problem: enabling a feature
>> should never prevent something else from working. Can you describe
>> what VTL context is and why it requires an exception to a rather
>> fundamental rule here? If you build a kernel that runs on every
>> single piece of arm64 hardware and every hypervisor, why can't
>> you add HYPERV_VTL_MODE to that as an option?
>>

In the VTL mode, we're running the kernel as secure firmware inside the
guest (one might see VTL2 working as Intel SMM or Secure World on ARM).

[...]

> 
> Ideally, a Linux kernel image could detect at runtime what VTL it is
> running at, and "do the right thing". Unfortunately, on x86 Linux this
> has proved difficult (or perhaps impossible) because the amount of
> boot-time setup required to ask the question about the current VTL
> is significant. The idiosyncrasies and historical baggage of x86 requires
> that Linux do some x86-specific initialization steps for VTL > 0
> before the question can be asked. Hence the introduction of
> CONFIG_HYPERV_VTL_MODE, and the behavior that when it is
> selected, the kernel image won't run normally in VTL 0.
> 
> I'll go out on a limb and say that I suspect on arm64 a runtime
> determination based on querying the VTL *could* be made (though
> I'm not the person writing the code). But taking advantage of that
> on arm64 produces an undesirable dichotomy with x86.

On arm64 that is much easier, I agree. On x86 we'd need a kludge of

static void __naked __init __aligned(4096) early_hvcall_pg(void)
{
	/*
	 * Fill the early hvcall page with `0xF1` aka `INT1` to catch
	 * programming errors. The hypervisor will overlay the page with
	 * the vendor-specific code sequences to make hypercalls on x86(_64).
	 */
	asm (".skip 4096, 0xf1");
}

static u8 __init early_hvcall_pg_input[4096] 
__attribute__((aligned(4096)));
static u8 __init early_hvcall_pg_output[4096] 
__attribute__((aligned(4096)));

static void __init early_connect_to_hv(void)
{
	union hv_x64_msr_hypercall_contents hypercall_msr;
	u64 guest_id;

	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
	hypercall_msr.enable = 1;
	hypercall_msr.guest_physical_address = 
__phys_to_pfn(virt_to_phys(early_hvcall_pg));
	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
}

or variations thereof.

What's very nice about arm64 in this case at least, it's got SMCCC, hvc,
OF/DT and a history of options of being power-efficient and embedded.
Conversely, on x86(_64) the code sequences for hyeprcalls vary from the
first vendor to the second one so we have to have the hvcall page to
make this regular in the code. Support for OF/DT on x86 was added for
Intel set top boxes (MID, ~2015 iirc), and it took a bit of huffing and
puffing to make that work for us on the large/NUMA systems (and there
might be something about supporting x2apic that had to be figured out).

All told, we can have nicer things in our arm64 code yet diverging the
code much from x86(_64) is not very desirable. I am not sure yet what
the tradeoff should be, and my knowledge of Kconfig is rather basic.
Certainly I cannot propose to arm64 maintainers that we'd like to do
quirky things in Kconfig because of x86(-64), legacy specs, etc.

Perhaps, we could go back to the V2's option of

  config HYPERV
  	tristate "Microsoft Hyper-V client drivers"
  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
+		|| (ARM64 && !CPU_BIG_ENDIAN)
  	select PARAVIRT
  	select X86_HV_CALLBACK_VECTOR if X86
  	select OF_EARLY_FLATTREE if OF
@@ -15,7 +15,7 @@ config HYPERV

  config HYPERV_VTL_MODE
  	bool "Enable Linux to boot in VTL context"
-	depends on X86_64 && HYPERV
+	depends on HYPERV
  	depends on SMP
  	default n
  	help
@@ -31,7 +31,7 @@ config HYPERV_VTL_MODE

  	  Select this option to build a Linux kernel to run at a VTL other than
  	  the normal VTL0, which currently is only VTL2.  This option
-	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  initializes the kernel to run in VTL2, and adds the ability to boot
  	  secondary CPUs directly into 64-bit context as required for VTLs other
  	  than 0.  A kernel built with this option must run at VTL2, and will
  	  not run as a normal guest.

That's a minimal extension, its surprise factor is very low. It has not
been seen to cause issues. If no one has strong opinions against that,
I'd send that in V6.

> 
> Roman may have further thoughts on the topic, but that's
> what I know about how we got here.
> 
> Michael
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm
> [2] https://techcommunity.microsoft.com/blog/windowsosplatform/openhcl-the-new-open-source-paravisor/4273172

-- 
Thank you,
Roman


