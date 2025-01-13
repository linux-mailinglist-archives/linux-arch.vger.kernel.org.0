Return-Path: <linux-arch+bounces-9735-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC32A0C5B5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE7618881B8
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9A1F543C;
	Mon, 13 Jan 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="gejk0Z8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPzsKNq8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191F1F8EF2;
	Mon, 13 Jan 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811118; cv=none; b=iFmCeUsNzzFJmPdox5NIjVbJjRPX9Bja40kUPGwFD2NH6neaVm8pR8wla8l5rypNenGlk3A5zjFlif7hDyPJgGCd+Bl5JiFuk9+wRk4rDzsxJOFhuvdo5YIi+t7pPJwVyiAV8qwShInV/DFxtMBsBEKKAvnFj4SoSoX+wbo8C0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811118; c=relaxed/simple;
	bh=kl7hgw8cOEL/RQmyCLlKD8bQX86VflovZEM2Ocs6qLo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uh7I7cCQtzWoSHW6pOaCNBGsEihV+4/bao1oAz1fm21n0mE68VL2JEAJimvzXUT0ghO+NBgUqqRB35rMoPnT++hWNt27TeAAYRiNuLb4VpmOzZthQKFYO/J0LGrHvaWl9xImArqPU7tS/r+wGbK0hugricIt78+M8axqHYWezu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=gejk0Z8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPzsKNq8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 56B80114015A;
	Mon, 13 Jan 2025 18:31:54 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 18:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736811114;
	 x=1736897514; bh=+BEVA3pe2gCidtgg232kaeLaU3AF5fInSG/U3XwNmwU=; b=
	gejk0Z8d/by6y0unuWIhQ9s9jpdNr/NVr0hPgD6sYqIJJWtnkgoU1Ml7j/7W9EDb
	WIQbv3jUFmnJb7SGJ2FMopkY3nHk40XsHf6rMaIgzyjLB/hT0q2Lj9diKgnOrk2r
	MCKyTiogjoKHLY2yDXmN8pEN30rKkxIdxdcfsGZ1j9nwNDixrpIt981kFnbRXNz6
	Ug18jgvWxvkp4w+kcduVXRU1ESyL1vhYVaQFLGVTPZZ+jiUUEItk610hw7b0lG6S
	mTLHkrxCrtQOWyH3Q6/+Pr22ZVBfS+fxH5Mca5OYyCzllVWvF89L5p1OA0Q0PtQR
	3s/8M+CKyUmrVGarVHs63Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736811114; x=
	1736897514; bh=+BEVA3pe2gCidtgg232kaeLaU3AF5fInSG/U3XwNmwU=; b=V
	PzsKNq8QCkI3dIHoxHSgLFo7/Kj4J01vCJDf1oZaOIJdHKJDZdTkRqJTg+io4QxZ
	v4vcxECVr9NzSrH3VVyuURMCgMWSxY4xQ74PSpeXy3kpQRJXHuTWEZdpO+6kJfXS
	1TyvqC8UQwetQw9a1mqv1+tFbbb+lhtpnrShYXbZy9w0TnKZQt5mPhTgAl/VRQc3
	BABJv8e9INQI/qJHYM/Vqg3hxnYbgST3zx8AWpcvogcm/epyBdWJy8EgdB2qMznV
	OZfGZlhqB34Gc0LvE0EAQ9Kq0GLLO2UWR2lp7zshexyukxmwrREx5hqeOgMTPGEo
	UfmRy4sTkZXhIjcZFJ2XA==
X-ME-Sender: <xms:aKKFZyaSH_nE_7jnJWxfqKZeebTQX4fg6GBXBBRs1XLRUhL7yKEJEg>
    <xme:aKKFZ1Z6vWbQsnYkzjJaxCA1aI5fB7aJMew8WbrsyFW6DXypAwscZKXq4bER4XC3e
    QWxlfFv_oMII6ylFcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepkeffudeguedtgeektefgfeei
    teevhfeffffhkeehfedtjeetjedufeekvdffvefhnecuffhomhgrihhnpeguvggsihgrnh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    elpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhh
    rgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprh
    gtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhm
    pdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhlpdhrtghpthhtohepsghh
    vgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aKKFZ8-yPk1ulHIntCsZECMlz8CUPs5hL5JLATc5IwdgBXTX51bTng>
    <xmx:aKKFZ0qID9bDVaOQoL7RvXpjJI_Y_B_8_o1F0KH7E-TLcT6hFPsk9w>
    <xmx:aKKFZ9pHiyVl02CRVqNujbt4I6BGtvDroYAUslKVg0PIICjTUB8zQw>
    <xmx:aKKFZyQQuuh-xmzDSAgWhRhtHM_7s9ji8TNlJ9aCpsIaLhVjxB-Q9Q>
    <xmx:aqKFZxfty_dXusmhlEnjjjGtbceuV0pG-PKyRzXZotTksMHk94Sy6ojG>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C96D91C20066; Mon, 13 Jan 2025 18:31:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 23:29:28 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
In-Reply-To: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=8810:16=EF=BC=8CMateusz Jo=C5=84czyk=E5=86=99=E9=81=93=EF=BC=9A
> Hello,
>
> On Linux 6.13-rc6 for mipsel in QEMU on the Malta platform, the RTC CM=
OS
> driver does not load and /sys/class/rtc is empty. I have tested this w=
ith
> "make malta_defconfig", which compiles this driver into the kernel=20
> (CONFIG_RTC_DRV_CMOS=3Dy).

Hi Mateusz,

Thanks for tracking it down, this is indeed a huge effort.

>
> I have bisected this down to:
>
> commit 4bfb53e7d317c01f296b2feb2fae7c421c1d52dc
> Author: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Date:=C2=A0=C2=A0 Thu Sep 21 19:04:22 2023 +0800
>
>  =C2=A0=C2=A0=C2=A0 mips: add <asm-generic/io.h> including
>  =C2=A0=C2=A0=C2=A0 With the adding, some default ioremap_xx methods d=
efined in
>  =C2=A0=C2=A0=C2=A0 asm-generic/io.h can be used. E.g the default iore=
map_uc() returning
>  =C2=A0=C2=A0=C2=A0 NULL.
>  =C2=A0=C2=A0=C2=A0 We also massaged various headers to avoid nested i=
ncludes.

#regzbot introduced: 4bfb53e7d317c01f296b2feb2fae7c421c1d52dc

>
> I have tried to debug this.
>
> The fallout is apparently limited to the CMOS RTC driver, other
> drivers that access IO ports seem to function correctly (e.g. the
> PATA driver). Also, the read_persistent_clock64 function in
> arch/mips/mti-malta/malta-time.c, which accesses the same hardware
> works correctly.
>
> The CMOS RTC driver is likely special because this device is defined
> in a devicetree (arch/mips/boot/dts/mti/malta.dts) and there it is
> the only defined device on the ISA bus.
>
> That driver fails to load because the call to
>
> platform_get_resource(pdev, IORESOURCE_IO, 0);
>
> in cmos_platform_probe in drivers/rtc/rtc-cmos.c returns NULL.
>
> The mediator seems to be that this bad commit causes=20
> arch/mips/include/asm/io.h
> to #include <asm-generic/io.h> at the end. As a side effect, this caus=
es
> the PCI_IOBASE macro to be defined:
>
> #ifndef PCI_IOBASE
> #define PCI_IOBASE ((void __iomem *)0)
> #endif
>
> That PCI_IOBASE value above is AFAIK incorrect for MIPS (it should be
> defined to mips_io_port_base as far as I can tell), but this does not=20
> matter much here.

You are right, this is what should be done.

A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
just after including #include <asm-generic/io.h>, with ralink and loongs=
on64
as exception.

In the long term, we should scrutinize platform usage of mips_io_base
following ralink's approach.

>
> When that macro is defined, pci_address_to_pio() in pci.c calls the
> logic_pio_trans_cpuaddr() function, which fails. Removing that ifdef
> in this function "fixes" the issue and allows that driver to load and =
work
> apparently correctly:
>
> ----------8<------------------
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..368cd9ca6801 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4213,14 +4213,10 @@ EXPORT_SYMBOL_GPL(pci_pio_to_address);
> unsigned long __weak pci_address_to_pio(phys_addr_t address)
> {
> -#ifdef PCI_IOBASE
> - return logic_pio_trans_cpuaddr(address);
> -#else
> if (address > IO_SPACE_LIMIT)
> return (unsigned long)-1;
> return (unsigned long) address;
> -#endif
> }
> /**
> ----------8<------------------
>
> Additionally, the following message appears in dmesg on affected kerne=
ls:
>
> LOGIC PIO: addr 0x00000070 not registered in io_range_list
>
> (0x0070 is the IO port address of the CMOS RTC).
>
> When I added dump_stack() in logic_pio_trans_cpuaddr(), which prints=20
> this warning,
> I got the following:
>
> ----------8<------------------
> Call Trace:
> [<801185c8>] show_stack+0x38/0x118
> [<8010be24>] dump_stack_lvl+0x7c/0xbc
> [<80841060>] logic_pio_trans_cpuaddr+0x88/0x98
> [<80604bec>] __of_address_to_resource+0x208/0x228
> [<805ff45c>] of_device_alloc+0x7c/0x1ac
> [<805ff778>] of_platform_device_create_pdata+0x60/0xf8
> [<805ff9cc>] of_platform_bus_create+0x1b0/0x238
> [<805ffa14>] of_platform_bus_create+0x1f8/0x238
> [<805ffbd8>] of_platform_populate+0x80/0xf8
> [<80a60008>] of_platform_default_populate_init+0xcc/0xe4
> [<8011010c>] do_one_initcall+0x50/0x2b4
> [<80a3d0f0>] kernel_init_freeable+0x1f8/0x2a0
> [<8086975c>] kernel_init+0x24/0x118
> [<801124f8>] ret_from_kernel_thread+0x14/0x1c
> ----------8<------------------
>
> It appears that some call to logic_pio_register_range() from=20
> lib/logic_pio.c is missing.
> Perhaps the reserve_pio_range() function in arch/mips/loongson64/init.=
c=20
> could
> be reused, but that's too deep water for me.

Sadly that is not going to work as those MIPS platforms are not using
vmmap for PCI IO access :-(

>
> Steps to reproduce:
>
> ----------8<------------------
>
> wget=20
> https://ftp.debian.org/debian/dists/Debian12.9/main/installer-mipsel/c=
urrent/images/malta/netboot/initrd.gz
>
> CROSS_COMPILE=3Dmipsel-linux-gnu- ARCH=3Dmips make malta_defconfig
>
> CROSS_COMPILE=3Dmipsel-linux-gnu- ARCH=3Dmips make -j4
>
> qemu-system-mipsel -machine malta -cpu 24Kf -m 1g -nographic -kernel=20
> vmlinuz \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -initrd initrd.gz \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "console=3DttyS0 debug i=
gnore_loglevel"
>
> ----------8<------------------
>
>
> Greetings,
>
> Mateusz

--=20
- Jiaxun

