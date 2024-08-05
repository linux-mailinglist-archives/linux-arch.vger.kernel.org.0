Return-Path: <linux-arch+bounces-6026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74294855E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FF283B42
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C0A1514CE;
	Mon,  5 Aug 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ExG996eQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67905149C6A;
	Mon,  5 Aug 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896139; cv=none; b=BSMiJybkVXdju52biWapT2xqQeLTuX0hj4XehrbTuuGvvgpDkh/lLgyGcnTELO3YXDRYLfEt/sBIIO877dvIxwsbj4iUeQKgEfNKOhqLZHDo44H+yI/Z4QC5/LqJL6nRc3ZRYtZJbbB8Qh15sgezjGqjOanrvMQTb0rIlfIERiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896139; c=relaxed/simple;
	bh=Qd9QtJL78qy4DZtivGdD9JK7nN9GwbtazNpwHPFdXFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VP2UIjvOnme68PvzPBnV2EFH4u+iP8h4d/n4TGyYHf8MbaGeVZGj+nAkiCmNSOKLVe4bFwgzd/E2xJvuFHJThLxFgn9q0uhHMcUACS40i7wLweCQvJsQLCOzra80odSG0BmztmzdhMf0Ez2k+xjx+eWNvJZVrD3SEDN3yE+wmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ExG996eQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A133720B7165;
	Mon,  5 Aug 2024 15:15:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A133720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722896137;
	bh=G3dgLn42s1ul+udyzzDEMMSWft6zAfZ2rlnkvyFt+OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExG996eQVxnp55uEL3uhRAoHERbEJIYfxjRemCmsgZGiUBoZxjRCPZpKL5WD9jWyQ
	 TSCGCpbSaUQLk3irbv0+SlRckxO/veFeFezDOCoQjrlAllSgRy5KT9xycRWAvauccK
	 ibdf2bXQpbmQCqGbWC6LteHxJDIvJ+KUW+qKSSXk=
From: Roman Kisel <romank@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: apais@microsoft.com,
	arnd@arndb.de,
	benhill@microsoft.com,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	robh@kernel.org,
	romank@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	tglx@linutronix.de,
	vdso@hexbites.dev,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org
Subject: RE: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Date: Mon,  5 Aug 2024 15:15:37 -0700
Message-Id: <20240805221537.383265-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SN6PR02MB4157B22BD56677EFBD215D87D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157B22BD56677EFBD215D87D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > 
> > On 8/4/2024 9:05 PM, Saurabh Singh Sengar wrote:
> > > On Mon, Aug 05, 2024 at 03:01:58AM +0000, Michael Kelley wrote:
> > >> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59
> > PM
> > >>>
> > >>> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
> > >>> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
> > >>> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't require
> > >>> arm64 guests on Hyper-V to have ACPI.
> > >>>
> > >>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > >>> ---
> > >>>   drivers/hv/Kconfig | 6 +++---
> > >>>   1 file changed, 3 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > >>> index 862c47b191af..a5cd1365e248 100644
> > >>> --- a/drivers/hv/Kconfig
> > >>> +++ b/drivers/hv/Kconfig
> > >>> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
> > >>>   config HYPERV
> > >>>   	tristate "Microsoft Hyper-V client drivers"
> > >>>   	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > >>> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> > >>> +		|| (ARM64 && !CPU_BIG_ENDIAN)
> > >>>   	select PARAVIRT
> > >>>   	select X86_HV_CALLBACK_VECTOR if X86
> > >>>   	select OF_EARLY_FLATTREE if OF
> > >>> @@ -15,7 +15,7 @@ config HYPERV
> > >>>
> > >>>   config HYPERV_VTL_MODE
> > >>>   	bool "Enable Linux to boot in VTL context"
> > >>> -	depends on X86_64 && HYPERV
> > >>> +	depends on HYPERV
> > >>>   	depends on SMP
> > >>>   	default n
> > >>>   	help
> > >>> @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
> > >>>
> > >>>   	  Select this option to build a Linux kernel to run at a VTL other than
> > >>>   	  the normal VTL0, which currently is only VTL2.  This option
> > >>> -	  initializes the x86 platform for VTL2, and adds the ability to boot
> > >>> +	  initializes the kernel to run in VTL2, and adds the ability to boot
> > >>>   	  secondary CPUs directly into 64-bit context as required for VTLs other
> > >>>   	  than 0.  A kernel built with this option must run at VTL2, and will
> > >>>   	  not run as a normal guest.
> > >>> --
> > >>> 2.34.1
> > >>>
> > >>
> > >> In v2 of this patch, I suggested [1] making a couple additional minor changes
> > >> so that kernels built *without* HYPER_VTL_MODE would still require
> > >> ACPI.  Did that suggestion not work out?  If that's the case, I'm curious
> > >> about what goes wrong.
> > >
> > > Hi Michael/Roman,
> > > I was considering making HYPERV_VTL_MODE depend on CONFIG_OF. That should
> > address
> > > above concern as well. Do you see any potential issue with it.
> > >
> > Michael,
> > 
> > I ran into a pretty gnarly recursive dependencies which in all fairness
> > might stem from not being fluent enough in the Kconfig language. Any
> > help of how to approach implementing your idea would be greatly appreciated!
> > 
> 
> This is what I had in mind:
> 
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,7 +5,8 @@ menu "Microsoft Hyper-V guest support"
 > config HYPERV
        > tristate "Microsoft Hyper-V client drivers"
        > depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -               || (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +               || (ARM64 && !CPU_BIG_ENDIAN)
> +       depends on (ACPI || HYPERV_VTL_MODE)
        > select PARAVIRT
        > select X86_HV_CALLBACK_VECTOR if X86
        > select OF_EARLY_FLATTREE if OF
> @@ -15,7 +16,7 @@ config HYPERV
> 
 > config HYPERV_VTL_MODE
        > bool "Enable Linux to boot in VTL context"
> -       depends on X86_64 && HYPERV
> +       depends on X86_64
        > depends on SMP
        > default n
        > help
> 
> HYPERV_VTL_MODE can now be selected independently of HYPERV.
> The existing code should be such that even if someone is building a
> random config and gets HYPERV_VTL_MODE without HYPERV, the
> kernel will build and run in a non-Hyper-V environment and isn't
> broken somehow.
> 
> For HYPERV to be selected, either ACPI must already be selected, or
> HYPERV_VTL_MODE must already be selected. So "normal" kernels are
> still enforced to require ACPI. But if building with HYPERV_VTL_MODE,
> then ACPI is optional.
> 
Thanks a ton! Let me try this out for the (arch; VTL) build matrix :)

> Saurabh's idea of adding "depends on OF" to HYPERV_VTL_MODE
> should also work with these changes.
> 
> I haven't fully tested the above with all the relevant combinations
> on both x86 and arm64, but I think the logic makes sense.

