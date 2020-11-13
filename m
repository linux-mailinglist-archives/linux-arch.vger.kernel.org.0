Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F82B1F2F
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 16:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMPvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 10:51:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55985 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKMPvU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 10:51:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id c9so8514583wml.5;
        Fri, 13 Nov 2020 07:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fljTLWymgGBnzlrqNbYBU+VYW+PwHa/4BklRoaSYwdk=;
        b=lgc7tP/UeSOANsmzFgb5InAwn3sEb00QnuIvoffBbII9Xj1whCdpVSPuGk+38pBLxH
         K58dCMdemJQImnmseojUS4R8ZinG62xEhTK1p55LuYT3Uwby8w4enTLpTOVmhUEMzXAw
         ZE1GKoNXZHYiuXSD5i+K1+TJrgXL0HOkC8cMEhxhdGpw8yXZx8L/6uyYi4DAq1N143tq
         aC8B0zcQSwubLp+W688+BLRR+c2g92KkCkrHLAtLnuRbuoJqPm7G4W/Q0MM28kRM5FU5
         K0iJOROtAeuevpjLlwy05slf7WABQ4V1/cSEQWKg/jfV8JpDdtsos2YQr0JPpExbrMG6
         9LCQ==
X-Gm-Message-State: AOAM532OZs6XIOKQO/BpKyvBNCiigRbL/ylLUN0pza6TjDhIVfbVUZ8k
        fZ/VKn41gSenth3gt2gNHdE=
X-Google-Smtp-Source: ABdhPJw4MRmmPVjmAjQsFs+WFF4Ff8GkUeB0CjKuzKDlRtNPEflRAPvNJXdChkevYlP7ckgP73jIIw==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr3091817wmj.187.1605282673383;
        Fri, 13 Nov 2020 07:51:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w11sm11004306wmg.36.2020.11.13.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:51:12 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:51:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
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
Message-ID: <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
 <871rgyy3d1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rgyy3d1.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 12, 2020 at 04:57:46PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
[...]
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 67f5d35a73d3..4e590a167160 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
> >  
> >  extern u64 hv_current_partition_id;
> >  
> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> 
> You seem to be only doing EXPORT_SYMBOL_GPL() for
> hv_call_deposit_pages() and hv_call_create_vp() but not for
> hv_call_add_logical_proc() - is this intended? Also, I don't see
> hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
> arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?
> 

hv_call_deposit_pages and hv_call_create_vp will be needed by /dev/mshv,
which can be built as a module.

hv_call_add_logical_proc is only needed by mshyperv.c and not exported
in the first place.

This code is fine.

> > +
> >  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
> >  {
> >  	u64 input_address = input ? virt_to_phys(input) : 0;
> > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> > index 87b1a79b19eb..b6c74e1a5524 100644
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
> > @@ -413,6 +416,70 @@ struct hv_get_partition_id {
> >  	u64 partition_id;
> >  } __packed;
> >  
> > +/* HvDepositMemory hypercall */
> > +struct hv_deposit_memory {
> > +	u64 partition_id;
> > +	u64 gpa_page_list[];
> > +} __packed;
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
> > +/* HvAddLogicalProcessor hypercall */
> > +struct hv_add_logical_processor_in {
> > +	u32 lp_index;
> > +	u32 apic_id;
> > +	union hv_proximity_domain_info proximity_domain_info;
> > +	u64 flags;
> > +};
> > +
> > +struct hv_add_logical_processor_out {
> > +	struct hv_lp_startup_status startup_status;
> > +};
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
> > +
> > +/* HvCreateVp hypercall */
> > +struct hv_create_vp {
> > +	u64 partition_id;
> > +	u32 vp_index;
> > +	u8 padding[3];
> > +	u8 subnode_type;
> > +	u64 subnode_id;
> > +	union hv_proximity_domain_info proximity_domain_info;
> > +	u64 flags;
> > +};
> 
> You add '__packed' to 'struct hv_deposit_memory' but not to 'struct
> hv_create_vp'/'struct hv_add_logical_processor_in', this looks
> inconsistent.

Fixed.

Wei.
