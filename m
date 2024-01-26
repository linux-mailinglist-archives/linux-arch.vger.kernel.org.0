Return-Path: <linux-arch+bounces-1718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B183DBB9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 15:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFA3284106
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849C1CD07;
	Fri, 26 Jan 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HqyE4prg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGkLV9Sp"
X-Original-To: linux-arch@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A81C695;
	Fri, 26 Jan 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279055; cv=none; b=UVSLvv3x6jNEpQITdv/Y9GBoQX7c9FVE/TOjqb+iPY+41MF+AT0h8SlYMee9ltQHqACnwVoq1Q4TgCG56HevFVG3Qg1fZ7uqjErdKu5+tyyYnRALvRc3Wb1wj1V2aXgHu2Ka1V2mVqrQkgIWZJrDzgwGAvrmCkPA/kmqmNv3Dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279055; c=relaxed/simple;
	bh=hKIfs47ddSkIptRXRENQTpOASHv1OOHXf/8ceRFn0/k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TjjzkOhzEGawZ2GqHCits+UttT3I0o6R3iCDr0Hl686f6iUZyOEmRnCUJhMHHr2G0WqutrqaFJi2+IIPMk84nGvXv41XYneKuPiRcHrYTBVseUsFwHni9olUjx6euZZHrmloURm7FYgP8T5B4eLUfSoPkugkXwWFKk93H36A3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HqyE4prg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGkLV9Sp; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 96C8F2B004D0;
	Fri, 26 Jan 2024 09:24:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 09:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706279049;
	 x=1706286249; bh=TF+Ka+GXK+ztTGKn5RdSG0DNk91ZmYKf5EL+gc74hng=; b=
	HqyE4prgfd8Ba0Bmvq/8hIZN547wH19SUJZbqUpbMCd9JpXwBct8mBDqhraHb6+T
	mbEoF+BMPvsLE5Z6tS5/47kjcZTno7n4oyeu5Nvyg2oRBQNuOMTMFsI70KjowdOa
	WWkkaRlFFmgtM9fD8rzxvdoU53s1ecmYxb2NeqwEltV2IzbJUxJqbOCK0c5HTCfJ
	OuoQDl5Z6Nte2EOdaf12WHv9aBi5cBdWmr4UuK9N6YyNUqzWsLCAmBnpytyaR8gd
	CfJUI/PNAEQu2q0rdgXsnulMtUvqDMeMRA36m21aK+OsMhzO352cjVje325yedg3
	oVbHxxlz+MLgoISc0YNFkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706279049; x=
	1706286249; bh=TF+Ka+GXK+ztTGKn5RdSG0DNk91ZmYKf5EL+gc74hng=; b=p
	GkLV9SpgJfadZtrnSQJaU54TnuTjuQAOSG7J4wwGwen4oY9YDdsI2Q4vTsi7bkkI
	qukYU5RWgE3Jl+MbDh5Kgt6V9dS0chTDsV8ow0UreRfs9EJLa5zRpXU/DNf+l8Jt
	YwaH4yJy/cDQ+NTxm+LNLwqKT/CClboWq+iYWnzPRthNjvmMeSL+uks6YTKckt5A
	eOyXg7QcQliOomfqnDF7BVa6NB9QfNto5Yvxg02IhQ6tgn3N8icCXsnRGnBV15dH
	FnYE4/Iwef6aw+Vk0cgGiZ1JeW8EYwiANDxPywQN/tlrwJPo4sTKIDqZXa4rEHFA
	e3SiE4Vmf2TmUwZs3MTkA==
X-ME-Sender: <xms:iMCzZQNYer9f7VdPOXoyPKfCj2jFtSHFwUmb2nP_5Yohb-DdxY4JHA>
    <xme:iMCzZW9H5HZ_r4Jx6Ozw0c9htRvipTfjcFPBGtvrVcc6c_lhcCFO6BgUhbNPqrvUg
    1qqYnu0RGIY-GDYGS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:iMCzZXR8FMsOmcKyqhh09tq2UAow3bwCtteuyDRN_V4F3-ngFw2Zjg>
    <xmx:iMCzZYuhXHdz5KCGUV9bj3HgMcnsXTn-IPyg-j8fV4a7h_6SEtmPOA>
    <xmx:iMCzZYdu-71nQpJwF7TblWOq2VuZmgeBISgs0-h7I18TvXQEcVLtfQ>
    <xmx:icCzZbyhv8qGURYbFFSDIlfrgqETSP8vTsrazydnRbntID8tzlG8773dWCk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 60C02B6008D; Fri, 26 Jan 2024 09:24:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c11243e0-fcaf-4eda-92d3-c06a8f8cdb2d@app.fastmail.com>
In-Reply-To: <70b8db3ec0f8730fdd23dae21edc1a93d274b048.camel@redhat.com>
References: <20240123210553.GA326783@bhelgaas>
 <70b8db3ec0f8730fdd23dae21edc1a93d274b048.camel@redhat.com>
Date: Fri, 26 Jan 2024 15:23:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Neil Brown" <neilb@suse.de>,
 "John Sanpe" <sanpeqf@gmail.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "David Gow" <davidgow@google.com>, "Kees Cook" <keescook@chromium.org>,
 "Rae Moar" <rmoar@google.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Marco Elver" <elver@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>,
 "Danilo Krummrich" <dakr@redhat.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 stable@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v5 RESEND 5/5] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024, at 14:59, Philipp Stanner wrote:
> On Tue, 2024-01-23 at 15:05 -0600, Bjorn Helgaas wrote:
>> On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
>>=20
>> The kernel-doc addition could possibly also move there since it isn't
>> related to the unification.
>
> You mean the one from my devres-patch-series? Or documentation
> specifically about pci_iounmap()?
>
>>=20
>> > =C2=A0{
>> > -#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (uin=
tptr_t) PCI_IOBASE;
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uint=
ptr_t) p;
>> > -
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && a=
ddr < start + IO_SPACE_LIMIT) {
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ioport_unmap(p);
>> > +#ifdef CONFIG_HAS_IOPORT_MAP
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iomem_is_ioport(addr=
)) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ioport_unmap(addr);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0#endif
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(addr);
>> > =C2=A0}
>>=20
>> > + * If CONFIG_GENERIC_IOMAP is selected and the architecture does
>> > NOT provide its
>> > + * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that
>> > the generic
>> > + * version from asm-generic/io.h is NOT used and instead the
>> > second "generic"
>> > + * version from this file here is used.
>> > + *
>> > + * There are currently two generic versions because of a difficult
>> > cleanup
>> > + * process. Namely, the version in lib/iomap.c once was really
>> > generic when IA64
>> > + * still existed. Today, it's only really used by x86.
>> > + *
>> > + * TODO: Move this function to x86-specific code.
>>=20
>> Some of these TODOs look fairly simple.=C2=A0 Are they actually hard,=
 or
>> could they just be done now?
>
> If they were simple from my humble POV I would have implemented them.
> The information about the x86-specficity is from Arnd Bergmann, the
> header-maintainer.
>
> I myself am not that sure how much work it would be to move the entire
> lib/iomap.c file to x86. At least some (possibley "dead") hooks to it
> still exist, for example here:
> arch/powerpc/platforms/Kconfig  # L.189

This one definitely takes some work to untangle, it's selected
by two powerpc platforms, but one doesn't actually need it any
more, and the other one uses it only for non-PCI devices.

I think the other architectures are easier to change and do
fix real bugs, but it's probably best done one at a time.

     Arnd

