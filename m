Return-Path: <linux-arch+bounces-3956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A798B1F15
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260211F24446
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B786636;
	Thu, 25 Apr 2024 10:24:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FB85277;
	Thu, 25 Apr 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040642; cv=none; b=Gga+avrUyHu7GW/Yfo+ZbA/GDulY/k5EFRAAlQY8nc3/nINAVQfrMMnRpKV4AsOL5hzDU09vb1dBVaTLKzgE02NABS0/3PxK/p9R2xzTzVwHFHP3CXYtnFqAj8T8u48MkJp+1bV/Ka03qnPBIns8OTi/KYC7E1YrLjxrWP0vYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040642; c=relaxed/simple;
	bh=wmKTX0hf311FdAlA97nBVl4pjiE0U/L+0ndYEl0pI3U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZl3lzLOCZSudKg1Gjk8dtvV/9B0Sjg+ZTUxrRVeGItLMzSxk7cy5edXoiVBlev90LANWkQTWC6C5PDvMrZ1N5pY8sM6ziejP+Tacmq2LN1w77LJtvIxTCe6vvAjcoC4jAYZEzWtOjMaDL7Dw07f49V8uRGUZOx8yh1fTlk+rqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQBlk33SFz6D9Ct;
	Thu, 25 Apr 2024 18:23:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 65841140736;
	Thu, 25 Apr 2024 18:23:56 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 11:23:55 +0100
Date: Thu, 25 Apr 2024 11:23:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linuxarm
	<linuxarm@huawei.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240425112354.00000f26@huawei.com>
In-Reply-To: <20240424180830.00002a36@Huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
	<86il06rd19.wl-maz@kernel.org>
	<e149e79446be4ed99178eedda3e8a674@huawei.com>
	<20240424180830.00002a36@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 18:08:30 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 24 Apr 2024 17:35:54 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
> 
> > >  From: Marc Zyngier <maz@kernel.org>
> > >  Sent: Wednesday, April 24, 2024 4:33 PM
> > >  To: Jonathan Cameron <jonathan.cameron@huawei.com>
> > >  Cc: Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra
> > >  <peterz@infradead.org>; linux-pm@vger.kernel.org;
> > >  loongarch@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
> > >  arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > >  kernel@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org;
> > >  Russell King <linux@armlinux.org.uk>; Rafael J . Wysocki
> > >  <rafael@kernel.org>; Miguel Luis <miguel.luis@oracle.com>; James Morse
> > >  <james.morse@arm.com>; Salil Mehta <salil.mehta@huawei.com>; Jean-
> > >  Philippe Brucker <jean-philippe@linaro.org>; Catalin Marinas
> > >  <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Linuxarm
> > >  <linuxarm@huawei.com>; Ingo Molnar <mingo@redhat.com>; Borislav
> > >  Petkov <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>;
> > >  justin.he@arm.com; jianyong.wu@arm.com
> > >  Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
> > >  disabled but 'online capable' CPUs
> > >  
> > >  On Wed, 24 Apr 2024 13:54:38 +0100,
> > >  Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:    
> > >  >
> > >  > On Tue, 23 Apr 2024 13:01:21 +0100
> > >  > Marc Zyngier <maz@kernel.org> wrote:
> > >  >    
> > >  > > On Mon, 22 Apr 2024 11:40:20 +0100,
> > >  > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:    
> > >  > > >
> > >  > > > On Thu, 18 Apr 2024 14:54:07 +0100 Jonathan Cameron
> > >  > > > <Jonathan.Cameron@huawei.com> wrote:    
> > >  
> > >  [...]
> > >      
> > >  > > >    
> > >  > > > > +	/*
> > >  > > > > +	 * Capable but disabled CPUs can be brought online later.  What about
> > >  > > > > +	 * the redistributor? ACPI doesn't want to say!
> > >  > > > > +	 * Virtual hotplug systems can use the MADT's "always-on"  GICR entries.
> > >  > > > > +	 * Otherwise, prevent such CPUs from being brought online.
> > >  > > > > +	 */
> > >  > > > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > >  > > > > +		pr_warn_once("CPU %u's redistributor is  inaccessible: this CPU can't be brought online\n", cpu);
> > >  > > > > +		set_cpu_present(cpu, false);
> > >  > > > > +		set_cpu_possible(cpu, false);    
> > 
> > (a digression) shouldn't we be clearing the enabled mask as well?
> > 
> >                                           set_cpu_enabled(cpu, false);  
> 
> FWIW I think not necessary. enabled is only set in register_cpu() and aim here is to
> never call that for CPUs in this state.
> 
> Anyhow, I got distracted by the firmware bug I found whilst trying to test this but
> now have a test setup that hits this path (once deliberately broken), so will
> see what we can do about that doesn't have affect those masks.

This may be relevant with the context of Marc's email.  Don't crop so much!
However I think we probably don't care. This is bios bug, if we miss report it such
that userspace thinks it can online something that work work, it probably doesn't
matter.

Jonathan

> 
> Jonathan
> 
> 
> > 
> > 
> > Best regards
> > Salil  
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


