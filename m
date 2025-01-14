Return-Path: <linux-arch+bounces-9740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEBEA1037F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 11:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA99163AE6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B521ADC9B;
	Tue, 14 Jan 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WN9OLdpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k249IO4v"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E11ADC96;
	Tue, 14 Jan 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848798; cv=none; b=jlh+qXOVAG5GziOIWaHIMwpEGetW+idORZcowfj6gp/lEUsTIox8JaM4LAJBhoFO1jc7b06h9lEXFLyFfZIEYNx2elScY4+vuyZCUjRkk1QT6B+ZbiJ6rjEjF2NZJKiQYRhxeAtvmNaGgmLJw9457p5sjxhvjgPhqPq4sCDly5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848798; c=relaxed/simple;
	bh=b5Cbt4Yr/lwZHFfHu9nJiM5jqgMizJd5EpzO+f4DZvk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LXW6EO+ZWyhgUOzgS4xar0sNtf0aotHdox9KJpyYoOh4r4g5vhL9wqXl8z5GYiObBzBL+LnJdh5iJ+wljDwASYpbI03JjfTFSQ6YkMgfpdYKcVTvGrPJ9v2Cyxd2Gt0vgybwBce9e78KU8TmgWJTSBgcQ1l6QkTPkKrE/wFQncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WN9OLdpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k249IO4v; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0BDF254017F;
	Tue, 14 Jan 2025 04:59:54 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jan 2025 04:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736848794;
	 x=1736935194; bh=OBh34yte+JVSNtlGo5ta2IEWDQu5RJcZ9byYXV5wTG0=; b=
	WN9OLdpEqOoqUl8A0nPNJFgM3amjl+AfeFj21jAnzpOZtEtbjo3OZPsL0v+k0r8j
	KLVA3h1SiJ2jyw7q1bH9BdrW6C4ldTrWprZ1mo4Rbex9saDLhSf/jCrl0DMILF8M
	1DKnURqLxoPtCJ3/Qce2ItCKwaPTfmr2Kecyirjnlah6It0jpW/+DVEESgiWfQly
	aIvNPANO0VEw50cmnGv3TRgWhzf2HK3bxVN2JTGw5CTrpOz4PTcfRNlRQAALrp19
	3/GWKwIee6D+Jj5FJg03U5ZGWApEwZOWYOyDk3U54P5hfCZNM2XYVkfDcZkMKA/t
	Q63upPoA0r+5IS9xBjjNvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736848794; x=
	1736935194; bh=OBh34yte+JVSNtlGo5ta2IEWDQu5RJcZ9byYXV5wTG0=; b=k
	249IO4vem5SgZEyRloVHTaQjlkBMToruuL++bL9bQHEUlT6/EkUvLqRN8DCGYAgX
	+aFFXXA1tmXB/nfMBPJI0Kb8SCqWlcESZ06rSEV+72ottTh5uNXEZxUvg0oB4uWs
	Z+ThBHDy6lQOvMJL/5CidByL3tnDftyG57ML7887hxu6aWcU8UKjvews3FW1H/B7
	3ofljD67Nm1QZdRJjd6rfSpbFHYhIr2wYy6FBNIBTre1Tt5Wrc83MOEH+9vGPsOF
	rIQFq4kOyEVUjj6i3Ox51L73URLHzfERyiOAp/tpXnJpsE9zMzrfKSiSfgzHD5PS
	H+0JYJtmdFxQBomq7VbaQ==
X-ME-Sender: <xms:mjWGZ_iO5emcEQqLh2IIT3YgOFcRnbiAEY4NSYv2rAYZHOB-yI_20w>
    <xme:mjWGZ8DLxvnk14NCyKi665uiFVo2jS3rVjZBFdBcXwq08BjxcqBBHOIZgHVPRXByQ
    8WtRdbsy-GGkK16HOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhn
    ihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdho
    rhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhlpdhrtghpthhtohep
    sghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mjWGZ_GYE0F-IxBO-FoTXgxkP26Hrm4lhg7-eEDgEVDkBXyiapUDGA>
    <xmx:mjWGZ8QQ0JFMV2ab5CK3DC_tq9MJpajpZzVKAJUZYU8dKxgZj91vbg>
    <xmx:mjWGZ8z_mq3cZpkWWWIoLTSPzLw-6qmj8Ip89WIg6uAiDkhqy7DTYQ>
    <xmx:mjWGZy7OxmU5ofjacGEdzblYA5b3Grpb44ZG7luzoe9QavKDzwst1g>
    <xmx:mjWGZ4fq2tvC0Q7i3oDrW3iJ2uHYcMJ9l4LCYwPdsb2_sDZ93w0qCpKH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E206F2220074; Tue, 14 Jan 2025 04:59:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 10:59:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025, at 09:02, Geert Uytterhoeven wrote:
> On Tue, Jan 14, 2025 at 12:32=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flyg=
oat.com> wrote:
>> =E5=9C=A82025=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=8810:16=EF=BC=8CMateusz Jo=C5=84czyk=E5=86=99=E9=81=93=EF=BC=9A

>> > #ifndef PCI_IOBASE
>> > #define PCI_IOBASE ((void __iomem *)0)
>> > #endif
>> >
>> > That PCI_IOBASE value above is AFAIK incorrect for MIPS (it should =
be
>> > defined to mips_io_port_base as far as I can tell), but this does n=
ot
>> > matter much here.
>>
>> You are right, this is what should be done.
>>
>> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
>> just after including #include <asm-generic/io.h>, with ralink and loo=
ngson64
>> as exception.
>
> Shouldn't arch/mips/include/asm/io.h do
>
>     #define PCI_IOBASE mips_io_port_base
>
> unconditionally, _before_ including  <asm-generic/io.h>?

Yes, I think this would make the most sense, but the ordering
with the PCI initialization needs to be done carefully,
to ensure that PCI_IOBASE has its final value before the first
call to pci_remap_iospace().

>> In the long term, we should scrutinize platform usage of mips_io_base
>> following ralink's approach.
>
> Currently ralink handles that in a mach-specific include:
>
>     arch/mips/include/asm/mach-ralink/spaces.h:#define PCI_IOBASE
> mips_io_port_base
>
> Loongson does it differently:
>
>     arch/mips/include/asm/mach-loongson64/spaces.h:#define PCI_IOBASE
>      _AC(0xc000000000000000 + SZ_128K, UL)
>
> But still sets mips_io_port_base in prom_init():
>
>     arch/mips/loongson64/init.c:    set_io_port_base(PCI_IOBASE);
>
> so defining PCI_IOBASE to mips_io_port_base in the main <asm/io.h>
> should work.

This probably requires calling set_io_port_base() with the
actual virtual address rather than self-assigning the
uninitialized mips_io_port_base.

I assume the reason for loongson64 being different from every
other mips platform is the same as why it calls into the
logic_pio_register_range() directly. I don't understand that
code, but it's probably because it has ISA/LPC devices that
are directly wired to a non-memory-mapped set of registers
instead of them being behind a PCI bridge like the other
platforms. The idea of logic_pio is to have a more generic
way to redirect arbitrary port ranges into bus specific
function calls, where normal PCI (on non-x86) assumes that
all I/O ports are mapped into a small contiguous ranges
of virtual addresses.

   Arnd

