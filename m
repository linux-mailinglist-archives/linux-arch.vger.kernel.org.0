Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27BA6F4A5C
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjEBTav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEBTau (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 15:30:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387761FC3;
        Tue,  2 May 2023 12:30:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8dc09e884so5515971fa.1;
        Tue, 02 May 2023 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683055846; x=1685647846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0sUVnHSqc4uat8sAhfZisJAZwIOerlp+234b6+n8tM=;
        b=rw3rCTOdKq0z9YrJ7VVRjN6WGrwr+ICx1Os1qeuwedcZQh2M53vGEfrLklAlU97TXx
         0Q1xkZ8/eGYdc5YzoQsoNBlgcw0k6DIRVbA+qZGMz49XTuvYx8DXipb17g1aNEFFNuZ2
         aQmebdfdQekumQe4ispexVG/jkypPqpWn50aLSG+Sl/lGJ7gymk4awag0D5NVjY9iIon
         VJixFUAujKA3WP4EBQ/IeaRHFFlGg+1XTwKJ2Fjx3KVanrW4ihIVdcV83T5g1oVb92R4
         L/Qk8RL/H8+5bnlg4NQn5uL/1y6oyUDLw0PfFDTx5QzfkgnB9ZWGLKXdqQLFDRpyRT8p
         bbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055846; x=1685647846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0sUVnHSqc4uat8sAhfZisJAZwIOerlp+234b6+n8tM=;
        b=CKi0xjC/Qy1vfVisDU2sm3biF1bpPGVaTGfhD6+zR760pOTxl1poWZsaoPNdA989El
         5C7GlRKBaqViq89jI/kQs30BSwif5La2HQD4QhpvTiQzw+AQ4Bk3msTwE2DomsD4R1fX
         06grGlwgHJwJKo+ZZax4DVnYzIDY208yzPotogGBAi9og1fZX+X0+B3m9aib+bxULwxU
         ikJDuR2I5HhCUQFPMND7Ag+hOMQcLA+rPT8QODOGFWwy4Gk7yNpxa9s3ANDHZax98aCB
         ucHD9FHgFudvdhKOf9OMb+Uz6cjIgLLwUVKC8Ss8UDGG0LVEPGbBCUf2MxO95+uOJXj3
         uW8w==
X-Gm-Message-State: AC+VfDzJHxwrLMS8Km432+F1GS/4Etw40RM2jMmCHpGf1NSwTCW9/B7s
        eEgx+AMbVC79Zw2tbOjRQcg=
X-Google-Smtp-Source: ACHHUZ4l9SbL/8BZFyV+fbmMZr3b6aU2enjMXY+r/SYH70eqjZA0ABJgvtip69/P61yOArvNspaAsQ==
X-Received: by 2002:a2e:be8c:0:b0:2a9:f4e9:1a3d with SMTP id a12-20020a2ebe8c000000b002a9f4e91a3dmr1236194ljr.2.1683055846139;
        Tue, 02 May 2023 12:30:46 -0700 (PDT)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8857000000b002a8c271de33sm5359052ljj.67.2023.05.02.12.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:30:46 -0700 (PDT)
Date:   Tue, 2 May 2023 22:30:41 +0300
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V5 03/15] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Message-ID: <20230502223041.00000240.zhi.wang.linux@gmail.com>
In-Reply-To: <20230501085726.544209-4-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
        <20230501085726.544209-4-ltykernel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon,  1 May 2023 04:57:13 -0400
Tianyu Lan <ltykernel@gmail.com> wrote:

> From: Tianyu Lan <tiala@microsoft.com>
> 
> sev-snp guest provides vtl(Virtual Trust Level) and
> get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
> Set target vtl in the VMBus init message.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v4:
>        * Use struct_size to calculate array size.
>        * Fix some coding style
> 
> Change since RFC v3:
>        * Use the standard helper functions to check hypercall result
>        * Fix coding style
> 
> Change since RFC v2:
>        * Rename get_current_vtl() to get_vtl()
>        * Fix some coding style issues
> ---
>  arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
>  drivers/hv/connection.c            |  1 +
>  include/asm-generic/mshyperv.h     |  1 +
>  include/linux/hyperv.h             |  4 ++--
>  5 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9f3e2d71d015..331b855314b7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>  
> +static u8 __init get_vtl(void)
> +{
> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	u64 vtl = 0;
> +	u64 ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = (struct hv_get_vp_registers_output *)input;

===
> +	if (!input) {
> +		local_irq_restore(flags);
> +		goto done;
> +	}
> +
===
Is this really necessary?

drivers/hv/hv_common.c:

        hyperv_pcpu_input_arg = alloc_percpu(void  *);
        BUG_ON(!hyperv_pcpu_input_arg);


> +	memset(input, 0, struct_size(input, element, 1));
> +	input->header.partitionid = HV_PARTITION_ID_SELF;
> +	input->header.vpindex = HV_VP_INDEX_SELF;
> +	input->header.inputvtl = 0;
> +	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret = hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret))
> +		vtl = output->as64.low & HV_X64_VTL_MASK;
> +	else
> +		pr_err("Hyper-V: failed to get VTL! %lld", ret);
> +	local_irq_restore(flags);
> +
> +done:
> +	return vtl;
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -512,6 +546,8 @@ void __init hyperv_init(void)
>  	/* Query the VMs extended capability once, so that it can be cached. */
>  	hv_query_ext_cap(0);
>  
> +	/* Find the VTL */
> +	ms_hyperv.vtl = get_vtl();
>  	return;
>  
>  clean_guest_os_id:
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index cea95dcd27c2..4bf0b315b0ce 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -301,6 +301,13 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
>  #define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
>  
> +/*
> + * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
> + * there is not associated MSR address.
> + */
> +#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
> +#define	HV_X64_VTL_MASK			GENMASK(3, 0)
> +
>  /* Hyper-V memory host visibility */
>  enum hv_mem_host_visibility {
>  	VMBUS_PAGE_NOT_VISIBLE		= 0,
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 5978e9dbc286..02b54f85dc60 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	 */
>  	if (version >= VERSION_WIN10_V5) {
>  		msg->msg_sint = VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl = ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 402a8c1c202d..3052130ba4ef 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -48,6 +48,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bfbc37ce223b..1f2bfec4abde 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
>  		u64 interrupt_page;
>  		struct {
>  			u8	msg_sint;
> -			u8	padding1[3];
> -			u32	padding2;
> +			u8	msg_vtl;
> +			u8	reserved[6];
>  		};
>  	};
>  	u64 monitor_page1;

