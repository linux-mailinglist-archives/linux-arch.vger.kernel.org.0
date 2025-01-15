Return-Path: <linux-arch+bounces-9792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A2A11BA5
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2025 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D79E3A42A6
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2025 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EABB236EC9;
	Wed, 15 Jan 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pTsFUaf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qD0xLSu6"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD51EBFE8;
	Wed, 15 Jan 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928931; cv=none; b=BO7P4ZJrMzwtjsexcsp31rBXdE1jLN5tANySgtUUZgx+Wc6jCa4kY7pLTWGtywMDK6OTlytIMMT5p10V5t/laJL2cB4DNYQ0A4l3STuAvoagfJt70A+HdYyIsrH2ZGI2NRhGXZPuYRTLVVxgGHtTqZ95LB1VgZP0h0tp9ACKLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928931; c=relaxed/simple;
	bh=958AKdnms29VmzQsx3U3fJCjHZGQyQWTl/6eBHqs4dA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AV6bY+K1bwybxaKoPWDNY3duFiC84uwpGWYU2RV0Y4BtQy7CsULSzdC24q0Zf/YQjODJz6nfn8xeDbfGZ+ECO0XsAW8QpTOAzVQO3ps5S+Mxqhn/pdCPhnJtSCFJUO9/+cjMuAL4oJBnR/wneOUS5Rk9wVn67hDe7TNYbJNO/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pTsFUaf4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qD0xLSu6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BBD7C114013F;
	Wed, 15 Jan 2025 03:15:27 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 15 Jan 2025 03:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736928927;
	 x=1737015327; bh=FzGVK01lv8D6xNZRF4wWlQghCDQyf9wVZs1wXiqfIaM=; b=
	pTsFUaf4+FQOK+2AaV6Ise2cIpROAXabBhuEDW0uMfMipkY5Wc6grRJNuHV8FM13
	2YydVl0QiUr1N0CNtoaVEsNsxBEHf8djgdvElet2K5XR+7MBkpjWl5NwW46LKvPA
	hHW9xLr0+ZcNzk65N0739yCQkr+zmJRtmpgq5NB53+lJGGibVz0ti/LBf9dGuYpG
	ca90+QchzXziblsVorvYzRexlGuryoSrFRzHamXqDowlJ6hSLMAKmuLEnIS4lGn3
	EsDgfhVnsIWPMBck9S6SAmP2x3tf3/IVSp1AsUuCWM0XH2wHSvkXeDngi/9UQDyY
	bzuvQErz4OJG/w24TtUc5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736928927; x=
	1737015327; bh=FzGVK01lv8D6xNZRF4wWlQghCDQyf9wVZs1wXiqfIaM=; b=q
	D0xLSu6k84LYgjZAYNCZ2P0C3i+5j5x8IqlleWxE6Ho54TsP7DFPBGtuixOI1FNr
	/bmMK652qsn/WWSjXMlMy1LWEVIfAtSbLNgWZL+v2J3HHu3/I9V9qzVGk4tFAGuR
	R66Ft1PDNlKNymDxPxYPA8CjG6d05LL/HkZbsGL/xYM/D+2BBNyK25dQM280MfxP
	dupeNdzXoJ5nn8cdzdYOgdi4NzqpNxo2UnLllHvEHRwPnFvnnzt31Zi5gkqDyvwr
	dkfo3cUlwP81CHuvij5rElVGv+KOfZj2ipYWpDH1SXdYgk05e9Lh0hs/S2B2x15f
	7D6if05qqdMUEApoEj8bg==
X-ME-Sender: <xms:n26HZ9kQWzQVWJ0RV7fLy1yQ3PEjgaZ4xvhCt_Ydv5JTk9IsUb24AA>
    <xme:n26HZ40-6xkSdRkvg0WLE7L8-i7180KrN7G8atrVTdCkfyo50fNw3xUA5MFDg4Wb-
    6ktQNTBNxSZL-U1jrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphh
    grrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhho
    nhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdr
    ohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohepmhgrthdrjhhonhgtiiihkhesohdvrdhplhdprhgtphhtthho
    pehmrggtrhhosehorhgtrghmrdhmvgdruhhkpdhrtghpthhtohepsghhvgesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:n26HZzqouEoiBC6zNnMnD2UxmlN3JfwydK5oDAaxgxPkiPdIK7Evew>
    <xmx:n26HZ9koH15F4e1yNvbfjFBEgJG__R_kKQ_QAW1Iyr9yaKZK41vYnw>
    <xmx:n26HZ70eRyT7Xoq1jl8H-XTNjIS4Q1LEVsVeJV6JjTt2_hfue3zS4Q>
    <xmx:n26HZ8uACBUQfXY0KwzBPjlDz21VA1nI17VfmZFtP_XUeY7X5NOWwg>
    <xmx:n26HZ0vaViJUmp3HZFBXvrkDBZWI6uP92fCdkXUVL00S1nL8Iqfb_u-4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 057F42220072; Wed, 15 Jan 2025 03:15:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 09:15:06 +0100
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
Message-Id: <606d36ca-4cd3-4793-8b64-70b812e1e74f@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2501141707380.50458@angie.orcam.me.uk>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
 <08fe1ebb-b9c4-46c7-a6ab-5a336ec3b771@app.fastmail.com>
 <alpine.DEB.2.21.2501141605550.50458@angie.orcam.me.uk>
 <13d0c3f1-7e6b-4f25-ae00-9e41a15ec36c@app.fastmail.com>
 <alpine.DEB.2.21.2501141707380.50458@angie.orcam.me.uk>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 14, 2025, at 20:10, Maciej W. Rozycki wrote:
> On Tue, 14 Jan 2025, Arnd Bergmann wrote:
>
>> Ideally that should allow using the generic inb/outb and
>> ioread/iowrite helpers from include/asm-generic/io.h, but
>> unfortunately those don't support the address swizzling required
>> on SGI and Octeon platforms.
>
>  Address swizzling should be generic: for an endianness boundary crossing 
> depending on its wiring there's always either a byte-lane or a bit-lane 
> matching policy (of course both may be implemented in the same system via 
> different mapping windows, such as with the Broadcom SiByte BCM1250 SoC 
> though we only use one in Linux, or with some kind of a bus configuration 
> register) and either byte swapping or address swizzling is required 
> accordingly for the relevant use cases.  But I guess for just a bunch of 
> systems that implement the bit-lane matching policy there's little 
> incentive for complicating the generic helpers.

I checked the other architectures as well now, and I'm fairly
sure we had some architectures in the past that implemented the
same swizzling, but it seems that those all got removed over
time, and now it's literally just MIPS with SGI (ip27/ip30/ip32,
not ip22) and Octeon. From the comment above octeon_should_swizzle_table[]
it appears that this is actually configurable in a register
but was set up at the time to do SGI-compatible address swizzling,
when it could have just use a software byteswap (CONFIG_SWAP_IO_SPACE)
like the rest of the world.

I double-checked the setting of CONFIG_SWAP_IO_SPACE, and found
that it's mostly consistent in setting this for all big-endian
platforms, the exceptions are:

- ath79 is big-endian but does not set SWAP_IO_SPACE. I assume
  it works because there is a very limited set of PCIe cards
  actually in use on this platform, notably ath9k wireless.
  If readl()/writel()/inl()/outl()  don't do a software byteswap, there
  is probably similar hardware logic in place as on octeon and SGI,
  and the lack of address swizzling may mean sub-word access to PCI
  registers is broken.
  The ath9k driver only uses ioread32()/iowrite32(), which works
  regardless of the address swizzling, but many other devices
  would be broken.

- eyeq and rb532 are always little-endian, so SWAP_IO_SPACE
  does nothing despite being selected.

- nintendo64 has no PCI, and I guess the readl()/writel()
  in drivers/block/n64cart.c, sound/mips/snd-n64.c etc
  end up using readl()/writel() as native on-chip register
  accessors instead of byteswapping ones.

       Arnd

