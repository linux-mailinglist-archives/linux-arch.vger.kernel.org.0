Return-Path: <linux-arch+bounces-11015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5547A6B8B0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 11:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D33B1B22
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C621F1512;
	Fri, 21 Mar 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Aj8WzG1I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zly6AD+I"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB0200B0;
	Fri, 21 Mar 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552621; cv=none; b=e0p8wTkz0aJXA0iI3s5FJy0pVK2afKGrxO1vU7mVZYk0shXjPaQs9HksPRxxrT8F5QbKKU3EgOGjpMEq/RtLOnozLGWdCWhBmQrg6LyzK+3i3TEHWzXAR5noUOjO93m/C+2P4ZyXablwx+mDuX7ifgQk5DNpk/h44rBdRTiHOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552621; c=relaxed/simple;
	bh=RMs/PSp53L6WgsMIE2/Hg0EtwHglh5WtXQO5Wsvdm8s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f4ILBwi3GMskM2sj2OarNOWzHUW0jqmCzKayEVZvDzkTYH15la1mWMtBOriPfBoKmYoxyEhMJUvo+p6YeUJd0oC6PkDj8yxEyVeYuWy3UynOXVxrvxeYloh7uLeswsMkF6bUMlNKu6oEkyCZtlKYsj9HnQUdkKVunjE9+eIt2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Aj8WzG1I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zly6AD+I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE17011400EE;
	Fri, 21 Mar 2025 06:23:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 06:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742552618;
	 x=1742639018; bh=4UJevjEnua/hzuv6hukkiRL584yrJsU8XeWiL1LLMD8=; b=
	Aj8WzG1IUqT3lWmRHOZ7RrH+yaiNF6O+b1ll6F8XwGji2k6T7Gq+RCxrn5gCNfZN
	WC+mK6nvClR8BgcNVb8kyg/Gcju+HXbBPySim8hTNGG3rKYDQ1MJS+UKlNghWfbg
	k0Y87P4xbfAUjqfMPiE2LXI0NI0h1YEUaZonDEUhdh8V69/ZJz5S2/xxceHUufsa
	wf5WjhD3HJY/ZLbOPhOzozlk3XNA/EYAM8c8yluWzAij1FsHHFmXt5pqFHwbWS4A
	RWS5G+nrNUmMhu7aczpNVc9VV9axKXtR+6iojehnhmfWzIfseVF3B2WU/mxKihwz
	8m5c9cFOL79eZy64GPN0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742552618; x=
	1742639018; bh=4UJevjEnua/hzuv6hukkiRL584yrJsU8XeWiL1LLMD8=; b=z
	ly6AD+Ihs5gg7Xi6hEB+ltIrUd4lsTKMbCGVQ/Q6NwWP9muAIj3pTWDBT62AgYnK
	RPwqvQ2tdI3D7WdEfWWiMCorOeYPtmJidLWSQqEJKaGVJiv1Du/khrli/hn32Lgo
	RJsyufpWPdBFeOvlwN0+a02DMm/jJsT5b2XzajNffBnmfDMUMpBezXWXGYnChIbg
	TRc2BJJ3Kz3N49oMp03R0aiVcSwlq+ylWqYx+5ITeKqQEPpi1vBMDjY5Cbkpu0uC
	xU9TpPD4yvBoRPGHDZ3xMfnahGpiXp9Wre/LdRe8naQxSVgPskw2mQNtMaXASNLe
	u3gkuh4YgzV7djzCCHNWg==
X-ME-Sender: <xms:Kj7dZykJk9SsWjjvP9qQsveFNQdd4dHB9tl78p3Xz08gyY9DGmePzw>
    <xme:Kj7dZ53Yl-Su9tLE2JAS8RYLxGdcIbp5Wq8PAz9xfaTPBDR21PK-JjLwR_g2VTOcv
    hlBW3HMGRjGVHjaIcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghlmhgvrhesuggrsggsvg
    hlthdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohep
    iihhihhhrghnghdrshhhrghordhishgtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtohepsghjohhrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Kj7dZwqhYI8KVO9p2qwoKMwwDOBjgHGLyOa41iE_lI5pbFguaAmVWQ>
    <xmx:Kj7dZ2n57kKHcok9q14JayhgRSuMMjUK0w-d3Be7gE0cpoFX4Oyb1Q>
    <xmx:Kj7dZw1M5GoiRkOoXkgelQZpJdwWb9OnyMKpVsYf06QcTh6Jcus0Sg>
    <xmx:Kj7dZ9uraoJ3pE9R4GYSmHJpFKQhkeBLbud9ZEDotc4ffIoECPq6sw>
    <xmx:Kj7dZ1trPzB9iuKKEJApJowMAXKCYdRD4F601K1ruzXd1y-RkwcNDPzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5311C2220072; Fri, 21 Mar 2025 06:23:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T04d17f90b906d792
Date: Fri, 21 Mar 2025 11:23:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ignacio Encinas" <ignacio@iencinas.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Eric Biggers" <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Zhihang Shao" <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <583340a9-411d-406f-aee9-d3e2eb80ca43@app.fastmail.com>
In-Reply-To: <ac0b1f3e-6abe-4de2-bf5a-a4b3207a22c3@iencinas.com>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
 <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
 <4d45df0c-d44e-4bb6-8daa-0dba1b834bc4@iencinas.com>
 <07b8051b-9d5e-440e-b74d-1ca97402fe2a@app.fastmail.com>
 <ac0b1f3e-6abe-4de2-bf5a-a4b3207a22c3@iencinas.com>
Subject: Re: [PATCH v2 1/2] include/uapi/linux/swab.h: move default implementation for
 swab macros into asm-generic
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 23:36, Ignacio Encinas Rubio wrote:
> On 19/3/25 22:49, Arnd Bergmann wrote:
>> On Wed, Mar 19, 2025, at 22:37, Ignacio Encinas Rubio wrote:
>>> On 19/3/25 22:12, Arnd Bergmann wrote:
>> Right, I do remember when we had a discussion about this maybe
>> 15 years ago when gcc didn't have the builtins on all architectures
>> yet, but those versions are long gone, and we never cleaned it up.
>
> I just had a chance to look at this and it looks a bit more complex than
> I initially thought. ___constant_swab macros are used in more places
> than I expected, and {little,big}_endian.h define their own macros that
> are used elsewhere, ...
>
> It is not clear to me how to proceed here. I could:
>
>   1) Just remove ___constant_swab macros and replace them with
>   __builtin_swap everywhere
>
>   2) Go a step further and evaluate removing __constant_htonl and
>   relatives
>
> Let me know what you think is the best option :)

I think we can start enabling CONFIG_ARCH_USE_BUILTIN_BSWAP
on all architectures and removing the custom versions
from arch/*/include/uapi/asm/swab.h, which all seem to
predate the compiler builtins and likely produce worse code.

    Arnd

