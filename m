Return-Path: <linux-arch+bounces-14116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8ABDD2B6
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BAA3C6A49
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCC304BBA;
	Wed, 15 Oct 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggOhvzE/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667F2153E7;
	Wed, 15 Oct 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514050; cv=none; b=YcnDswQM4czpSsI0e2xABtj22QyKVED7z4z43qHRCblYUmuTjPxdd1it4rNGgCqPKXxNc/I5jxMgnYZyGacHOLoyIpwUK0i47wQQIFMxSGHlwK+DLrhQn7po/kHeVPPkCC3dpMeJpeaphGNRqe4SDei7MZhqXQ5lctnhRoXfDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514050; c=relaxed/simple;
	bh=dt30EklpSZi/7lhcJZNz9S2gIHGZWvqZN5FUmUz3/jw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K5XVLJFP4ofYGscBtc1KXg9E30fapWbIoWRBAce+C5QDIrboektgOpLoaUAhDHcOr2UNDkN29/h6gjOHTUf8qR2TvQM13uG8L7FNmnRjdsOyIBb4wtrU9JO33BR60mlVHs0koeiERtC4qtXJFfkw7W9/1X2/NFVtsmyObx6RReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggOhvzE/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 84E1D1D001A0;
	Wed, 15 Oct 2025 03:40:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Oct 2025 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760514047; x=1760600447; bh=Hjz+mqNYfvzjq/YJEYihb4TnZiLmD1Lj/yX
	vDrOsq5A=; b=ggOhvzE/7YVP9rUtx9NtsXRkOsnCUJ/qt2NFNUpu3oXu6ci9usU
	9FwZHtgU8LRnAIO5s/IJdmxbLYqCd4rJ7HVVWQFb8CiHDKnWZ/dtofEKyw8Ol9Rp
	r7X5qfX/MWWAvOgwFDggReiRiF0ATQnyLtA0A0YVo/2x9znfosycZ3+Gk1rhOvld
	1KqZ2UdWKYLrWL5DiEvSQOC3NMr0jriN3wtE6sQpLaQxyNdm+ge1G4M0ecc6S0m4
	R4p27Nf9FgXyAf4dmTSc68BrRw2zSneIax+fd1n7ed9PGcFwPWkO58mv3Fn76KjZ
	ZWlZ1Q14tRmXqjvTdJ9BeA1KlGsQfp6Sokw==
X-ME-Sender: <xms:_k_vaFvQ6j6nUU9Bz9OmIrnvm1b43RCX6IjtYMrvOQCRcb7LZSuGCQ>
    <xme:_k_vaCJs1lzijUQR7-Bpe29tzk0vmejTwk-v6rAZ6-0k_oDo6yoSkfSiPzXp3-FAT
    N_PV6kOM9MmxreuEIjdWXogP-WCvC-aAmg5xjE-xlVBahfIdqt8JQ>
X-ME-Received: <xmr:_k_vaBbkQR-x7xV9LEBBoGKY9rkzilWsr14DSBEIvCzTDxOG02osw2ak1iaUkq3vm2wEBmsHRhIj8-35Ve35BrXtXM-IFGmjB-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuh
    igsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfi
    hnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhr
    tghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_k_vaNkowgqRDxU0NrAP6HZs27XEnrfVUnwK4cWX2Ev_9_WkFonUbQ>
    <xmx:_k_vaHXi1PoUukZyiT8j65TiGM3flKikc39SU7PKTnoemtd_VuXg6w>
    <xmx:_k_vaPLIE-igCSJb_mDiNimE5GR9xSzZNvdI_UIPlDwllRy0ikDQDg>
    <xmx:_k_vaHuOiZS341r5sWdGZlxWEwoLz_Q9W5uXweooNJh2ZLbBDZfUeQ>
    <xmx:_0_vaETJOQMYxuBxhK-52T5aaFOLCH365KBvspjjxybBzPmgyHp2i3km>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 03:40:43 -0400 (EDT)
Date: Wed, 15 Oct 2025 18:40:39 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: David Laight <david.laight.linux@gmail.com>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
In-Reply-To: <20251014112359.451d8058@pumpkin>
Message-ID: <f5f939ae-f966-37ba-369d-be147c0642a3@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org> <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org> <20251014112359.451d8058@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 14 Oct 2025, David Laight wrote:

> On Wed, 08 Oct 2025 09:19:20 +1100
> Finn Thain <fthain@linux-m68k.org> wrote:
> 
> > Discourage assumptions that simply don't hold for all Linux ABIs.
> > Exceptions to the natural alignment rule for scalar types include
> > long long on i386 and sh.
> > ---
> >  Documentation/core-api/unaligned-memory-access.rst | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
> > index 5ceeb80eb539..1390ce2b7291 100644
> > --- a/Documentation/core-api/unaligned-memory-access.rst
> > +++ b/Documentation/core-api/unaligned-memory-access.rst
> > @@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
> >  When accessing N bytes of memory, the base memory address must be evenly
> >  divisible by N, i.e. addr % N == 0.
> >  
> > -When writing code, assume the target architecture has natural alignment
> > -requirements.
> 
> I think I'd be more explicit, perhaps:
> Note that not all architectures align 64bit items on 8 byte boundaries or
> even 32bit items on 4 byte boundaries.
> 

That's what the next para is alluding to...

> > In reality, only a few architectures require natural alignment on all sizes
> > of memory access. However, we must consider ALL supported architectures; 
> > writing code that satisfies natural alignment requirements is the easiest way 
> > to achieve full portability.

How about this?

"In reality, only a few architectures require natural alignment for all 
sizes of memory access. That is, not all architectures need 64-bit values 
to be aligned on 8-byte boundaries and 32-bit values on 4-byte boundaries. 
However, when writing code intended to achieve full portability, we must 
consider all supported architectures."

> > @@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
> >  to pad structures so that accesses to fields are suitably aligned (assuming
> >  you do not cast the field to a type of different length).
> >  
> > -Similarly, you can also rely on the compiler to align variables and function
> > -parameters to a naturally aligned scheme, based on the size of the type of
> > -the variable.
> > -
> >  At this point, it should be clear that accessing a single byte (u8 or char)
> >  will never cause an unaligned access, because all memory addresses are evenly
> >  divisible by one.
> 
> 

