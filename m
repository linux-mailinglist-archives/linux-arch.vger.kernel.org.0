Return-Path: <linux-arch+bounces-10642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E15A59BAF
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EE188A292
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3869230BC8;
	Mon, 10 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T90BZrzK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAA216392;
	Mon, 10 Mar 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625596; cv=none; b=BdTkF07lo/P+nEycTrsjOAKL088DTE8BdsbtxRRTTBFF+NFhSc7vA/CShJq5mXDq6Kb2D7rwXIDSa6D85KgaDBz/hBWD11blfUgkTztg99dqjffiPB/45Dgo4+R+MFeTIHRTO7Z8UHXuQcSA1JUrINYcOVvXPHxzyD3dl8tOoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625596; c=relaxed/simple;
	bh=1BgaCQUGjQAOFM2D533osL0JWW3ihZoxHt/01NLC7o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj21qTRPn/AUC2LgaWTeenPX7AF5KQScM0fRw3WXKfGIowYpq/LrITMuidieP1+/rvJ+VZZ1CTg10FXhut6sKAadwYS+6uvypAlXB7qFNQAlKdv5Zr3V0bT/8xurU5BpotCC+G4zHVMIQPkwXxL+OS4uJOe3VnTNeHqtOrpgoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T90BZrzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D301C4CEE5;
	Mon, 10 Mar 2025 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625595;
	bh=1BgaCQUGjQAOFM2D533osL0JWW3ihZoxHt/01NLC7o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T90BZrzKkMaFjQSN1Wg9F/kJ/P0/1qgdM5YfI/PPzUXluWCl/0lAsIuPt4k3EisEJ
	 6g5WBqtRXrh0DztHQE16HokVpCRvdv3gXBFYJEc1ns+kyMsYAoTvsHv+1DZtP/RdZK
	 iuXuFB+zwH89BPHlDjijaLla71syZ8n+Dhhg9qViTmcScJY3zpkZgooDXLykJTZvck
	 IB/uTUXesE9e/kJZQ8MyRb42iANVgt2fbt2+PwNNAnqiFW7G13vJiylJEqlqXH8H1J
	 HULez/bKqe48z/oNYxTLZbiVWDg8EQAQ9JvQOhkAgn3WUw6tdm8nLLlLRV8IMJvME5
	 6IA/VEFHVgVhw==
Date: Mon, 10 Mar 2025 16:53:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, arnd@arndb.de, bhelgaas@google.com,
	bp@alien8.de, catalin.marinas@arm.com, conor+dt@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com,
	krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
	lenb@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
	maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev,
	rafael@kernel.org, robh@kernel.org, ssengar@linux.microsoft.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
	will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v5 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
Message-ID: <Z88Y-R7BnXa4Xi3I@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-7-romank@linux.microsoft.com>
 <Z84yyAqkqJ2ZyAd-@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <2342dda1-2976-4506-ab68-640739a1bd5b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2342dda1-2976-4506-ab68-640739a1bd5b@linux.microsoft.com>

On Mon, Mar 10, 2025 at 09:42:15AM -0700, Roman Kisel wrote:
> 
> 
> On 3/9/2025 5:31 PM, Wei Liu wrote:
> > On Fri, Mar 07, 2025 at 02:02:58PM -0800, Roman Kisel wrote:
> > > The hyperv guest code might run in various Virtual Trust Levels.
> > > 
> > > Report the level when the kernel boots in the non-default (0)
> > > one.
> > > 
> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > ---
> > >   arch/arm64/hyperv/mshyperv.c | 2 ++
> > >   arch/x86/hyperv/hv_vtl.c     | 2 +-
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> > > index a7db03f5413d..3bc16dbee758 100644
> > > --- a/arch/arm64/hyperv/mshyperv.c
> > > +++ b/arch/arm64/hyperv/mshyperv.c
> > > @@ -108,6 +108,8 @@ static int __init hyperv_init(void)
> > >   	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> > >   		hv_get_partition_id();
> > >   	ms_hyperv.vtl = get_vtl();
> > > +	if (ms_hyperv.vtl > 0) /* non default VTL */
> > 
> > "non-default".
> > 
> 
> Thanks, will fix that!
> 
> > > +		pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
> > >   	ms_hyperv_late_init();
> > > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > > index 4e1b1e3b5658..c21bee7e8ff3 100644
> > > --- a/arch/x86/hyperv/hv_vtl.c
> > > +++ b/arch/x86/hyperv/hv_vtl.c
> > > @@ -24,7 +24,7 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
> > >   void __init hv_vtl_init_platform(void)
> > >   {
> > > -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > > +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
> > 
> > Where isn't there a check for ms_hyperv.vtl > 0 here?
> > 
> 
> On x86, there is
> 
> #ifdef CONFIG_HYPERV_VTL_MODE
> void __init hv_vtl_init_platform(void);
> int __init hv_vtl_early_init(void);
> #else
> static inline void __init hv_vtl_init_platform(void) {}
> static inline int __init hv_vtl_early_init(void) { return 0; }
> #endif
> 
> > Please be consistent across different architectures.
> > 
> 
> In the earlier versions of the patch series, I had that piece
> from the above mirrored in the arm64, and there was advice on
> removing the function as it contained just one statement.
> I'll revisit the approach, thanks for your help!

As long as the output is consistent across different architectures, I'm
good.

Wei.

> 
> > >   	x86_platform.realmode_reserve = x86_init_noop;
> > >   	x86_platform.realmode_init = x86_init_noop;
> > > -- 
> > > 2.43.0
> > > 
> > > 
> 
> -- 
> Thank you,
> Roman
> 

