Return-Path: <linux-arch+bounces-10601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECCAA589A7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 01:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CFE3A9610
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4504182D0;
	Mon, 10 Mar 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eneyuQA7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345A632;
	Mon, 10 Mar 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741566666; cv=none; b=EcKsYhqweNz3jBxfLSC2TzGc4rNev7cPBJmWVUqnayKeiOeyBbRFl3o0OtQOgdlHJOjZ11yPcWAMysOX7qtJjXdVB4F7+Uu8bge7+no8C5bJdw0Yw7CfCCZSq6oR4Kz4Z95MO0nA63SZabFrQy7dgIE1NtYkBvPt78sa/nmBJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741566666; c=relaxed/simple;
	bh=127U7j9Ed6A/U+MTwMIn2yifTZmeLRlUzJiRx4bf5Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2OeRBwqIShIwGgie66OoX3Ywi7XacK2QVIo0phYbVAM/KKw5L4EQB4rjvshqZKrYqPwlBCF1JnQMrUADlpVCM0Bkeo4jofTBtFt0HDscfbxTUURILzqkS864Q+LCLOsOZ4qmoD9k9klged1Pa3E81e7Wi7aJVkwNWUiViNBO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eneyuQA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5BC4CEE3;
	Mon, 10 Mar 2025 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741566665;
	bh=127U7j9Ed6A/U+MTwMIn2yifTZmeLRlUzJiRx4bf5Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eneyuQA7ykopq6S8UEKfLVTAcoh47yfGIyP+jGj+MeeDBzaNFNhxvkIPnaRvDW4GR
	 3ElSa1Rcld7O5AzJkk8twIU5lFCgWiBf5vNLPutmhvohsLYdekOvuQxlcATOOmNSOL
	 oy+78DKZe/m1Q8ZxkYJJvGoPrVwC1BrNfuxgULZNHz65IH/M/37K/rifMBJJpuVcom
	 N+TobUAr9cPgkoULGmReb1NG5sZjys6iojuvRBPAwPXGsncjJKQ2ONRM5aUK0ykDOe
	 yCd+V0vOGqXO+XPoZw9/6/ZJu0a+v7uQNA+ckeDwo4Su72E7JnlkAVup+KFU6O2u9D
	 /UkG5nAGdv14g==
Date: Mon, 10 Mar 2025 00:31:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com,
	krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
	lenb@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
	maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev,
	rafael@kernel.org, robh@kernel.org, ssengar@linux.microsoft.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com,
	devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v5 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
Message-ID: <Z84yyAqkqJ2ZyAd-@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-7-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307220304.247725-7-romank@linux.microsoft.com>

On Fri, Mar 07, 2025 at 02:02:58PM -0800, Roman Kisel wrote:
> The hyperv guest code might run in various Virtual Trust Levels.
> 
> Report the level when the kernel boots in the non-default (0)
> one.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 2 ++
>  arch/x86/hyperv/hv_vtl.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index a7db03f5413d..3bc16dbee758 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -108,6 +108,8 @@ static int __init hyperv_init(void)
>  	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
>  	ms_hyperv.vtl = get_vtl();
> +	if (ms_hyperv.vtl > 0) /* non default VTL */

"non-default".

> +		pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
>  
>  	ms_hyperv_late_init();
>  
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 4e1b1e3b5658..c21bee7e8ff3 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -24,7 +24,7 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
>  
>  void __init hv_vtl_init_platform(void)
>  {
> -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);

Where isn't there a check for ms_hyperv.vtl > 0 here?

Please be consistent across different architectures.

>  
>  	x86_platform.realmode_reserve = x86_init_noop;
>  	x86_platform.realmode_init = x86_init_noop;
> -- 
> 2.43.0
> 
> 

