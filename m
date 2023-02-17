Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155469A56E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 07:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBQGBn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 01:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQGBm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 01:01:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6772B082;
        Thu, 16 Feb 2023 22:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676613700; x=1708149700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e8dwyHe1OfxIWTM3M8v2ygxze2bnZHcEvqIdWl3nJa0=;
  b=iLvNtbsciBts0vNE7YoQJBU7LrLWPRZUmyit1hPdU9tHQRmYzlzghaST
   rUWTBpsCKJ4s6WE4LCeH3HNDyg0fg2smvykL/Hd96dfRhBDs/URsb4cEB
   /wBZ7/16Kwodn0f1/uLZ8a3AtXwFjSshrR7+zDOevb7xkYv7DLyqccpXD
   V2tZkGY+Sm5sCogWyC7UZgujsRRs21qyB138Yug8NK8cmpyW2fmvo9eJF
   QV9DmitJ0gUwK+bI+hyY2Kq3jjG0UNuMjIFl5UdwVsDx5QSiwAqUZxSeS
   CtJGp/sqRnySIYojfhuvxJyOtDohgOqlaTiHiNKIbGEZcO4hcNrnpAe0q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320019929"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320019929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:01:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779676233"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="779676233"
Received: from jaeikcho-mobl1.amr.corp.intel.com (HELO [10.212.245.223]) ([10.212.245.223])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:01:38 -0800
Message-ID: <00d25fba-345f-a461-d852-33813da45cf8@linux.intel.com>
Date:   Thu, 16 Feb 2023 22:01:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@linutronix.de,
        tony.luck@intel.com, wei.liu@kernel.org, x86@kernel.org,
        mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
References: <20230206192419.24525-1-decui@microsoft.com>
 <20230206192419.24525-5-decui@microsoft.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230206192419.24525-5-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/6/23 11:24 AM, Dexuan Cui wrote:
> A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> 
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the cc_mask.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> 
> Changes in v2:
>   Implemented hv_tdx_hypercall() in C rather than in assembly code.
>   Renamed the parameter names of hv_tdx_hypercall().
>   Used cc_mkdec() directly in hv_do_hypercall().
> 
> Changes in v3:
>   Decrypted/encrypted hyperv_pcpu_input_arg in
>     hv_common_cpu_init() and hv_common_cpu_die().
> 
>  arch/x86/hyperv/hv_init.c       |  8 ++++++++
>  arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
>  drivers/hv/hv_common.c          | 21 +++++++++++++++++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 41ef036ebb7b..6a0bcbd18306 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -430,6 +430,10 @@ void __init hyperv_init(void)
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>  
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +
>  	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> @@ -469,6 +473,7 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>  
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> @@ -602,6 +607,9 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return false;
>  
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
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
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 49bca07bbd2c..159ab74d80e6 100644
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
> @@ -37,6 +38,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>  
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +/*
> + * If the hypercall involves no input or output parameters, the hypervisor
> + * ignores the corresponding GPA pointer.
> + */
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> @@ -44,6 +51,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control,
> +					cc_mkdec(input_address),
> +					cc_mkdec(output_address));
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>  
> @@ -81,6 +92,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -112,6 +126,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a9a03ab04b97..219c3f235c50 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  
> @@ -125,6 +126,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount = hv_root_partition ? 2 : 1;
> +	int ret;
>  
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -134,6 +136,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>  
> +	if (hv_isolation_type_tdx()) {
> +		ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +		if (ret) {
> +			/* It may be unsafe to free *inputarg */
> +			*inputarg = NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -154,6 +167,8 @@ int hv_common_cpu_die(unsigned int cpu)
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
>  	void *mem;
> +	int pgcount = hv_root_partition ? 2 : 1;
> +	int ret;
>  
>  	local_irq_save(flags);
>  
> @@ -168,6 +183,12 @@ int hv_common_cpu_die(unsigned int cpu)
>  
>  	local_irq_restore(flags);
>  
> +	if (hv_isolation_type_tdx()) {
> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	kfree(mem);
>  
>  	return 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
