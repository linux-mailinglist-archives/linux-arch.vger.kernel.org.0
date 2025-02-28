Return-Path: <linux-arch+bounces-10459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2CA48D94
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E793B420C
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B84C6D;
	Fri, 28 Feb 2025 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jzqkDSoz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F622301;
	Fri, 28 Feb 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703921; cv=none; b=BB7gQjeJYScwoo9mOXhHhpRlMdV61Bhl03CslAQaLUaXF4HeDw1LQt4GMCd4PMW8SWBa2Q/IqufLiLqyIXXJV1EBCd8f2RpktOVrTVfKm/7/Ilbr5R33fY4T4WfB1AocF/V6ICqXwIxmDYBZH0T4ZCpn4suirg8NScL4OIn5FEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703921; c=relaxed/simple;
	bh=9o+Lmx+xTGII9sbB4DhcGUT3pkp4wJe8xIYlPFF3TOE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iZ8gPB00cE8YvHRKE8kYAtzN0J10QUWan11HKog/Z+sd3hGsC+oh0eDLjVkUcmgxaHSOFVi8U0uv2KdFSUOOgN7QWGkEzmRTo65X8l0roI8uaj4HpoOFrCr+C6F5maKJp4fEpusiEpVOrG4PTfT4xqMRwE0mVOv2zEwOSjYsKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jzqkDSoz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B86E210EAC2;
	Thu, 27 Feb 2025 16:51:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B86E210EAC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740703919;
	bh=TedvLHMPHE8XHCBytj3ubvZb/vERcp/qqIqNRTK3pBY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jzqkDSozW6Jc8P6g7f0kthOLKs0gswB3Y5Tx5xcZDSXOfrJhVx8CoEaBJdNmbG3dY
	 5xAXJvEkgzR3GR/RlflR8KKFl4JTy1ZGMIDJ8r9FVmGz/hgGHF4p57cEn8+SCSlTlN
	 8x0I4yt8Rbulty4/1wm7Uf8Xgi9mB3P+Hc7Vx8ZI=
Message-ID: <dca8eb13-e994-482f-a818-5eaa638bd605@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:51:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
> hv_call_deposit_pages, and hv_call_create_vp are all needed in module
> with CONFIG_MSHV_ROOT=m.
> 

Nit: It's generally good practice to use parentheses when mentioning functions, i.e.
hv_get_hypervisor_version(), hv_call_deposit_pages() etc

Otherwise, looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c   | 1 +
>  arch/x86/kernel/cpu/mshyperv.c | 1 +
>  drivers/hv/hv_common.c         | 1 +
>  drivers/hv/hv_proc.c           | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 2265ea5ce5ad..4e27cc29c79e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -26,6 +26,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>  
>  static int __init hyperv_init(void)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 2c29dfd6de19..0116d0e96ef9 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>  
>  static void __init ms_hyperv_init_platform(void)
>  {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ce20818688fe..252fd66ad4db 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -717,6 +717,7 @@ int hv_result_to_errno(u64 status)
>  	}
>  	return -EIO;
>  }
> +EXPORT_SYMBOL_GPL(hv_result_to_errno);
>  
>  void hv_identify_partition_type(void)
>  {
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 8fc30f509fa7..20c8cee81e2b 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -108,6 +108,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  	kfree(counts);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>  
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  {
> @@ -194,4 +195,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  
>  	return ret;
>  }
> -
> +EXPORT_SYMBOL_GPL(hv_call_create_vp);


