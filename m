Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9E65FF7B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jan 2023 12:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjAFLYA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Jan 2023 06:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAFLX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2023 06:23:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F09687AF;
        Fri,  6 Jan 2023 03:23:57 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bx6so1193332ljb.3;
        Fri, 06 Jan 2023 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc6AJeA6QH8mH/qpz0YFPtwqEUXIOgf8yzugvC3dW1M=;
        b=TL/k8lUwg40VBfY5xPwGsh7yQUs9JhuonEOjFKQ7yUsZQwRzpIRSX2F8WW1ol4qFIF
         c06M9xkEjFjd3JG9Yz3v7wFD6aPMFhe0szw1IcseCQlzCKKvdPr8hGa4OR4KJrAQoikx
         aU+nIgwirHt2VF+1GTkELwZzhO/7wAehSRK+kPoFEDqpTu02GpSiMxuXvEOQxzJi9fZH
         qH1jSmZwKFW9C2VrOnBdEM0CO9ZsKHIYMdasBS72MB6RpuQ+wS9sNn1C1WSmJUDKZOIY
         WMFS3FGE2Kp9hWKr737blph/WrWRpl90aw/drA8wa0kkf2Zqnv21KiPlVwBHxkwVJLvC
         5+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc6AJeA6QH8mH/qpz0YFPtwqEUXIOgf8yzugvC3dW1M=;
        b=LWIbtYUh22UVEksVS/QE0n5w9BOcwjyW7r17uc407WwnT90CuUsW8WKyfKKikiBOFp
         Xphxxw2qwXzJCqKucU0/CsuOW8q9nHLwxDtUc2bq+2AQdc/HCf36FiDzEbFTLrNrF6ry
         JTEV72ojBFxLEPd0XSYYTPH7+6B4PXSUz1CMb/mHhrj8IvrzCq5KVZzp5Nzcsyyho9gA
         V00UJWw/u2XobmzEAoM+gvIfDaL5rR8q0FZ4nPwWo4P+rmg4hxTWJwuYDRJeiz7P42cd
         078fqVDgaYsobLcbQ3z2vuEAKuAv0OFeFKByhhQE8LQKyA9IWaIkIHIbS0TRefOL8HQv
         jyIA==
X-Gm-Message-State: AFqh2krJ/yucGWdIbLdFJAQijxJzZFsOAhcp+n3SwOvtOzzysznYMRZO
        PuOS4B3pG9OmuMi6pQnq3Vo=
X-Google-Smtp-Source: AMrXdXupMQrYymXm+dRDk5s3STVi7rk0UMKV2owVopFZee24BcTmuiHyE03l74DEwyLcde5ykSmoyg==
X-Received: by 2002:a2e:3306:0:b0:27f:b476:c05 with SMTP id d6-20020a2e3306000000b0027fb4760c05mr2923474ljc.5.1673004235939;
        Fri, 06 Jan 2023 03:23:55 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b0027b54ff90c0sm74690ljk.139.2023.01.06.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:23:55 -0800 (PST)
Date:   Fri, 6 Jan 2023 13:23:54 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Message-ID: <20230106132354.00007af3@gmail.com>
In-Reply-To: <20221207003325.21503-6-decui@microsoft.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-6-decui@microsoft.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  6 Dec 2022 16:33:24 -0800
Dexuan Cui <decui@microsoft.com> wrote:

> A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> 
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the cc_mask.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> Changes in v2:
>   Implemented hv_tdx_hypercall() in C rather than in assembly code.
>   Renamed the parameter names of hv_tdx_hypercall().
>   Used cc_mkdec() directly in hv_do_hypercall().
> 
>  arch/x86/hyperv/hv_init.c       |  8 ++++++++
>  arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a823fde1ad7f..c0ba53ad8b8e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -430,6 +430,10 @@ void __init hyperv_init(void)
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>  
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +
>  	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1,
> VMALLOC_START, VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> @@ -469,6 +473,7 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>  
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> @@ -604,6 +609,9 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return false;
>  
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> */
> +	if (hv_isolation_type_tdx())
> +		return true;
>  	/*
>  	 * Verify that earlier initialization succeeded by checking
>  	 * that the hypercall page is setup
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 13ccb52eecd7..07e4253b5809 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -276,6 +276,20 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	struct tdx_hypercall_args args = { };
> +
> +	args.r10 = control;
> +	args.rdx = param1;
> +	args.r8  = param2;
> +
> +	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	return args.r11;
> +}
> +EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>  #endif
>  
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h index 8a2cafec4675..a4d665472d9e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -10,6 +10,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <asm/mshyperv.h>
> +#include <asm/coco.h>
>  
>  union hv_ghcb;
>  
> @@ -39,6 +40,12 @@ int hv_call_deposit_pages(int node, u64 partition_id,
> u32 num_pages); int hv_call_add_logical_proc(int node, u32 lp_index, u32
> acpi_id); int hv_call_create_vp(int node, u64 partition_id, u32
> vp_index, u32 flags); 
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +/*
> + * If the hypercall involves no input or output parameters, the
> hypervisor
> + * ignores the corresponding GPA pointer.
> + */
>  static inline u64 hv_do_hypercall(u64 control, void *input, void
> *output) {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> @@ -46,6 +53,10 @@ static inline u64 hv_do_hypercall(u64 control, void
> *input, void *output) u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control,
> +					cc_mkdec(input_address),
> +					cc_mkdec(output_address));
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>  

> @@ -83,6 +94,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64
> input1) u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status),
> ASM_CALL_CONSTRAINT, @@ -114,6 +128,9 @@ static inline u64
> hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2) u64 hv_status,
> control = (u64)code | HV_HYPERCALL_FAST_BIT; 
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
In some paths, for example vmbus_set_event(), choosing the SNP-based or
generic hypercall happens in the caller, while now TDX-based hypercall is
embraced in the generic hypercall path, e.g. hv_do_fast_hypercall8(). Which
style will be chosen in the future? Seems the coding structure needs to be
aligned.

void vmbus_set_event(struct vmbus_channel *channel)
{
        u32 child_relid = channel->offermsg.child_relid;

        if (!channel->is_dedicated_interrupt)
                vmbus_send_interrupt(child_relid);

        ++channel->sig_events;

        if (hv_isolation_type_snp())
                hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
                                NULL, sizeof(channel->sig_event));
        else
                hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT,
        channel->sig_event);
}


>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC

