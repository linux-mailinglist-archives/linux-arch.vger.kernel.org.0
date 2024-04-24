Return-Path: <linux-arch+bounces-3928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890238B10AF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6121F23FDB
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2E16D332;
	Wed, 24 Apr 2024 17:08:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FA16D324;
	Wed, 24 Apr 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978517; cv=none; b=rDX7YldO6vXHE91SdcmPsw+7EY0wWQEVb37iNGButJMeQc0LynQtDO6XIUmOY0AQpzziCGEHKZ/rxn/sIsRgRKM2J9W+qyT1jHKkJTagputWWbWaJaW3CnWjOlwaherlJZjr0+taALPBdSS1wjkkKwzIkccKSzj+u8oHdg0Sa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978517; c=relaxed/simple;
	bh=O1pq/ISUV3l7ZIKZLlkalLC1kLeYxyB8yvf9TagRkAM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFHwFB+hf2AmvHFuKcTMLMuA92JuaRYbGLTfwa+TrJcSBb4isgLSu7dCp//OtdR9m0EQ51MwKwALx6ykuAAXAOhtJycWcdkd8g+dhxEvSrG7dpEr9P8KQPD0HPzzpzdfWcJ9v7GL01AJu8kHtEixB1M/hWUc4ZEFLDlbs15CmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VPlkX1nPtz6J9Zf;
	Thu, 25 Apr 2024 01:06:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B7401400DB;
	Thu, 25 Apr 2024 01:08:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 18:08:31 +0100
Date: Wed, 24 Apr 2024 18:08:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Message-ID: <20240424180830.00002a36@Huawei.com>
In-Reply-To: <e149e79446be4ed99178eedda3e8a674@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
	<86il06rd19.wl-maz@kernel.org>
	<e149e79446be4ed99178eedda3e8a674@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 17:35:54 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> >  From: Marc Zyngier <maz@kernel.org>
> >  Sent: Wednesday, April 24, 2024 4:33 PM
> >  To: Jonathan Cameron <jonathan.cameron@huawei.com>
> >  Cc: Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra
> >  <peterz@infradead.org>; linux-pm@vger.kernel.org;
> >  loongarch@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
> >  arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> >  kernel@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org;
> >  Russell King <linux@armlinux.org.uk>; Rafael J . Wysocki
> >  <rafael@kernel.org>; Miguel Luis <miguel.luis@oracle.com>; James Morse
> >  <james.morse@arm.com>; Salil Mehta <salil.mehta@huawei.com>; Jean-
> >  Philippe Brucker <jean-philippe@linaro.org>; Catalin Marinas
> >  <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Linuxarm
> >  <linuxarm@huawei.com>; Ingo Molnar <mingo@redhat.com>; Borislav
> >  Petkov <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>;
> >  justin.he@arm.com; jianyong.wu@arm.com
> >  Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
> >  disabled but 'online capable' CPUs
> >  
> >  On Wed, 24 Apr 2024 13:54:38 +0100,
> >  Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:  
> >  >
> >  > On Tue, 23 Apr 2024 13:01:21 +0100
> >  > Marc Zyngier <maz@kernel.org> wrote:
> >  >  
> >  > > On Mon, 22 Apr 2024 11:40:20 +0100,
> >  > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:  
> >  > > >
> >  > > > On Thu, 18 Apr 2024 14:54:07 +0100 Jonathan Cameron
> >  > > > <Jonathan.Cameron@huawei.com> wrote:  
> >  
> >  [...]
> >    
> >  > > >  
> >  > > > > +	/*
> >  > > > > +	 * Capable but disabled CPUs can be brought online later.  What about
> >  > > > > +	 * the redistributor? ACPI doesn't want to say!
> >  > > > > +	 * Virtual hotplug systems can use the MADT's "always-on"  GICR entries.
> >  > > > > +	 * Otherwise, prevent such CPUs from being brought online.
> >  > > > > +	 */
> >  > > > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> >  > > > > +		pr_warn_once("CPU %u's redistributor is  inaccessible: this CPU can't be brought online\n", cpu);
> >  > > > > +		set_cpu_present(cpu, false);
> >  > > > > +		set_cpu_possible(cpu, false);  
> 
> (a digression) shouldn't we be clearing the enabled mask as well?
> 
>                                           set_cpu_enabled(cpu, false);

FWIW I think not necessary. enabled is only set in register_cpu() and aim here is to
never call that for CPUs in this state.

Anyhow, I got distracted by the firmware bug I found whilst trying to test this but
now have a test setup that hits this path (once deliberately broken), so will
see what we can do about that doesn't have affect those masks.

Jonathan


> 
> 
> Best regards
> Salil


