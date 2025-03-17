Return-Path: <linux-arch+bounces-10902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ABFA64CEA
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65431891DE9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24663236426;
	Mon, 17 Mar 2025 11:38:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB4199E8D;
	Mon, 17 Mar 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211491; cv=none; b=sMAPg6Ng4yx/Kb8jj6OZMkdnPCvvLTgF4MbAplLq2iN1mdlZOEBzRlxXXp7pWrTWHEgK7F3m3bPbuYS9gBSoTkwcfoM+tLW5KVuAXXEJHJ9hx8CfVUr1VymAnSGKt45OMNxLd+csk53BlCVUquG9lOiVGP1hvtrdpmscXPCgmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211491; c=relaxed/simple;
	bh=EqvvYmOyfgYejPEXBf8UIa6m1QV3pZwmCtppfI9ul+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkipM+JPb4dnbep4o0FHJOALbRPH4YCY2TAx8pk0bah+XOQxMZn5Qwqn8UhI/Nktf9D4OYchDbCs+tZZeH8Jvz/ytevutzKVXJgT50B/ki4htYoWVqXpAhOOdqEfNTpg/4ZyOss6/pT8AXK2YruEbXcbXMz5uCJ8q7Z+0BUyhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DB3413D5;
	Mon, 17 Mar 2025 04:38:16 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BECB3F694;
	Mon, 17 Mar 2025 04:38:00 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:37:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dan.carpenter@linaro.org, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
	kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, maz@kernel.org, mingo@redhat.com,
	oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
	ssengar@linux.microsoft.com, sudeep.holla@arm.com,
	suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Message-ID: <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315001931.631210-3-romank@linux.microsoft.com>

On Fri, Mar 14, 2025 at 05:19:22PM -0700, Roman Kisel wrote:
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
> 
> Hoist the ACPI detection logic into a separate function. Then
> use the vendor-specific hypervisor service call (implemented
> recently in Hyper-V) via SMCCC in the non-ACPI case.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 43 +++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 2265ea5ce5ad..c5b03d3af7c5 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -27,6 +27,41 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  	return 0;
>  }
>  
> +static bool __init hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/*
> +	 * Hypervisor ID is only available in ACPI v6+, and the
> +	 * structure layout was extended in v6 to accommodate that
> +	 * new field.
> +	 *
> +	 * At the very minimum, this check makes sure not to read
> +	 * past the FADT structure.
> +	 *
> +	 * It is also needed to catch running in some unknown
> +	 * non-Hyper-V environment that has ACPI 5.x or less.
> +	 * In such a case, it can't be Hyper-V.
> +	 */
> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
> +#else
> +	return false;
> +#endif
> +}
> +

The 'acpi_disabled' variable doesn't exist for !CONFIG_ACPI, so its use
prior to the ifdeffery looks misplaced.

Usual codestyle is to avoid ifdeffery if possible, using IS_ENABLED().
Otherwise, use a stub, e.g.

| #ifdef CONFIG_ACPI
| static bool __init hyperv_detect_via_acpi(void)
| {
| 	if (acpi_disabled)
| 		return false;
| 	
| 	if (acpi_gbl_FADT.header.revision < 6)
| 		return false;
| 	
| 	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
| }
| #else
| static inline bool hyperv_detect_via_acpi(void) { return false; }
| #endif

Mark.

> +static bool __init hyperv_detect_via_smccc(void)
> +{
> +	uuid_t hyperv_uuid = UUID_INIT(
> +		0x4d32ba58, 0x4764, 0xcd24,
> +		0x75, 0x6c, 0xef, 0x8e,
> +		0x24, 0x70, 0x59, 0x16);
> +
> +	return arm_smccc_hyp_present(&hyperv_uuid);
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +70,11 @@ static int __init hyperv_init(void)
>  
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>  
>  	/* Setup the guest ID */
> -- 
> 2.43.0
> 

