Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458C6400D7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 08:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiLBHFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 02:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBHFN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 02:05:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C70E3BF66F;
        Thu,  1 Dec 2022 23:05:11 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id D340820B83C2;
        Thu,  1 Dec 2022 23:05:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D340820B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669964711;
        bh=kGHSThbYKKTOR8QGVnvv2rjWR1cQHVY5CjRWRxGvGvw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D0L/gxIXKSYl0GcqDR8ZAEvcwnxDWSlz9f/Ye6hX9hT8gF9WH8Q+UkLc2+GzRRmfB
         D9DWKwG9H8ICN56mGjctAIlQOQk7D8+cfy16i3cKUqWG97KLFYNvILRgfmodH7ahE2
         9HOYlY7x73ockagzBCPRZJtIhkpmKhK8LtqMM25k=
Subject: Re: [PATCH v7 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
References: <cover.1669788587.git.jinankjain@linux.microsoft.com>
 <dae50574584d821dda19399cb3535089e1465b6a.1669788587.git.jinankjain@linux.microsoft.com>
 <BYAPR21MB16889FE0F7862850DAEB308ED7179@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Message-ID: <064f51db-8114-b2b0-21dd-e47eb03da0be@linux.microsoft.com>
Date:   Fri, 2 Dec 2022 12:35:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB16889FE0F7862850DAEB308ED7179@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-20.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 12/2/2022 9:30 AM, Michael Kelley (LINUX) wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Thursday, December 1, 2022 3:04 AM
>> Child partitions are free to allocate SynIC message and event page but in
>> case of root partition it must use the pages allocated by Microsoft
>> Hypervisor (MSHV). Base address for these pages can be found using
>> synthetic MSRs exposed by MSHV. There is a slight difference in those MSRs
>> for nested vs non-nested root partition.
>>
>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>> ---
>>   arch/x86/include/asm/hyperv-tlfs.h | 11 ++++
>>   arch/x86/include/asm/mshyperv.h    | 30 ++-------
>>   arch/x86/kernel/cpu/mshyperv.c     | 69 +++++++++++++++++++++
>>   drivers/hv/hv.c                    | 99 ++++++++++++++++++++++--------
>>   include/asm-generic/mshyperv.h     |  5 +-
>>   5 files changed, 165 insertions(+), 49 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 58c03d18c235..b5019becb618 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>>   #define HV_REGISTER_SINT14			0x4000009E
>>   #define HV_REGISTER_SINT15			0x4000009F
>>
>> +/*
>> + * Define synthetic interrupt controller model specific registers for
>> + * nested hypervisor.
>> + */
>> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
>> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
>> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
>> +#define HV_REGISTER_NESTED_SIMP                0x40001083
>> +#define HV_REGISTER_NESTED_EOM                 0x40001084
>> +#define HV_REGISTER_NESTED_SINT0               0x40001090
>> +
>>   /*
>>    * Synthetic Timer MSRs. Four timers per vcpu.
>>    */
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 61f0c206bff0..3197d49c888c 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -198,30 +198,10 @@ static inline bool hv_is_synic_reg(unsigned int reg)
>>   	return false;
>>   }
>>
>> -static inline u64 hv_get_register(unsigned int reg)
>> -{
>> -	u64 value;
>> -
>> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
>> -		hv_ghcb_msr_read(reg, &value);
>> -	else
>> -		rdmsrl(reg, value);
>> -	return value;
>> -}
>> -
>> -static inline void hv_set_register(unsigned int reg, u64 value)
>> -{
>> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
>> -		hv_ghcb_msr_write(reg, value);
>> -
>> -		/* Write proxy bit via wrmsl instruction */
>> -		if (reg >= HV_REGISTER_SINT0 &&
>> -		    reg <= HV_REGISTER_SINT15)
>> -			wrmsrl(reg, value | 1 << 20);
>> -	} else {
>> -		wrmsrl(reg, value);
>> -	}
>> -}
>> +u64 hv_get_register(unsigned int reg);
>> +void hv_set_register(unsigned int reg, u64 value);
>> +u64 hv_get_nested_register(unsigned int reg);
>> +void hv_set_nested_register(unsigned int reg, u64 value);
>>
>>   #else /* CONFIG_HYPERV */
>>   static inline void hyperv_init(void) {}
>> @@ -241,6 +221,8 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
>>   }
>>   static inline void hv_set_register(unsigned int reg, u64 value) { }
>>   static inline u64 hv_get_register(unsigned int reg) { return 0; }
>> +static inline void hv_set_nested_register(unsigned int reg, u64 value) { }
>> +static inline u64 hv_get_nested_register(unsigned int reg) { return 0; }
>>   static inline int hv_set_mem_host_visibility(unsigned long addr, int numpages,
>>   					     bool visible)
>>   {
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index f9b78d4829e3..f2f6e10301a8 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -41,7 +41,76 @@ bool hv_root_partition;
>>   bool hv_nested;
>>   struct ms_hyperv_info ms_hyperv;
>>
>> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case HV_REGISTER_SIMP:
>> +		return HV_REGISTER_NESTED_SIMP;
>> +	case HV_REGISTER_NESTED_SIEFP:
>> +		return HV_REGISTER_SIEFP;
>> +	case HV_REGISTER_SCONTROL:
>> +		return HV_REGISTER_NESTED_SCONTROL;
>> +	case HV_REGISTER_SINT0:
>> +		return HV_REGISTER_NESTED_SINT0;
>> +	case HV_REGISTER_EOM:
>> +		return HV_REGISTER_NESTED_EOM;
>> +	default:
>> +		return reg;
>> +	}
> Just a question:  You added #defines for 6 nested registers.  But
> the switch statement above maps only 5 registers.  Is it intentional
> that there's not a mapping for HV_REGISTER_SVERSION?

Good catch! Will fix it in the next revision.

>
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_HYPERV)
>> +static u64 _hv_get_register(unsigned int reg, bool nested)
>> +{
>> +	u64 value;
>> +
>> +	if (nested)
>> +		reg = hv_get_nested_reg(reg);
>> +
>> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
>> +		hv_ghcb_msr_read(reg, &value);
>> +	else
>> +		rdmsrl(reg, value);
>> +	return value;
>> +}
>> +
>> +static void _hv_set_register(unsigned int reg, u64 value, bool nested)
>> +{
>> +	if (nested)
>> +		reg = hv_get_nested_reg(reg);
>> +
>> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
>> +		hv_ghcb_msr_write(reg, value);
>> +
>> +		/* Write proxy bit via wrmsl instruction */
>> +		if (reg >= HV_REGISTER_SINT0 &&
>> +		    reg <= HV_REGISTER_SINT15)
>> +			wrmsrl(reg, value | 1 << 20);
>> +	} else {
>> +		wrmsrl(reg, value);
>> +	}
>> +}
>> +
>> +u64 hv_get_register(unsigned int reg)
>> +{
>> +	return _hv_get_register(reg, false);
>> +}
>> +
>> +void hv_set_register(unsigned int reg, u64 value)
>> +{
>> +	_hv_set_register(reg, value, false);
>> +}
>> +
>> +u64 hv_get_nested_register(unsigned int reg)
>> +{
>> +	return _hv_get_register(reg, true);
>> +}
>> +
>> +void hv_set_nested_register(unsigned int reg, u64 value)
>> +{
>> +	_hv_set_register(reg, value, true);
>> +}
>> +
>>   static void (*vmbus_handler)(void);
>>   static void (*hv_stimer0_handler)(void);
>>   static void (*hv_kexec_handler)(void);
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 4d6480d57546..0ed052f2423e 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -147,7 +147,7 @@ int hv_synic_alloc(void)
>>   		 * Synic message and event pages are allocated by paravisor.
>>   		 * Skip these pages allocation here.
>>   		 */
>> -		if (!hv_isolation_type_snp()) {
>> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
>>   			hv_cpu->synic_message_page =
>>   				(void *)get_zeroed_page(GFP_ATOMIC);
>>   			if (hv_cpu->synic_message_page == NULL) {
>> @@ -188,8 +188,16 @@ void hv_synic_free(void)
>>   		struct hv_per_cpu_context *hv_cpu
>>   			= per_cpu_ptr(hv_context.cpu_context, cpu);
>>
>> -		free_page((unsigned long)hv_cpu->synic_event_page);
>> -		free_page((unsigned long)hv_cpu->synic_message_page);
>> +		if (hv_root_partition) {
>> +			if (hv_cpu->synic_event_page != NULL)
>> +				memunmap(hv_cpu->synic_event_page);
>> +
>> +			if (hv_cpu->synic_message_page != NULL)
>> +				memunmap(hv_cpu->synic_message_page);
>> +		} else {
>> +			free_page((unsigned long)hv_cpu->synic_event_page);
>> +			free_page((unsigned long)hv_cpu->synic_message_page);
>> +		}
>>   		free_page((unsigned long)hv_cpu->post_msg_page);
>>   	}
>>
>> @@ -213,10 +221,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   	union hv_synic_scontrol sctrl;
>>
>>   	/* Setup the Synic's message page */
>> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>> +	simp.as_uint64 = hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP) :
>> +				     hv_get_register(HV_REGISTER_SIMP);
> Unfortunately, this code and the similar places below will run into
> problems on ARM64.  Drivers/hv/hv.c is common code on all architectures
> so it needs to compile and run on ARM64 as well as x86/x64.  But there's
> no hv_get_nested_register() defined or implemented on the ARM64 side,
> so the code will fail to compile.
>
> I think there's a better way to do this.   Based on Nuno's comments, it
> seems like there are two hv_get_register() functions needed:
>
> 1)  Get the value of the register or its nested cousin, based on the value
> of hv_nested.  That's what you are explicitly coding here.
> 2) Get the value of the register.  Don't access the nested cousin, regardless
> of the value of hv_nested.
>
> Based on how you coded things earlier, I'm assuming #1 is what you want to
> use in most cases, and specifically here in drivers/hv/hv.c.  That's good,
> because #1 can hide the testing of hv_nested in the x86-specific
> implementation of hv_get_register(), while the ARM64 version of
> hv_get_register() continues to do whatever it does now with no changes.
>
> I'm also assuming that #2 may be used in particular cases in the code
> that is specifically related to nesting.  Give the #2 version a different
> name --- maybe hv_get_nonnested_register(), or something like that --
> and use it only in code under arch/x86 that is related to nesting.  That
> way, ARM64 won't be affected.
>
> Of course, the same approach applies to hv_set_register().
>
> hv_get_register() and hv_get_nonnested_register() will obviously
> share some code.  But rather than calling a common function starting
> with underscore like you've done above, let me suggest that
> hv_get_register() test hv_nested and potentially do the translation,
> then call hv_get_nonnested_register().  That way you'll end up
> with just two functions instead of three as above with
> hv_get_register(), hv_get_nested_register(), and _hv_get_register().

I tried the way you suggested and it worked for ARM64 this time. But 
still I would have three functions. Because the base function 
_hv_get_register() would still be required in order to avoid code 
duplication in hv_get_non_nested_register().

>
> I haven't coded up any of this, so take it as a suggestion.  There
> could be some problem with it that I haven't seen, or my assumptions
> might be wrong.  But give it a try and see if it works out.  I'm hoping
> it can all be handled on the x86 side without having to add complexity
> on the ARM64 side.
>
> Michael
>
>> +
>>   	simp.simp_enabled = 1;
>>
>> -	if (hv_isolation_type_snp()) {
>> +	if (hv_isolation_type_snp() || hv_root_partition) {
>>   		hv_cpu->synic_message_page
>>   			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>>   				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>> @@ -227,13 +237,18 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   			>> HV_HYP_PAGE_SHIFT;
>>   	}
>>
>> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>>
>>   	/* Setup the Synic's event page */
>> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>> +	siefp.as_uint64 = hv_nested ?
>> +				  hv_get_nested_register(HV_REGISTER_SIEFP) :
>> +				  hv_get_register(HV_REGISTER_SIEFP);
>>   	siefp.siefp_enabled = 1;
>>
>> -	if (hv_isolation_type_snp()) {
>> +	if (hv_isolation_type_snp() || hv_root_partition) {
>>   		hv_cpu->synic_event_page =
>>   			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>>   				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>> @@ -245,13 +260,19 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   			>> HV_HYP_PAGE_SHIFT;
>>   	}
>>
>> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>>
>>   	/* Setup the shared SINT. */
>>   	if (vmbus_irq != -1)
>>   		enable_percpu_irq(vmbus_irq, 0);
>> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
>> -					VMBUS_MESSAGE_SINT);
>> +	shared_sint.as_uint64 =
>> +		hv_nested ?
>> +			hv_get_nested_register(HV_REGISTER_SINT0 +
>> +					       VMBUS_MESSAGE_SINT) :
>> +			hv_get_register(HV_REGISTER_SINT0 +
>> VMBUS_MESSAGE_SINT);
>>
>>   	shared_sint.vector = vmbus_interrupt;
>>   	shared_sint.masked = false;
>> @@ -266,14 +287,22 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   #else
>>   	shared_sint.auto_eoi = 0;
>>   #endif
>> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SINT0 +
>> VMBUS_MESSAGE_SINT,
>> +				       shared_sint.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>>   				shared_sint.as_uint64);
>> -
>>   	/* Enable the global synic bit */
>> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>> +	sctrl.as_uint64 = hv_nested ?
>> +				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
>> +				  hv_get_register(HV_REGISTER_SCONTROL);
>>   	sctrl.enable = 1;
>>
>> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>>   }
>>
>>   int hv_synic_init(unsigned int cpu)
>> @@ -297,17 +326,25 @@ void hv_synic_disable_regs(unsigned int cpu)
>>   	union hv_synic_siefp siefp;
>>   	union hv_synic_scontrol sctrl;
>>
>> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
>> -					VMBUS_MESSAGE_SINT);
>> +	shared_sint.as_uint64 =
>> +		hv_nested ?
>> +			hv_get_nested_register(HV_REGISTER_SINT0 +
>> +					       VMBUS_MESSAGE_SINT) :
>> +			hv_get_register(HV_REGISTER_SINT0 +
>> VMBUS_MESSAGE_SINT);
>>
>>   	shared_sint.masked = 1;
>>
>>   	/* Need to correctly cleanup in the case of SMP!!! */
>>   	/* Disable the interrupt */
>> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SINT0 +
>> VMBUS_MESSAGE_SINT,
>> +				       shared_sint.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>>   				shared_sint.as_uint64);
>>
>> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>> +	simp.as_uint64 = hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP) :
>> +				     hv_get_register(HV_REGISTER_SIMP);
>>   	/*
>>   	 * In Isolation VM, sim and sief pages are allocated by
>>   	 * paravisor. These pages also will be used by kdump
>> @@ -320,9 +357,14 @@ void hv_synic_disable_regs(unsigned int cpu)
>>   	else
>>   		simp.base_simp_gpa = 0;
>>
>> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>>
>> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>> +	siefp.as_uint64 = hv_nested ?
>> +				  hv_get_nested_register(HV_REGISTER_SIEFP) :
>> +				  hv_get_register(HV_REGISTER_SIEFP);
>>   	siefp.siefp_enabled = 0;
>>
>>   	if (hv_isolation_type_snp())
>> @@ -330,12 +372,21 @@ void hv_synic_disable_regs(unsigned int cpu)
>>   	else
>>   		siefp.base_siefp_gpa = 0;
>>
>> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>>
>>   	/* Disable the global synic bit */
>> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>> +	sctrl.as_uint64 = hv_nested ?
>> +				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
>> +				  hv_get_register(HV_REGISTER_SCONTROL);
>>   	sctrl.enable = 0;
>> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +
>> +	if (hv_nested)
>> +		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +	else
>> +		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>>
>>   	if (vmbus_irq != -1)
>>   		disable_percpu_irq(vmbus_irq);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index f131027830c3..db0b5be1e087 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -147,7 +147,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg,
>> u32 old_msg_type)
>>   		 * possibly deliver another msg from the
>>   		 * hypervisor
>>   		 */
>> -		hv_set_register(HV_REGISTER_EOM, 0);
>> +		if (hv_nested)
>> +			hv_set_nested_register(HV_REGISTER_EOM, 0);
>> +		else
>> +			hv_set_register(HV_REGISTER_EOM, 0);
>>   	}
>>   }
>>
>> --
>> 2.25.1


Regards,

Jinank

