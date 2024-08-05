Return-Path: <linux-arch+bounces-5963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68637947431
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FA1B21D28
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63792594;
	Mon,  5 Aug 2024 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c74LQN71"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A005639;
	Mon,  5 Aug 2024 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830705; cv=none; b=sNVtoZsRyc4Ytz2EqTRLSgUl1KmraWG4Fx6I28JApckOrh4suQkmjMyfKuBqASmWlVUeswHlRVzqMk5fH5KlXnGA5rN1mwiGXyc8RGBOHjrQsSsko4iJPzhkbKLbXydXxRL+vgdaW7iNfXnsxP76EvG2n+HPH6Zb7vL6vZch2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830705; c=relaxed/simple;
	bh=F5UlEKjcdOB3fmvxR/q7kBnXO4gxaT2S1xTmAp6cR3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXm4eJVbCyQ23CQsLwv8sJxL1l1eJA20eWCT9a7EvgrJiUTrQFaEdeHd2vcxLohM0T248HQi6jSysl0SXaTHhMU9l2tc5+jiH82F9zbsAlXm8dhgdd7IPPrjj1utTcBFAVwZEEIcFXxOi/HweB+RMq32EQIusW0dDYj3+OVomO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c74LQN71; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D47E520B7177; Sun,  4 Aug 2024 21:05:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D47E520B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722830703;
	bh=I1GaWJg8Sp2+uOGgu35UgR9+VgzXj8/xH9Lf/Hrt7Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c74LQN71DfX/CJUDisQXdTAepBkL0nVpSPw6WlmCRewdc4vsQZJEdy5eIWf/M3ki3
	 pp9PpSZ2FoTBL1NkB6WCbJgIIMz2zQFj1mgFltjGasnS6+gqTKCbf0uyBpsjs5Qd83
	 4Im8NXkZ7x2Ai3gkBDt93WooBClwxTxwrXsaX8mI=
Date: Sun, 4 Aug 2024 21:05:03 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com" <kw@linux.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>,
	"vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: Re: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Message-ID: <20240805040503.GA14919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-3-romank@linux.microsoft.com>
 <SN6PR02MB4157824AC8ECA000559F5160D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157824AC8ECA000559F5160D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 05, 2024 at 03:01:58AM +0000, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
> > 
> > Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
> > and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
> > dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't require
> > arm64 guests on Hyper-V to have ACPI.
> > 
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 862c47b191af..a5cd1365e248 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> >  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> > +		|| (ARM64 && !CPU_BIG_ENDIAN)
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR if X86
> >  	select OF_EARLY_FLATTREE if OF
> > @@ -15,7 +15,7 @@ config HYPERV
> > 
> >  config HYPERV_VTL_MODE
> >  	bool "Enable Linux to boot in VTL context"
> > -	depends on X86_64 && HYPERV
> > +	depends on HYPERV
> >  	depends on SMP
> >  	default n
> >  	help
> > @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
> > 
> >  	  Select this option to build a Linux kernel to run at a VTL other than
> >  	  the normal VTL0, which currently is only VTL2.  This option
> > -	  initializes the x86 platform for VTL2, and adds the ability to boot
> > +	  initializes the kernel to run in VTL2, and adds the ability to boot
> >  	  secondary CPUs directly into 64-bit context as required for VTLs other
> >  	  than 0.  A kernel built with this option must run at VTL2, and will
> >  	  not run as a normal guest.
> > --
> > 2.34.1
> > 
> 
> In v2 of this patch, I suggested [1] making a couple additional minor changes
> so that kernels built *without* HYPER_VTL_MODE would still require
> ACPI.  Did that suggestion not work out?  If that's the case, I'm curious
> about what goes wrong.

Hi Michael/Roman,
I was considering making HYPERV_VTL_MODE depend on CONFIG_OF. That should address
above concern as well. Do you see any potential issue with it.

- Saurabh

