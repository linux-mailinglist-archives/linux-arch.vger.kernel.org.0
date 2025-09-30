Return-Path: <linux-arch+bounces-13810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A42BAEB9D
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 01:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24390169C0E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02824C068;
	Tue, 30 Sep 2025 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDWkJifP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F50433B3;
	Tue, 30 Sep 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273536; cv=none; b=LqP6Zu1Vh2wSGAoMmh+vgrFxxxRV8Tq7ZITjUATDsJD7A8+brwdqzYNz5hnM/TvxGdlnYN3EKbKc3FBtAtZ6lCNJZqGBJIia8yGrcHT307UA3A0LYIkm57dcFZzIVOQo61pdfUbCErU8ysESRNd+D6KROHk2Ga51EbnGSPM5xUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273536; c=relaxed/simple;
	bh=9F3UlcQn2tMNvTLRxebq+6nMCQOvDBR6s/sw3oxC5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1r2SSzpi4IZsDHKjaTDriOKIoN0Kn926A8h5kGsNc3VICBCd6yV+/EdyZKvINCrVT1dF1P3Kst2k0WKMy+U+qJr7He1I1y+Kw00QK+1vsv8Tz9Tgo+OQ3DoMd1vPLTKrxYYxD/xSNTLZsfD+RmH5ggRkATJ1Ej80N8NEksWKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDWkJifP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C8C4CEF0;
	Tue, 30 Sep 2025 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759273535;
	bh=9F3UlcQn2tMNvTLRxebq+6nMCQOvDBR6s/sw3oxC5KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDWkJifPt/hsw6VFR1GqDPfycT+Ye1fO99DAj+oUKV1HsZoQjQWiTFj+NbwEImQbq
	 7Eek2BvA7ASDlNDSgedJ8uxAJcaxlA/g1pHBBtrZPb87GfSOHu7keR/ODapAbLgK5H
	 Nx09vkBkCoBPtSFJ5OreYdSR9LFQViYQMl3VCqmgERHIevzcxR0DZtyekNuZFhGhO9
	 7ZEGcKtZsUwtxuLpSqERrT4Xm+rL7x//sjD9/s80BLhKn3QaCWhBbt414e14NEaWnm
	 bEMPWTBxIqYYB3cUw/7qXxDTkb78a+bH4bGYGMxVae1zzBt03wP0p4yVabCyOObRu5
	 rr4zxQLzYwrfA==
Date: Tue, 30 Sep 2025 23:05:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com, kvijayab@amd.com, romank@linux.microsoft.com,
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Message-ID: <aNxiPhrbquYg3PGq@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>

On Thu, Sep 18, 2025 at 11:00:18AM -0400, Tianyu Lan wrote:
> Secure AVIC is a new hardware feature in the AMD64
> architecture to allow SEV-SNP guests to prevent the
> hypervisor from generating unexpected interrupts to
> a vCPU or otherwise violate architectural assumptions
> around APIC behavior.
> 
> Each vCPU has a guest-allocated APIC backing page of
> size 4K, which maintains APIC state for that vCPU.
> APIC backing page's ALLOWED_IRR field indicates the
> interrupt vectors which the guest allows the hypervisor
> to send.
> 
> This patchset is to enable the feature for Hyper-V
> platform. Patch "Drivers: hv: Allow vmbus message
> synic interrupt injected from Hyper-V" is to expose
> new fucntion hv_enable_coco_interrupt() and device
> driver and arch code may update AVIC backing page
> ALLOWED_IRR field to allow Hyper-V inject associated
> vector.
> 
> The patchset is based on the tip tree commit 27a17e02418e
> (x86/sev: Indicate the SEV-SNP guest supports Secure AVIC)
> 
> Tianyu Lan (5):
>   x86/hyperv: Don't use hv apic driver when Secure AVIC is available
>   drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
>   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
>   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

These look good to me.

>   x86/Hyper-V: Add Hyper-V specific hvcall to set backing page

Please address Borislav's comment on this patch.

Thanks,
Wei

> 
>  arch/x86/hyperv/hv_apic.c           |  8 ++++++
>  arch/x86/hyperv/hv_init.c           | 31 ++++++++++++++++++++++-
>  arch/x86/hyperv/ivm.c               | 38 ++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  2 ++
>  arch/x86/kernel/apic/x2apic_savic.c |  9 ++++++-
>  arch/x86/kernel/cpu/mshyperv.c      |  3 +++
>  drivers/hv/hv.c                     |  2 ++
>  drivers/hv/hv_common.c              |  5 ++++
>  include/asm-generic/mshyperv.h      |  1 +
>  include/hyperv/hvgdk_mini.h         | 39 +++++++++++++++++++++++++++++
>  10 files changed, 136 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

