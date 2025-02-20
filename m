Return-Path: <linux-arch+bounces-10242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C53A3CF6F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 03:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE54C189AB84
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E61D63FA;
	Thu, 20 Feb 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d+dtWzGK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F043F1D63FC;
	Thu, 20 Feb 2025 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019262; cv=none; b=d3dN0I8D98/m6TT9e5u5YpDZzUdkmRuME4Kl97N90TRXw+AKx3Y6UkL7aYyOnS3vbYcDvFxIjDP5S/MCvAVa90OHAAXerfoV6TBFHJX5sWNfn8WrsyI15f0uTVZXKognLtwjBQrv5Cl0zALvyibe7CIEzCcNC/Y/oaZxHyL1ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019262; c=relaxed/simple;
	bh=E78MFVVonCvhoPfB/9ODGrfDuE/N2cLhSfv9Cnys7xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udkt7vFFCKUMhnw/9+nmB6gt9Pn8og+8q800KWehiMNpdRXpRcZLJlWNmZbpmxJOWUdnC5nFTKJyj86Nh9eSde2HmO1RxzUV2UZkqghSR9Bd894YxH1VJfWDS1YxR7W0P2tZvTfY44j/+GP20amtS0MR6yV+iiUlssNmlwu73Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d+dtWzGK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB3C92043DEE;
	Wed, 19 Feb 2025 18:40:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB3C92043DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740019259;
	bh=bxU+8WttbN2F5/Reuw0zhJZjMiM1XS6gufuI6lYqdY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+dtWzGKjvXB4oPn7Lw1Cs2D5Q8eiqlnK/efb7+5clpT/FsGX7mpNMXHpgJLD7gMB
	 5IGU5pGL0Yugy0cg+ltge8EliDlOXF3tqqi+hiqJsBBm+78QIslB4r+WBKHzdEfdpP
	 cTr5qd/5uqzYzbpj80UduRcjlVYycEj7E+riOVfM=
Message-ID: <de06f682-ca11-48da-beca-4dcb49c9fecd@linux.microsoft.com>
Date: Wed, 19 Feb 2025 18:40:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
References: <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F396B9FECAD555520DDED4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1defc59b-3e6c-4023-b57b-d81a4358e69e@linux.microsoft.com>
 <SN6PR02MB4157F735E4B553740CAEE369D4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F735E4B553740CAEE369D4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/2025 6:07 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 19, 2025 3:53 PM
>>
>> On 2/19/2025 11:46 AM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday,
>> February 11, 2025 2:22 PM
>>>>
>>>> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
>>>> booting and future mshv driver functionality.
>>>
>>> This statement could use a bit more explanation as to "why".  Something
>>> like:
>>>
>>> Running in the root partition is a unique and specialized case that requires
>>> additional code. The config option allows kernels built to run as a normal
>>> Hyper-V guest to exclude this code, which is important since significant
>>> additional code specific to the root partition is expected to be added over
>>> time.
>>>
>>
>> This sounds good to me
>>
>>> Related, what's the thinking behind making CONFIG_MSHV_ROOT be
>>> tri-state? Obviously, it would allow most of the root partition code
>>> to be loaded as a module instead of built-in to the kernel image, but is that
>>> a useful scenario given the unique nature of running in the root partition?
>>> Since the root partition environment is very specific and constrained,
>>> perhaps just always building the root partition code into the kernel
>>> makes sense. I'm asking purely as a question because I'm not familiar with
>>> the details of how a root partition kernel is likely to be setup & run. If
>>> possible, give a short explanation for the "why tri-state" question.
>>> Remember, that's what commit message are for -- to answer the "why"
>>> question as much as to summarize the "what" question.
>>>
>>
>> In the past it enabled quicker development: I would iterate on the driver
>> code and just rebuild and reinsert the module. I'll admit I haven't used that
>> workflow in a while so I'm not sure how useful it still is.
>>
>> Is there a *downside* (from upstream perspective) to keeping it a tristate
>> that I'm not aware of? e.g. Would it be difficult to change it to a bool in
>> future if we decide we really don't need it?
> 
> OK -- I had not thought about the development workflow, and that's valid.
> There's no downside to keeping it tri-state that I'm aware of. And I think it
> would be easy to change to just a Boolean in the future if tri-state
> isn't really useful. It was just one of those things that surprised me
> a little bit, and I was wondering "why". :-)
> 

Ok great, I will mention it is primarily to aid development.

>>
>> While we're on this topic, do you know if CONFIG_HYPERV=m is ever used, and
>> why?
> 
> Yes, it is definitely used by the distro vendors. They want to have a single
> product release that is useable pretty much everywhere. So they don't
> want to burden the main kernel binary with Hyper-V code that
> wouldn't be used on bare metal, or a KVM/QEMU VM, etc. Azure images
> might be a little more specific to Hyper-V, and might have the Hyper-V
> code built-in -- it depends on the distro vendor. I don't remember having
> taken a census to know which approach predominates, but my guess is
> "=m".
> 

Good to know!

>>
>>>>
>>>> Change hv_root_partition into a function which always returns false
>>>> if CONFIG_MSHV_ROOT=n.
>>>
>>> Again, help answer the "why" question. I think the goal is related to
>>> the above by allowing the compiler to optimize away any "if (root partition)"
>>> code when building for a normal Hyper-V guest.
>>>

Forgot to respond here last email - Yep, I will explain it more clearly as you
suggest.

>>>>
>>>> Introduce hv_current_partition_type to store the type of partition
>>>> (guest, root, or other kinds in future), and hv_identify_partition_type()
>>>> to it up early in Hyper-V initialization.
>>>>
>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> ---
>>>> Depends on
>>>> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com/
>>>>
>>>>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>>>>  arch/x86/hyperv/hv_init.c          | 10 ++++----
>>>>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
>>>>  drivers/clocksource/hyperv_timer.c |  4 +--
>>>>  drivers/hv/Kconfig                 | 12 +++++++++
>>>>  drivers/hv/Makefile                |  3 ++-
>>>>  drivers/hv/hv.c                    | 10 ++++----
>>>>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
>>>>  drivers/hv/vmbus_drv.c             |  2 +-
>>>>  drivers/iommu/hyperv-iommu.c       |  4 +--
>>>>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++-----
>>>>  11 files changed, 92 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>>>> index 29fcfd595f48..2265ea5ce5ad 100644
>>>> --- a/arch/arm64/hyperv/mshyperv.c
>>>> +++ b/arch/arm64/hyperv/mshyperv.c
>>>> @@ -61,6 +61,8 @@ static int __init hyperv_init(void)
>>>>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>>>>  		ms_hyperv.misc_features);
>>>>
>>>> +	hv_identify_partition_type();
>>>> +
>>>>  	ret = hv_common_init();
>>>>  	if (ret)
>>>>  		return ret;
>>>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>>>> index 9be1446f5bd3..ddeb40930bc8 100644
>>>> --- a/arch/x86/hyperv/hv_init.c
>>>> +++ b/arch/x86/hyperv/hv_init.c
>>>> @@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
>>>>  		return 0;
>>>>
>>>>  	hvp = &hv_vp_assist_page[cpu];
>>>> -	if (hv_root_partition) {
>>>> +	if (hv_root_partition()) {
>>>>  		/*
>>>>  		 * For root partition we get the hypervisor provided VP assist
>>>>  		 * page, instead of allocating a new page.
>>>> @@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
>>>>
>>>>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>>>>  		union hv_vp_assist_msr_contents msr = { 0 };
>>>> -		if (hv_root_partition) {
>>>> +		if (hv_root_partition()) {
>>>>  			/*
>>>>  			 * For root partition the VP assist page is mapped to
>>>>  			 * hypervisor provided page, and thus we unmap the
>>>> @@ -317,7 +317,7 @@ static int hv_suspend(void)
>>>>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>>>>  	int ret;
>>>>
>>>> -	if (hv_root_partition)
>>>> +	if (hv_root_partition())
>>>>  		return -EPERM;
>>>>
>>>>  	/*
>>>> @@ -518,7 +518,7 @@ void __init hyperv_init(void)
>>>>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>>>>  	hypercall_msr.enable = 1;
>>>>
>>>> -	if (hv_root_partition) {
>>>> +	if (hv_root_partition()) {
>>>>  		struct page *pg;
>>>>  		void *src;
>>>>
>>>> @@ -592,7 +592,7 @@ void __init hyperv_init(void)
>>>>  	 * If we're running as root, we want to create our own PCI MSI domain.
>>>>  	 * We can't set this in hv_pci_init because that would be too late.
>>>>  	 */
>>>> -	if (hv_root_partition)
>>>> +	if (hv_root_partition())
>>>>  		x86_init.irqs.create_pci_msi_domain = hv_create_pci_msi_domain;
>>>>  #endif
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>>>> index f285757618fc..4f01f424ea5b 100644
>>>> --- a/arch/x86/kernel/cpu/mshyperv.c
>>>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>>>> @@ -33,8 +33,6 @@
>>>>  #include <asm/numa.h>
>>>>  #include <asm/svm.h>
>>>>
>>>> -/* Is Linux running as the root partition? */
>>>> -bool hv_root_partition;
>>>>  /* Is Linux running on nested Microsoft Hypervisor */
>>>>  bool hv_nested;
>>>>  struct ms_hyperv_info ms_hyperv;
>>>> @@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
>>>>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>>>>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>>>>
>>>> -	/*
>>>> -	 * Check CPU management privilege.
>>>> -	 *
>>>> -	 * To mirror what Windows does we should extract CPU management
>>>> -	 * features and use the ReservedIdentityBit to detect if Linux is the
>>>> -	 * root partition. But that requires negotiating CPU management
>>>> -	 * interface (a process to be finalized). For now, use the privilege
>>>> -	 * flag as the indicator for running as root.
>>>> -	 *
>>>> -	 * Hyper-V should never specify running as root and as a Confidential
>>>> -	 * VM. But to protect against a compromised/malicious Hyper-V trying
>>>> -	 * to exploit root behavior to expose Confidential VM memory, ignore
>>>> -	 * the root partition setting if also a Confidential VM.
>>>> -	 */
>>>> -	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>>>> -	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>>>> -		hv_root_partition = true;
>>>> -		pr_info("Hyper-V: running as root partition\n");
>>>> -	}
>>>> +	hv_identify_partition_type();
>>>>
>>>>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>>>>  		hv_nested = true;
>>>> @@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
>>>>
>>>>  # ifdef CONFIG_SMP
>>>>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
>>>> -	if (hv_root_partition ||
>>>> +	if (hv_root_partition() ||
>>>>  	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
>>>>  		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>>>>  # endif
>>>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>>>> index f00019b078a7..09549451dd51 100644
>>>> --- a/drivers/clocksource/hyperv_timer.c
>>>> +++ b/drivers/clocksource/hyperv_timer.c
>>>> @@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
>>>>  	 * mapped.
>>>>  	 */
>>>>  	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
>>>> -	if (hv_root_partition)
>>>> +	if (hv_root_partition())
>>>>  		tsc_pfn = tsc_msr.pfn;
>>>>  	else
>>>>  		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
>>>> @@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
>>>>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>>>>  		return;
>>>>
>>>> -	if (!hv_root_partition) {
>>>> +	if (!hv_root_partition()) {
>>>>  		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
>>>>  		     __func__);
>>>>  		return;
>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>> index 862c47b191af..aac172942f6c 100644
>>>> --- a/drivers/hv/Kconfig
>>>> +++ b/drivers/hv/Kconfig
>>>> @@ -55,4 +55,16 @@ config HYPERV_BALLOON
>>>>  	help
>>>>  	  Select this option to enable Hyper-V Balloon driver.
>>>>
>>>> +config MSHV_ROOT
>>>> +	tristate "Microsoft Hyper-V root partition support"
>>>> +	depends on HYPERV
>>>> +	depends on !HYPERV_VTL_MODE
>>>> +	depends on PAGE_SIZE_4KB
>>>
>>> Add a comment about why PAGE_SIZE_4KB is a requirement, even on
>>> arm64 systems that can support guests with larger page sizes. We
>>> discussed why in an earlier email thread, but somebody looking at
>>> this in the future might wonder.
>>>
>>>> +	default n
>>>> +	help
>>>> +	  Select this option to enable support for booting and running as root
>>>> +	  partition on Microsoft Hyper-V.
>>>> +
>>>> +	  If unsure, say N.
>>>> +
>>>
>>> One thing to keep in mind:  Sometimes people build kernels with all
>>> config options set to "Y".  We want to make sure that if someone does
>>> that, the kernel will still run in a non-Hyper-V environment.  We had this
>>> problem with CONFIG_HYPERV_VTL_MODE=y, where a kernel built with
>>> that wouldn't run elsewhere, and that had to be fixed.  I don't think the
>>> changes in this patch cause a problem in that regard, but it is something
>>> to keep in mind for the future.
>>>
>>> As I see it, setting CONFIG_MSHV_ROOT=y (or =m) just adds code to
>>> the kernel image or modules list, and enables runtime detection of
>>> whether the kernel is actually in the root partition. If not actually in the
>>> root partition, the behavior is normal guest behavior. I think that is all good.
>>>
>> Yes, agreed. The assumption we are working under is that enabling
>> CONFIG_MSHV_ROOT
>> doesn't break any normal guest or non-Hyper-V scenarios.
>>
>> Of course it's hard to always be certain that our code doesn't break some other
>> config option at runtime, but we fix that whenever we see it (or exclude the
>> combination via Kconfig).
>>
>>>>  endmenu
>>>> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
>>>> index 9afcabb3fbd2..2b8dc954b350 100644
>>>> --- a/drivers/hv/Makefile
>>>> +++ b/drivers/hv/Makefile
>>>> @@ -13,4 +13,5 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>>>>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>>>>
>>>>  # Code that must be built-in
>>>> -obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o hv_proc.o
>>>> +obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
>>>> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
>>>
>>> OK, so hv_proc.o is always built-in, regardless of whether
>>> CONFIG_MSHV_ROOT=y or =m. I think that makes sense. The functions in
>>> hv_proc.c are called somewhere in the middle of the kernel boot process,
>>> and I'm unsure if the module loading mechanism is fully set up at the point
>>> the functions are needed. This approach avoids any risk of not being able
>>> to load the module. Presumably still-to-be-added code for the root partition
>>> could be built as a module (though see my comment in the commit message).
>>>
>>
>> Yep, that was the idea.
>>
>>>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>>>> index 36d9ba097ff5..93d82382351c 100644
>>>> --- a/drivers/hv/hv.c
>>>> +++ b/drivers/hv/hv.c
>>>> @@ -144,7 +144,7 @@ int hv_synic_alloc(void)
>>>>  		 * Synic message and event pages are allocated by paravisor.
>>>>  		 * Skip these pages allocation here.
>>>>  		 */
>>>> -		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
>>>> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
>>>>  			hv_cpu->synic_message_page =
>>>>  				(void *)get_zeroed_page(GFP_ATOMIC);
>>>>  			if (!hv_cpu->synic_message_page) {
>>>> @@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>>>  	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
>>>>  	simp.simp_enabled = 1;
>>>>
>>>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>>>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>>>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>>>>  		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>>>>  				~ms_hyperv.shared_gpa_boundary;
>>>> @@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>>>  	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
>>>>  	siefp.siefp_enabled = 1;
>>>>
>>>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>>>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>>>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>>>>  		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>>>>  				~ms_hyperv.shared_gpa_boundary;
>>>> @@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>>>>  	 * addresses.
>>>>  	 */
>>>>  	simp.simp_enabled = 0;
>>>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>>>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>>>  		iounmap(hv_cpu->synic_message_page);
>>>>  		hv_cpu->synic_message_page = NULL;
>>>>  	} else {
>>>> @@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>>>>  	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
>>>>  	siefp.siefp_enabled = 0;
>>>>
>>>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>>>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>>>  		iounmap(hv_cpu->synic_event_page);
>>>>  		hv_cpu->synic_event_page = NULL;
>>>>  	} else {
>>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>>> index cb3ea49020ef..d1227e85c5b7 100644
>>>> --- a/drivers/hv/hv_common.c
>>>> +++ b/drivers/hv/hv_common.c
>>>> @@ -34,8 +34,11 @@
>>>>  u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>>>>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>>>>
>>>> +enum hv_partition_type hv_current_partition_type;
>>>> +EXPORT_SYMBOL_GPL(hv_current_partition_type);
>>>> +
>>>>  /*
>>>> - * hv_root_partition, ms_hyperv and hv_nested are defined here with other
>>>> + * ms_hyperv and hv_nested are defined here with other
>>>>   * Hyper-V specific globals so they are shared across all architectures and are
>>>>   * built only when CONFIG_HYPERV is defined.  But on x86,
>>>>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
>>>> @@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
>>>>   * here, allowing for an overriding definition in the module containing
>>>>   * ms_hyperv_init_platform().
>>>>   */
>>>> -bool __weak hv_root_partition;
>>>> -EXPORT_SYMBOL_GPL(hv_root_partition);
>>>> -
>>>>  bool __weak hv_nested;
>>>>  EXPORT_SYMBOL_GPL(hv_nested);
>>>>
>>>> @@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
>>>>
>>>>  static inline bool hv_output_page_exists(void)
>>>>  {
>>>> -	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>>>> +	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>>>>  }
>>>>
>>>>  void __init hv_get_partition_id(void)
>>>> @@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>>>>
>>>>  bool hv_is_hibernation_supported(void)
>>>>  {
>>>> -	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
>>>> +	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE_S4);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>>>>
>>>> @@ -683,3 +683,23 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
>>>>  	return HV_STATUS_INVALID_PARAMETER;
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>>>> +
>>>> +void hv_identify_partition_type(void)
>>>> +{
>>>> +	/*
>>>> +	 * Check partition creation and cpu management privileges
>>>> +	 *
>>>> +	 * Hyper-V should never specify running as root and as a Confidential
>>>> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
>>>> +	 * to exploit root behavior to expose Confidential VM memory, ignore
>>>> +	 * the root partition setting if also a Confidential VM.
>>>> +	 */
>>>> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>>>> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>>>> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>>>> +		hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
>>>> +		pr_info("Hyper-V: running as root partition\n");
>>>> +	} else {
>>>> +		hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
>>>> +	}
>>>
>>> If the flags indicate running in the root partition, but CONFIG_MSHV_ROOT=n,
>>> perhaps that should probably be flagged with an error message. I haven't thought
>>> through what to do then: Panic, keep running as a normal guest, or something else?
>>>
>>
>> If the kernel is run as root partition with CONFIG_MSHV_ROOT=n, I think it will crash
>> or hang at some point later in boot.
>>
>> How about this:
>>
>> 	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>> 	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>> 	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>> 		pr_info("Hyper-V: running as root partition\n");
>> 		if (IS_ENABLED(CONFIG_MSHV_ROOT))
>> 			hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
>> 		else
>> 			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>> 	}
>>
>> We could also BUG_ON() since it will almost certainly crash anyway, but maybe just
>> letting it continue is ok.
> 
> I'm OK with just continuing, as I don't have any justification for an alternative.
> It's a strange situation that should not happen, but it's worthwhile to output
> some indication of why things are about to go badly.
> 

Ok, thanks for the comments. Planning to post v2 soon.

Nuno

> Michael
> 
>>
>>>> +}
>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>>> index 0f6cd44fff29..844eba0429fa 100644
>>>> --- a/drivers/hv/vmbus_drv.c
>>>> +++ b/drivers/hv/vmbus_drv.c
>>>> @@ -2646,7 +2646,7 @@ static int __init hv_acpi_init(void)
>>>>  	if (!hv_is_hyperv_initialized())
>>>>  		return -ENODEV;
>>>>
>>>> -	if (hv_root_partition && !hv_nested)
>>>> +	if (hv_root_partition() && !hv_nested)
>>>>  		return 0;
>>>>
>>>>  	/*
>>>> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
>>>> index 2a86aa5d54c6..53e4b37716af 100644
>>>> --- a/drivers/iommu/hyperv-iommu.c
>>>> +++ b/drivers/iommu/hyperv-iommu.c
>>>> @@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>>>>  	    x86_init.hyper.msi_ext_dest_id())
>>>>  		return -ENODEV;
>>>>
>>>> -	if (hv_root_partition) {
>>>> +	if (hv_root_partition()) {
>>>>  		name = "HYPERV-ROOT-IR";
>>>>  		ops = &hyperv_root_ir_domain_ops;
>>>>  	} else {
>>>> @@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>>>>  		return -ENOMEM;
>>>>  	}
>>>>
>>>> -	if (hv_root_partition)
>>>> +	if (hv_root_partition())
>>>>  		return 0; /* The rest is only relevant to guests */
>>>>
>>>>  	/*
>>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>>> index 7adc10a4fa3e..6f898792fb51 100644
>>>> --- a/include/asm-generic/mshyperv.h
>>>> +++ b/include/asm-generic/mshyperv.h
>>>> @@ -28,6 +28,11 @@
>>>>
>>>>  #define VTPM_BASE_ADDRESS 0xfed40000
>>>>
>>>> +enum hv_partition_type {
>>>> +	HV_PARTITION_TYPE_GUEST,
>>>> +	HV_PARTITION_TYPE_ROOT,
>>>> +};
>>>> +
>>>>  struct ms_hyperv_info {
>>>>  	u32 features;
>>>>  	u32 priv_high;
>>>> @@ -59,6 +64,7 @@ struct ms_hyperv_info {
>>>>  extern struct ms_hyperv_info ms_hyperv;
>>>>  extern bool hv_nested;
>>>>  extern u64 hv_current_partition_id;
>>>> +extern enum hv_partition_type hv_current_partition_type;
>>>>
>>>>  extern void * __percpu *hyperv_pcpu_input_arg;
>>>>  extern void * __percpu *hyperv_pcpu_output_arg;
>>>> @@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
>>>>  extern int vmbus_interrupt;
>>>>  extern int vmbus_irq;
>>>>
>>>> -extern bool hv_root_partition;
>>>> -
>>>>  #if IS_ENABLED(CONFIG_HYPERV)
>>>>  /*
>>>>   * Hypervisor's notion of virtual processor ID is different from
>>>> @@ -213,15 +217,12 @@ void __init hv_common_free(void);
>>>>  void __init ms_hyperv_late_init(void);
>>>>  int hv_common_cpu_init(unsigned int cpu);
>>>>  int hv_common_cpu_die(unsigned int cpu);
>>>> +void hv_identify_partition_type(void);
>>>>
>>>>  void *hv_alloc_hyperv_page(void);
>>>>  void *hv_alloc_hyperv_zeroed_page(void);
>>>>  void hv_free_hyperv_page(void *addr);
>>>>
>>>> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>>>> -int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>>>> -int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>>>> -
>>>>  /**
>>>>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>>>>   * @cpu_number: CPU number in Linux terms
>>>> @@ -309,6 +310,7 @@ void hyperv_cleanup(void);
>>>>  bool hv_query_ext_cap(u64 cap_query);
>>>>  void hv_setup_dma_ops(struct device *dev, bool coherent);
>>>>  #else /* CONFIG_HYPERV */
>>>> +static inline void hv_identify_partition_type(void) {}
>>>>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>>>>  static inline bool hv_is_hibernation_supported(void) { return false; }
>>>>  static inline void hyperv_cleanup(void) {}
>>>> @@ -320,4 +322,29 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
>>>>  }
>>>>  #endif /* CONFIG_HYPERV */
>>>>
>>>> +#if IS_ENABLED(CONFIG_MSHV_ROOT)
>>>> +static inline bool hv_root_partition(void)
>>>> +{
>>>> +	return	hv_current_partition_type == HV_PARTITION_TYPE_ROOT;
>>>
>>> Nit: There's an extra space character after "return".
>>>
>>
>> Fixed for next version, thanks.
>>
>>>> +}
>>>> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>>>> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>>>> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>>>> +
>>>> +#else /* CONFIG_MSHV_ROOT */
>>>> +static inline bool hv_root_partition(void) { return false; }
>>>> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>>> +{
>>>> +	return hv_result(U64_MAX);
>>>> +}
>>>> +static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
>>>> +{
>>>> +	return hv_result(U64_MAX);
>>>> +}
>>>> +static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>>> +{
>>>> +	return hv_result(U64_MAX);
>>>> +}
>>>> +#endif /* CONFIG_MSHV_ROOT */
>>>> +
>>>>  #endif
>>>> --
>>>> 2.34.1


