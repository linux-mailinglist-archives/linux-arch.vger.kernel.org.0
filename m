Return-Path: <linux-arch+bounces-7822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19157994445
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2AAB2197D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43117D36A;
	Tue,  8 Oct 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bjNgc0cU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psOjcXwi"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964517A5A1;
	Tue,  8 Oct 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379677; cv=none; b=Zw46MjjkLTaegkpU8O9JGbqDARAiS/Pk/OynoeEdVDy1nOO5Zau7QODiMUyBm9GkvaP6M5+vCMajfjYTXor+Vf3Wkt1AxeH2kRkP6FqAg9P6r4pPvYbMaEG20EqEknEztp94Tb4H5ClpTN/XeCGO49y0ZFbOu/Epsn+vtOdN4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379677; c=relaxed/simple;
	bh=VKY9AlnrM9YiRfo50NjYcLDV1DcMPrKJfBa2b9+eWDU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lkrPp8YyCVYYbVEaCq/QpIHAw3u16rQes/9DhZDH7ionO4oxwi72EeQkPy1dlMJSId08JNrFKULv7x6NEW0uYzMh1D0rmJereeLbNcEzQDUaQ0uPYlgNG/vXhXTQCPhcGROoG1ChxmyyHtAwbSoXOf0g5OvJDhgoVOEVWqg6AEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bjNgc0cU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psOjcXwi; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 51CC0200791;
	Tue,  8 Oct 2024 05:27:54 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728379674;
	 x=1728386874; bh=vXVXlSmeQt3lDbjU6nzfzfDoQAW9RRomvBadp2xogcw=; b=
	bjNgc0cUBA4uZdH1q47ixH6gx6ApEG2i+6J6MPi8YvLMk08HDLdfZy8hT8Zg6yKe
	2NNW+K4vM+BLpVDgWKXQdLIKSYik0I3IB7tJont13em6PzKvSbkr1B06qXFqKd2M
	d0ejs6pFeYw/YXyhY+Lcf2huo4OyJRBX1xHiNcSNQmv5p+6ZX+wr7Pd1lBixTgNN
	hy3ySSe4YK4xve31mXcvCM9P9Iw3LCUZGsP9K1m9N7p5Xb7ubYL9XZcAEES2eqKH
	q4Bj/X1CPUurJVbo5pIPpwwN0hbRGOj6w0V/7h1MK76aEfaffRgEVf3txqnhVsaH
	NQLl8GS7yuUNX9Q5G2TmCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728379674; x=
	1728386874; bh=vXVXlSmeQt3lDbjU6nzfzfDoQAW9RRomvBadp2xogcw=; b=p
	sOjcXwit6BXpazNlyHcp7RQtet3ms/ShGIHVtIXjHH7z2u/WnegtOxGTuiQ548AQ
	+QeNCeOEnTuopzDdr6d1WJbi0tqer+OAMlHpYNMA4rKYXQSYp8xhdFdowZELsMYk
	mPiA+7k1yhl45NYwlOZiplxm5RqztnqU39N1c1aWbEv2VrChje997BHNId6Fidh8
	f/66rTIRr/Rf8m4bRDMcg+3Et00AosDHyah9nBj+ZrujjgTGAUXfWePzzlS94iIY
	R0idMtIh3pgHEw8KwMyxu5rrZ+cNSTvxzSNz15dfdF6tlWKdZbu29sjFAq+ca8xW
	Sb+T7NjbiudHSJhRasvgA==
X-ME-Sender: <xms:FvsEZxj4OSOJO5R_iNsz2YcNkoHn0yLCSkYK6NBW46UzHpbVeaOylw>
    <xme:FvsEZ2BOquKh3Ly6rs2-r88YflJwtYbElvZlqzUDwQxS0vX2aRowkRAfJok_DDP9J
    pVcVjM_bJaqf2Jtc-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhg
    rdhukhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtoh
    hmpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhrvgih
    shdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhroh
    huphdrvghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghp
    thhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhggh
    hinhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-ME-Proxy: <xmx:FvsEZxH3zfzkJa8RVVsQJZoKvnwBlHYLBK33c0RZVMnXZVlSu1AFqQ>
    <xmx:FvsEZ2TkOnb2xmY6R_aU2VmL8HDxOWOBk8tgzBsUripCRCPzrK9zmw>
    <xmx:FvsEZ-zauMDlD6bC6qkUsSUnHXG1P0xy_37njpHP8yhxpPZjQln2mQ>
    <xmx:FvsEZ87a2x1N0-w1vvIsh6Lf1hOcJGqvGuZ7q-fy_-iHchmecU6CvA>
    <xmx:GvsEZ3DPdeCYlhTq-fZUHLeUnTw2J7FWdf8IfVzPa0rAh4jeq3MQ4aNK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C545D2220071; Tue,  8 Oct 2024 05:27:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 09:27:20 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-sound@vger.kernel.org, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <a9fa56b4-b00c-4941-8c8c-1d3b58b573e2@app.fastmail.com>
In-Reply-To: <20241008075023.3052370-2-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 07:50, Julian Vetter wrote:
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 80de699bf6af..f14655ed4d9d 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -102,6 +102,12 @@ static inline void log_post_read_mmio(u64 val, u8 
> width, const volatile void __i
> 
>  #endif /* CONFIG_TRACE_MMIO_ACCESS */
> 
> +extern void memcpy_fromio(void *to, const volatile void __iomem *from,
> +			  size_t count);
> +extern void memcpy_toio(volatile void __iomem *to, const void *from,
> +			size_t count);
> +extern void memset_io(volatile void __iomem *dst, int c, size_t count);
> +

I think having this globally visible is the reason you are running
into the mismatched prototypes. The patches to change the architecture
specific implementations are all good, but I would instead add
#ifdef checks around the prototypes the same way you do for the
implementation, to make the series bisectible and shorter.

 include/asm-generic/io.h |  58 ++----------------
 lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++

Along the same lines, I would change lib/Makefile to build
this file unconditionally even on architectures that don't
set CONFIG_HAS_IOMEM. Again, strengthening the driver dependencies
is good, but it feels like a distraction here when we just need the
common implementation to be available.

       Arnd

