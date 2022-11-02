Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2CA616571
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 16:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKBPAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKBPAF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 11:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20D2B620
        for <linux-arch@vger.kernel.org>; Wed,  2 Nov 2022 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667401132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIUui6XemfDmNnKveTsJ7okhqXcH8eMwCddrAWsAvh8=;
        b=ULhpDMkovA5QMBRTybJ5vdXEGGadofOClT37OX1k4q921b7d2XWD8iWrOO/wWjAbGZpVQW
        XgesZl7iGTBzs3JSVLbu43awbyErpzfgCm2qOSSMq363UbF/gDGEs1rrLS01C4LxnOlSir
        scEmml6LC7bYnySNBQweGt7SfTeyCLE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-sJb8_WUuNjGFGc4CRQllRg-1; Wed, 02 Nov 2022 10:58:51 -0400
X-MC-Unique: sJb8_WUuNjGFGc4CRQllRg-1
Received: by mail-wm1-f70.google.com with SMTP id h8-20020a1c2108000000b003cf550bfc8dso1181118wmh.2
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 07:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIUui6XemfDmNnKveTsJ7okhqXcH8eMwCddrAWsAvh8=;
        b=QdeiWk3Gwh1x37kPBWupLvV9pccrQtRcJSyv8gPkl46YK4iF9baIxJU2tIh6Nnb63j
         OabYm0T4ry7/+oJAC9nrkD83DZA7mny25fDb4HMTZrhEc16tUhYAI3WTg1zkxcN9MmBj
         vSV2ZhG3z3cUIJ4vyQicRSes3mT01qG+8/VvHCBSidF21SRrsk2rhUV8bREAskxXpvs+
         D492uCJLcBxAWAePRGkjf/JgB8ug8naq/ZYjpPsVMqe6jHNaZIlu0gpUW4UZgunYWY5W
         i5+cniqxo+wjjp4KxtSjoEajKHXDHIoQq29zTr8sBat7iR4Vgaz13lXrdcf5z/r+rUzL
         TUFw==
X-Gm-Message-State: ACrzQf3dCL0wgz/0szI4qRfo0Q6EFJR6EmnrQJ+JSAYN3DrGLesZ9h1M
        FajvaSop+snH9KTXBAghp6NxFnI7JvA8Cd/IjRXfeOwtGrQ1vmG2kMA0VqKLh6fpjMtH5f4/NCF
        Bvj7jz2Bu3mlTJBRkd65O4hMwFuEl8ubew5BUhq97rrHSzsF2fw0s3hRDD/aH7dqbH8Jvf9UgcQ
        ==
X-Received: by 2002:adf:f98a:0:b0:236:677c:2407 with SMTP id f10-20020adff98a000000b00236677c2407mr15876816wrr.578.1667401130393;
        Wed, 02 Nov 2022 07:58:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xFdFHDutoVz3RfLfUXOtfgbF9PYQtxkvFyArdcYq9THDvS/zsbOexyln9yYO1AvwtquS0yA==
X-Received: by 2002:adf:f98a:0:b0:236:677c:2407 with SMTP id f10-20020adff98a000000b00236677c2407mr15876772wrr.578.1667401130077;
        Wed, 02 Nov 2022 07:58:50 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b003bfaba19a8fsm2424488wms.35.2022.11.02.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:58:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/6] hv: Setup synic registers in case of nested root
 partition
In-Reply-To: <78973f0cfed8a19fced95875c0142a08386e66ed.1667394408.git.jinankjain@microsoft.com>
References: <cover.1667394408.git.jinankjain@microsoft.com>
 <78973f0cfed8a19fced95875c0142a08386e66ed.1667394408.git.jinankjain@microsoft.com>
Date:   Wed, 02 Nov 2022 15:58:48 +0100
Message-ID: <871qqls8rb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jinank Jain <jinankjain@linux.microsoft.com> writes:

> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSRs
> for nested vs non-nested root partition.
>
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++
>  drivers/hv/hv.c                    | 55 ++++++++++++++++++------------
>  2 files changed, 45 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index d9a611565859..0319091e2019 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>  #define HV_REGISTER_SINT14			0x4000009E
>  #define HV_REGISTER_SINT15			0x4000009F
>  
> +/*
> + * Define synthetic interrupt controller model specific registers for
> + * nested hypervisor.
> + */
> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
> +#define HV_REGISTER_NESTED_SIMP                0x40001083
> +#define HV_REGISTER_NESTED_EOM                 0x40001084
> +#define HV_REGISTER_NESTED_SINT0               0x40001090
> +
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..92ee910561c4 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -25,6 +25,11 @@
>  /* The one and only */
>  struct hv_context hv_context;
>  
> +#define REG_SIMP (hv_nested ? HV_REGISTER_NESTED_SIMP : HV_REGISTER_SIMP)
> +#define REG_SIEFP (hv_nested ? HV_REGISTER_NESTED_SIEFP : HV_REGISTER_SIEFP)
> +#define REG_SCTRL (hv_nested ? HV_REGISTER_NESTED_SCONTROL : HV_REGISTER_SCONTROL)
> +#define REG_SINT0 (hv_nested ? HV_REGISTER_NESTED_SINT0 : HV_REGISTER_SINT0)
> +
>  /*
>   * hv_init - Main initialization routine.
>   *
> @@ -147,7 +152,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp()) {
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
>  			hv_cpu->synic_message_page =
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page == NULL) {
> @@ -188,8 +193,16 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (hv_root_partition) {
> +			if (hv_cpu->synic_event_page != NULL)
> +				memunmap(hv_cpu->synic_event_page);
> +
> +			if (hv_cpu->synic_message_page != NULL)
> +				memunmap(hv_cpu->synic_message_page);
> +		} else {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>  		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>  
> @@ -213,10 +226,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>  
>  	/* Setup the Synic's message page */
> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 = hv_get_register(REG_SIMP);

To avoid all this code churn (here and in the next patch dealing with
EOM), would it make sense to move the logic picking nested/non-nested
register into hv_{get,set}_register() instead?

E.g. something like (untested, incomplete):

static inline u32 hv_get_nested_reg(u32 reg) {
	switch (reg) {
	HV_REGISTER_SIMP: return HV_REGISTER_NESTED_SIMP;
        HV_REGISTER_NESTED_SVERSION: return HV_REGISTER_NESTED_SVERSION;
        ...
 	default: return reg;
	}

}

static inline u64 hv_get_register(unsigned int reg)
{
	u64 value;

	if (hv_nested)
		reg = hv_get_nested_reg(reg);

	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
		hv_ghcb_msr_read(reg, &value);
	else
		rdmsrl(reg, value);
	return value;
}

static inline void hv_set_register(unsigned int reg, u64 value)
{
	if (hv_nested)
		reg = hv_get_nested_reg(reg);

	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
		hv_ghcb_msr_write(reg, value);

		/* Write proxy bit via wrmsl instruction */
		if (reg >= HV_REGISTER_SINT0 &&
		    reg <= HV_REGISTER_SINT15)
			wrmsrl(reg, value | 1 << 20);
	} else {
		wrmsrl(reg, value);
	}
}


>  	simp.simp_enabled = 1;
>  
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -227,13 +240,13 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>  
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_register(REG_SIMP, simp.as_uint64);
>  
>  	/* Setup the Synic's event page */
> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 = hv_get_register(REG_SIEFP);
>  	siefp.siefp_enabled = 1;
>  
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -245,12 +258,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>  
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_register(REG_SIEFP, siefp.as_uint64);
>  
>  	/* Setup the shared SINT. */
>  	if (vmbus_irq != -1)
>  		enable_percpu_irq(vmbus_irq, 0);
> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> +	shared_sint.as_uint64 = hv_get_register(REG_SINT0 +
>  					VMBUS_MESSAGE_SINT);
>  
>  	shared_sint.vector = vmbus_interrupt;
> @@ -266,14 +279,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>  #else
>  	shared_sint.auto_eoi = 0;
>  #endif
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	hv_set_register(REG_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>  
>  	/* Enable the global synic bit */
> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 = hv_get_register(REG_SCTRL);
>  	sctrl.enable = 1;
>  
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_register(REG_SCTRL, sctrl.as_uint64);
>  }
>  
>  int hv_synic_init(unsigned int cpu)
> @@ -297,17 +310,17 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>  
> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> +	shared_sint.as_uint64 = hv_get_register(REG_SINT0 +
>  					VMBUS_MESSAGE_SINT);
>  
>  	shared_sint.masked = 1;
>  
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	hv_set_register(REG_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>  
> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 = hv_get_register(REG_SIMP);
>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> @@ -320,9 +333,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	else
>  		simp.base_simp_gpa = 0;
>  
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_register(REG_SIMP, simp.as_uint64);
>  
> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 = hv_get_register(REG_SIEFP);
>  	siefp.siefp_enabled = 0;
>  
>  	if (hv_isolation_type_snp())
> @@ -330,12 +343,12 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	else
>  		siefp.base_siefp_gpa = 0;
>  
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_register(REG_SIEFP, siefp.as_uint64);
>  
>  	/* Disable the global synic bit */
> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 = hv_get_register(REG_SCTRL);
>  	sctrl.enable = 0;
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_register(REG_SCTRL, sctrl.as_uint64);
>  
>  	if (vmbus_irq != -1)
>  		disable_percpu_irq(vmbus_irq);

-- 
Vitaly

