Return-Path: <linux-arch+bounces-5208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D443C91D0D0
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 11:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F37281B43
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FE12D769;
	Sun, 30 Jun 2024 09:26:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FF374CC;
	Sun, 30 Jun 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739617; cv=none; b=geAzICeLsyc53ZT08j4Q6pX2O57iUHNaoFhRfrCY1BSOxKJikVjFeUt0tjWU7Ug/C6SNFjgIK37wyUi3tQ5jvmJ7a9gKl3PqK5Wh/fA1xOTJHyrQBkHcDhR1wswSt4QCIlK0uCem/s2AGVKQkB+HFN7zMrAHCBekKZ7fH2Q3BaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739617; c=relaxed/simple;
	bh=G6kjI9e67vuphJpJZBPzCIb8jDjF9XA4lesDH05PDMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bav5FaD2DEsOMkBBzK3j0HoaPXAChmYZrKyOFrIZCT2uTD5gWr0NKHA57S6CuivqKl+snptIFGWR9jwSvYuQ7xnBLRSst9DXzOU8iInmmExeZPIMKxkafCaLuwNd8ciJtVTHXtcc3hDdl5EssIdtiKAQBhKW/WPJpapROK0l6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88924C2BD10;
	Sun, 30 Jun 2024 09:26:52 +0000 (UTC)
Date: Sun, 30 Jun 2024 10:26:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	x86@kernel.org, Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
	justin.he@arm.com, jianyong.wu@arm.com
Subject: Re: [PATCH v10 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
Message-ID: <ZoEk2mfQkIhLuh-8@arm.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
 <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
 <47a261e0-006d-4c64-9c9b-bc73797b8d6b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47a261e0-006d-4c64-9c9b-bc73797b8d6b@redhat.com>

Hi Gavin,

On Sun, Jun 30, 2024 at 10:39:04AM +1000, Gavin Shan wrote:
> On 5/29/24 11:34 PM, Jonathan Cameron wrote:
> > In order to move arch_register_cpu() to be called via the same path
> > for initially present CPUs described by ACPI and hotplugged CPUs
> > ACPI_HOTPLUG_CPU needs to be enabled.
> > 
> > The protection against invalid IDs in acpi_map_cpu() is needed as
> > at least one production BIOS is in the wild which reports entries
> > in DSDT (with no _STA method, so assumed enabled and present)
> > that don't match MADT.
> > 
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   arch/arm64/Kconfig       |  1 +
> >   arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
> >   2 files changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5d91259ee7b5..e8f2ef2312db 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -5,6 +5,7 @@ config ARM64
> >   	select ACPI_CCA_REQUIRED if ACPI
> >   	select ACPI_GENERIC_GSI if ACPI
> >   	select ACPI_GTDT if ACPI
> > +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
> 
> ACPI_HOTPLUG_CPU depends on (ACPI_PROCESSOR && HOTPLUG_CPU). It needs to be:
> 
> 	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
> 
> Otherwise, we can have compiling error with the following configurations.
> 
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_HOTPLUG_CPU=n
> CONFIG_ACPI_HOTPLUG_CPU=y
> 
> arch/arm64/kernel/smp.c: In function ‘arch_unregister_cpu’:
> arch/arm64/kernel/smp.c:563:9: error: implicit declaration of function ‘unregister_cpu’; did you mean ‘register_cpu’? [-Werror=implicit-function-declaration]
>   563 |         unregister_cpu(c);
>       |         ^~~~~~~~~~~~~~
>       |         register_cpu

Ah, I thought that in addition to the warning for unmet dependencies,
kbuild would also leave the option off. I need to add SUSPEND=n and
HIBERNATE=n to my build scripts.

The fix matches what x86 does, so I'm ok with it.

> Since the series has been queued to Catalin's "for-next/vcpu-hotplug" branch, I
> guess the easiest way would be to fix it in place with Catalin's help.

I wasn't planning to rebase the branch unless there's something major.
Since the doesn't happen with defconfig, it's doesn't affect bisection
that much, so my preference would be for a fix on top of this branch
(and with a Fixes: tag since the branch is stable).

Thanks.

-- 
Catalin

