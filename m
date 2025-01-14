Return-Path: <linux-arch+bounces-9737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB385A1011F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02DF167BE0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E823C717;
	Tue, 14 Jan 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AY62WAM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSVczRPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DE233556;
	Tue, 14 Jan 2025 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838130; cv=none; b=ErhjQneeoWJAe2YetKsLHE2MJOExDDgGgyXBXTppwlH2wj4l/QC5YVl0xQhW9O9LJ5qKYNzEXOJigZvFvXKSqEq2d8NbyGaGSj1IfKvx8Sq8+Kdifv7+105Cm1F3M1lEiKF8wd5aBN9pTaz/hG3p/TpAj8Em1Bu+QwUIlI5OMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838130; c=relaxed/simple;
	bh=686+NrDAW9bNTmitxH84eF07Uu0lZ60Ztj/3HztO0cs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lOmekPI6A/jvdxmHfoZe34AlR0VZdE8rYuJUYUkQIExv5hpjU23GO9D7CkYLfqX7kKCSlP3gjtMcpLZpWp+9qwBSz/3xdw5vPV4t9gZsqo6eQ707z//+w9z1I+Q9MBBXrs1VqX3ZPWar0CBq5MgxzVIMYf8ZMzQp1YS1+VVLF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AY62WAM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSVczRPd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E84B52540181;
	Tue, 14 Jan 2025 02:02:06 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jan 2025 02:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736838126;
	 x=1736924526; bh=7kJin29ZAC23nvJ94hHXdVdtuact9nb0rLVCyOJc/Ug=; b=
	AY62WAM6EucRhw+Z1jYD+ea3XeTZEcga4DHHHkmxFpvjw2b0088aD7DCHEv32Mug
	iGTrdHusthm32hGuebL3Ofppl8iwlf0j9ActKEiybolrwBWYULHfiFtYKZp9FeKL
	24CmPnhkGfFWWqyR1EOz1bqpyXOAW1GorKa/ltsJvzGCyYwYdFhxnz0CCXOxS+O6
	b+t40AXk+ahcwCqRWX4pkqsB7Akw99hyDGjPFuBkYGdE7UjWjs2ZWROVwUXluXPJ
	8BALfan4df5OqmGNwFEVEc3WWgqL+cnOSykvrW0khRhbJCAvL0cNbnE6z/Agjpd2
	4Ya3cQa7kHKF1ZHjUxLeTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736838126; x=
	1736924526; bh=7kJin29ZAC23nvJ94hHXdVdtuact9nb0rLVCyOJc/Ug=; b=C
	SVczRPd3x0+kkG8K6OSYA9CjZgMcJswyS0uYCdyumP9LGMf9WYWxKj2iIy91dTwd
	S3Ktkfa+z28uYZSMDQFSuUhupGwRrkIcmOh1v2JWti2Y+zvKu7/vzmOpXv4H1jSx
	7/HlIbhYVqE1x8maW0KLoNsQmqBRZ3ZzPS8aVvxrPyTHUnK+Kf4+rVcDOYb4EqVk
	WFCE1zMNFiwlJOmkejtKOoN21YVTeNGxM1munxwQ0R5sZdjVA97Rt9m1lta5WGYX
	htF3HSdJLuYypbaiQDa6k4WqZxB5P1mJ77S7FRG3Zto5VceFlKA11gi3QQXcXzEY
	D1mpDvMpSZAVYPnvQmm2A==
X-ME-Sender: <xms:7QuGZ0nr6AK2KPHCQdZVZy54GiTOKplJlCMI0YYDVv1SVAS4E-sQhQ>
    <xme:7QuGZz3g0f3lUHDl1Pje69-LKwdx8WdHNyn8QZbi77FsSnT0CwYWoAHtVznERuvAA
    Gca28CGK4_OxSa9ulI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhn
    ihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhlpd
    hrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    rghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    mhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7QuGZyqgbzc6rQe2LNsiaE71tDkSvsbEs-GUdE1oVSLutjpBUSY_xA>
    <xmx:7QuGZwlaCDz0i3IMU8hbiN8K5x4tkvTjJKPNfiXj5dvqrfouh8NqRw>
    <xmx:7QuGZy0wAhte3KEYbz62VzUQIXeco0FC3zdaUHAfVFI75Aj-GkC3Ug>
    <xmx:7QuGZ3uNmWfGr489SuEPDKsRl6G9BTmOvvXCdE7WLOZIS7sKaaJksQ>
    <xmx:7guGZzLnTn241FI9LYPGMo04omKtlvr-6pDXW1m4Gf0PfqVw7kkX0RTB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D02FE2220074; Tue, 14 Jan 2025 02:02:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 08:01:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <436dc4cb-6d99-415e-b20c-52f3221f85fc@app.fastmail.com>
In-Reply-To: <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025, at 00:29, Jiaxun Yang wrote:
> =E5=9C=A82025=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=8810:16=EF=BC=8CMateusz Jo=C5=84czyk=E5=86=99=E9=81=93=EF=BC=9A
>> The mediator seems to be that this bad commit causes=20
>> arch/mips/include/asm/io.h
>> to #include <asm-generic/io.h> at the end. As a side effect, this cau=
ses
>> the PCI_IOBASE macro to be defined:
>>
>> #ifndef PCI_IOBASE
>> #define PCI_IOBASE ((void __iomem *)0)
>> #endif
>>
>> That PCI_IOBASE value above is AFAIK incorrect for MIPS (it should be
>> defined to mips_io_port_base as far as I can tell), but this does not=20
>> matter much here.
>
> You are right, this is what should be done.
>
> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
> just after including #include <asm-generic/io.h>, with ralink and loon=
gson64
> as exception.
>
> In the long term, we should scrutinize platform usage of mips_io_base
> following ralink's approach.

I think we are close to the point of being able to remove the broken
default PCI_IOBASE: the NULL pointer here is almost always wrong, and
mainly existed to shut up build failures on architectures that have
no port I/O at all. I know that sparc32 and m68k have cases that
actually rely on the broken PCI_IOBASE, so those need a local workaround,
not sure if some mips platform also falls into this category, as
I have not looked here in detail.

Hopefully we can get to a point where any reference to port I/O
(inb/outb, PCI_IOPORT, mips_io_port_base, ...) is guarded by
an #ifdef CONFIG_HAS_IOPORT check, and this is set exactly on
those platforms that set mips_io_port_base to a valid address.

      Arnd

