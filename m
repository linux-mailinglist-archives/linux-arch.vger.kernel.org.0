Return-Path: <linux-arch+bounces-5962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACED947401
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB091C20F80
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90913CFA1;
	Mon,  5 Aug 2024 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ad8VkI/J"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF0225A2;
	Mon,  5 Aug 2024 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830022; cv=none; b=uKEFouTwh+STsuraTAaQVNdh1cjzqxArIDmePj4FSye4aV+bOdQ001TXRm2q8PeoSid5zYbE2ODVeobcMdsNeRc0U1W4zufcerArRkRnmwfqM5cgjhZwuoRLcB7j+IyICS0iTR9mxO0xWgBfvgOYYLSbxBItP7yUYP8kqIJo6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830022; c=relaxed/simple;
	bh=33eDFO8W6d7SI7QE9iOfChQ/0I3uFJfhv7yR7349Fxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4GTCwF9JWs6mhgEYgeJf6XbIAIv3AMo/wFuQKlbhK5QdYrhXSirQLEU3GcBi2YK2ZQWpIdGGMoaMrxKDVQbC7eDiitnfI9oFmkVWO5UoRzxEdij7rTcEk35tYGSdzA8u4Mfv+7bylf39w+kVW/q2Q6oPHM6ggSlROy1p/HTV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ad8VkI/J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CB21520B7165; Sun,  4 Aug 2024 20:53:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB21520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722830020;
	bh=3yOa1R3fy9ib0F7SoxeqWZ1vzxyTRhDKhyThdqdBT88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad8VkI/JXiWlExVRDoTa5Sy6bK3M5YFwKWrWBWRpQbbfEPze/uHhSdtBwWpFnTNqx
	 MbmBKtOfvc6C6Hk5YUYNsq/S7+JDxpRbap11VP8RM0wmfUDfdZkB/q6GchobQUj9Q+
	 nfbtGRKEIIW3X1fLaWWSRV6adawJDL93sbdM2ks4=
Date: Sun, 4 Aug 2024 20:53:40 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Message-ID: <20240805035340.GA13276@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-2-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 26, 2024 at 03:59:04PM -0700, Roman Kisel wrote:
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
> 
> Hoist the ACPI detection logic into a separate function,
> use the new SMC added recently to Hyper-V to use in the
> non-ACPI case.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
>  arch/arm64/include/asm/mshyperv.h |  5 +++++
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..341f98312667 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -27,6 +27,34 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  	return 0;
>  }
>  
> +static bool hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/* Hypervisor ID is only available in ACPI v6+. */
> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool hyperv_detect_via_smc(void)
> +{
> +	struct arm_smccc_res res = {};
> +
> +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +
> +	return res.a0 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
> +		res.a1 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
> +		res.a2 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
> +		res.a3 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
> +}

As you mentioned in the cover letter this is supported in latest Hyper-V hypervisor,
can we add a comment about it, specifying the exact version in it would be great.

If someone attempts to build non-ACPI kernel on older Hyper-V what is the
behaviour of this function, do we need to safeguard or handle that case ?

- Saurabh


