Return-Path: <linux-arch+bounces-10411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A993EA46F84
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC17A3AE4DF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A42620D8;
	Wed, 26 Feb 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JJJRcjPE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50C82620D4;
	Wed, 26 Feb 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613152; cv=none; b=o586/WodtIZVMUt9oERKxqvX4zJLBtwwgwsDPOfSwCsBQ/8nCeHVVi21d2F1gGSb98v6PxifYE2q7T7LORbuVWlIjAK4KbISYVHGbUAPRlqtyQZva6Rq3cSht+srMoJSiU3Gg+JNSi8KAjS2B1xaZRnxdAeiQrR9yHxm3f1hwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613152; c=relaxed/simple;
	bh=UwBqgHb2FDtCRZVHrxd0ZfnTJAkOxlWOsCJKr4g0luw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8+a0BPTeRezOSzsS75jl+aTezAiXiFN2heDW6o+2SehbYHnhZgAdZlMbBFTywFaI2iquLRnLQMo6Qns8xkWW/gZ0PB08b7Olg0XSOpVDuRtFSAkDEeMQIrjRUVSgHOh1JPO0jMdlTM03j29RFGXgPN4NlIERNLS8MZ5eOe7yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JJJRcjPE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2DF42210EAC0;
	Wed, 26 Feb 2025 15:39:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DF42210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740613150;
	bh=Q+HFT7bov+RaxIItYhtEfkOy6FPJyEYGXdPDsHKSe8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJJRcjPE/QIMIWzQnEoRiW6U1WnIINrXiVvJWQ6SHe0J6Saw4V1bdRSbUnD4lmaE3
	 d6c7uPQ45dx0pqG+9B6BE9SrlLpyhUGtOqtctbhnWQWH2n1fnDbKqauHNqamkMGQNK
	 aWNXEuKaqfgxLl6RqOOpp/XMUGVS6vSKorL8G/Xo=
Date: Wed, 26 Feb 2025 15:39:07 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org, vkuznets@redhat.com,
	prapal@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Message-ID: <Z7-mG7X-cyZAKa7V@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:08:01PM -0800, Nuno Das Neves wrote:
> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
> SynIC event ring buffer for each SINT.
> 
> This will be used by the mshv driver, but must be tracked independently
> since the driver module could be removed and re-inserted.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 252fd66ad4db..2763cb6d3678 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>  int hv_common_cpu_init(unsigned int cpu)
>  {
>  	void **inputarg, **outputarg;
> +	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	const int pgcount = hv_output_page_exists() ? 2 : 1;
> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>  	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  
>  	/*
> -	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
> -	 * allocated if this CPU was previously online and then taken offline
> +	 * The per-cpu memory is already allocated if this CPU was previously
> +	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
>  		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>  		}
>  
> +		if (hv_root_partition()) {
> +			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> +			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
> +							sizeof(u8), flags);
> +

Redundant empty line ^^^
> +			if (unlikely(!*synic_eventring_tail)) {
> +				kfree(mem);
> +				return -ENOMEM;
> +			}
> +		}
> +
>  		if (!ms_hyperv.paravisor_present &&
>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>  			ret = set_memory_decrypted((unsigned long)mem, pgcount);

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> -- 
> 2.34.1
> 

