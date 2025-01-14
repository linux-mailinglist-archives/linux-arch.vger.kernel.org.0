Return-Path: <linux-arch+bounces-9747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA7A10BE5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90661665E4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD61AA1DC;
	Tue, 14 Jan 2025 16:11:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0C8615A;
	Tue, 14 Jan 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871108; cv=none; b=ZYZ/l8TYeO/UK4Fn4VJdz4/suAuKqiAyO3W3xpZxH3KAipKzR9viCeJ4MgcJXbGom22zskPVJEUumLkuOTSzH4lJMNmS5vEXAzv4wsDS1S5MKKJcc4TMmx04TwBfeTRhMYyUGY7iRgVPPwK0dXfpvDLMF55UpfGHq8fHtOXdV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871108; c=relaxed/simple;
	bh=Pc9VDmTqGYYkwMCrosCIswhIfgeY12y7nilFgmwbLr4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NyY/HWK4/5dSUCspu0ODtouaRBC03vA88azPckv0po51eutyQ4hi5bx18Vt0P9RTcFAqZn+IGrI9/BvqqA2W2Je+SbZb8Ki50BpYU9l1sSswyDHm53CyZlSgs+65HF8NjeqWxpazE8bBB0BbHBUxb14bdnyD/cFiVVKOnCcZZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9ADC392009C; Tue, 14 Jan 2025 17:11:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 952D192009B;
	Tue, 14 Jan 2025 16:11:45 +0000 (GMT)
Date: Tue, 14 Jan 2025 16:11:45 +0000 (GMT)
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
In-Reply-To: <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl> <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com> <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com> <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jan 2025, Arnd Bergmann wrote:

> >> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
> >> just after including #include <asm-generic/io.h>, with ralink and loongson64
> >> as exception.
> >
> > Shouldn't arch/mips/include/asm/io.h do
> >
> >     #define PCI_IOBASE mips_io_port_base
> >
> > unconditionally, _before_ including  <asm-generic/io.h>?
> 
> Yes, I think this would make the most sense, but the ordering
> with the PCI initialization needs to be done carefully,
> to ensure that PCI_IOBASE has its final value before the first
> call to pci_remap_iospace().

 Is defining PCI_IOBASE going to do the right thing for non-PCI MIPS 
platforms, or should the definition be #ifdef CONFIG_PCI rather than 
unconditional?  FWIW I think all PCI MIPS platforms support port I/O.

  Maciej

