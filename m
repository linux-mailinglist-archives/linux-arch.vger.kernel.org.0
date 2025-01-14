Return-Path: <linux-arch+bounces-9759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2506A10EA9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120DB1887B62
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FE20CCD1;
	Tue, 14 Jan 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ZAvUl3TB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/NO18h2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7520CCC2;
	Tue, 14 Jan 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877429; cv=none; b=Lz5C6pu9USuVdecw0xkgNcG/l8nFf3okSnIpvUY55xzBNFyXi3IX8px9lsIawqvORU9CzF0v7Hm2ZvCbGQJJfm/YfLFrAmeJ+Z8+Kgj75x8VJ3Y6TBgUIFTwXSNPU/kuNbY/ZtHHV4Ts9qMRzzVjoW/KYg+bCTscoetqq83wjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877429; c=relaxed/simple;
	bh=IFCv8SicT6UMtekvIXRUQ5/mGj1YnsJSHGQdLlphHJ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GZDB+2ZCqIwAg4MQZ8E/wjTaAWZ9hc4cPLnWN8cs9kZxokZGaPh3kdZD/JbGV8znneT+v/KWqbqRKz5K3wYDo3j6gf8gs/XD1kmr9f15Q7NI98tL+nOgb9WkNdHu7501YwaxL+A6gKRUGzPXrsOxkrN9aI//bpcUn4ALxrvnUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ZAvUl3TB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/NO18h2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EDAB61140158;
	Tue, 14 Jan 2025 12:57:06 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 12:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736877426;
	 x=1736963826; bh=xH9KpNHPinJSXc+YOduyekwpfscBp5EMPUSMjmF8CbA=; b=
	ZAvUl3TBy+lVbk12vJBPX8o1xYpGKxB4XalbO+EsFei2riCaKq9WJ7qb1924I1cl
	3k+Z3Zt0SSh1VbTHNB9yEMSYzbbe9nG6Klp+4cs6iFY6bdh++YQa9o7Y148p3ckO
	NET2ZUUpgy6yJtcjE9g6CIe/Oz4IjuZvlYcKuoygICTWJlJcvdRp9sfzingKSPti
	l7syZGw3aMVIjKNWhHgE+msImVxcz0WjrQu2Ia4twLTSda+wLXInvPqm6wSrCBGv
	ipSdeGvncCBhsFZaEkuXccG/k0gLbNw06dlR1qJWjH88fjtpb0Gn0BUeFCCPdAZ0
	9s1YChqCpWcKcNv5Y2jdMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736877426; x=
	1736963826; bh=xH9KpNHPinJSXc+YOduyekwpfscBp5EMPUSMjmF8CbA=; b=m
	/NO18h2gnu9JI+iC8PVIrsiU5/zecSSSVSX3f5x3gLUS87mjhXTytI9vaKtMjCM3
	EvKJWRiDnw85KS9X5agjOMRG+ZBe0EmpHxCBEXqJdC7DKS80GhWW/UOf6AqitMGZ
	A109chbioVkr6wcrIrB0kHCafqnkjK79UTTaiopuyIQTOEKo1DsI4vRPJY0/8pn5
	fHrTe8i2md9c91IPOUuuUdz67XccFPFcZlJUQSKCHTixZC7ywbZVKMpsQBwcy6yW
	Ss4VJXPppNDdZKtGjh1fivBnM5AZ2vJrFO5b4fkzrf94ptWOyVY2h6+VaoI2oWqb
	IgnWVpTTnmzxq2udApgoA==
X-ME-Sender: <xms:caWGZ6trrWd0m4G6FVbunF8VYowCfhppg_eHLgk0fH0dVskULoF6KQ>
    <xme:caWGZ_eVLMeFT1bAoJ7CytpcAtcONX2JM6PdAZtD0QNCVcII9yTuglm17hnS8dwH7
    tgKsu8T2oa1fpb0dY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
    teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphht
    thhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheprghlvgigrghnughrvgdrsg
    gvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgvggvrhhtsehlihhn
    uhigqdhmieekkhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrthdrjhhonhgtiiihkhesohdvrdhp
    lhdprhgtphhtthhopehmrggtrhhosehorhgtrghmrdhmvgdruhhkpdhrtghpthhtohepsg
    hhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:caWGZ1wczEVAC2-tnqJbKSz8O6wJ3pIv9DXFspIck6YTJuZZBSxTig>
    <xmx:caWGZ1MnFksrcKfPCs1ySsxO_a4ihHUE3w--RzxRoyPhUdKa_yeJFA>
    <xmx:caWGZ68Ui1ZQwyQv3BXgvJR7gRUd0hW_34od-vdLVFLYUqJ197R10Q>
    <xmx:caWGZ9WkByLzUcucWziNZhJweuTDz_0xPJRwGtx4wK4NoPs_8F3USg>
    <xmx:cqWGZ70wLJ80zN1lB95PP9BZjYGKufsznzMUw0EBe6UI9hCPbmdDKsht>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B96281C20068; Tue, 14 Jan 2025 12:57:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 17:56:46 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Arnd Bergmann" <arnd@arndb.de>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <ce65d897-7fa0-4796-a45a-997b38dc23b2@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
 <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
 <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=8814=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=884:11=EF=BC=8CMaciej W. Rozycki=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, 14 Jan 2025, Arnd Bergmann wrote:
>
>> >> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io=
.h
>> >> just after including #include <asm-generic/io.h>, with ralink and =
loongson64
>> >> as exception.
>> >
>> > Shouldn't arch/mips/include/asm/io.h do
>> >
>> >     #define PCI_IOBASE mips_io_port_base
>> >
>> > unconditionally, _before_ including  <asm-generic/io.h>?
>>=20
>> Yes, I think this would make the most sense, but the ordering
>> with the PCI initialization needs to be done carefully,
>> to ensure that PCI_IOBASE has its final value before the first
>> call to pci_remap_iospace().
>
>  Is defining PCI_IOBASE going to do the right thing for non-PCI MIPS=20
> platforms, or should the definition be #ifdef CONFIG_PCI rather than=20
> unconditional?  FWIW I think all PCI MIPS platforms support port I/O.

I think the right thing to do is to unselect HAS_IOPORT for those
platforms.

Thanks

>
>   Maciej

--=20
- Jiaxun

