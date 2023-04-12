Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287A6DFA9B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDLPxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLPxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 11:53:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C10D5FEA;
        Wed, 12 Apr 2023 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681314789; x=1712850789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wg2flcIFH25W0H12ELsI6nR4EdOpohSK8WduP3JDHWE=;
  b=bt1qyM9pX6akb1noKf6QDiulEAHQV61kZHffrRh/3nqEG3YBMldA+kVV
   EPQl1bKmAWjxNP7eoelT4tBiKaCC90izzyZmJdG65ebNJ7tKm1poENaY9
   EYjQomX0pSJhRN9v3nC1YU0o2eUwYeXTBI/k4WwflHypyl9S2odzeyVQ1
   2WL3hxQMOF04fk91NY4bBVECn/VbbGaQ8PZUxdghMymsS8oHz6Fa5jwmZ
   T+GB2OYQZJy3U6wtAHorlCdCeFtiHJrOCBP4kNvk4fJLzaVRHZLur86XR
   /zhMPdiLfFQ6tj46cSuHV6JeKV6vFWIuINdmIoO8bUJtZAkHaZYEZ1DHz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="371788950"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="371788950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753578701"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753578701"
Received: from johnmusg-mobl.amr.corp.intel.com (HELO [10.255.230.24]) ([10.255.230.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:53:06 -0700
Message-ID: <8ef9b06b-33b5-c785-8aec-0fd765c91911@intel.com>
Date:   Wed, 12 Apr 2023 08:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230403174406.4180472-9-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/3/23 10:43, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Read processor amd memory info from specific address which are
> populated by Hyper-V. Initialize smp cpu related ops, pvalidate
> system memory and add it into e820 table.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 78 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 16 +++++++
>  arch/x86/kernel/cpu/mshyperv.c  |  3 ++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 368b2731950e..fa4de2761460 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -17,6 +17,11 @@
>  #include <asm/mem_encrypt.h>
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
> +#include <asm/coco.h>
> +#include <asm/io_apic.h>
> +#include <asm/sev.h>
> +#include <asm/realmode.h>
> +#include <asm/e820/api.h>
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
> @@ -57,6 +62,22 @@ union hv_ghcb {
>  
>  static u16 hv_ghcb_version __ro_after_init;
>  
> +static u32 processor_count;
> +
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	if (!early) {
> +		while (num_processors < processor_count) {
> +			early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
> +			early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
> +			physid_set(num_processors, phys_cpu_present_map);
> +			set_cpu_possible(num_processors, true);
> +			set_cpu_present(num_processors, true);
> +			num_processors++;
> +		}
> +	}
> +}

Folks, please minimize indentation:

	if (early)
		return;

It would also be nice to see *some* explanation in the changelog or
comments about why it's best and correct to just do nothing if early==1.

Also, this _consumes_ data from hv_sev_init_mem_and_cpu().  It would
make more sense to me to have them ordered the other way.
hv_sev_init_mem_and_cpu() first, this second.

>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
>  {
>  	union hv_ghcb *hv_ghcb;
> @@ -356,6 +377,63 @@ static bool hv_is_private_mmio(u64 addr)
>  	return false;
>  }
>  
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
> +	 * directly without bootloader and so roms,
> +	 * bios regions and reserve resources are not
> +	 * available. Set these callback to NULL.
> +	 */
> +	x86_platform.legacy.reserve_bios_regions = 0;
> +	x86_init.resources.probe_roms = x86_init_noop;
> +	x86_init.resources.reserve_resources = x86_init_noop;
> +	x86_init.mpparse.find_smp_config = x86_init_noop;
> +	x86_init.mpparse.get_smp_config = hv_snp_get_smp_config;

This is one of those places that vertical alignment adds clarity:

> +	x86_init.resources.probe_roms	     = x86_init_noop;
> +	x86_init.resources.reserve_resources = x86_init_noop;
> +	x86_init.mpparse.find_smp_config     = x86_init_noop;
> +	x86_init.mpparse.get_smp_config      = hv_snp_get_smp_config;

See? 3 noops and only one actual implemented function.  Clear as day now.

> +	/*> +	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +	 * and legacy APIC page read/write. Switch to hv apic here.
> +	 */
> +	disable_ioapic_support();

Do these systems have X86_FEATURE_APIC set?  Why is this needed in
addition to the architectural enumeration that already exists?

Is there any other place in the kernel that has this one-off disabling
of the APIC?

> +	/* Read processor number and memory layout. */
> +	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> +	entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
> +			+ sizeof(struct memory_map_entry));

Ick.

There are a lot of ways to do this.  But, this is an awfully ugly way.

struct snp_processor_info {
	u32 processor_count;
	struct memory_map_entry[] entries;
}

struct snp_processor_info *snp_pi =
				__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
processor_count = snp_pi->processor_count;

Then, have your for() loop through snp_pi->entries;

Actually, I'm not _quite_ sure that processor_count and entries are next
to each other.  But, either way, I do think a struct makes sense.

Also, what guarantees that EN_SEV_SNP_PROCESSOR_INFO_ADDR is mapped?
It's up above 8MB which I don't remember off the top of my head as being
a special address.

> +	/*
> +	 * E820 table in the memory just describes memory for
> +	 * kernel, ACPI table, cmdline, boot params and ramdisk.
> +	 * Hyper-V popoulates the rest memory layout in the EN_SEV_
> +	 * SNP_PROCESSOR_INFO_ADDR.
> +	 */

Really?  That is not very cool.  We need a better explanation of why
there was no way to use the decades-old e820 or EFI memory map and why
this needs to be a special snowflake.

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

Oh, is this just about having a pre-accepted area and a non-accepted
area?  Is this basically another one-off implementation of unaccepted
memory ... that doesn't use the EFI standard?

>  void __init hv_vtom_init(void)
>  {
>  	/*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 3c15e23162e7..a4a59007b5f2 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -41,6 +41,20 @@ extern bool hv_isolation_type_en_snp(void);
>  
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
> +/*
> + * Hyper-V puts processor and memory layout info
> + * to this address in SEV-SNP enlightened guest.
> + */
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR 0x802000
> +
> +struct memory_map_entry {
> +	u64 starting_gpn;
> +	u64 numpages;
> +	u16 type;
> +	u16 flags;
> +	u32 reserved;
> +};
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -246,12 +260,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
>  bool hv_ghcb_negotiate_protocol(void);
>  void hv_ghcb_terminate(unsigned int set, unsigned int reason);
>  void hv_vtom_init(void);
> +void hv_sev_init_mem_and_cpu(void);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
>  static inline void hv_vtom_init(void) {}
> +static inline void hv_sev_init_mem_and_cpu(void) {}
>  #endif
>  
>  extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 2f2dcb2370b6..71820bbf9e90 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -529,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>  
> +	if (hv_isolation_type_en_snp())
> +		hv_sev_init_mem_and_cpu();
> +
>  	hardlockup_detector_disable();
>  }
>  

