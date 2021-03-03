Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B232C860
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhCDAtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348125AbhCCRHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Mar 2021 12:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYbzimg8dKv1Dc6JVUggNyLLrfw9P2fj+f+gK8edcwA=;
        b=aIrSkLtNVZHdu3PVOCx8IhxVodQLtsv6rAuA/wcnHLj0C4TGJHcRUS107zRij9NAAbw4Vx
        dI6IEIHwRB7uLNKZXRMrAe2dSqp1UpDrGizTzYhthIb25XIvmuaffTvfpB+1/rKFzdoLUC
        cATzPKo5WDWYA+kQwhD2aTZYDpkYIGU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-oseQ_TPYPk2DYi7Eb865PA-1; Wed, 03 Mar 2021 12:05:52 -0500
X-MC-Unique: oseQ_TPYPk2DYi7Eb865PA-1
Received: by mail-ej1-f72.google.com with SMTP id n25so10776779ejd.5
        for <linux-arch@vger.kernel.org>; Wed, 03 Mar 2021 09:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nYbzimg8dKv1Dc6JVUggNyLLrfw9P2fj+f+gK8edcwA=;
        b=k4vhAaKDI5JDH7Ti0WARo0ATZJ2UlDrGhP4Jtwkj9PX2eoFvc1nZk1u2aSKLAhEgEX
         w9F4jXUVbfRuNQdeGMxRM8wDkCIcTOlUhb/AjYIcQU1r90RnGfooS4efJGYzJirJYWso
         QqwPKo8EOztc09T36UrYzGKwehl3kgvjCZnmEzSMQ0j7mWgsdcfjbdxrKrOhmAMc8zyo
         GQmCKqXF7/0FhqdH2wQdCZHo1WO2yKfvJhHfgDtyNpophkLoeVUWI3A8aKIe3rReWJn0
         0czro+Qtc1hMpioyupqWqrVxsIav1ghcrlR7q2XLjC7C3G3gZUi5TGfZ/603SBDO9xT+
         EvSw==
X-Gm-Message-State: AOAM530rBtqcKgfnvRNLBg3QneiZC7F6jwi/eew9Fq6/4ktwWh0B0wpX
        QlUo3cB7IIDEBlXdewQEk/Jx85P0+m0Sm1vnYSHijI6Mh/6T8DZpP/WXWDJ4/l740rF7UifF152
        8jlyQqOBMQwGy0KtBEaYctw==
X-Received: by 2002:a17:906:cd05:: with SMTP id oz5mr20298399ejb.345.1614791150880;
        Wed, 03 Mar 2021 09:05:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSEHE8qNcUe8Bv5sgBBypQgxqUH4qqklAdaHhUH7IEnd5FUR0Qc4gVsdQoUl7i0uiKZR16Gw==
X-Received: by 2002:a17:906:cd05:: with SMTP id oz5mr20298369ejb.345.1614791150699;
        Wed, 03 Mar 2021 09:05:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 14sm21488216ejy.11.2021.03.03.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:05:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: Re: [RFC PATCH 3/12] x86/HV: Initialize GHCB page and shared memory
 boundary
In-Reply-To: <20210228150315.2552437-4-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-4-ltykernel@gmail.com>
Date:   Wed, 03 Mar 2021 18:05:48 +0100
Message-ID: <87sg5ccglv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V exposes GHCB page via SEV ES GHCB MSR for SNP guest
> to communicate with hypervisor. Map GHCB page for all
> cpus to read/write MSR register and submit hvcall request
> via GHCB. Hyper-V also exposes shared memory boundary via
> cpuid HYPERV_CPUID_ISOLATION_CONFIG and store it in the
> shared_gpa_boundary of ms_hyperv struct. This prepares
> to share memory with host for SNP guest.
>

It seems the patch could be split into two: per-cpu GHCB setup and
shared memory boundary setup as these changes seem to be independent.

> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 52 +++++++++++++++++++++++++++++++---
>  arch/x86/kernel/cpu/mshyperv.c |  2 ++
>  include/asm-generic/mshyperv.h | 14 ++++++++-
>  3 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0db5137d5b81..90e65fbf4c58 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -82,6 +82,9 @@ static int hv_cpu_init(unsigned int cpu)
>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>  	void **input_arg;
>  	struct page *pg;
> +	u64 ghcb_gpa;
> +	void *ghcb_va;
> +	void **ghcb_base;
>  
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
> @@ -128,6 +131,17 @@ static int hv_cpu_init(unsigned int cpu)
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
>  	}
>  
> +	if (ms_hyperv.ghcb_base) {
> +		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
> +
> +		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);

Do we actually need to do ioremap_cache() and not ioremap_uc() for GHCB?
(just wondering)

> +		if (!ghcb_va)
> +			return -ENOMEM;
> +
> +		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
> +		*ghcb_base = ghcb_va;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -223,6 +237,7 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned long flags;
>  	void **input_arg;
>  	void *pg;
> +	void **ghcb_va = NULL;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -236,6 +251,13 @@ static int hv_cpu_die(unsigned int cpu)
>  		*output_arg = NULL;
>  	}
>  
> +	if (ms_hyperv.ghcb_base) {
> +		ghcb_va = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
> +		if (*ghcb_va)
> +			iounmap(*ghcb_va);
> +		*ghcb_va = NULL;
> +	}
> +
>  	local_irq_restore(flags);
>  
>  	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
> @@ -372,6 +394,9 @@ void __init hyperv_init(void)
>  	u64 guest_id, required_msrs;
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	int cpuhp, i;
> +	u64 ghcb_gpa;
> +	void *ghcb_va;
> +	void **ghcb_base;
>  
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return;
> @@ -432,9 +457,24 @@ void __init hyperv_init(void)
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>  			__builtin_return_address(0));
> -	if (hv_hypercall_pg == NULL) {
> -		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> -		goto remove_cpuhp_state;
> +	if (hv_hypercall_pg == NULL)
> +		goto clean_guest_os_id;
> +
> +	if (hv_isolation_type_snp()) {
> +		ms_hyperv.ghcb_base = alloc_percpu(void *);
> +		if (!ms_hyperv.ghcb_base)
> +			goto clean_guest_os_id;
> +
> +		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
> +		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
> +		if (!ghcb_va) {
> +			free_percpu(ms_hyperv.ghcb_base);
> +			ms_hyperv.ghcb_base = NULL;
> +			goto clean_guest_os_id;
> +		}
> +
> +		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
> +		*ghcb_base = ghcb_va;
>  	}
>  
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> @@ -499,7 +539,8 @@ void __init hyperv_init(void)
>  
>  	return;
>  
> -remove_cpuhp_state:
> +clean_guest_os_id:
> +	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  	cpuhp_remove_state(cpuhp);
>  free_vp_assist_page:
>  	kfree(hv_vp_assist_page);
> @@ -528,6 +569,9 @@ void hyperv_cleanup(void)
>  	 */
>  	hv_hypercall_pg = NULL;
>  
> +	if (ms_hyperv.ghcb_base)
> +		free_percpu(ms_hyperv.ghcb_base);
> +
>  	/* Reset the hypercall page */
>  	hypercall_msr.as_uint64 = 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 347c32eac8fd..d6c363456cbf 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -330,6 +330,8 @@ static void __init ms_hyperv_init_platform(void)
>  	if (ms_hyperv.features_b & HV_ISOLATION) {
>  		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
>  		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
> +		ms_hyperv.shared_gpa_boundary =
> +			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
>  
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index dff58a3db5d5..ad0e33776668 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -34,7 +34,19 @@ struct ms_hyperv_info {
>  	u32 max_vp_index;
>  	u32 max_lp_index;
>  	u32 isolation_config_a;
> -	u32 isolation_config_b;
> +	union
> +	{
> +		u32 isolation_config_b;;
> +		struct {
> +			u32 cvm_type : 4;
> +			u32 Reserved11 : 1;
> +			u32 shared_gpa_boundary_active : 1;
> +			u32 shared_gpa_boundary_bits : 6;
> +			u32 Reserved12 : 20;
> +		};
> +	};
> +	void  __percpu **ghcb_base;
> +	u64 shared_gpa_boundary;
>  };
>  extern struct ms_hyperv_info ms_hyperv;

-- 
Vitaly

