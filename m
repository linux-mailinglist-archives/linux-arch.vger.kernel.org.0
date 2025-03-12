Return-Path: <linux-arch+bounces-10691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5CA5E6A7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5986176E54
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38441EFFBA;
	Wed, 12 Mar 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jVYXdLGQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CCE1EFFB2;
	Wed, 12 Mar 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815056; cv=none; b=BjJX/WRXyeVxAhsBYQjJFRjkaQnan3FOZ1SOEzO7V2ak1RqxmjX7TBk0Ghyi/7qGlp7u7FRol/7YWgBkgNBS8b4kJvtTdilSvLWnKkgWfX5t0sY03g/beDoiUw2tZXgJ45yhDJZCw8+mshkcJwmRgd4Wz1K1xWldsntNhCepxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815056; c=relaxed/simple;
	bh=b3SG1qguOMx7tqHsbHfarJaOxpoJiGI0tAHShXJVlrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mchLcKFamnfrP2WQ1XULDUSjEFRFaMKOWV/o+fe9hbqv9Qn+0tt/jtITbuo3YtQ+ZPQpQYcDR2xrTEmqQhbcE8u9MRrXOEWGnDGCPTdHZagLBcgWGeuTDasEWJAsTHql3U36l7MsaE1+yz7qmngkWl9IWvNgMloQ3MiL0C7XGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jVYXdLGQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56DB7210B15D;
	Wed, 12 Mar 2025 14:30:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56DB7210B15D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741815054;
	bh=0jZMHKO18dXTXA4LJuA2uOeEgiBBF4NGlAFfPYSUkIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVYXdLGQsYulvVeW8IFJWbnpTdPhO3YkIzVogJSfNX4/5ywy0iqJqge8B5pZ1HaAV
	 Iv100RzYOsmebNCVxD7ORkWEDunwcz/79GyJiqkQhUDuH+nPFal96SJH1Ki4+uRbVB
	 jJP64KqnGyiH4Tkhk5Kk5cE7kjlh3hiRNV9MLqM8=
Message-ID: <3d26e47a-cb42-47f6-a18c-e330ee065a2b@linux.microsoft.com>
Date: Wed, 12 Mar 2025 14:30:54 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
To: Wei Liu <wei.liu@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>,
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
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
 <Z9HvHsGyXDnN38_B@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z9HvHsGyXDnN38_B@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/12/2025 1:31 PM, Wei Liu wrote:
> On Wed, Mar 12, 2025 at 11:33:11AM -0700, Roman Kisel wrote:
>>
>>
>> On 3/10/2025 3:18 PM, Michael Kelley wrote:
>>> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 10, 2025 2:21 PM
>>>>
>>>> On Mon, Mar 10, 2025, at 22:01, Michael Kelley wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de> Sent: Saturday, March 8, 2025 1:05 PM
>>>>>>>    config HYPERV_VTL_MODE
>>>>>>>    	bool "Enable Linux to boot in VTL context"
>>>>>>> -	depends on X86_64 && HYPERV
>>>>>>> +	depends on (X86_64 || ARM64)
>>>>>>>    	depends on SMP
>>>>>>> +	select OF_EARLY_FLATTREE
>>>>>>> +	select OF
>>>>>>>    	default n
>>>>>>>    	help
>>>>>>
>>>>>> Having the dependency below the top-level Kconfig entry feels a little
>>>>>> counterintuitive. You could flip that back as it was before by doing
>>>>>>
>>>>>>         select HYPERV_VTL_MODE if !ACPI
>>>>>>         depends on ACPI || SMP
>>>>>>
>>>>>> in the HYPERV option, leaving the dependency on HYPERV in
>>>>>> HYPERV_VTL_MODE.
>>>>>
>>>>> I would argue that we don't ever want to implicitly select
>>>>> HYPERV_VTL_MODE because of some other config setting or
>>>>> lack thereof.  VTL mode is enough of a special case that it should
>>>>> only be explicitly selected. If someone omits ACPI, then HYPERV
>>>>> should not be selectable unless HYPERV_VTL_MODE is explicitly
>>>>> selected.
>>>>>
>>>>> The last line of the comment for HYPERV_VTL_MODE says
>>>>> "A kernel built with this option must run at VTL2, and will not run
>>>>> as a normal guest."  In other words, don't choose this unless you
>>>>> 100% know that VTL2 is what you want.
>>>>
>>>> It sounds like the latter is the real problem: enabling a feature
>>>> should never prevent something else from working. Can you describe
>>>> what VTL context is and why it requires an exception to a rather
>>>> fundamental rule here? If you build a kernel that runs on every
>>>> single piece of arm64 hardware and every hypervisor, why can't
>>>> you add HYPERV_VTL_MODE to that as an option?
>>>>
>>
>> In the VTL mode, we're running the kernel as secure firmware inside the
>> guest (one might see VTL2 working as Intel SMM or Secure World on ARM).
>>
>> [...]
>>
>>>
>>> Ideally, a Linux kernel image could detect at runtime what VTL it is
>>> running at, and "do the right thing". Unfortunately, on x86 Linux this
>>> has proved difficult (or perhaps impossible) because the amount of
>>> boot-time setup required to ask the question about the current VTL
>>> is significant. The idiosyncrasies and historical baggage of x86 requires
>>> that Linux do some x86-specific initialization steps for VTL > 0
>>> before the question can be asked. Hence the introduction of
>>> CONFIG_HYPERV_VTL_MODE, and the behavior that when it is
>>> selected, the kernel image won't run normally in VTL 0.
>>>
>>> I'll go out on a limb and say that I suspect on arm64 a runtime
>>> determination based on querying the VTL *could* be made (though
>>> I'm not the person writing the code). But taking advantage of that
>>> on arm64 produces an undesirable dichotomy with x86.
>>
>> On arm64 that is much easier, I agree. On x86 we'd need a kludge of
>>
>> static void __naked __init __aligned(4096) early_hvcall_pg(void)
>> {
>> 	/*
>> 	 * Fill the early hvcall page with `0xF1` aka `INT1` to catch
>> 	 * programming errors. The hypervisor will overlay the page with
>> 	 * the vendor-specific code sequences to make hypercalls on x86(_64).
>> 	 */
>> 	asm (".skip 4096, 0xf1");
>> }
>>
>> static u8 __init early_hvcall_pg_input[4096] __attribute__((aligned(4096)));
>> static u8 __init early_hvcall_pg_output[4096]
>> __attribute__((aligned(4096)));
>>
>> static void __init early_connect_to_hv(void)
>> {
>> 	union hv_x64_msr_hypercall_contents hypercall_msr;
>> 	u64 guest_id;
>>
>> 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
>> 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>> 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> 	hypercall_msr.enable = 1;
>> 	hypercall_msr.guest_physical_address =
>> __phys_to_pfn(virt_to_phys(early_hvcall_pg));
>> 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> }
>>
>> or variations thereof.
> 
> OT here but what's stopping us from doing this on x86?
> 

At the first glance, seems like nothing I think. For the conf scenarios
like TDX and SEV-SNP, due to the early hvcall I/O pages above allocated
in BSS, might need to mark the pages as decrypted and zero them out so
they look like proper BSS section (the page contents are scrambled after
flipping the page encryption bit iirc).

> It seems to me there is some value in setting up the hypercall page as
> early as possible. The same page can be used through the lifetime of the
> partition. The early input and output pages should be reclaimed.
> 

Wholeheartedly agree!

> Also, since the hypervisor will insert an overlay page, it makes sense
> to not allocate a page from Linux at all. When I ported Xen to run as
> a guest on Hyper-V, I used that approach. The setup worked just fine.
> 
> All being said, things work today, so I'm in no hurry to change things.
> 

I'll try fleshing this out soon-ish if no one beats me to that :)

> Wei.

-- 
Thank you,
Roman


