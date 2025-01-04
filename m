Return-Path: <linux-arch+bounces-9589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6881A0158B
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38953A3F34
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490C1CDA15;
	Sat,  4 Jan 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="A6HlF1X8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wmF8WwtZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF51CB51B;
	Sat,  4 Jan 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736004707; cv=none; b=A4AFi0IXH1E/v93DitfRn1TGhLMaKe4m/K17g6HN3wBS79QU3B+7mF9voTNUQXplfKFr84q+q9RyjtGfAZgsxPg+dRuO9fqhZOkTOqieRqWesJ/ta8ByzzQ+ubcxV4gIhD7zj8k02Du38xfv3OarsSNjy4J4BD5ahahhxlI+9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736004707; c=relaxed/simple;
	bh=Y7FzKjlkcbsjDN2oW6kEV2UiVUr7SXpjxAxSee/tDjg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UoiQ1VJWGR82dP/TMCJLMhG0/vC0WUM8oI8/QFT8oajOiaPTwc2lkNSH10kVeaS2So47PX7iuSFBjVw8E1At/9SNg9tZ9CtZmmkDRUioJuSmCiMKyK5+m8D2feNHu8zUk7nteCyPbEbmtMvHJO5+pa9oygAcKaBLXlYbEkmmE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=A6HlF1X8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wmF8WwtZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CE35211400BB;
	Sat,  4 Jan 2025 10:31:42 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 04 Jan 2025 10:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736004702;
	 x=1736091102; bh=wdBAHaiOaxFu7bw2LTQv+tWj0IOrhJR86UlWiABSfsk=; b=
	A6HlF1X8eS6TJTI3gzjghnb9uMVW+7F0e8LKJKhvBClisfjQTDDwGS3as+NFq8fq
	7pV16LQ9Y2CcBnnkGfOtyLkwYloJHB6DyJ1HYCq+6xveY+AKwXzAnZNKEtImb/c3
	hu2izqUOKn8lJMfB/6WEbTLrGpu2bl6rrXl9I9WSv9eR3Z/Ird6DsfKlOMvgzqqQ
	p0UB2f6bHpwCzbkgmOux2NxIqxzo1HmBb7VNKTy4dFftv7Jz4YRuWVFcKfordPDO
	NDtLyfZBIKFA9oVzco1mh2NdW1u2LxPDqd0wuPT91CCdW5zV1YDsuk3z/YAhZs1R
	0ix21ms+KvL3BzgltC9yKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736004702; x=
	1736091102; bh=wdBAHaiOaxFu7bw2LTQv+tWj0IOrhJR86UlWiABSfsk=; b=w
	mF8WwtZBta9cBfEqkW3LV6j+XmVcKvNC9SqQEWfShCEm1LOCpqtoYbo0MMF7xc+g
	ztvPShYKKNj+3OAq+TDuPBIEFBsDRJA1FTgM8pvYDqnAmUVCPtR3sDWqrUzg4F6L
	OCFYX8gE4hKHyvGnTaKyT1Cyn1C5ORQ4NYxbPGurjguryLLrXDdrzrhqQC+EhlZC
	5qq3BgAoWiLlK+/Z4tTCQKfupJofhI6lo52A/OzED1uSGAwKJ0f2LHmdFV0UVucN
	H548vhlLUGeeVvjY1a5xjyJg4TK23arBJE0ilO0qzPSM1WIV02WKaWrCtzG/a3Um
	0IeQOPkVZx5QHlE5+jDNA==
X-ME-Sender: <xms:XVR5Z_AUmEFmvpM9jLaKT-jUXSkuw9IXV_EXcNrMzjx2jNvtLkDZ-g>
    <xme:XVR5Z1imxkU2fZMlTQNdrp_lvqX0QcuNkmp9TQpPSIPQa1VvxGuhw6HI6Gg47Uit7
    RSa7yfPTh508DsE7aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:XVR5Z6k7iM99xV-jENKOWU-66Ov_DgblTPesaYYRu8M4G7UodfYrFw>
    <xmx:XVR5ZxypSpX619nP58s2CREFFZoFPgheMwvJ5RbJYmxCbevaPBHmrg>
    <xmx:XVR5Z0TtzA5tFHEn9LC24ohH7ZaNfA1mKOd3btUj8gX07aaJx4XXyg>
    <xmx:XVR5Z0a6Ap4f8Nh3Vv9ZP3rZNOA2QvxVSSjgAWmiqqLQq1IZqe8lTA>
    <xmx:XlR5Z5KPaFRIMIDwQfV4lH7Sw582NCxuUPq_TW9H8F6OAtpxHMAtaOIc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D526D2220072; Sat,  4 Jan 2025 10:31:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 16:31:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <03b0d959-9a25-4a67-bd66-979fd6909430@app.fastmail.com>
In-Reply-To: <20250102-la32-uapi-v1-1-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-1-db32aa769b88@flygoat.com>
Subject: Re: [PATCH 1/3] loongarch: Wire up 32 bit syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 2, 2025, at 19:34, Jiaxun Yang wrote:
> 
> +#ifdef CONFIG_32BIT
> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
> +		prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
> +{
> +	/*
> +	 * Note that the shift for mmap2 is constant (12),
> +	 * regardless of PAGE_SIZE
> +	 */
> +
> +	if (offset & (~PAGE_MASK >> 12))
> +		return -EINVAL;
> +
> +	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> +			       offset >> (PAGE_SHIFT - 12));
> +}
> +#endif

I think it's time we move this into mm/mmap.c and agree on the calling
conventions across architectures. I'm currently travelling, but I can
dig out a patch I made a while ago to convert most 32-bit
architectures over to a common mmap2() implementation.

As far as I can tell, the only architectures that actually want
mmap_pgoff() are m68k, arc and hexagon. Everything else either has
a fixed 4KB page size (so mmap_pgoff and mmap2 are the same), or
they already enforce the mmap2 semantics.

There are some smaller differences between architectures at the
moment that I think shouldn't really exist: sparc32/m68k/arm32/parisc
skips the alignment check, sparc64 and alpha add an overflow check (on
sys_mmap) and powerpc adds a pgprot argument check. I think the
version you have is fine for common code (including the ones that
don't check alignment today), not sure about the additional checks.

     Arnd

