Return-Path: <linux-arch+bounces-10413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448AFA46FAF
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461303AC495
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853525D1E4;
	Wed, 26 Feb 2025 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n+MWT2Of"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5127004B;
	Wed, 26 Feb 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613886; cv=none; b=DjCW1fIis3Vna0ZNLN01KYV1Sj251L1ossFKzxTN34Pb+RhAh6euGyiyw7W4fhUxTNRPtIFnCRXMi6FRPjipvOTau3ZBS5dsinA0I0w2wPRsQuqVtpwRn2ZaE68gIwuStvIjcTGnYZM4LEliJH5hCoEjfAnaAfPAnD7ekeFnk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613886; c=relaxed/simple;
	bh=owoOiIV/S68Na7TeG/F8G65pYaMGYPs8EpWgXG+MHvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6C6crFVKM6TkXM+qwJq7/O5Ed2AVlD5xXe5/ES5vgzU+n8h+TDqZTfe3E9NttR3UzVs2IVLRiHl4dRrCRf+DCqNQgL+Tuww7VYPokpCFjpYenMLsCe8m9WoxqJN7je75aRRTguP6fIa8P33gDkFEINnTzpqq3mNC1zIxOYv5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n+MWT2Of; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id C853F210EACD;
	Wed, 26 Feb 2025 15:51:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C853F210EACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740613884;
	bh=d+6I+3A1b4iKmWuAFLCEc6Cxy/RwiNoKQINkgAxYW+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+MWT2OfBjANgztlGDriEEM11l+NAjEHrobcrCxCnPibzMo12xR4JKZRSGtO0sf4w
	 3RzDqrRxyFlELGGpbpBsyaGm5ADrPpt55c8GJbd1TQx3u+LIJHojqvAByoYbTphfI2
	 0PnHNwffW+IeWKXwvZTUTq9JqJ8upPvhZlec5Gn4=
Date: Wed, 26 Feb 2025 15:51:21 -0800
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
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
Message-ID: <Z7-o-VnE6iffOi7Z@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:08:03PM -0800, Nuno Das Neves wrote:
> A few additional definitions are required for the mshv driver code
> (to follow). Introduce those here and clean up a little bit while
> at it.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  64 ++++++++++++++++-
>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>  3 files changed, 280 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 58895883f636..e4a3cca0cbce 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
 @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /* HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>  
> +enum hv_intercept_type {
> +#if defined(CONFIG_X86_64)

Prehaps it would be nice to have per-arch headers for such structures
instead.

> +	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0x00000000,
> +	HV_INTERCEPT_TYPE_X64_MSR			= 0x00000001,
> +	HV_INTERCEPT_TYPE_X64_CPUID			= 0x00000002,
> +#endif
> +	HV_INTERCEPT_TYPE_EXCEPTION			= 0x00000003,
> +	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
> +	HV_INTERCEPT_TYPE_RESERVED0			= 0x00000004,
> +	HV_INTERCEPT_TYPE_MMIO				= 0x00000005,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0x00000006,
> +	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0x00000007,
> +#endif
> +	HV_INTERCEPT_TYPE_HYPERCALL			= 0x00000008,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0x00000009,
> +	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0x0000000A,
> +	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0x0000000B,
> +	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0x0000000C,
> +#endif
> +	HV_INTERCEPT_TYPE_MAX,
> +	HV_INTERCEPT_TYPE_INVALID			= 0xFFFFFFFF,
> +};
> +
> +union hv_intercept_parameters {
> +	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
> +	__u64 as_uint64;

Should this one be "u64" instead of "__u64" (here and below) ?

> +#if defined(CONFIG_X86_64)
> +	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
> +	__u16 io_port;
> +	/* HV_INTERCEPT_TYPE_X64_CPUID */
> +	__u32 cpuid_index;
> +	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
> +	__u32 apic_write_mask;
> +	/* HV_INTERCEPT_TYPE_EXCEPTION */
> +	__u16 exception_vector;
> +	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
> +	__u32 msr_index;
> +#endif
> +	/* N.B. Other intercept types do not have any parameters. */
> +};
> +
>  /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
>  #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
>  
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 64407c2a3809..1b447155c338 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -19,11 +19,24 @@
>  
>  #define HV_VP_REGISTER_PAGE_VERSION_1	1u
>  
> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT		7
> +
> +union hv_vp_register_page_interrupt_vectors {
> +	u64 as_uint64;
> +	struct {
> +		u8 vector_count;
> +		u8 vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
> +	} __packed;
> +} __packed;

Packed attribute for the union looks redundant.

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

