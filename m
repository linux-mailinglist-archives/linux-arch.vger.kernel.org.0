Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3F761D45
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGYPXh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjGYPXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 11:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E55E42
        for <linux-arch@vger.kernel.org>; Tue, 25 Jul 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690298566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9mBhDoGQ3JObgjS7OW/V+V7P8XjDmhT8kheexTlPRE=;
        b=XxRjPQGr/XH2B0aNT/2q6SSgLXs5AQ00I9f6H+BEhKdwsdKDj0fTISE+tEuVNhh1eWROYx
        LoM3g48J1NDy1jWiBzlUsH6WgG6QQ2ROcaK4xtfsl9bDs7uSTFZuJ1aJgTUNMH9uOQ/muP
        KH4Pr7v7tMYy415YWAFdRLLtjqAi1fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-QAdFgxtPNkq6TPR3328slQ-1; Tue, 25 Jul 2023 11:22:45 -0400
X-MC-Unique: QAdFgxtPNkq6TPR3328slQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso34498775e9.2
        for <linux-arch@vger.kernel.org>; Tue, 25 Jul 2023 08:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298564; x=1690903364;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9mBhDoGQ3JObgjS7OW/V+V7P8XjDmhT8kheexTlPRE=;
        b=Fgba4/dBUH+T6SsR0L6pDaAuCuP5qR2Il+2mF/xj8DMs5m4j/mAF/Iifa1Qc2IDr7y
         HUgVRh5ucrYRTRoGjOCYVCbTium/0gq7NB3f/o+V6QU9VubA/YcgGyTkWg7JVRc9/Pq2
         y7QgqW5wx+bflUBRvYZu/yAB2K0XGmlt5XVU7+Y9J033mhe5wYs9PUkiLr9ol2H4fQKH
         z705aVuEDLmkB1c+AA8sR3bklYyAEuPiKVNHVX4vGSJ1lcR78zehSo8PJI6cUIgVUi0f
         imb6GovTmQSqCdFb0BWgifvJDBwo7Qmls+6om7j8gwMT/9rzzQdtvlZzGu4GLJ8MZOa2
         U/Jg==
X-Gm-Message-State: ABy/qLa+k6vGh+Sm2EDQBGwrnwI7wN4E1GegPpbgOIrhgTofyDGz0lVn
        pr/C2fBww7qJNdm12s1EJB4ja82WBEWUDp+QCxHd7xd85+FTq9RO2sXeV3mG7k5OZIQmhG8QZ20
        TmX4waawrjZe/hwBN7Vqt6w==
X-Received: by 2002:a05:600c:2106:b0:3f9:ba2:5d19 with SMTP id u6-20020a05600c210600b003f90ba25d19mr9572172wml.33.1690298564443;
        Tue, 25 Jul 2023 08:22:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5krxv/KWhPryzhnakx2wQxMZ6yI0hRhzu2uZF4bzXXhPeA+DNxkXZTfxfSPbdPPWW6Kq3XQ==
X-Received: by 2002:a05:600c:2106:b0:3f9:ba2:5d19 with SMTP id u6-20020a05600c210600b003f90ba25d19mr9572148wml.33.1690298564043;
        Tue, 25 Jul 2023 08:22:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id d11-20020a1c730b000000b003fc00892c13sm13278785wmb.35.2023.07.25.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:22:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, rppt@kernel.org, nikunj@amd.com,
        thomas.lendacky@amd.com, liam.merwick@oracle.com,
        alexandr.lobakin@intel.com, michael.roth@amd.com,
        tiala@microsoft.com, pasha.tatashin@soleen.com,
        peterz@infradead.org, jpoimboe@kernel.org,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
In-Reply-To: <20230725150825.283891-1-ltykernel@gmail.com>
References: <20230725150825.283891-1-ltykernel@gmail.com>
Date:   Tue, 25 Jul 2023 17:22:41 +0200
Message-ID: <871qgwow1q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> Rename hv_isolation_type_snp and hv_isolation_type_en_snp()
> to make them much intuitiver.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Thanks for the patch! A few comments below ...

> ---
> This patch is based on the patchset "x86/hyperv: Add AMD sev-snp
> enlightened guest support on hyperv" https://lore.kernel.org/lkml/
> 20230718032304.136888-3-ltykernel@gmail.com/T/.
>
>  arch/x86/hyperv/hv_init.c       |  6 +++---
>  arch/x86/hyperv/ivm.c           | 17 +++++++++--------
>  arch/x86/include/asm/mshyperv.h |  8 ++++----
>  arch/x86/kernel/cpu/mshyperv.c  | 12 ++++++------
>  drivers/hv/connection.c         |  2 +-
>  drivers/hv/hv.c                 | 16 ++++++++--------
>  drivers/hv/hv_common.c          | 10 +++++-----
>  include/asm-generic/mshyperv.h  |  4 ++--
>  8 files changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b004370d3b01..49054dc30604 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
>  	void *ghcb_va;
>  	void **ghcb_base;
>  
> -	if (!hv_isolation_type_snp())
> +	if (!isol_type_snp_paravisor())
>  		return 0;
>  
>  	if (!hv_ghcb_pg)
> @@ -116,7 +116,7 @@ static int hv_cpu_init(unsigned int cpu)
>  			 * is blocked to run in Confidential VM. So only decrypt assist
>  			 * page in non-root partition here.
>  			 */
> -			if (*hvp && hv_isolation_type_en_snp()) {
> +			if (*hvp && isol_type_snp_enlightened()) {
>  				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>  				memset(*hvp, 0, PAGE_SIZE);
>  			}
> @@ -453,7 +453,7 @@ void __init hyperv_init(void)
>  		goto common_free;
>  	}
>  
> -	if (hv_isolation_type_snp()) {
> +	if (isol_type_snp_paravisor()) {
>  		/* Negotiate GHCB Version. */
>  		if (!hv_ghcb_negotiate_protocol())
>  			hv_ghcb_terminate(SEV_TERM_SET_GEN,
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 2eda4e69849d..2911c2525ed5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -591,24 +591,25 @@ bool hv_is_isolation_supported(void)
>  	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
>  }
>  
> -DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +DEFINE_STATIC_KEY_FALSE(isol_type_snp_paravisor_flag);
>  
>  /*
> - * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> + * isol_type_snp_paravisor - Check system runs in the AMD SEV-SNP based
>   * isolation VM.
>   */
> -bool hv_isolation_type_snp(void)
> +bool isol_type_snp_paravisor(void)


I think that it would be better to keep 'hv_' prefix here for two reasons: 
...

>  {
> -	return static_branch_unlikely(&isolation_type_snp);
> +	return static_branch_unlikely(&isol_type_snp_paravisor_flag);
...
First reason is that it would be possible to drop '_flag' suffix here.
...

>  }
>  
> -DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +DEFINE_STATIC_KEY_FALSE(isol_type_snp_enlightened_flag);
> +
>  /*
> - * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isol_type_snp_enlightened - Check system runs in the AMD SEV-SNP based
>   * isolation enlightened VM.
>   */
> -bool hv_isolation_type_en_snp(void)
> +bool isol_type_snp_enlightened(void)
>  {
> -	return static_branch_unlikely(&isolation_type_en_snp);
> +	return static_branch_unlikely(&isol_type_snp_enlightened_flag);
>  }
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index c5a3c29fad01..51eb239d71dd 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -25,8 +25,8 @@
>  
>  union hv_ghcb;
>  
> -DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> -DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +DECLARE_STATIC_KEY_FALSE(isol_type_snp_paravisor_flag);
> +DECLARE_STATIC_KEY_FALSE(isol_type_snp_enlightened_flag);
>  
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -46,7 +46,7 @@ extern void *hv_hypercall_pg;
>  
>  extern u64 hv_current_partition_id;
>  
> -extern bool hv_isolation_type_en_snp(void);
> +extern bool isol_type_snp_enlightened(void);
>  
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
> @@ -268,7 +268,7 @@ static inline void hv_sev_init_mem_and_cpu(void) {}
>  static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>  #endif
>  
> -extern bool hv_isolation_type_snp(void);
> +extern bool isol_type_snp_paravisor(void);
>  
>  static inline bool hv_is_synic_reg(unsigned int reg)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 6ff0b60d30f9..d9dcee48099c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -66,7 +66,7 @@ u64 hv_get_non_nested_register(unsigned int reg)
>  {
>  	u64 value;
>  
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +	if (hv_is_synic_reg(reg) && isol_type_snp_paravisor())
>  		hv_ghcb_msr_read(reg, &value);
>  	else
>  		rdmsrl(reg, value);
> @@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
>  
>  void hv_set_non_nested_register(unsigned int reg, u64 value)
>  {
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> +	if (hv_is_synic_reg(reg) && isol_type_snp_paravisor()) {
>  		hv_ghcb_msr_write(reg, value);
>  
>  		/* Write proxy bit via wrmsl instruction */
> @@ -300,7 +300,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
>  	 *  enlightened guest.
>  	 */
> -	if (hv_isolation_type_en_snp())
> +	if (isol_type_snp_enlightened())
>  		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
>  
>  	if (!hv_root_partition)
> @@ -421,9 +421,9 @@ static void __init ms_hyperv_init_platform(void)
>  
>  
>  		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> -			static_branch_enable(&isolation_type_en_snp);
> +			static_branch_enable(&isol_type_snp_enlightened_flag);
>  		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
> -			static_branch_enable(&isolation_type_snp);
> +			static_branch_enable(&isol_type_snp_paravisor_flag);
>  		}
>  	}
>  
> @@ -545,7 +545,7 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>  
> -	if (hv_isolation_type_en_snp())
> +	if (isol_type_snp_enlightened())
>  		hv_sev_init_mem_and_cpu();
>  
>  	hardlockup_detector_disable();
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 02b54f85dc60..8659d18a55fe 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
>  
>  	++channel->sig_events;
>  
> -	if (hv_isolation_type_snp())
> +	if (isol_type_snp_paravisor())
>  		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
>  				NULL, sizeof(channel->sig_event));
>  	else
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index ec6e35a0d9bf..7651d79205da 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -64,7 +64,7 @@ int hv_post_message(union hv_connection_id connection_id,
>  	aligned_msg->payload_size = payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>  
> -	if (hv_isolation_type_snp())
> +	if (isol_type_snp_paravisor())
>  		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
>  				(void *)aligned_msg, NULL,
>  				sizeof(*aligned_msg));
> @@ -109,7 +109,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +		if (!isol_type_snp_paravisor() && !hv_root_partition) {
>  			hv_cpu->synic_message_page =
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page == NULL) {
> @@ -125,7 +125,7 @@ int hv_synic_alloc(void)
>  			}
>  		}
>  
> -		if (hv_isolation_type_en_snp()) {
> +		if (isol_type_snp_enlightened()) {
>  			ret = set_memory_decrypted((unsigned long)
>  				hv_cpu->synic_message_page, 1);
>  			if (ret) {
> @@ -174,7 +174,7 @@ void hv_synic_free(void)
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
>  		/* It's better to leak the page if the encryption fails. */
> -		if (hv_isolation_type_en_snp()) {
> +		if (isol_type_snp_enlightened()) {
>  			if (hv_cpu->synic_message_page) {
>  				ret = set_memory_encrypted((unsigned long)
>  					hv_cpu->synic_message_page, 1);
> @@ -221,7 +221,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled = 1;
>  
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (isol_type_snp_paravisor() || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -240,7 +240,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled = 1;
>  
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (isol_type_snp_paravisor() || hv_root_partition) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -323,7 +323,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled = 0;
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (isol_type_snp_paravisor() || hv_root_partition) {
>  		iounmap(hv_cpu->synic_message_page);
>  		hv_cpu->synic_message_page = NULL;
>  	} else {
> @@ -335,7 +335,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled = 0;
>  
> -	if (hv_isolation_type_snp() || hv_root_partition) {
> +	if (isol_type_snp_paravisor() || hv_root_partition) {
>  		iounmap(hv_cpu->synic_event_page);
>  		hv_cpu->synic_event_page = NULL;
>  	} else {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2d43ba2bc925..527e91409ef7 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -381,7 +381,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>  		}
>  
> -		if (hv_isolation_type_en_snp()) {
> +		if (isol_type_snp_enlightened()) {
>  			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
>  			if (ret) {
>  				kfree(*inputarg);
> @@ -509,17 +509,17 @@ bool __weak hv_is_isolation_supported(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
>  
> -bool __weak hv_isolation_type_snp(void)
> +bool __weak isol_type_snp_paravisor(void)
>  {
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
> +EXPORT_SYMBOL_GPL(isol_type_snp_paravisor);
>  
> -bool __weak hv_isolation_type_en_snp(void)
> +bool __weak isol_type_snp_enlightened(void)
>  {
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +EXPORT_SYMBOL_GPL(isol_type_snp_enlightened);
>  
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index f73a044ecaa7..d60a9306c0cc 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -64,7 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> -extern bool hv_isolation_type_snp(void);
> +extern bool isol_type_snp_paravisor(void);
>  
>  /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
>  static inline int hv_result(u64 status)
> @@ -279,7 +279,7 @@ bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  enum hv_isolation_type hv_get_isolation_type(void);
>  bool hv_is_isolation_supported(void);
> -bool hv_isolation_type_snp(void);
> +bool isol_type_snp_paravisor(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);

...

Second reason is that 'isol_type_snp_paravisor'/'isol_type_snp_enlightened'
are exported and present in headers, it is unclear that these are
Hyper-V related.

-- 
Vitaly

