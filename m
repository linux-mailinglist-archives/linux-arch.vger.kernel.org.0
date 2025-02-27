Return-Path: <linux-arch+bounces-10434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C314A48780
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1EE16C609
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6481F584B;
	Thu, 27 Feb 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dCMYHJlh"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430CB199239;
	Thu, 27 Feb 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679895; cv=none; b=ThpHkQpCdEmiAxTFrHhrjXs1z9uhH248YedoUjHYkXkOKrmja80fWtzTvJf4xIAA+w2gDtP0xF+SiOhQciqCbuzuaDgUCQyy8JxS23wev6N3tFALIP5TfOBUJNrl0JoA5Equ8bchodu9T6b/i1kUTUBrGCJ2uPmaPEbo/egCY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679895; c=relaxed/simple;
	bh=wKTSt+MovDiog/H6fF0C7dbKbg+vOqROSarqlY9RWtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLeeO+hiUlG8qpMhDXzHugzQFy3y9ICstc1Ofx0bFmTFh4ka0xBx3rhqDZcHrtxQNTBeZ+GO4JdqsdtaQ64NYit3gQGabSm2pPKFCTip/jtDTFM53d/t6zVqTVPY6QfwIO/y6kWlJYlziCKlJTKF+MqZdFlqEZSRWzcJJNURVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dCMYHJlh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90A85203CDDF;
	Thu, 27 Feb 2025 10:11:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90A85203CDDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740679893;
	bh=5PwRYSAUHqQeSDxhm2bQfQtxnfTWxm0thIO57fvgsKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCMYHJlhcHp7HpaaqM/xo3xcDHeX+BR6NspNgtru54jt68z0NiVe72r6cpxO4KSWl
	 HTpZ6+C8GLgGZxhotNFOeWh4czASJ4l/bfmkWwPf5a+FRxr10C/BdLa7xLlbOZyFPR
	 5i5UA+3HH4wSKGSpk+HAUPHY5Z6rNrW0Av7r9c4Q=
Message-ID: <ba243e7a-927c-4e33-901f-f62a5b1f24eb@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:11:33 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
> hv_call_deposit_pages, and hv_call_create_vp are all needed in module
> with CONFIG_MSHV_ROOT=m.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   arch/arm64/hyperv/mshyperv.c   | 1 +
>   arch/x86/kernel/cpu/mshyperv.c | 1 +
>   drivers/hv/hv_common.c         | 1 +
>   drivers/hv/hv_proc.c           | 3 ++-
>   4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 2265ea5ce5ad..4e27cc29c79e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -26,6 +26,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>   
>   static int __init hyperv_init(void)
>   {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 2c29dfd6de19..0116d0e96ef9 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>   
>   static void __init ms_hyperv_init_platform(void)
>   {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ce20818688fe..252fd66ad4db 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -717,6 +717,7 @@ int hv_result_to_errno(u64 status)
>   	}
>   	return -EIO;
>   }
> +EXPORT_SYMBOL_GPL(hv_result_to_errno);
>   
>   void hv_identify_partition_type(void)
>   {
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 8fc30f509fa7..20c8cee81e2b 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -108,6 +108,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   	kfree(counts);
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>   
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>   {
> @@ -194,4 +195,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>   
>   	return ret;
>   }
> -
> +EXPORT_SYMBOL_GPL(hv_call_create_vp);

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


