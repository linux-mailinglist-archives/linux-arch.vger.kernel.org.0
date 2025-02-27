Return-Path: <linux-arch+bounces-10443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA937A48C49
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A802A3B45EE
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0E23E32D;
	Thu, 27 Feb 2025 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bxzf0KSs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7627780C;
	Thu, 27 Feb 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697406; cv=none; b=GKQjQZqRIHwGVRGBKqrGXswP+F+FHmG5Egll4x3xmiDrLu+rVnb/iwk806wokfbrTBD0Sj0ZcbR4NBwGc+ZsXT4SIUSWVzdo9DnMZa8CZYzKanwxSzRTBLWO6x0bBodlF5Mx/UB+Fj6nz1DPz/buNfQgV0ZI9qDZ/9kYNfgOqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697406; c=relaxed/simple;
	bh=Oh6iicTgRqCb3d6Jv18CnAJ8BsqrIVIXT/9a+s+qe90=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APIzkm1CJTrH7TuFv9FuZPhU3/F7TG0b+yf0qt1T+GToVcTPPKqfXVswd0XbnEYeJEaH9UZiTSC4s9IZ9QxPgeZfPQaQ8gHrmXUG6LN0ES7PBhQw45zczEVi0TNU1ip1U44weTDZOnn7L6UDDUyUUFXEK+XPMdIO3fVqRhRuJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bxzf0KSs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7CFE210EAC1;
	Thu, 27 Feb 2025 15:03:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7CFE210EAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740697404;
	bh=QxAcpt0+lW01/ig2J6vWiepSryvmGyljQIhYNOU2c/8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bxzf0KSsUaGf0Nytx/thMSUWtHwHn5I/IWuc30R4oUpVESsi59QYzve8DdAojqVeS
	 wh7oR5+oq6vJ3pbCm3dM9Bi11DroQv/1tvRSdzmVSbBJ8Q4ubfxZcaWgDCwnVAWAyB
	 SVRIH/V8d2vZzi2MEtzdxJG4TulbapRL5gkG36N8=
Message-ID: <7749367d-d87d-43f0-8c24-cd08bb4ce1a8@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:03:22 -0800
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
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> Factor out the check for enabling auto eoi, to be reused in root
> partition code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv.c                | 12 +-----------
>  include/asm-generic/mshyperv.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 

<snip>

> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 258034dfd829..1f46d19a16aa 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -77,6 +77,19 @@ extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>  
> +/*
> + * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> + * it doesn't provide a recommendation flag and AEOI must be disabled.
> + */
> +static inline bool hv_recommend_using_aeoi(void)
> +{
> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> +	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> +#else
> +	return false;
> +#endif
> +}
> +

I must be missing something very basic here, and if so, I apologize, and please enlighten me.

HV_DEPRECATING_AEOI_RECOMMENDED is defined as BIT(9) in include/hyperv/hvgdk_mini.h, and
asm-generic/mshyperv.h includes that via include/hyperv/hvhdk.h.

If this is the case, when would HV_DEPRECATING_AEOI_RECOMMENDED ever be not defined?
If it's always defined, do we need the #ifdef?

Thanks,
Easwar (he/him)

