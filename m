Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738F762A4F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 06:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjGZE2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGZE1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 00:27:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A22082D48;
        Tue, 25 Jul 2023 21:26:52 -0700 (PDT)
Received: from [10.171.20.65] (unknown [167.220.238.65])
        by linux.microsoft.com (Postfix) with ESMTPSA id 828E22380B17;
        Tue, 25 Jul 2023 21:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 828E22380B17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690345612;
        bh=eSSFE37BQmdV3L+lRN6zp4WJzj2Rij++NeZzBS9Ss18=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NUbkG6N/qUDaTVwL9jnj7ui1eZdAUrlBVfgO9lR4L4yeg6xMsLL+Mke/nHxZAIWwe
         LMTsUWfsjCwmyBGhvkOh85DG1KQECCboYHoQTuMQwEop/imCW01vVXFQzfGk/gDLcp
         7xCt93YJAuZOfKXJpuXDmP3NGKu/RPKcC0moGjPg=
Message-ID: <4d0715a5-70a8-9667-ccf0-de9bc933bb04@linux.microsoft.com>
Date:   Wed, 26 Jul 2023 09:56:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-8-ltykernel@gmail.com>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <20230718032304.136888-8-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

On 7/18/2023 8:53 AM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
>
> Hyper-V enlightened guest doesn't have boot loader support.
> Boot Linux kernel directly from hypervisor with data (kernel
> image, initrd and parameter page) and memory for boot up that
> is initialized via AMD SEV PSP protocol (Please reference
> Section 4.5 Launching a Guest of [1]).
>
> Kernel needs to read processor and memory info from EN_SEV_
> SNP_PROCESSOR/MEM_INFO_ADDR address which are populated by
> Hyper-V. The data is prepared by hypervisor via SNP_
> LAUNCH_UPDATE with page type SNP_PAGE_TYPE_UNMEASURED and
> Initialize smp cpu related ops, validate system memory and
> add them into e820 table.
>
> [1]: https://www.amd.com/system/files/TechDocs/56860.pdf
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since v2:
> 	* Update change log.
> ---
>   arch/x86/hyperv/ivm.c           | 93 +++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/mshyperv.h | 17 ++++++
>   arch/x86/kernel/cpu/mshyperv.c  |  3 ++
>   3 files changed, 113 insertions(+)
>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index b2b5cb19fac9..ede47c8264e0 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -18,6 +18,11 @@
>   #include <asm/mshyperv.h>
>   #include <asm/hypervisor.h>
>   #include <asm/mtrr.h>
> +#include <asm/coco.h>
> +#include <asm/io_apic.h>
> +#include <asm/sev.h>
> +#include <asm/realmode.h>
> +#include <asm/e820/api.h>
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   
> @@ -58,6 +63,8 @@ union hv_ghcb {
>   
>   static u16 hv_ghcb_version __ro_after_init;
>   
> +static u32 processor_count;
> +
>   u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
>   {
>   	union hv_ghcb *hv_ghcb;
> @@ -357,6 +364,92 @@ static bool hv_is_private_mmio(u64 addr)
>   	return false;
>   }
>   
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	/*
> +	 * The "early" parameter can be true only if old-style AMD
> +	 * Opteron NUMA detection is enabled, which should never be
> +	 * the case for an SEV-SNP guest.  See CONFIG_AMD_NUMA.
> +	 * For safety, just do nothing if "early" is true.
> +	 */
> +	if (early)
> +		return;
> +
> +	/*
> +	 * There is no firmware and ACPI MADT table support in
> +	 * in the Hyper-V SEV-SNP enlightened guest. Set smp
> +	 * related config variable here.
> +	 */
> +	while (num_processors < processor_count) {
> +		early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
> +		early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
> +		physid_set(num_processors, phys_cpu_present_map);
> +		set_cpu_possible(num_processors, true);
> +		set_cpu_present(num_processors, true);
> +		num_processors++;
> +	}
> +}
> +
> +__init void hv_sev_init_mem_and_cpu(void)
> +{
> +	struct memory_map_entry *entry;
> +	struct e820_entry *e820_entry;
> +	u64 e820_end;
> +	u64 ram_end;
> +	u64 page;
> +
> +	/*
> +	 * Hyper-V enlightened snp guest boots kernel
> +	 * directly without bootloader. So roms, bios
> +	 * regions and reserve resources are not available.
> +	 * Set these callback to NULL.
> +	 */
> +	x86_platform.legacy.rtc			= 0;
> +	x86_platform.legacy.reserve_bios_regions = 0;
> +	x86_platform.set_wallclock		= set_rtc_noop;
> +	x86_platform.get_wallclock		= get_rtc_noop;
> +	x86_init.resources.probe_roms		= x86_init_noop;
> +	x86_init.resources.reserve_resources	= x86_init_noop;
> +	x86_init.mpparse.find_smp_config	= x86_init_noop;
> +	x86_init.mpparse.get_smp_config		= hv_snp_get_smp_config;
> +
> +	/*
> +	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +	 * and legacy APIC page read/write. Switch to hv apic here.
> +	 */
> +	disable_ioapic_support();

Where are we switching hv_apic? May I am missing something here?

Also in my experiments I have seen that if we don't enable I/O Apic 
legacy serial console does not seem to work for SEV-SNP guests.

> +
> +	/* Get processor and mem info. */
> +	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> +	entry = (struct memory_map_entry *)__va(EN_SEV_SNP_MEM_INFO_ADDR);
> +
> +	/*
> +	 * There is no bootloader/EFI firmware in the SEV SNP guest.
> +	 * E820 table in the memory just describes memory for kernel,
> +	 * ACPI table, cmdline, boot params and ramdisk. The dynamic
> +	 * data(e.g, vcpu number and the rest memory layout) needs to
> +	 * be read from EN_SEV_SNP_PROCESSOR_INFO_ADDR.
> +	 */
> +	for (; entry->numpages != 0; entry++) {
> +		e820_entry = &e820_table->entries[
> +				e820_table->nr_entries - 1];
> +		e820_end = e820_entry->addr + e820_entry->size;
> +		ram_end = (entry->starting_gpn +
> +			   entry->numpages) * PAGE_SIZE;
> +
> +		if (e820_end < entry->starting_gpn * PAGE_SIZE)
> +			e820_end = entry->starting_gpn * PAGE_SIZE;
> +
> +		if (e820_end < ram_end) {
> +			pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
> +			e820__range_add(e820_end, ram_end - e820_end,
> +					E820_TYPE_RAM);
> +			for (page = e820_end; page < ram_end; page += PAGE_SIZE)
> +				pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
> +		}
> +	}
> +}
> +
>   void __init hv_vtom_init(void)
>   {
>   	/*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 025eda129d99..e57df590846a 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -50,6 +50,21 @@ extern bool hv_isolation_type_en_snp(void);
>   
>   extern union hv_ghcb * __percpu *hv_ghcb_pg;
>   
> +/*
> + * Hyper-V puts processor and memory layout info
> + * to this address in SEV-SNP enlightened guest.
> + */
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR  0x802000
> +#define EN_SEV_SNP_MEM_INFO_ADDR	0x802018
> +
> +struct memory_map_entry {
> +	u64 starting_gpn;
> +	u64 numpages;
> +	u16 type;
> +	u16 flags;
> +	u32 reserved;
> +};
> +
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>   int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -234,12 +249,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
>   bool hv_ghcb_negotiate_protocol(void);
>   void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
>   void hv_vtom_init(void);
> +void hv_sev_init_mem_and_cpu(void);
>   #else
>   static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>   static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
>   static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>   static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
>   static inline void hv_vtom_init(void) {}
> +static inline void hv_sev_init_mem_and_cpu(void) {}
>   #endif
>   
>   extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 5398fb2f4d39..d3bb921ee7fe 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -529,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
>   	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>   		mark_tsc_unstable("running on Hyper-V");
>   
> +	if (hv_isolation_type_en_snp())
> +		hv_sev_init_mem_and_cpu();
> +
>   	hardlockup_detector_disable();
>   }
>   

Regards,

Jinank

