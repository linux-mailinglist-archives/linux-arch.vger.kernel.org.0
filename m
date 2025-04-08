Return-Path: <linux-arch+bounces-11314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B3A7F5A2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF481898D22
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096A261360;
	Tue,  8 Apr 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuNiBJYi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19635979;
	Tue,  8 Apr 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096007; cv=none; b=I9LyKDYL10YTW235M8J+efPOXq7SYNbHcLGvEVBIwQrYqST+I4QqwoNVCPHVD++m0BiDQVj96ygy4r8GQb1Ymam3FzQVvwiP9c7sA8J/XajVjIku0XmMotmFAz1S+CWd4CWHhiPw3JnZpON8r+dGEzrcMwZjiVwTWqWS43tzlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096007; c=relaxed/simple;
	bh=b4/HM8+SciHG286LvQnLgT/d3PAh2mnGk8+5TyFZWoU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6wSqExhdJ2bVMT5SKOA3VbjgrtgNI56C7SgkG5bcKB3OuLmIr0NVk4s1YJhOdVxXohZl33DBuwFlAL00LXN9CFhUQQPSux341Bjr1OMzvuOoT9XmyNuCU99lAhD/hEcXTkFMD2LJ332b5PIFCPndwNCh0nVjbDSl2A/keO0UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuNiBJYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4448C4CEE5;
	Tue,  8 Apr 2025 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744096007;
	bh=b4/HM8+SciHG286LvQnLgT/d3PAh2mnGk8+5TyFZWoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tuNiBJYibWOt5+vSOcQ+JRLaGgZWDkwaR5g7lNtcFTYc0eXDRKe6tq4CFJoPxKpIt
	 5zBNMaoK7dfKeOvGjJHcZC3SgfNhwMciKiHLr3Xj3tBZTIQAQriWeFzCef/7bg1+dE
	 hyqgZvsEdCEEUnc8kb8ixxAmY0ceVaTbQ/FV/etjY5hzXxF4tmwW+1dePcWZiVahGl
	 0JA6jU7oJiTCnEF5XrUfeiimXLagzfg43mKERJZSQ+zqZhgvK4Qk5R1p1r9X+bNtjt
	 Kk9dCK73/RxRciBC9MdW/1HCWKw9hR/5lrex479hCJcM2sa/cq97vi7qhYhnbL+BmN
	 nEcjjtUmDVjOg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u232h-003JRY-F2;
	Tue, 08 Apr 2025 08:06:43 +0100
Date: Tue, 08 Apr 2025 08:06:42 +0100
Message-ID: <86semjku7x.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	rafael.j.wysocki@intel.com,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v7 01/11] arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID
In-Reply-To: <20250407201336.66913-2-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
	<20250407201336.66913-2-romank@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: romank@linux.microsoft.com, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org, dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org, rafael.j.wysocki@intel.com, ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft
 .com, sunilmut@microsoft.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 07 Apr 2025 21:13:26 +0100,
Roman Kisel <romank@linux.microsoft.com> wrote:
> 
> The KVM/arm64 uses SMCCC to detect hypervisor presence. That code is
> private, and it follows the SMCCC specification. Other existing and
> emerging hypervisor guest implementations can and should use that
> standard approach as well.
> 
> Factor out a common infrastructure that the guests can use, update KVM
> to employ the new API. The central notion of the SMCCC method is the
> UUID of the hypervisor, and the new API follows that.
> 
> No functional changes. Validated with a KVM/arm64 guest.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/kvm/hypercalls.c        | 10 +++--
>  drivers/firmware/smccc/kvm_guest.c | 10 +----
>  drivers/firmware/smccc/smccc.c     | 17 ++++++++
>  include/linux/arm-smccc.h          | 64 ++++++++++++++++++++++++++++--
>  4 files changed, 85 insertions(+), 16 deletions(-)
>

[...]

> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 67f6fdf2e7cd..4bb38f0e3fe2 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -7,6 +7,11 @@
>  
>  #include <linux/args.h>
>  #include <linux/init.h>
> +
> +#ifndef __ASSEMBLER__
> +#include <linux/uuid.h>
> +#endif

That's a pretty unusual guard in arm64 land. Looking at the current
state of the kernel:

$ git grep -w __ASSEMBLER__ arch/arm64/ | wc -l
2
$ git grep -w __ASSEMBLY__ arch/arm64/ | wc -l
122

I'd suggest the later rather than the former.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

