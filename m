Return-Path: <linux-arch+bounces-9742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E6AA103F0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 11:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBBB167A03
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC7243334;
	Tue, 14 Jan 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NfLE5o6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGs46Y+t"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA31C5F07;
	Tue, 14 Jan 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850175; cv=none; b=u1RW3kSIMJvohLq/WKgR/2u/8a+/xog9eOfX1FQc1xxcE++dT80t5r7mz/k7LvEqe1Nb9bwBlGllcjU3JK/mVIYVJ4VXIZuH+AdNspJz1jqGLs+souUlqCsuBhvbWzOsAI+uKhoasmRLhDnVUJf6BUGaggXiDk1y4JOr/dmb0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850175; c=relaxed/simple;
	bh=HKlp0ua3+76dLy6yu6yKgIeU3km1Jm1+9RXeF/NKRm0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kJ8MEVyLjcA5aaS6LMLOItyXr/FGqBLoD4bwZw/uXbikv9fAEnAphgl0sKfZaB8JGvcIJHUZXvj5Ymtbx10lgcfaLGeGzuBrV1NAr1ks6QM8FhPSgg1lyFYOyDylKmNVvYUFmnYWBFROUyP78pBWwszVpaMtwH/j2DB3OZQZsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=NfLE5o6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGs46Y+t; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB1582540149;
	Tue, 14 Jan 2025 05:22:52 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736850172;
	 x=1736936572; bh=d3Szq5KGsUif+e6rNmRG6BY+jwUtKQ6YOnGUaj1+UdA=; b=
	NfLE5o6bPIrZTcMPgG0IdDBp9v519SRQozXn7UMMR5yfBeiLwhueeKpQmtMadOPG
	YdRjSuR/TqctdDGxtW3Gvguz2H69rbLX/Te1IWsgmbQVV/3jkfT4+2xaoJ6X7w6D
	AyEAC0a9qlQTWcBIe3qCPxCrDSx67996k4E9jcwU+cuSO+f2BJifDg/pk4hjZzdt
	7LCOpuiWLO2T4qxUT+IbkzVGF6Odbewl9qH9O42zXKNTpUAEvnzWmUn5wzfW8eIX
	4dPDVAwKNDD4rSKjGtDujr6NX40iwxAWIJIJxQ1uV/MyaIUrAQXNednSvMfOnfE8
	5A63nhvFnABB6TSyMLD1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736850172; x=
	1736936572; bh=d3Szq5KGsUif+e6rNmRG6BY+jwUtKQ6YOnGUaj1+UdA=; b=W
	Gs46Y+tyxOSxH2seHsBbs0LKWD9YoPojyXv//AkWeLaznRdp2U+J7FH9N5sUl/Hs
	S3n1IHceO3sSGONwRRgistQPO7kY0l6hP53lJn7lY5hxoSwBvkden8cLh6jrUvtG
	FnXqOTxfaVLwTkAou2kZvqPBHM54EUo0dwmmV8cgdQ2fnUglkj543BcjS26EV+WH
	xXOsbIYM75AEvDJgmF9CxUiqeX8f5q+NvNGNzFpY+KbBfhwDBb2ujeG0jPqpp6V1
	h1R42Umb/iW4xrWDhiYN3t/ZdNVr6oGobkaYLzIa+/Jt0Sr+I9mmjKA73N7kWlw9
	hD9bduyWebbeZZBYakAgA==
X-ME-Sender: <xms:_DqGZ3wczmeI3ydgwXYwCqSdXGbpurHHas-ao98AHiPIZU0boIRjOA>
    <xme:_DqGZ_Skn3LloOjaLpXMbXLzVObdMXUHNAkeHbZ5TNRCUGGUYK1DXGx7z3JtMbk6V
    JFbONC6eLxfMsL78kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthht
    oheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvg
    hllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhu
    gidqmheikehkrdhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhl
    pdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_DqGZxXMfNxtwMSKEq__Iv8jSSCbfaRGSbkrJ6w-ZboD0XDvUsuUsQ>
    <xmx:_DqGZxgvvZ5vlhJekM4w_mGWcPqVZZS93B-Lvt3qmf2YmnCkcXrmPQ>
    <xmx:_DqGZ5BhQAVJWD5k6grEYaE4OE9lThek9obDYfTB0YObOea9Ap_Y_A>
    <xmx:_DqGZ6KGt2XFZ1gP7p67iaP27Cv7hi212Ftq21Sp1DPOweffU-M8hg>
    <xmx:_DqGZ9tFXDwOhhLBiUpsDeYqTxxC1UaGHU18I_PF3X-mCzTxrngtJgMJ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 742A81C20079; Tue, 14 Jan 2025 05:22:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 10:22:24 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <99de6ed6-2577-42d7-949d-cd5adc740dbb@app.fastmail.com>
In-Reply-To: <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
 <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=8814=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=889:59=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> This probably requires calling set_io_port_base() with the
> actual virtual address rather than self-assigning the
> uninitialized mips_io_port_base.
>
> I assume the reason for loongson64 being different from every
> other mips platform is the same as why it calls into the
> logic_pio_register_range() directly. I don't understand that
> code, but it's probably because it has ISA/LPC devices that
> are directly wired to a non-memory-mapped set of registers
> instead of them being behind a PCI bridge like the other
> platforms. The idea of logic_pio is to have a more generic
> way to redirect arbitrary port ranges into bus specific
> function calls, where normal PCI (on non-x86) assumes that
> all I/O ports are mapped into a small contiguous ranges
> of virtual addresses.

That's correct, Loongson systems has a memory-mapped LPC bridge
accessible via MMIO. We are handling registration and mapping
process here.

It also has ioport capable PCI bridge, which will be taken care by
platform code.

I think current problem of logic_pio is it handles creation of
mappings and PIO range registration separately.

Thanks
>
>    Arnd

--=20
- Jiaxun

