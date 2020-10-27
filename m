Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579D29ACDD
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 14:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900472AbgJ0NKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 09:10:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44610 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900470AbgJ0NKJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 09:10:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id t9so1813330wrq.11;
        Tue, 27 Oct 2020 06:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtZX6/ZvfrVqtGiiLvhIkr06J1sYIltZgSttNxNLSfs=;
        b=XoS5x/lQo2ah1bc6KyWJKkFONovDAAr5NiWWfz6j2IJXELKm7L+9svyDl+Vz7BbxHU
         7HY+jTXnqFzL6PvSyGrsrjiUvTQtXFskap8bJkcWDd68z4KLt0q7bnE7WaT5EFnYAdS0
         hXDF/46q8bwj6/Dlo8W6ClZQvTdsHy+i2MCH56ytH6cnABXR2/YPxGCgmmpHAaNzpC43
         FGH4BMN/lUKpbG8+x9G1oTJFFlj90KNeRcRFxRDXiNo41NykhY8I/JESm7g1fo5QlFHx
         q/QBj61QAbAY1rT4yBc1zy4u1kVpgLy7vkMaHp13p8WFgHCLERA0WqEmzfEB9wSXCsB/
         tsow==
X-Gm-Message-State: AOAM532KgK9PaWL++WtmYAfBHaaey5KVeKUoU9etVWepT2D16eLm/IPB
        aqGhT8BbJfrKRYkol6qkXoI=
X-Google-Smtp-Source: ABdhPJzg50k11PChe5swTDK8IzhMi8CDmrjLdnGHzXFFfKcX4sABHXXU22zSgaB52V8af0HQyEjZOg==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr2642129wrn.33.1603804205610;
        Tue, 27 Oct 2020 06:10:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c1sm1989908wru.49.2020.10.27.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:10:04 -0700 (PDT)
Date:   Tue, 27 Oct 2020 13:10:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
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
Subject: Re: [PATCH RFC v1 09/18] x86/hyperv: provide a bunch of helper
 functions
Message-ID: <20201027131003.wirign3evs73hoqi@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-1-wei.liu@kernel.org>
 <87sgbjjod4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgbjjod4.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 01:00:55PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > They are used to deposit pages into Microsoft Hypervisor and bring up
> > logical and virtual processors.
> >
> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/hyperv/Makefile          |   2 +-
> >  arch/x86/hyperv/hv_proc.c         | 209 ++++++++++++++++++++++++++++++
> >  arch/x86/include/asm/mshyperv.h   |   4 +
> >  include/asm-generic/hyperv-tlfs.h |  56 ++++++++
> >  4 files changed, 270 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/x86/hyperv/hv_proc.c
> >
> > diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> > index 89b1f74d3225..565358020921 100644
> > --- a/arch/x86/hyperv/Makefile
> > +++ b/arch/x86/hyperv/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-y			:= hv_init.o mmu.o nested.o
> > -obj-$(CONFIG_X86_64)	+= hv_apic.o
> > +obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> >  
> >  ifdef CONFIG_X86_64
> >  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> > diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> > new file mode 100644
> > index 000000000000..847c72465d0e
> > --- /dev/null
> > +++ b/arch/x86/hyperv/hv_proc.c
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/types.h>
> > +#include <linux/version.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/acpi.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/slab.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <asm/hypervisor.h>
> > +#include <asm/mshyperv.h>
> > +#include <asm/apic.h>
> > +
> > +#include <asm/trace/hyperv.h>
> > +
> > +#define HV_DEPOSIT_MAX_ORDER (8)
> > +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> > +
> > +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> > +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> 
> Nit: include/linux/kernel.h defines min() and max() macros with type
> checking.

Fixed.

> 
> > +
> > +/*
> > + * Deposits exact number of pages
> > + * Must be called with interrupts enabled
> > + * Max 256 pages
> > + */
> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> > +{
> > +	struct page **pages;
> > +	int *counts;
> > +	int num_allocations;
> > +	int i, j, page_count;
> > +	int order;
> > +	int desired_order;
> > +	int status;
> > +	int ret;
> > +	u64 base_pfn;
> > +	struct hv_deposit_memory *input_page;
> > +	unsigned long flags;
> > +
> > +	if (num_pages > HV_DEPOSIT_MAX)
> > +		return -EINVAL;
> > +	if (!num_pages)
> > +		return 0;
> > +
> > +	ret = -ENOMEM;
> > +
> > +	/* One buffer for page pointers and counts */
> > +	pages = page_address(alloc_page(GFP_KERNEL));
> > +	if (!pages)
> > +		goto free_buf;
> 
> There is nothing to free, just do 'return -ENOMEM' here;
> 
> > +	counts = (int *)&pages[256];
> > +
> 
> Oh this is weird. So 'pages' is an array of 512 'struct page *' items
> and we use its second half (pages[256]) for an array of signed(!)
> integers(!). Can we use a locally defined struct or something better for
> that?
> 

This can be changed. I will make the counts array have its own buffer.

> > +	/* Allocate all the pages before disabling interrupts */
> > +	num_allocations = 0;
> > +	i = 0;
> > +	order = HV_DEPOSIT_MAX_ORDER;
> > +
> > +	while (num_pages) {
> > +		/* Find highest order we can actually allocate */
> > +		desired_order = 31 - __builtin_clz(num_pages);
> > +		order = MIN(desired_order, order);
> > +		do {
> > +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> > +			if (!pages[i]) {
> > +				if (!order) {
> > +					goto err_free_allocations;
> > +				}
> > +				--order;
> > +			}
> > +		} while (!pages[i]);
> > +
> > +		split_page(pages[i], order);
> > +		counts[i] = 1 << order;
> > +		num_pages -= counts[i];
> > +		i++;
> 
> So here we believe we will never overrun the 2048 bytes we 'allocated'
> for 'counts' above. While 'if (num_pages > HV_DEPOSIT_MAX)' presumably
> guarantees that, this is not really obvious.
> 

This is moot since counts is going to have its own buffer allocated with
kcalloc(HV_DEPOSIT_MAX, sizeof(int), ...).

> > +		num_allocations++;
> > +	}
> > +
> > +	local_irq_save(flags);
> > +
> > +	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +	input_page->partition_id = partition_id;
> > +
> > +	/* Populate gpa_page_list - these will fit on the input page */
> > +	for (i = 0, page_count = 0; i < num_allocations; ++i) {
> > +		base_pfn = page_to_pfn(pages[i]);
> > +		for (j = 0; j < counts[i]; ++j, ++page_count)
> > +			input_page->gpa_page_list[page_count] = base_pfn + j;
> > +	}
> > +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> > +				     page_count, 0, input_page,
> > +				     NULL) & HV_HYPERCALL_RESULT_MASK;
> > +	local_irq_restore(flags);
> > +
> > +	if (status != HV_STATUS_SUCCESS) {
> 
> Nit: same like in one ov the previous patches, status can be 'u16'.
> 

Fixed.

> > +		pr_err("Failed to deposit pages: %d\n", status);
> > +		ret = status;
> > +		goto err_free_allocations;
> > +	}
> > +
> > +	ret = 0;
> > +	goto free_buf;
> > +
> > +err_free_allocations:
> > +	for (i = 0; i < num_allocations; ++i) {
> > +		base_pfn = page_to_pfn(pages[i]);
> > +		for (j = 0; j < counts[i]; ++j)
> > +			__free_page(pfn_to_page(base_pfn + j));
> > +	}
> > +
> > +free_buf:
> > +	free_page((unsigned long)pages);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> > +
> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> > +{
> > +	struct hv_add_logical_processor_in *input;
> > +	struct hv_add_logical_processor_out *output;
> > +	int status;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	do {
> > +		local_irq_save(flags);
> > +
> > +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +		/* We don't do anything with the output right now */
> > +		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +
> > +		input->lp_index = lp_index;
> > +		input->apic_id = apic_id;
> > +		input->flags = 0;
> > +		input->proximity_domain_info.domain_id = node_to_pxm(node);
> > +		input->proximity_domain_info.flags.reserved = 0;
> > +		input->proximity_domain_info.flags.proximity_info_valid = 1;
> > +		input->proximity_domain_info.flags.proximity_preferred = 1;
> > +		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
> > +					 input, output);
> > +		local_irq_restore(flags);
> > +
> > +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> > +			if (status != HV_STATUS_SUCCESS) {
> > +				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
> > +				       lp_index, apic_id, status);
> > +				ret = status;
> > +			}
> > +			break;
> 
> So if status == HV_STATUS_SUCCESS we break and avoid
> hv_call_deposit_pages() below?
> 

Yes, that means adding the logical processor has succeeded. There is
nothing more to do.

> > +		}
> > +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> > +
> > +	} while (!ret);
> 
> And if hv_call_deposit_pages() returns '0' we keep doing something? Sorry
> but I'm probably missing something important in the 'depositing'
> process, could you please add a comment explaining what's going on here?
> 

We only get here because 1) there isn't sufficient memory in the last
iteration, 2) we've succeeded in adding a bit more memory. In this case
we will want to retry adding the logical processor.

I will add a comment before the loop.

> > +
> > +	return ret;
> > +}
> > +
[...]
> > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> > index 87b1a79b19eb..2b05bed712c0 100644
> > --- a/include/asm-generic/hyperv-tlfs.h
> > +++ b/include/asm-generic/hyperv-tlfs.h
> > @@ -142,6 +142,8 @@ struct ms_hyperv_tsc_page {
> >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
> >  #define HVCALL_SEND_IPI_EX			0x0015
> >  #define HVCALL_GET_PARTITION_ID			0x0046
> > +#define HVCALL_DEPOSIT_MEMORY			0x0048
> > +#define HVCALL_CREATE_VP			0x004e
> >  #define HVCALL_GET_VP_REGISTERS			0x0050
> >  #define HVCALL_SET_VP_REGISTERS			0x0051
> >  #define HVCALL_POST_MESSAGE			0x005c
> > @@ -149,6 +151,7 @@ struct ms_hyperv_tsc_page {
> >  #define HVCALL_POST_DEBUG_DATA			0x0069
> >  #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
> >  #define HVCALL_RESET_DEBUG_SESSION		0x006b
> > +#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
> >  #define HVCALL_RETARGET_INTERRUPT		0x007e
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> > @@ -413,6 +416,59 @@ struct hv_get_partition_id {
> >  	u64 partition_id;
> >  } __packed;
> >  
> > +/* HvDepositMemory hypercall */
> > +struct hv_deposit_memory {
> > +	u64 partition_id;
> > +	u64 gpa_page_list[];
> > +};
> 
> Other structures above have '__packed' and I remember there were
> different opinions if it is needed or not (for properly padded
> structures). I'd suggest we stay consitent and keep adding it unless we
> decide to get rid of them (but you've added it to the newly introduced
> hv_get_partition_id above).

Fixed.

> > +
> > +
> > +struct hv_proximity_domain_flags {
> > +	u32 proximity_preferred : 1;
> > +	u32 reserved : 30;
> > +	u32 proximity_info_valid : 1;
> > +};
> > +
> > +/* Not a union in windows but useful for zeroing */
> > +union hv_proximity_domain_info {
> > +	struct {
> > +		u32 domain_id;
> > +		struct hv_proximity_domain_flags flags;
> > +	};
> > +	u64 as_uint64;
> > +};
> > +
> > +struct hv_lp_startup_status {
> > +	u64 hv_status;
> > +	u64 substatus1;
> > +	u64 substatus2;
> > +	u64 substatus3;
> > +	u64 substatus4;
> > +	u64 substatus5;
> > +	u64 substatus6;
> > +};
> > +
> > +/* HvAddLogicalProcessor hypercalls */
> 
> s/hypercalls/hypercall/

Fixed.

Wei.
