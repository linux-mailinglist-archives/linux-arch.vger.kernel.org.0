Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21AE2B091A
	for <lists+linux-arch@lfdr.de>; Thu, 12 Nov 2020 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgKLP54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Nov 2020 10:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgKLP5z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Nov 2020 10:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605196672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMsslzB60p6fE68DmvMliK7UF+Lv8JTCHb2KCVlluDo=;
        b=X8iVyYW+O1zEN/3p7JLy+/WC4hDcMzF1uu4xYPGo9ikgUXYCA/QxOeqJ9OtpVi2UFtMImg
        qVbL28At7YKGN+36f5chL7ucN+1QzC1VX8w9IA9SPIJkTiY24X9l5oUJe2XZy4IXPZwZGC
        ZvFwS3Hfr+8q9bVsT2oz3xyqCi7GM3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-Yokv1--fOpaszOlPYeCc0w-1; Thu, 12 Nov 2020 10:57:51 -0500
X-MC-Unique: Yokv1--fOpaszOlPYeCc0w-1
Received: by mail-wr1-f70.google.com with SMTP id x16so2097906wrg.7
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2020 07:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eMsslzB60p6fE68DmvMliK7UF+Lv8JTCHb2KCVlluDo=;
        b=fLzNlvcyjcnK6t61tKOKMcfCP22eY9cnYHdBxdj8tjQFDfhIbFrrsn9EETnGtBhF2R
         wfDfzHm8AYWbsExMH+K/uasbBtZvVf9D4HPbOhEeHJPPkVjHCJq7Yd7tN4P0as0skQnf
         6EPCOMqavoCp4F5350Y48KsnVJ1mJzCixw6oaK0VdnvLpDWIbT1t3j+//fMTDQi7Kv9r
         njbWtLYPZrQJMd6/xx8ZKfMCMDRPeY52gGSaQsgJ9kl69NeWlsDGvM3KTmk2sg46on5K
         DnnE9W+OUlNPRoWDHsoqck/sDut+XAcUiEIq+d2xhlEHfQRNnPpxL0uV6Z/bvUuCukt/
         +HNA==
X-Gm-Message-State: AOAM531I+Wx7bWCrsBWSH0iJ0h0uo/pEwvYhJNIq4/dcQs34pQm19igm
        z8gD9rw9GFMbJ9dLMaTSpHieqnyTLAN+RXundcFlJAKjNcJspVMbjWTyIXAilYKQ1PIT/fti55Z
        IUZ3RKNlWvGaFCrRbYa9XicWl5eBt372EbCdCosczuggCQ0QJ/+cmeDI/HpsUtP2G5bHoKW5ZtA
        ==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr164865wrv.329.1605196669304;
        Thu, 12 Nov 2020 07:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxS8FL/rGWLRebjIj5BO7JLYQfEAyrXlJE2ouC3hPEX/lKUkClC2UxnLRmwJKF6B+Q3NpRgSA==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr164816wrv.329.1605196668951;
        Thu, 12 Nov 2020 07:57:48 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x81sm7556334wmg.5.2020.11.12.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:57:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
In-Reply-To: <20201105165814.29233-10-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:57:46 +0100
Message-ID: <871rgyy3d1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2:
> 1. Adapt to hypervisor side changes
> 2. Address Vitaly's comments
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 217 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  67 +++++++++
>  4 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/hv_proc.c
>
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 89b1f74d3225..565358020921 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:= hv_init.o mmu.o nested.o
> -obj-$(CONFIG_X86_64)	+= hv_apic.o
> +obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
>  
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> new file mode 100644
> index 000000000000..0fd972c9129a
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clockchips.h>
> +#include <linux/acpi.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/minmax.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +
> +#include <asm/trace/hyperv.h>
> +
> +#define HV_DEPOSIT_MAX_ORDER (8)
> +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> +
> +/*
> + * Deposits exact number of pages
> + * Must be called with interrupts enabled
> + * Max 256 pages
> + */
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	struct page **pages;
> +	int *counts;
> +	int num_allocations;
> +	int i, j, page_count;
> +	int order;
> +	int desired_order;
> +	u16 status;
> +	int ret;
> +	u64 base_pfn;
> +	struct hv_deposit_memory *input_page;
> +	unsigned long flags;
> +
> +	if (num_pages > HV_DEPOSIT_MAX)
> +		return -E2BIG;
> +	if (!num_pages)
> +		return 0;
> +
> +	/* One buffer for page pointers and counts */
> +	pages = page_address(alloc_page(GFP_KERNEL));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
> +	if (!counts) {
> +		free_page((unsigned long)pages);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate all the pages before disabling interrupts */
> +	num_allocations = 0;
> +	i = 0;
> +	order = HV_DEPOSIT_MAX_ORDER;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		desired_order = 31 - __builtin_clz(num_pages);
> +		order = min(desired_order, order);
> +		do {
> +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> +			if (!pages[i]) {
> +				if (!order) {
> +					ret = -ENOMEM;
> +					goto err_free_allocations;
> +				}
> +				--order;
> +			}
> +		} while (!pages[i]);
> +
> +		split_page(pages[i], order);
> +		counts[i] = 1 << order;
> +		num_pages -= counts[i];
> +		i++;
> +		num_allocations++;
> +	}
> +
> +	local_irq_save(flags);
> +
> +	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	input_page->partition_id = partition_id;
> +
> +	/* Populate gpa_page_list - these will fit on the input page */
> +	for (i = 0, page_count = 0; i < num_allocations; ++i) {
> +		base_pfn = page_to_pfn(pages[i]);
> +		for (j = 0; j < counts[i]; ++j, ++page_count)
> +			input_page->gpa_page_list[page_count] = base_pfn + j;
> +	}
> +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> +				     page_count, 0, input_page,
> +				     NULL) & HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("Failed to deposit pages: %d\n", status);
> +		ret = status;
> +		goto err_free_allocations;
> +	}
> +
> +	ret = 0;
> +	goto free_buf;
> +
> +err_free_allocations:
> +	for (i = 0; i < num_allocations; ++i) {
> +		base_pfn = page_to_pfn(pages[i]);
> +		for (j = 0; j < counts[i]; ++j)
> +			__free_page(pfn_to_page(base_pfn + j));
> +	}
> +
> +free_buf:
> +	free_page((unsigned long)pages);
> +	kfree(counts);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> +
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> +{
> +	struct hv_add_logical_processor_in *input;
> +	struct hv_add_logical_processor_out *output;
> +	int status;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/*
> +	 * When adding a logical processor, the hypervisor may return
> +	 * HV_STATUS_INSUFFICIENT_MEMORY. When that happens, we deposit more
> +	 * pages and retry.
> +	 */
> +	do {
> +		local_irq_save(flags);
> +
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		/* We don't do anything with the output right now */
> +		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		input->lp_index = lp_index;
> +		input->apic_id = apic_id;
> +		input->flags = 0;
> +		input->proximity_domain_info.domain_id = node_to_pxm(node);
> +		input->proximity_domain_info.flags.reserved = 0;
> +		input->proximity_domain_info.flags.proximity_info_valid = 1;
> +		input->proximity_domain_info.flags.proximity_preferred = 1;
> +		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
> +					 input, output);
> +		local_irq_restore(flags);
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status != HV_STATUS_SUCCESS) {
> +				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
> +				       lp_index, apic_id, status);
> +				ret = status;
> +			}
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> +{
> +	struct hv_create_vp *input;
> +	u16 status;
> +	unsigned long irq_flags;
> +	int ret = 0;
> +
> +	/* Root VPs don't seem to need pages deposited */
> +	if (partition_id != hv_current_partition_id) {
> +		ret = hv_call_deposit_pages(node, partition_id, 90);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	do {
> +		local_irq_save(irq_flags);
> +
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		input->partition_id = partition_id;
> +		input->vp_index = vp_index;
> +		input->flags = flags;
> +		input->subnode_type = HvSubnodeAny;
> +		if (node != NUMA_NO_NODE) {
> +			input->proximity_domain_info.domain_id = node_to_pxm(node);
> +			input->proximity_domain_info.flags.reserved = 0;
> +			input->proximity_domain_info.flags.proximity_info_valid = 1;
> +			input->proximity_domain_info.flags.proximity_preferred = 1;
> +		} else {
> +			input->proximity_domain_info.as_uint64 = 0;
> +		}
> +		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status != HV_STATUS_SUCCESS) {
> +				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
> +				       vp_index, flags, status);
> +				ret = status;
> +			}
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(node, partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_call_create_vp);
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 67f5d35a73d3..4e590a167160 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  extern u64 hv_current_partition_id;
>  
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);

You seem to be only doing EXPORT_SYMBOL_GPL() for
hv_call_deposit_pages() and hv_call_create_vp() but not for
hv_call_add_logical_proc() - is this intended? Also, I don't see
hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?

> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 87b1a79b19eb..b6c74e1a5524 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -142,6 +142,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
>  #define HVCALL_GET_PARTITION_ID			0x0046
> +#define HVCALL_DEPOSIT_MEMORY			0x0048
> +#define HVCALL_CREATE_VP			0x004e
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -149,6 +151,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_POST_DEBUG_DATA			0x0069
>  #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
>  #define HVCALL_RESET_DEBUG_SESSION		0x006b
> +#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> @@ -413,6 +416,70 @@ struct hv_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>  
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_proximity_domain_flags {
> +	u32 proximity_preferred : 1;
> +	u32 reserved : 30;
> +	u32 proximity_info_valid : 1;
> +};
> +
> +/* Not a union in windows but useful for zeroing */
> +union hv_proximity_domain_info {
> +	struct {
> +		u32 domain_id;
> +		struct hv_proximity_domain_flags flags;
> +	};
> +	u64 as_uint64;
> +};
> +
> +struct hv_lp_startup_status {
> +	u64 hv_status;
> +	u64 substatus1;
> +	u64 substatus2;
> +	u64 substatus3;
> +	u64 substatus4;
> +	u64 substatus5;
> +	u64 substatus6;
> +};
> +
> +/* HvAddLogicalProcessor hypercall */
> +struct hv_add_logical_processor_in {
> +	u32 lp_index;
> +	u32 apic_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};
> +
> +struct hv_add_logical_processor_out {
> +	struct hv_lp_startup_status startup_status;
> +};
> +
> +enum HV_SUBNODE_TYPE
> +{
> +    HvSubnodeAny = 0,
> +    HvSubnodeSocket,
> +    HvSubnodeAmdNode,
> +    HvSubnodeL3,
> +    HvSubnodeCount,
> +    HvSubnodeInvalid = -1
> +};
> +
> +/* HvCreateVp hypercall */
> +struct hv_create_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 padding[3];
> +	u8 subnode_type;
> +	u64 subnode_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};

You add '__packed' to 'struct hv_deposit_memory' but not to 'struct
hv_create_vp'/'struct hv_add_logical_processor_in', this looks
inconsistent.

> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

