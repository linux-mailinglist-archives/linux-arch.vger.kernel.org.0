Return-Path: <linux-arch+bounces-9741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B272A103AA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE0D1888FD4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D917557;
	Tue, 14 Jan 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="RuVgGHDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyVVkXDB"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1A1ADC6C;
	Tue, 14 Jan 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849390; cv=none; b=Xzogt/SjT4/GFYZ2RhcW78AAs0vgK2BW+OBCEztpUlYpWyamayTIECb6ph7jRwBDPxupTNTsYTg3xGRlezTliKzwBnJ9B1/Ol0q45hT0ZPeM19Rw7KgkognSnIS7myh0oMvP6geyocogKohmcbF2FxbRfEYsF/83gjl/DWeoCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849390; c=relaxed/simple;
	bh=njG1deb+oTJU8RMGtJmcsakvv3galM80tHuTklyW0AI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QiQQ8Njz9QZb0H7htl5SeYZUlPJR/sL2eDUqC6lg9ony6vHUAukpvA/hpkpRk2SuBph6wBDtTpH6vWnRDYICV0armXpBEnHK4smXCsWkFHrihNDFXUkRL9Yvk7Cswh+Gy6sy1j4RknfvmYMCNEmd0S0/M5d2bcZN9+/kEMBUhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=RuVgGHDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyVVkXDB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A58FD25401D8;
	Tue, 14 Jan 2025 05:09:47 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 05:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736849387;
	 x=1736935787; bh=DPn//TJ/9kGEJ1n8tpne/ERwqtQrqEX8GPpOjwPBf68=; b=
	RuVgGHDbNiFTpdJZsSRsQ7yyc5ayRI2h2l7dqnaxshOMnWy9zbsQT5jAA+iqt647
	/xlTcCfaGpisYS+/IB6I8g4l/KIWgGa0jEFrra/MK7jphjr/7kglwGUmYAxh9S12
	/wtkx2iqhUCZ7RbjM3jYv7fIt5W5Yz9g8G/TptbEven7bjRWR57joY3QMrj6k9nK
	8eG6YCepgttm3cr+vpK0l/w0XBhUvyEe6D2/9rJyQmT459NszvcyZQCwJNelnij+
	zW2Lxi4yY4pO2/T8w3FqTqo9PcVtCVhMwNvcX77Z+HpQZJ7xsT0sglWyuD7rEFVJ
	FSJajdi3X51RNkSzqPST9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736849387; x=
	1736935787; bh=DPn//TJ/9kGEJ1n8tpne/ERwqtQrqEX8GPpOjwPBf68=; b=n
	yVVkXDB/RzmGdkA2oNmhrLXRDZUseZ8LvuC7f/y5T+eStYoM19MkBPw8IeW+HJjG
	AYu0QnyMqg0n+k9gb8EawbF+1PRpqboKO/YVwPg6DbfuVHvW7P00mH8fhEE2R2MP
	Nx5s1GM/spCfsm7Wbb78de80BXD5SIeWq5PczBCjdXesYFRzMVPBmvcqTWvm/g7N
	VBoOk59CTdFm3rMmkEuNOL8dQ8dmsBKpPvSBGSCCSN3j90kmhD9yDSvhtkqeUPkv
	ny5NEVqLabPADSM9qJfyV3fAaFUaiOI8pd6TY/sHVFJkXCs6iU8g+5Q9s9CBuxmw
	b12oNguZrpos9e6eMZHxA==
X-ME-Sender: <xms:6jeGZ0YTLOE6eGvzPel2OQGcdm4DXPfQDstPuBgYYtbrV5BDzuMT1g>
    <xme:6jeGZ_Y0kzme6kXGHWatMnlQuG-v7HiKE13pTeBoDlHsksLOcAuMGtCjHqqaakS4O
    WKiLI7HymXVospea1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:6jeGZ-_oauPeMIPwheIiwXU9Yz90Q7IgWiZArm3UYdlSl3tAT9Z0jg>
    <xmx:6jeGZ-pTAyURs_FCR-qWkvL69Xt65e6iz8jjeZJQ5dVVKSZDUKA66g>
    <xmx:6jeGZ_q6ykOn0Q_erZ0mreg0WSHH27e1A445jkLaeZjeQiNzfYMKqw>
    <xmx:6jeGZ8TUrKwo4qfN9YqLJvnkcnZa3QsutPjY7-T4bQSkc59KO7tiHw>
    <xmx:6zeGZy1DnU8UnGQy9UjTSkTTG4OwgRUs_n_NHniAxCyRDKJ51wqK_KIw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3D791C20079; Tue, 14 Jan 2025 05:09:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 10:09:26 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <12aa35c3-3f74-40bf-9fa1-7540aa4292c3@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=8814=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=888:02=EF=BC=8CGeert Uytterhoeven=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
[...]
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

The problem here is defining PCI_IOBASE implied use of logic_pio and VM =
mapped
io access, which is not true for many MIPS systems...

>
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

Yes, we need to make sure malta problem won't happen on other platforms
before making this definition.=20

Thanks

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux=
-m68k.org
>
> In personal conversations with technical people, I call myself a hacke=
r. But
> when I'm talking to journalists I just say "programmer" or something l=
ike that.
>                                 -- Linus Torvalds

--=20
- Jiaxun

