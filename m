Return-Path: <linux-arch+bounces-9784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B0A110DD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B087A168DB3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193121FAC29;
	Tue, 14 Jan 2025 19:10:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC371B85FA;
	Tue, 14 Jan 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881839; cv=none; b=mTy/cYu/bJTqz4npTrdIlsNO95RzkOdY8sutkutGnBGxd3OJlEjHj+77U+R7ikpgrFOapKwUaN9LNILaAhP7jR7Z8jCfiaYexsYMwEfSzvp7747MVrzprxYZXER6DX5i8kcC96473Obp3lCignfwdSFvwtrFGYGhP1rbepUh4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881839; c=relaxed/simple;
	bh=r2ye69cdwNDbsX3S2TzJaJ3k24emtxeCPGVD/kKC9YY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hfUC3F7tHMO3piVXaWoDduf4FF4egMgRytdnww5+dRThOBTsiagMRjYY1/TkpuDT62+S4jbwIn73o1eBlVNzh+y6GsvOvapIm6lKkXtixX0+QVfTgAJ3oF3z4tEu6Tada7PaNF3oFCfJoR1OXlQ4eURGSRQCIUUb7JcTvf47G+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E09EC92009C; Tue, 14 Jan 2025 20:10:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DA84C92009B;
	Tue, 14 Jan 2025 19:10:34 +0000 (GMT)
Date: Tue, 14 Jan 2025 19:10:34 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@arndb.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Jiaxun Yang <jiaxun.yang@flygoat.com>, 
    =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, 
    "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
    Baoquan He <bhe@redhat.com>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
In-Reply-To: <13d0c3f1-7e6b-4f25-ae00-9e41a15ec36c@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2501141707380.50458@angie.orcam.me.uk>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl> <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com> <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com> <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
 <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk> <13d0c3f1-7e6b-4f25-ae00-9e41a15ec36c@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jan 2025, Arnd Bergmann wrote:

> >> Yes, I think this would make the most sense, but the ordering
> >> with the PCI initialization needs to be done carefully,
> >> to ensure that PCI_IOBASE has its final value before the first
> >> call to pci_remap_iospace().
> >
> >  Is defining PCI_IOBASE going to do the right thing for non-PCI MIPS 
> > platforms, or should the definition be #ifdef CONFIG_PCI rather than 
> > unconditional?  FWIW I think all PCI MIPS platforms support port I/O.
> 
> PCI_IOBASE should be defined whenever CONFIG_HAS_IOPORT is set.

 Right, this will be more correctly scoped, so #ifdef CONFIG_HAS_IOPORT 
then.

> Ideally that should allow using the generic inb/outb and
> ioread/iowrite helpers from include/asm-generic/io.h, but
> unfortunately those don't support the address swizzling required
> on SGI and Octeon platforms.

 Address swizzling should be generic: for an endianness boundary crossing 
depending on its wiring there's always either a byte-lane or a bit-lane 
matching policy (of course both may be implemented in the same system via 
different mapping windows, such as with the Broadcom SiByte BCM1250 SoC 
though we only use one in Linux, or with some kind of a bus configuration 
register) and either byte swapping or address swizzling is required 
accordingly for the relevant use cases.  But I guess for just a bunch of 
systems that implement the bit-lane matching policy there's little 
incentive for complicating the generic helpers.

> These platforms look like they currently set a NULL pointer
> as the I/O port base:
> 
> arch/mips/alchemy/common/setup.c:       set_io_port_base(0);
> arch/mips/ath79/setup.c:        set_io_port_base(KSEG1);
> arch/mips/bcm63xx/setup.c:      set_io_port_base(0);
> arch/mips/bmips/setup.c:        set_io_port_base(0);
> arch/mips/lantiq/prom.c:        set_io_port_base((unsigned long) KSEG1);
> 
> At least some of these, possibly all, also have a PCI or PCMCIA
> host controller driver that sets a different value later
> when that bus is probed.

$ grep set_io_port_base arch/mips/pci/*

reveals some, i.e. alchemy, and bmips I believe uses the generic handler.  
Other ones may not support port I/O after all, especially where the 
platform in question is meant to be used in PCI device mode.

> I don't see any I/O space getting set up for ath25, dec, ingenic,
> loongson32, pic32, eyeq, nintendo64, and realtek-rtl. It looks to
> me like any I/O port access on these turns into a misaligned NULL
> pointer dereference, but there is a good chance I'm missing how
> it gets set up there.

 There's no PCI with the dec platform (i.e. either no I/O bus at all or 
TURBOchannel), so the PCI I/O space is irrelevant, and obviously the MIPS 
architecture has no native I/O space.  I don't know about the other ones, 
but I supppose at least some of them could be SoCs or systems with no PCI 
either.

  Maciej

