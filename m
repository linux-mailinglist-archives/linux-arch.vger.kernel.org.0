Return-Path: <linux-arch+bounces-10323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37CA402C9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 23:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668073B1F85
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20682204698;
	Fri, 21 Feb 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fU9edqL7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95C1D63C4;
	Fri, 21 Feb 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177484; cv=none; b=hQ93S5If4cx4E8UE3GtcyhsWu366LIu2ATiHBKBumm0jOZHsl2P0kU3p515XJADAEph6KnfpUkNZahIkqI+h6i+CIbbiByuPUJTbtU2zzgg0tPMOo5LWiJ65xeNl6+T4ghfbKXAPDSFMNoYiHngc1c+V2AltwP7id7BWQG/j8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177484; c=relaxed/simple;
	bh=87+G+isEcmWiVoVNIUsuYZU/8OKHmoTe5KPcaPzxpFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfoSqdf1ZoGggR5kVkOwIPhhuAtin5OK2+2MCpUACS7TObYqFfdSgQmGLIfockRa0/UT+haIQfj124ntP+slOUnVlTp2Y/fgPVdzivA8+5gVD5tkZuYNB9f1Y8B+gnl8pZlAA/dKo9hqzHJH97kTLs/eBjhldRmdRVFKpCHD1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fU9edqL7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ACBD205367B;
	Fri, 21 Feb 2025 14:38:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ACBD205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740177481;
	bh=MsnDGeKem9oAJ4DfbJ9EzNxL83lm0NuBxOZDlGaPaqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fU9edqL79t+eGspse/e4ixw5dyOyLAf5eqSqt9JUdxYuwOEBfznV08RmUoLlItO02
	 GJOHiiV+FSHJR0sU6V0dRdFyiwiejebWvBi0lH0rg+CbePqitsUjAOUZ1c6Fz4eCZb
	 JiWvXzn/WoyQyhJZm7beLkhPDnySYxcS7qX7IXhI=
Message-ID: <39b25002-f380-426b-ba18-9276d143a0db@linux.microsoft.com>
Date: Fri, 21 Feb 2025 14:38:00 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hyperv: Change hv_root_partition into a function
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
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
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740167795-13296-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41571DC572600680E3527DA0D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571DC572600680E3527DA0D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/2025 12:58 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, February 21, 2025 11:57 AM
>>
>> Introduce hv_curr_partition_type to store the partition type
>> as an enum.
>>
>> Right now this is limited to guest or root partition, but there will
>> be other kinds in future and the enum is easily extensible.
>>
>> Set up hv_curr_partition_type early in Hyper-V initialization with
>> hv_identify_partition_type(). hv_root_partition() just queries this
>> value, and shouldn't be called before that.
>>
>> Making this check into a function sets the stage for adding a config
>> option to gate the compilation of root partition code. In particular,
>> hv_root_partition() can be stubbed out always be false if root
>> partition support isn't desired.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>>  arch/x86/hyperv/hv_init.c          | 10 +++++-----
>>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++--------------------
>>  drivers/clocksource/hyperv_timer.c |  4 ++--
>>  drivers/hv/hv.c                    | 10 +++++-----
>>  drivers/hv/hv_common.c             | 32 ++++++++++++++++++++++++------
>>  drivers/hv/vmbus_drv.c             |  2 +-
>>  drivers/iommu/hyperv-iommu.c       |  4 ++--
>>  include/asm-generic/mshyperv.h     | 15 ++++++++++++--
>>  9 files changed, 58 insertions(+), 45 deletions(-)
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 

Thank you!

>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 29fcfd595f48..2265ea5ce5ad 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -61,6 +61,8 @@ static int __init hyperv_init(void)
>>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>>  		ms_hyperv.misc_features);
>>
>> +	hv_identify_partition_type();
>> +
>>  	ret = hv_common_init();
>>  	if (ret)
>>  		return ret;
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 9be1446f5bd3..ddeb40930bc8 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
>>  		return 0;
>>
>>  	hvp = &hv_vp_assist_page[cpu];
>> -	if (hv_root_partition) {
>> +	if (hv_root_partition()) {
>>  		/*
>>  		 * For root partition we get the hypervisor provided VP assist
>>  		 * page, instead of allocating a new page.
>> @@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
>>
>>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>>  		union hv_vp_assist_msr_contents msr = { 0 };
>> -		if (hv_root_partition) {
>> +		if (hv_root_partition()) {
>>  			/*
>>  			 * For root partition the VP assist page is mapped to
>>  			 * hypervisor provided page, and thus we unmap the
>> @@ -317,7 +317,7 @@ static int hv_suspend(void)
>>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>>  	int ret;
>>
>> -	if (hv_root_partition)
>> +	if (hv_root_partition())
>>  		return -EPERM;
>>
>>  	/*
>> @@ -518,7 +518,7 @@ void __init hyperv_init(void)
>>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>>  	hypercall_msr.enable = 1;
>>
>> -	if (hv_root_partition) {
>> +	if (hv_root_partition()) {
>>  		struct page *pg;
>>  		void *src;
>>
>> @@ -592,7 +592,7 @@ void __init hyperv_init(void)
>>  	 * If we're running as root, we want to create our own PCI MSI domain.
>>  	 * We can't set this in hv_pci_init because that would be too late.
>>  	 */
>> -	if (hv_root_partition)
>> +	if (hv_root_partition())
>>  		x86_init.irqs.create_pci_msi_domain = hv_create_pci_msi_domain;
>>  #endif
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index f285757618fc..4f01f424ea5b 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -33,8 +33,6 @@
>>  #include <asm/numa.h>
>>  #include <asm/svm.h>
>>
>> -/* Is Linux running as the root partition? */
>> -bool hv_root_partition;
>>  /* Is Linux running on nested Microsoft Hypervisor */
>>  bool hv_nested;
>>  struct ms_hyperv_info ms_hyperv;
>> @@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
>>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>>
>> -	/*
>> -	 * Check CPU management privilege.
>> -	 *
>> -	 * To mirror what Windows does we should extract CPU management
>> -	 * features and use the ReservedIdentityBit to detect if Linux is the
>> -	 * root partition. But that requires negotiating CPU management
>> -	 * interface (a process to be finalized). For now, use the privilege
>> -	 * flag as the indicator for running as root.
>> -	 *
>> -	 * Hyper-V should never specify running as root and as a Confidential
>> -	 * VM. But to protect against a compromised/malicious Hyper-V trying
>> -	 * to exploit root behavior to expose Confidential VM memory, ignore
>> -	 * the root partition setting if also a Confidential VM.
>> -	 */
>> -	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>> -	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>> -		hv_root_partition = true;
>> -		pr_info("Hyper-V: running as root partition\n");
>> -	}
>> +	hv_identify_partition_type();
>>
>>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>>  		hv_nested = true;
>> @@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
>>
>>  # ifdef CONFIG_SMP
>>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
>> -	if (hv_root_partition ||
>> +	if (hv_root_partition() ||
>>  	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
>>  		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>>  # endif
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index f00019b078a7..09549451dd51 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
>>  	 * mapped.
>>  	 */
>>  	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
>> -	if (hv_root_partition)
>> +	if (hv_root_partition())
>>  		tsc_pfn = tsc_msr.pfn;
>>  	else
>>  		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
>> @@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
>>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>>  		return;
>>
>> -	if (!hv_root_partition) {
>> +	if (!hv_root_partition()) {
>>  		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
>>  		     __func__);
>>  		return;
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index fab0690b5c41..a38f84548bc2 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -144,7 +144,7 @@ int hv_synic_alloc(void)
>>  		 * Synic message and event pages are allocated by paravisor.
>>  		 * Skip these pages allocation here.
>>  		 */
>> -		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
>> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
>>  			hv_cpu->synic_message_page =
>>  				(void *)get_zeroed_page(GFP_ATOMIC);
>>  			if (!hv_cpu->synic_message_page) {
>> @@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
>>  	simp.simp_enabled = 1;
>>
>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>>  		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>>  				~ms_hyperv.shared_gpa_boundary;
>> @@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
>>  	siefp.siefp_enabled = 1;
>>
>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>>  		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>>  				~ms_hyperv.shared_gpa_boundary;
>> @@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>>  	 * addresses.
>>  	 */
>>  	simp.simp_enabled = 0;
>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>  		iounmap(hv_cpu->synic_message_page);
>>  		hv_cpu->synic_message_page = NULL;
>>  	} else {
>> @@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>>  	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
>>  	siefp.siefp_enabled = 0;
>>
>> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
>> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>>  		iounmap(hv_cpu->synic_event_page);
>>  		hv_cpu->synic_event_page = NULL;
>>  	} else {
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 5cf9894b9e79..3d9cfcfbc854 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -34,8 +34,11 @@
>>  u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>>
>> +enum hv_partition_type hv_curr_partition_type;
>> +EXPORT_SYMBOL_GPL(hv_curr_partition_type);
>> +
>>  /*
>> - * hv_root_partition, ms_hyperv and hv_nested are defined here with other
>> + * ms_hyperv and hv_nested are defined here with other
>>   * Hyper-V specific globals so they are shared across all architectures and are
>>   * built only when CONFIG_HYPERV is defined.  But on x86,
>>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
>> @@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
>>   * here, allowing for an overriding definition in the module containing
>>   * ms_hyperv_init_platform().
>>   */
>> -bool __weak hv_root_partition;
>> -EXPORT_SYMBOL_GPL(hv_root_partition);
>> -
>>  bool __weak hv_nested;
>>  EXPORT_SYMBOL_GPL(hv_nested);
>>
>> @@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
>>
>>  static inline bool hv_output_page_exists(void)
>>  {
>> -	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>> +	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>>  }
>>
>>  void __init hv_get_partition_id(void)
>> @@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>>
>>  bool hv_is_hibernation_supported(void)
>>  {
>> -	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
>> +	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE_S4);
>>  }
>>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>>
>> @@ -717,3 +717,23 @@ int hv_result_to_errno(u64 status)
>>  	}
>>  	return -EIO;
>>  }
>> +
>> +void hv_identify_partition_type(void)
>> +{
>> +	/* Assume guest role */
>> +	hv_curr_partition_type = HV_PARTITION_TYPE_GUEST;
>> +	/*
>> +	 * Check partition creation and cpu management privileges
>> +	 *
>> +	 * Hyper-V should never specify running as root and as a Confidential
>> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
>> +	 * to exploit root behavior to expose Confidential VM memory, ignore
>> +	 * the root partition setting if also a Confidential VM.
>> +	 */
>> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>> +		pr_info("Hyper-V: running as root partition\n");
>> +		hv_curr_partition_type = HV_PARTITION_TYPE_ROOT;
>> +	}
>> +}
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 75eb1390b45c..22afebfc28ff 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2656,7 +2656,7 @@ static int __init hv_acpi_init(void)
>>  	if (!hv_is_hyperv_initialized())
>>  		return -ENODEV;
>>
>> -	if (hv_root_partition && !hv_nested)
>> +	if (hv_root_partition() && !hv_nested)
>>  		return 0;
>>
>>  	/*
>> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
>> index 2a86aa5d54c6..53e4b37716af 100644
>> --- a/drivers/iommu/hyperv-iommu.c
>> +++ b/drivers/iommu/hyperv-iommu.c
>> @@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>>  	    x86_init.hyper.msi_ext_dest_id())
>>  		return -ENODEV;
>>
>> -	if (hv_root_partition) {
>> +	if (hv_root_partition()) {
>>  		name = "HYPERV-ROOT-IR";
>>  		ops = &hyperv_root_ir_domain_ops;
>>  	} else {
>> @@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>>  		return -ENOMEM;
>>  	}
>>
>> -	if (hv_root_partition)
>> +	if (hv_root_partition())
>>  		return 0; /* The rest is only relevant to guests */
>>
>>  	/*
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 3f115e2bcdaa..54ebd630e72c 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -28,6 +28,11 @@
>>
>>  #define VTPM_BASE_ADDRESS 0xfed40000
>>
>> +enum hv_partition_type {
>> +	HV_PARTITION_TYPE_GUEST,
>> +	HV_PARTITION_TYPE_ROOT,
>> +};
>> +
>>  struct ms_hyperv_info {
>>  	u32 features;
>>  	u32 priv_high;
>> @@ -59,6 +64,7 @@ struct ms_hyperv_info {
>>  extern struct ms_hyperv_info ms_hyperv;
>>  extern bool hv_nested;
>>  extern u64 hv_current_partition_id;
>> +extern enum hv_partition_type hv_curr_partition_type;
>>
>>  extern void * __percpu *hyperv_pcpu_input_arg;
>>  extern void * __percpu *hyperv_pcpu_output_arg;
>> @@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
>>  extern int vmbus_interrupt;
>>  extern int vmbus_irq;
>>
>> -extern bool hv_root_partition;
>> -
>>  #if IS_ENABLED(CONFIG_HYPERV)
>>  /*
>>   * Hypervisor's notion of virtual processor ID is different from
>> @@ -213,6 +217,7 @@ void __init hv_common_free(void);
>>  void __init ms_hyperv_late_init(void);
>>  int hv_common_cpu_init(unsigned int cpu);
>>  int hv_common_cpu_die(unsigned int cpu);
>> +void hv_identify_partition_type(void);
>>
>>  void *hv_alloc_hyperv_page(void);
>>  void *hv_alloc_hyperv_zeroed_page(void);
>> @@ -310,6 +315,7 @@ void hyperv_cleanup(void);
>>  bool hv_query_ext_cap(u64 cap_query);
>>  void hv_setup_dma_ops(struct device *dev, bool coherent);
>>  #else /* CONFIG_HYPERV */
>> +static inline void hv_identify_partition_type(void) {}
>>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>>  static inline bool hv_is_hibernation_supported(void) { return false; }
>>  static inline void hyperv_cleanup(void) {}
>> @@ -321,4 +327,9 @@ static inline enum hv_isolation_type
>> hv_get_isolation_type(void)
>>  }
>>  #endif /* CONFIG_HYPERV */
>>
>> +static inline bool hv_root_partition(void)
>> +{
>> +	return hv_curr_partition_type == HV_PARTITION_TYPE_ROOT;
>> +}
>> +
>>  #endif
>> --
>> 2.34.1


