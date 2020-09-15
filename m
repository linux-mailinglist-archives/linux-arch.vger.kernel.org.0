Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61B926A3E3
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgIOLJn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 07:09:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbgIOLJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 07:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600168153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guiS9knUyp96zieB7cvAHcyvDidqbqv5BAVHFJQmDkg=;
        b=bndapW7vjR49TGm/iVA0kRWZayOnyoenAuivxlS6scsW780KGd3gJcgg3Vr8n+ySWXEzjP
        VA4saFu1+XWTJhb0y3F25EaPYmy8LrjA/gjDjqPzRXIEezJT7sym8Uh/SF9BFGMzpzBg/t
        hMi7V2z8YQTgMxWu4C70R4vkmfyfdKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-SFrPxHvKOhOQsiwn75FB7A-1; Tue, 15 Sep 2020 07:00:59 -0400
X-MC-Unique: SFrPxHvKOhOQsiwn75FB7A-1
Received: by mail-wr1-f71.google.com with SMTP id v5so1066559wrs.17
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 04:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=guiS9knUyp96zieB7cvAHcyvDidqbqv5BAVHFJQmDkg=;
        b=FL1GpokmV0P1+cr4DWeXHTE8fTaD8ZexSHzPBVGCe3JbffwHLaMAQOM4V9INXg4YdI
         JO5M3PqpHzTHAnpDFam5Jagj5y8yjaDlauJZsw9Lp1eb2K+Nx/MtgNr4MMExhiU5a2BK
         YhbzQw39tfsxgjQlU8H5RtZ7xM+56lUj7ta4Jm8bOryVxFdu6uNbiFKviLin1YC/7Rct
         VN+dcMXLdsCinTwSyzkMmh3hal59Gu8sStqlpAvZwdhWQv6fgLjQbEis/kZ/OXOx1O5S
         r8/NodWYGbBpFoBD+mOtrYZsk0D0sVSt0NXefGPScVQgyw3ITKRVf21sY2I6m5Wxqn1+
         J/Ng==
X-Gm-Message-State: AOAM533iQnxW4hmhQtMXmdDdStPpk/3ala2BTgzLMBKkNs132VLvm945
        wEilRQ6IB2u+nrdcnLWJCTlQZNTwFD+iVb6jHiY317qOPfRRSwz0g0wq8L1dFKYc+uJWmRsR5F0
        bj85DBYDZ/4HWyFCxmraB7Q==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20201566wru.137.1600167657335;
        Tue, 15 Sep 2020 04:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCkmaofZgQSVXb+OS8Si/lFoB6TPt66RmLSK2FDOqjVL1SWHCcz8BvjMum4MfFHmsxG9nOFQ==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20201518wru.137.1600167656991;
        Tue, 15 Sep 2020 04:00:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b76sm25426505wme.45.2020.09.15.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:00:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list\:GENERIC INCLUDE\/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v1 09/18] x86/hyperv: provide a bunch of helper functions
In-Reply-To: <20200914115928.83184-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914115928.83184-1-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 13:00:55 +0200
Message-ID: <87sgbjjod4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 209 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  56 ++++++++
>  4 files changed, 270 insertions(+), 1 deletion(-)
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
> index 000000000000..847c72465d0e
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -0,0 +1,209 @@
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
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +
> +#include <asm/trace/hyperv.h>
> +
> +#define HV_DEPOSIT_MAX_ORDER (8)
> +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> +
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))

Nit: include/linux/kernel.h defines min() and max() macros with type
checking.

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
> +	int status;
> +	int ret;
> +	u64 base_pfn;
> +	struct hv_deposit_memory *input_page;
> +	unsigned long flags;
> +
> +	if (num_pages > HV_DEPOSIT_MAX)
> +		return -EINVAL;
> +	if (!num_pages)
> +		return 0;
> +
> +	ret = -ENOMEM;
> +
> +	/* One buffer for page pointers and counts */
> +	pages = page_address(alloc_page(GFP_KERNEL));
> +	if (!pages)
> +		goto free_buf;

There is nothing to free, just do 'return -ENOMEM' here;

> +	counts = (int *)&pages[256];
> +

Oh this is weird. So 'pages' is an array of 512 'struct page *' items
and we use its second half (pages[256]) for an array of signed(!)
integers(!). Can we use a locally defined struct or something better for
that?

> +	/* Allocate all the pages before disabling interrupts */
> +	num_allocations = 0;
> +	i = 0;
> +	order = HV_DEPOSIT_MAX_ORDER;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		desired_order = 31 - __builtin_clz(num_pages);
> +		order = MIN(desired_order, order);
> +		do {
> +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> +			if (!pages[i]) {
> +				if (!order) {
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

So here we believe we will never overrun the 2048 bytes we 'allocated'
for 'counts' above. While 'if (num_pages > HV_DEPOSIT_MAX)' presumably
guarantees that, this is not really obvious.

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

Nit: same like in one ov the previous patches, status can be 'u16'.

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

So if status == HV_STATUS_SUCCESS we break and avoid
hv_call_deposit_pages() below?

> +		}
> +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +
> +	} while (!ret);

And if hv_call_deposit_pages() returns '0' we keep doing something? Sorry
but I'm probably missing something important in the 'depositing'
process, could you please add a comment explaining what's going on here?

> +
> +	return ret;
> +}
> +
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> +{
> +	struct hv_create_vp *input;
> +	int status;
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
> index 4039302e0ae9..60afc3e417d0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -67,6 +67,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  extern u64 hv_current_partition_id;
>  
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 87b1a79b19eb..2b05bed712c0 100644
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
> @@ -413,6 +416,59 @@ struct hv_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>  
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +};

Other structures above have '__packed' and I remember there were
different opinions if it is needed or not (for properly padded
structures). I'd suggest we stay consitent and keep adding it unless we
decide to get rid of them (but you've added it to the newly introduced
hv_get_partition_id above).
> +
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
> +/* HvAddLogicalProcessor hypercalls */

s/hypercalls/hypercall/

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
> +/* HvCreateVp hypercall */
> +struct hv_create_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 padding;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

