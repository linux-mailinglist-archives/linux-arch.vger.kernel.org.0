Return-Path: <linux-arch+bounces-13922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFDBBD700
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F36064E3A98
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C5260590;
	Mon,  6 Oct 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbn4Wcse"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4161262FE9;
	Mon,  6 Oct 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742761; cv=none; b=tPIeSqv6rr8Moe7LYjh0LnJ/ehQ9cf1P1PmV6S1NdKrWhP2mdzRw3EC7h8vLhSY+cfXQFaQ7Dy2x73BbHYK836Qe2MH2IcZjstrV8wDnpn8rGsXPjjY/PsUXEPK5FL3Si7rRKdxabChUyQGiUZPUPIDEuFWJzfT83vqQRAJZ4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742761; c=relaxed/simple;
	bh=UySLR6TmbZVuXe9tJaNxLhSTcW7QSfIrkFO0rBy6FIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M4AU181N+spqiZvEeHvieso1XSAG+MOx6LK1oxOji1VJ/hQLexqhiKvEHWOHOENw3cr1e71/970xqu1fKB8cIUQKdnDUU1XlW0uXgYw5kFJQr0wUTG4moUU1prVkW7E6h50x9s72Mvsshax+Ytsm6uTWxYZWykJQpMluyHMGeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbn4Wcse; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA75E7A005D;
	Mon,  6 Oct 2025 05:25:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Oct 2025 05:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759742758; x=1759829158; bh=qod5y7xd7sXLsKt/VwC7GHOOQx3sEX5cZEN
	DcS4e0w8=; b=vbn4WcseJA8B2WjfLM27TqHv8cJRoVxXgsEPgjrnryJooSdxioY
	KUL9aO+zuyN8xI12XWjZW3mIG9qKRC6WTPYz39InE2dFSrDUHpqkxj10nRpk2wHt
	AOwE4I1M2ij9D9aIfYjcUw9OLf20gTjRagZb89AXFRf1l/EijePJ134aXsciwoJZ
	oZxIGl1EL7uEopsNDAcGAvABRl5WcQ61C4foyRC/urZKfdBcvG1sdZoeX8r/Bfnl
	4f+8EN3Hu693MZuQ4DjH3+swjf5z3wyvJJQgyOpmfL2nZpyfkv1VdWts1qIlElx+
	CTw9MNkkKH+7Hy1GjdUeDV6SW51nAXZKL2g==
X-ME-Sender: <xms:JovjaOnSW0LvWWnZfcHCdOZhAw1_X7viIuVW7t8MhC_k8vYbz2Efgw>
    <xme:JovjaN_0YGh425YTJXlKVY2JKqSFDE3kpALYC8vNc3HLKiNy0V_IpmK1uzIjuiVxn
    MuoMUxLkRpO6Bdxwx1pgmV06uySyNTXmsW4bGXUF6Rt5v2keaLIXv0>
X-ME-Received: <xmr:JovjaMKqdXYxFSqG-uwQBsr1KeQwlTbPNsIgTdiB4302mXx94WxIebaRnekRkktSrV-srPmarhfprHG41EskOZcEhKVW8WXd8pU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
    htohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JovjaCh_xiAl-7cdLtm-JQSPmeDt74upCUK2V5eUo-z6Ob5oKjmTNw>
    <xmx:JovjaI81krDfjINsFKIotuMtakJjoV_yT_03Av0Y5o8SDVUIiCoihQ>
    <xmx:JovjaHPnoFHiwVt9MO-nh3oZ3ApbrHhy53GlrxlNHd1PaslIAhen2Q>
    <xmx:JovjaMDoYQL0CJCVVXSChenkeO-IxRPiW81QVAIl9P8B0OeLWcfYmw>
    <xmx:JovjaAVcMKLcxmugAlm2C6iZpBAWorRbpyZxxsXVQxORiSnkjr8d0x4o>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 05:25:57 -0400 (EDT)
Date: Mon, 6 Oct 2025 20:25:59 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <7de25cf0-595e-4b8e-b0da-6e5a66ec1358@app.fastmail.com>
Message-ID: <68bd3bbd-66cd-8acc-1e17-c677193172a5@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org> <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com> <60325e45-e4a7-d0cf-ba28-a1a811f9a890@linux-m68k.org>
 <7de25cf0-595e-4b8e-b0da-6e5a66ec1358@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 1 Oct 2025, Arnd Bergmann wrote:

> >> Since there is nothing telling the compiler that the 'old' argument 
> >> to atomic*_try_cmpcxchg() needs to be naturally aligned, maybe that 
> >> check should be changed to only test for the ABI-guaranteed 
> >> alignment? I think that would still be needed on x86-32.
> >>  
> >
> > I don't know why we would check the alignment of the 'old' quantity. 
> > It's going to be loaded into a register before being used, right?
> 
> I was wondering about that as well, but checking for alignof(*old) 
> probably can't hurt. The only architectures that actually have a custom 
> arch_try_cmpxchg*() are s390 and x86 and those don't care about 
> alignmnent of 'old', but it's possible that another architecture that 
> can't handle unaligned load/store would add an inline asm implementation 
> in the future and break if an alignment fixup happens in the middle of 
> an ll/sc loop.
> 

That hypothetical future requirement seems improbable to me. Moreover, 
would such an architecture have a need for CONFIG_DEBUG_ATOMIC?

