Return-Path: <linux-arch+bounces-9296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171009E7EB2
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 08:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74A3163599
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06A6F2F2;
	Sat,  7 Dec 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy3jnFxO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9213398A;
	Sat,  7 Dec 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733556984; cv=none; b=jT7Z0GpKptpZdMcnOqcQxhIxx/JLt5c/r7wig98e2BlpE+6IpJqTQIGXleaczWiRbpSfrOQy6+usmZJoKeBrDCPkxx8dtAe2OMlc9rUVpCFtRqcrcUcZwNOHFE+bo8wxRdh2vJmD4GCfgTnDZZYC4sPewBLTP5hh4FSVuCjR6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733556984; c=relaxed/simple;
	bh=iLSvIrLPNNbchuaGZc83iW4IkW+Y9a/O2Ve94PJllHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfHbdPDDMRSurDC2KjleA/ljz4Q8mjpHV85ZDQ4ehQ4zovLz10L+41a1zPrN+8p0hfKMqGyqnAGl7bjTfthoqzX0rhg5/+qaVdkYygJ+CsPwScz0GmmDp0inP9KSB9+TuRBAPj0NkzxzYUqdafTa3yynsAfkP+/TDKcFE2nqOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy3jnFxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD36C4CECD;
	Sat,  7 Dec 2024 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733556983;
	bh=iLSvIrLPNNbchuaGZc83iW4IkW+Y9a/O2Ve94PJllHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy3jnFxOn67Nm3tt98eEl+L6+gQUemFu+mQfWiFPk1oDVJeMkOGNTkwJHlRhBM1Ql
	 ySciepeIlxYSytJ4h2NPtGNI5xe+Bbhrn4BOOQOwtUvHfEZAoYiJ/5N7uyezWfddMY
	 spYQRwlko8yNSZ/0sC0V4DnuL8AGbAkDxPbAeCGO98/mxyTjLHk/bZgJnwipSWspAp
	 6C37EZIPZCzM8LynC67ujfb2JskbefvqILPP3TnWEisjuiz/D7ro/8Fgk1FEcCbrzD
	 di/ITVdbm5WdlWY5XjvZJ60dAg2ZbZPBBCDzzXQE90+zqKYNFXDnuL++ZAmYpJFi/S
	 v4jvnhbgPC6Mw==
Date: Sat, 7 Dec 2024 07:36:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: Re: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic
 code
Message-ID: <Z1P69tl2qMNH-xmg@liuwe-devbox-debian-v2>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Dec 06, 2024 at 02:21:46PM -0800, Nuno Das Neves wrote:
> From: Nuno Das Neves <nudasnev@microsoft.com>
> 
> Make hv_current_partition_id available in both x86_64 and arm64.
> This feature isn't specific to x86_64 and will be needed by common
> code.
> 
> While at it, replace the BUG()s with WARN()s. Failing to get the id
> need not crash the machine (although it is a very bad sign).
> 

A lot of things have changed since it was introduced. I don't remember
why I decided to use BUG() instead of WARN() in the first place.

If the system can still function without knowing its partition id, then
can this be removed completely? We can always use the SELF id.

Thanks,
Wei.

> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c    |  3 +++
>  arch/x86/hyperv/hv_init.c       | 25 +------------------------
>  arch/x86/include/asm/mshyperv.h |  2 --
>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  2 ++
>  5 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..5050e748d266 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,6 +19,9 @@
>  
>  static bool hyperv_initialized;
>  
> +u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 95eada2994e1..950f5ccdb9d9 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -35,7 +35,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  
> -u64 hv_current_partition_id = ~0ull;
> +u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>  
>  void *hv_hypercall_pg;
> @@ -394,24 +394,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
>  		old_setup_percpu_clockev();
>  }
>  
> -static void __init hv_get_partition_id(void)
> -{
> -	struct hv_get_partition_id *output_page;
> -	u64 status;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> -	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> -	if (!hv_result_success(status)) {
> -		/* No point in proceeding if this failed */
> -		pr_err("Failed to get partition ID: %lld\n", status);
> -		BUG();
> -	}
> -	hv_current_partition_id = output_page->partition_id;
> -	local_irq_restore(flags);
> -}
> -
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
> @@ -606,11 +588,6 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> -		hv_get_partition_id();
> -
> -	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
> -
>  #ifdef CONFIG_PCI_MSI
>  	/*
>  	 * If we're running as root, we want to create our own PCI MSI domain.
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 5f0bc6a6d025..9eeca2a6d047 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -44,8 +44,6 @@ extern bool hyperv_paravisor_present;
>  
>  extern void *hv_hypercall_pg;
>  
> -extern u64 hv_current_partition_id;
> -
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
>  bool hv_isolation_type_snp(void);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 7a35c82976e0..819bcfd2b149 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,11 +278,34 @@ static void hv_kmsg_dump_register(void)
>  	}
>  }
>  
> +static void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u64 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		WARN(true, "Failed to get partition ID: %lld\n", status);
> +		return;
> +	}
> +	hv_current_partition_id = output_page->partition_id;
> +	local_irq_restore(flags);
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
>  	union hv_hypervisor_version_info version;
>  
> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();
> +
> +	WARN_ON(hv_root_partition && hv_current_partition_id == HV_PARTITION_ID_SELF);
> +
>  	/* Get information about the Hyper-V host version */
>  	if (!hv_get_hypervisor_version(&version))
>  		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 8fe7aaab2599..8c4ff6e9aae7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -60,6 +60,8 @@ struct ms_hyperv_info {
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
>  
> +extern u64 hv_current_partition_id;
> +
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>  
> -- 
> 2.34.1
> 

