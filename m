Return-Path: <linux-arch+bounces-206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E557E9868
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671181C203A4
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1318022;
	Mon, 13 Nov 2023 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s1qV1NPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391116436;
	Mon, 13 Nov 2023 08:57:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434EC46AB;
	Mon, 13 Nov 2023 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s5Y4+GBI1idt885dHqSlmCpxDTCC53GskoMylOtfMEQ=; b=s1qV1NPdjQcYNlQAH0HnCureja
	lYM0KeWoOVTXJ+nvcY2qysAv8biWNl91gK+sRrrAZOAF2kpgUNC1Rf74g61vu4921ppiLkBKMhxuF
	vrbxEEQZ6Y2WiKanzePtJUZhu5YRPTe/3tShMKJE0MaFOCI8tl1pBhatLMJ0Opz9VKhtqJvhQNFgY
	Rbu4qwcgsu9qGSWU18ENEur4D0vN0y/p2/RqEGqzx7AGj9uH9cYx37B76a+mjUqS1V+E/YKRcrWl1
	1Yw/qPK5OgBxXP4uhXJRADiWqdVeMdSXRl4xTamkdzHGqHhYXNOY5gmCHtVTzZBjeQl0vQ1L62eQH
	wEOSGG8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49224)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r2SkQ-0006OC-2B;
	Mon, 13 Nov 2023 08:56:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r2SkM-0004PF-EM; Mon, 13 Nov 2023 08:56:42 +0000
Date: Mon, 13 Nov 2023 08:56:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH RFC 05/22] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on
 arm64 and riscv
Message-ID: <ZVHkykFMp+CMUqyf@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JL6-00CTws-3z@rmk-PC.armlinux.org.uk>
 <8e288692-7460-4aa4-86f3-500327256bc3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e288692-7460-4aa4-86f3-500327256bc3@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 13, 2023 at 10:29:39AM +1000, Gavin Shan wrote:
> On 11/7/23 20:29, Russell King (Oracle) wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Neither arm64 nor riscv support physical hotadd of CPUs that were not
> > present at boot. For arm64 much of the platform description is in static
> > tables which do not have update methods. arm64 does support HOTPLUG_CPU,
> > which is backed by a firmware interface to turn CPUs on and off.
> > 
> > acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
> > and removing CPUs that were not present at boot. arm64 systems that do this
> > are not supported as there is currently insufficient information in the
> > platform description. (e.g. did the GICR get removed too?)
> > 
> > arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
> > to prevent CPUs that were not described as present at boot from being
> > added to the system. Similarly, riscv relies on the same check in
> > map_rintc_hartid(). Both architectures also rely on the weak 'always fails'
> > definitions of acpi_map_cpu() and arch_register_cpu().
> > 
> > Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
> > CPUs present. Neither arm64 nor riscv support this.
> > 
> > Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
> > selecting it on the other three ACPI architectures. This allows the weak
> > definitions of some symbols to be removed.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Changes since RFC:
> >   * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
> >     HOTPLUG_CPU isn't.
> > Changes since RFC v3:
> >   * Dropped ia64 changes
> > ---
> >   arch/loongarch/Kconfig        |  1 +
> >   arch/x86/Kconfig              |  1 +
> >   drivers/acpi/Kconfig          |  1 -
> >   drivers/acpi/acpi_processor.c | 18 ------------------
> >   4 files changed, 2 insertions(+), 19 deletions(-)
> > 
> 
> With the following nits addressed:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index d889a0b97bc1..64620e90c12c 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -5,6 +5,7 @@ config LOONGARCH
> >   	select ACPI
> >   	select ACPI_GENERIC_GSI if ACPI
> >   	select ACPI_MCFG if ACPI
> > +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
> >   	select ACPI_PPTT if ACPI
> >   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> >   	select ARCH_BINFMT_ELF_STATE
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 3762f41bb092..dbdcfc708369 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -59,6 +59,7 @@ config X86
> >   	#
> >   	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
> >   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> > +	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
> >   	select ARCH_32BIT_OFF_T			if X86_32
> >   	select ARCH_CLOCKSOURCE_INIT
> >   	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index f819e760ff19..a3acfc750fce 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -310,7 +310,6 @@ config ACPI_HOTPLUG_CPU
> >   	bool
> >   	depends on ACPI_PROCESSOR && HOTPLUG_CPU
> >   	select ACPI_CONTAINER
> > -	default y
> >   config ACPI_PROCESSOR_AGGREGATOR
> >   	tristate "Processor Aggregator"
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 0f5218e361df..4fe2ef54088c 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> >   /* Initialization */
> >   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> > -int __weak acpi_map_cpu(acpi_handle handle,
> > -		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
> > -{
> > -	return -ENODEV;
> > -}
> > -
> > -int __weak acpi_unmap_cpu(int cpu)
> > -{
> > -	return -ENODEV;
> > -}
> > -
> > -int __weak arch_register_cpu(int cpu)
> > -{
> > -	return -ENODEV;
> > -}
> > -
> > -void __weak arch_unregister_cpu(int cpu) {}
> > -
> 
> Since we're here, EXPORT_SYMBOL() can be dropped for these functions on
> x86 and loongarch because they're not called from a module?

I'm confused, and don't understand your comment. You've r-b the
previous two patches that remove the EXPORT_SYMBOL()s for
arch_register_cpu() and arch_unregister_cpu() from x86 and loongarch.
So it seems your comment is already addressed, and thus makes no
sense.

Please clarify.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

