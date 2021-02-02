Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079E30C56A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhBBQWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 11:22:19 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39412 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhBBQUO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 11:20:14 -0500
Received: by mail-wr1-f50.google.com with SMTP id a1so21107387wrq.6;
        Tue, 02 Feb 2021 08:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JrLCgdivBEVmDMdcQ1NaQdm7/SMoJr7CgaCLRpH7NnQ=;
        b=Nt2aiiTn+h/wvPtrZyaNastl1dz3lkHfJvWm4EYOKtnL+0ky2gQK/VSAz4VFe3EXfp
         tH3Eh8OZzDh4WK/sPEZ8W+dBMZpkks31uM2LyOd4P/w5zzYbkp8afdGgJSs4ZaYrCtpS
         f5OHXxtDg45pz/n8B0tKJ6XMnuEmFTlMewnjgbJDEp9qYzBb48ps4Af9N1wh7Mg2LcwE
         J6GQOSta4mmqHVgiA6ifU7P9qPhGBXDOY681ESk2NA0RaoiJ52VVmO5bT9wL9IxAnPcD
         ZOGahEvGpC/BWZfnR5OESEnTjxKcpRfdHVO1Kn69/Bta1ewvd3yeJ0hX3Hv6XwLSsbVU
         bG9Q==
X-Gm-Message-State: AOAM5312zKnJlFKiCaLNapplSQt9rDKOnQWef8/g5hfW+8KW4HC2f7RH
        H5bKcpvNWYK+OAJeZexLaL8=
X-Google-Smtp-Source: ABdhPJy7iW6ZS9n503ZkvhBbOnNym4MUcukxoE0RKb3+SODK4A9ORJxzgS7DaLSL70IouwQL/uFSCg==
X-Received: by 2002:adf:d0d2:: with SMTP id z18mr25511772wrh.70.1612282769948;
        Tue, 02 Feb 2021 08:19:29 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t197sm4640600wmt.3.2021.02.02.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:29 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:19:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 09/16] x86/hyperv: provide a bunch of helper functions
Message-ID: <20210202161928.vqth7u7ohpk6mykc@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-10-wei.liu@kernel.org>
 <MWHPR21MB159390266F2172D12FEBBDD8D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159390266F2172D12FEBBDD8D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 26, 2021 at 01:20:36AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
[...]
> > +#include <asm/trace/hyperv.h>
> > +
> > +#define HV_DEPOSIT_MAX_ORDER (8)
> > +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> 
> Is there any reason to not let the maximum be 511, which is
> how many entries will fit on the hypercall input page?  The
> max could be define in terms of HY_HYP_PAGE_SIZE so that
> the logical dependency is fully expressed.  

Let me try changing this. This file is largely authored by Lilian and
Nuno. I don't see a particular reason why the value can't be larger.

I've updated the value to the following.

/*
 * See struct hv_deposit_memory. The first u64 is partition ID, the rest
 * are GPAs.
 */
#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)

Let's see how that goes. I will test it once I fix other places.

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
> > +	u16 status;
> > +	int ret;
> > +	u64 base_pfn;
> > +	struct hv_deposit_memory *input_page;
> > +	unsigned long flags;
> > +
> > +	if (num_pages > HV_DEPOSIT_MAX)
> > +		return -E2BIG;
> > +	if (!num_pages)
> > +		return 0;
> > +
> > +	/* One buffer for page pointers and counts */
> > +	pages = page_address(alloc_page(GFP_KERNEL));
> > +	if (!pages)
> 
> Does the above check work?  If alloc_pages() returns NULL, it looks like
> page_address() might fault.
> 

Good catch. Fixed.

> > +		return -ENOMEM;
> > +
> > +	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
> > +	if (!counts) {
> > +		free_page((unsigned long)pages);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Allocate all the pages before disabling interrupts */
> > +	num_allocations = 0;
> > +	i = 0;
> > +	order = HV_DEPOSIT_MAX_ORDER;
> > +
> > +	while (num_pages) {
> > +		/* Find highest order we can actually allocate */
> > +		desired_order = 31 - __builtin_clz(num_pages);
> > +		order = min(desired_order, order);
> 
> The above seems redundant since request sizes larger than the
> max have already been rejected.
> 

min(...) can be dropped.

> > +		do {
> > +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> > +			if (!pages[i]) {
> > +				if (!order) {
> > +					ret = -ENOMEM;
> > +					goto err_free_allocations;
> > +				}
> > +				--order;
> > +			}
> > +		} while (!pages[i]);
> 
> The duplicative test of !pages[i] is somewhat annoying.  How about
> this:
> 
> 		while{!pages[i] = alloc_pages_node(node, GFP_KERNEL, order) {
> 			if (!order) {
> 				ret = -ENOMEM;
> 				goto err_free_allocations;
> 			}
> 			--order;
> 		}
> 
> or if you don't like doing an assignment in the while test:
> 
> 		while(1) {
> 			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> 			if (page[i])
> 				break;
> 			if (!order) {
> 				ret = -ENOMEM;
> 				goto err_free_allocations;
> 			}
> 			--order;
> 		}
> 

I will use this variant.

> > +
> > +		split_page(pages[i], order);
> > +		counts[i] = 1 << order;
> > +		num_pages -= counts[i];
> > +		i++;
> > +		num_allocations++;
> 
> Incrementing both I and num_allocations in the loop seems
> redundant, especially since num_allocations isn't used in the loop.
> Could num_allocations be assigned the value of i once the loop
> is exited?  (and num_allocations would not need to be initialized to 0.) 
> Would also have to do the assignment in the error case.
> 

Yes. That can be done.

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
> 
> Similar comment about how hypercall status is checked.
> 

Fixed.

> > +	local_irq_restore(flags);
> > +
> > +	if (status != HV_STATUS_SUCCESS) {
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
> > +	kfree(counts);
> > +	return ret;
> > +}
> > +
> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> > +{
> > +	struct hv_add_logical_processor_in *input;
> > +	struct hv_add_logical_processor_out *output;
> > +	int status;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +#ifdef CONFIG_ACPI_NUMA
> > +	int pxm = node_to_pxm(node);
> > +#else
> > +	int pxm = 0;
> > +#endif
> 
> It seems like the above #ifdef'ery might be better fixed in
> include/acpi/acpi_numa.h, where there's already a null definition
> of pxm_to_node() in case CONFIG_ACPI_NUMA isn't defined.  There
> should also be a null definition of node_to_pxm() in that file.
> 

Sure.

> > +
> > +	/*
> > +	 * When adding a logical processor, the hypervisor may return
> > +	 * HV_STATUS_INSUFFICIENT_MEMORY. When that happens, we deposit more
> > +	 * pages and retry.
> > +	 */
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
> > +		input->proximity_domain_info.domain_id = pxm;
> > +		input->proximity_domain_info.flags.reserved = 0;
> > +		input->proximity_domain_info.flags.proximity_info_valid = 1;
> > +		input->proximity_domain_info.flags.proximity_preferred = 1;
> > +		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
> > +					 input, output);
> > +		local_irq_restore(flags);
> > +
> > +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> 
> The 'and' with HV_HYPERCALL_RESULT_MASK isn't coded anywhere for this
> hypercall, and 'status' is declared as 'int'.
> 

Fixed.

> > +			if (status != HV_STATUS_SUCCESS) {
> > +				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
> > +				       lp_index, apic_id, status);
> > +				ret = status;
> > +			}
> > +			break;
> > +		}
> > +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> > +	} while (!ret);
> > +
> > +	return ret;
> > +}
> > +
> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> > +{
> > +	struct hv_create_vp *input;
> > +	u16 status;
> > +	unsigned long irq_flags;
> > +	int ret = 0;
> > +#ifdef CONFIG_ACPI_NUMA
> > +	int pxm = node_to_pxm(node);
> > +#else
> > +	int pxm = 0;
> > +#endif
> 
> Same comment.
> 
> > +
> > +	/* Root VPs don't seem to need pages deposited */
> > +	if (partition_id != hv_current_partition_id) {
> > +		ret = hv_call_deposit_pages(node, partition_id, 90);
> 
> Perhaps add a comment about the value "90".  Was it
> empirically determined?

I think so. I will add a comment.

> 
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	do {
> > +		local_irq_save(irq_flags);
> > +
> > +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +		input->partition_id = partition_id;
> > +		input->vp_index = vp_index;
> > +		input->flags = flags;
> > +		input->subnode_type = HvSubnodeAny;
> > +		if (node != NUMA_NO_NODE) {
> > +			input->proximity_domain_info.domain_id = pxm;
> > +			input->proximity_domain_info.flags.reserved = 0;
> > +			input->proximity_domain_info.flags.proximity_info_valid = 1;
> > +			input->proximity_domain_info.flags.proximity_preferred = 1;
> > +		} else {
> > +			input->proximity_domain_info.as_uint64 = 0;
> > +		}
> > +		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
> > +		local_irq_restore(irq_flags);
> > +
> > +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> 
> Same problems with the status check.

Fixed.

> 
> > +			if (status != HV_STATUS_SUCCESS) {
> > +				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
> > +				       vp_index, flags, status);
> > +				ret = status;
> > +			}
> > +			break;
> > +		}
> > +		ret = hv_call_deposit_pages(node, partition_id, 1);
> > +
> > +	} while (!ret);
> > +
> > +	return ret;
> > +}
> > +
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 67f5d35a73d3..4e590a167160 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
[...]
> > +/* HvAddLogicalProcessor hypercall */
> > +struct hv_add_logical_processor_in {
> > +	u32 lp_index;
> > +	u32 apic_id;
> > +	union hv_proximity_domain_info proximity_domain_info;
> > +	u64 flags;
> > +};
> 
> __packed is missing from this struct definition
> 

Fixed.

> > +
> > +struct hv_add_logical_processor_out {
> > +	struct hv_lp_startup_status startup_status;
> > +} __packed;
> > +
> > +enum HV_SUBNODE_TYPE
> > +{
> > +    HvSubnodeAny = 0,
> > +    HvSubnodeSocket,
> > +    HvSubnodeAmdNode,
> > +    HvSubnodeL3,
> > +    HvSubnodeCount,
> > +    HvSubnodeInvalid = -1
> > +};
> 
> Are these values defined by Hyper-V?  If so, explicitly coding the
> value of each enum member might be better.

Fixed.

Wei.
