Return-Path: <linux-arch+bounces-9748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7EA10CFD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B560A163666
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2381B5EB5;
	Tue, 14 Jan 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="u99tG0OS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5xvtpxz"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C21E529;
	Tue, 14 Jan 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874368; cv=none; b=H0xWAKKl21yXJ04kxu0tAE2oa24dcWSfS3pbIbBUqOMpdErbxF6VULND+eJIuy7m/Pju2XhbZmPe7O8K9biTWLMb4cgebUiwdFCL1hhsQe7sBig7eKlvWzchPZbaP1I8P8iFzKiWWz3QVC35TyZfdGmDYr9lWug/Z3fW5wUsrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874368; c=relaxed/simple;
	bh=yb7FbtCTyLqmWXFGQhLOIkxdhpM5YZ2XgFdoGK+nrS0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RVWt8oRRvhD2kDkuDXmcKLdWktQnOdcQJPg1IaIX8PoAw/xB30BvMTGzV/nwIfLLZKR15KXOh3lf7F422NuS9M67zdCKAsDtz8P6u1u5TAgJxpLJWPypaZ6/tSamh9x0fQCLIoCMI3GMlWPpj50w9oWQLbqm5VEKvOeWSJK2tkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=u99tG0OS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5xvtpxz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EAC91140174;
	Tue, 14 Jan 2025 12:06:05 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jan 2025 12:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736874365;
	 x=1736960765; bh=Q6ScP+1iZgmBbgN+RLbsV/rWVS+1L9QG0ApgTsWV8Gs=; b=
	u99tG0OSgH0+kSlGz77vKynDUwFvCGjowpMCp2lzt0rh2J89cVtl9KOLl6bDweRX
	yx++rX0xPLKI100YTJ8ElhqdUTgqjTR1DR0uu5wWGCepSdgMVpcNUdQuvfu/W8iz
	1R9s9wMsGtfGDlqnSQIf80R+ilM/MHFmXuGZvhsBPWMd6FeXFxVKVUcwxOVh7gWx
	I556K3gwdyfLWfAInKQpIVu1r3h36jnZPv+BFHtnIbrnum87M/Yq2bG9oeIDNgu2
	fiL0qv7EET7CqMve9Wmzt6sVu5ZSsdn2dKv/XRk6Rwtw5jEa0zHYXUQtF3t4zsD8
	s2hveqd9Tkxv8CLDHBdYmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736874365; x=
	1736960765; bh=Q6ScP+1iZgmBbgN+RLbsV/rWVS+1L9QG0ApgTsWV8Gs=; b=S
	5xvtpxzthR9ieYnoBMMEHWv+wviqKz7gGG4xyFiSWar4iyjXGJthHNJR6D1J+0+L
	tVTQiuZGW0tXY5PjQAbiS8+5CxYFqORE62Mq1BbphfICMLphnogJp9N+yO/S8DL9
	kHige455B2vmkLO3ASHSueDSA2lLNVHehwK1bZVlgKjMpbgbF9BsgR6FyuUVKoPO
	F7ADuCBkQUyd2bwCdFXvXQzpyZbeQ+2yvRtUyUr8U+NdTHowDgdbeTs4nYNyq7AJ
	piWvYPjoOHkMA9s+HCXaG0skYvksXmLsMLpiyBoFvD/l1OD9Sujv9lXgl2COdgU1
	xR1VLv1xw+rQOrZqh/1/g==
X-ME-Sender: <xms:fJmGZ2zbiZXaalQbZvEawuyNxicvoaV6km_cF0SipePNP8IvOF9Qeg>
    <xme:fJmGZySRW77Utq1Et4SE9hdz5JUSFx9XiU_hI2O2Zp9w21HXBXvwn8rcAhdmZK6wS
    cw70KJ9mcT0nMknIxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhn
    ihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdho
    rhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhlpdhrtghpthhtohep
    mhgrtghrohesohhrtggrmhdrmhgvrdhukhdprhgtphhtthhopegshhgvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:fJmGZ4V8803dZ07mO_CQyyRs7Jr9e2mm93MX_J6cpgA3sKpOgAoVCw>
    <xmx:fJmGZ8juClgKvJ-WMjFhX4yTgR9qoN9VDZGwg8hj90clRiv9YKuzPA>
    <xmx:fJmGZ4Af0xt1WoacGAS7OgSrNSwT3oNhMBx1wu-GQHp-GNJxpTX2PA>
    <xmx:fJmGZ9IFGBLOReE9bDbSVxajdWbdZ_-6TAUvbzXcKk4wRo3lXi1CCw>
    <xmx:fZmGZ86RQI2-3QGMxbDIvVtYr1oTr1nqb3KBkmxDaJ-Ux8NwlX-x4tLX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45F502220073; Tue, 14 Jan 2025 12:06:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 18:04:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <13d0c3f1-7e6b-4f25-ae00-9e41a15ec36c@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
 <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
 <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 14, 2025, at 17:11, Maciej W. Rozycki wrote:
> On Tue, 14 Jan 2025, Arnd Bergmann wrote:
>> >> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
>> >> just after including #include <asm-generic/io.h>, with ralink and loongson64
>> >> as exception.
>> >
>> > Shouldn't arch/mips/include/asm/io.h do
>> >
>> >     #define PCI_IOBASE mips_io_port_base
>> >
>> > unconditionally, _before_ including  <asm-generic/io.h>?
>> 
>> Yes, I think this would make the most sense, but the ordering
>> with the PCI initialization needs to be done carefully,
>> to ensure that PCI_IOBASE has its final value before the first
>> call to pci_remap_iospace().
>
>  Is defining PCI_IOBASE going to do the right thing for non-PCI MIPS 
> platforms, or should the definition be #ifdef CONFIG_PCI rather than 
> unconditional?  FWIW I think all PCI MIPS platforms support port I/O.

PCI_IOBASE should be defined whenever CONFIG_HAS_IOPORT is set.
Ideally that should allow using the generic inb/outb and
ioread/iowrite helpers from include/asm-generic/io.h, but
unfortunately those don't support the address swizzling required
on SGI and Octeon platforms.

These platforms look like they currently set a NULL pointer
as the I/O port base:

arch/mips/alchemy/common/setup.c:       set_io_port_base(0);
arch/mips/ath79/setup.c:        set_io_port_base(KSEG1);
arch/mips/bcm63xx/setup.c:      set_io_port_base(0);
arch/mips/bmips/setup.c:        set_io_port_base(0);
arch/mips/lantiq/prom.c:        set_io_port_base((unsigned long) KSEG1);

At least some of these, possibly all, also have a PCI or PCMCIA
host controller driver that sets a different value later
when that bus is probed.

I don't see any I/O space getting set up for ath25, dec, ingenic,
loongson32, pic32, eyeq, nintendo64, and realtek-rtl. It looks to
me like any I/O port access on these turns into a misaligned NULL
pointer dereference, but there is a good chance I'm missing how
it gets set up there.

       Arnd.

