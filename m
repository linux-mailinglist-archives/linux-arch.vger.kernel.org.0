Return-Path: <linux-arch+bounces-13820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FDBAF465
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9940B7A5927
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89426F2B2;
	Wed,  1 Oct 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="f3OOVoaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSOr+vjf"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C50FC0A;
	Wed,  1 Oct 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301089; cv=none; b=NxBDc4nAx/h1odXUKlwuTTdt9mn8tF20xxFeDGzi6qm0HVZTtBkR7BZWCFIdIxr3bHguDfiUMllv6/qENWZ2EV1r7VmSBEDuWBJWF1fHA7FRy0dqy2X6H90q8MO/LclLhn60fGjOo1vpwGK8kKTlltn0sDtJfAAOrYbv3tqBIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301089; c=relaxed/simple;
	bh=Z8BCe4iaNeWsBEaGqmtX0eVcmR+lCvjMbO5uvQdSXPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XHbHP9uN1HwUWz+vmydx6VDiBhmt2ogY79+NkvQdc6ZFFOngF2+7wL86GDYPYZMXqpjARt2JMQp1HFhZSaGGYWS80oV2tam01/PDiP/geUEII9cbLkJUnD4M6HV02Zb61dki95SgmJ2NBaJZSveqZJLb81yftDVIwj+XKCaXpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=f3OOVoaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSOr+vjf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D0191EC016F;
	Wed,  1 Oct 2025 02:44:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 02:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759301085;
	 x=1759387485; bh=h2PY/hlOQdw6rIXoyxgJocjwCk9M0fTS2q6ugQ8vStE=; b=
	f3OOVoaWj9LdGVQ6RtQMMoNU6teZtU4LDc/GtQ7Fb6I125mIMqkiXqVW3OXR4kaZ
	w3II2aqG+UeH5P56lmx/k9OQhYgK6ELBFLWyJyK2x/zmkYmMML2iZi+z9917oQaw
	XLeyW8+yW/kiEjQQ9aujQPSwnKmMFIvibVZcGZNd1fRtUIMxGQE6SqVCCu64P1NA
	1H98hMJ/sFG6UfNRiHXTBK4bnMMLQXgWfEiMOsdo2+Kxuxh3N+Ymecq39RUCshfi
	A64q76vXFJBNMJSriI7JRzXK6LsqJ7cUPeEozmD0ACf1yf2j7iOUtnhikyUJl7sM
	cb33CETpIwQrcCtoS+dIew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759301085; x=
	1759387485; bh=h2PY/hlOQdw6rIXoyxgJocjwCk9M0fTS2q6ugQ8vStE=; b=x
	SOr+vjf5o49Cs3kdLa0KFfmES0CN5oX6gDHNUgTadphBVZ7SZg3yr3on32YOsK1K
	a07Vpxb4f48DM4+GNlt6vyBrjRq1sSZ4Nyw/avfqUXgATomU1Y94C0F0u3EKTMLe
	N0ODhY2zFD6PXp68+DIe7HEkJXKFxha0jl4GF3cZ2lI2pqkw+VzB31C0scRpdyix
	RV3EKsPWsKyGrzlO4EI2n/wymIfI/uKAOL8W50/IaDXpJqtAZUUSMHLzlnMz1XVx
	M9t0Nk/1ph8LO8GMeLrmmfr+uLwJeVbmY1a0N+lLZY01z07z78JfqGsqpIJDUDKz
	KMCTzOrmGuDS6Qdt6tL1g==
X-ME-Sender: <xms:3M3caIpfzTxAblV-d58n9nFgXChpTwPYDuc5ruVmk4IChRCROrueuw>
    <xme:3M3caJd9DgLkriGdU-eNZfSGTLdHYR8aqktZaaVP6LCr4esldYgJTuMvPECpukm9m
    kBbPzsdOfgaEUN3EPeY5DRFdcFpwzZn0Cw3tjEjdzpMXx-GlgAlG9LE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvfffgfefhgfdtiedvieetfefgkefhieegvdejfffgheeiuedttdetkeffhefgvden
    ucffohhmrghinhepghhouggsohhlthdrohhrghdpghhnuhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepsghoqhhunhdr
    fhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehgvggvrhht
    sehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggvrdihrghngheslh
    hinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:3M3caElhms60U0Ao69Bt2Dm8K8zQopNSyPlZUHP9GUO8mDllOWRU0A>
    <xmx:3M3caKOA2frNA-FJj-6AiEo_14JZOv2ZvaIA9IqpKELmkVy5UIfHFA>
    <xmx:3M3caO5YYqXqLB6gfDJ3VfI8XeVxd641akUYUTN7CWqrh3nRyzV0WA>
    <xmx:3M3caOZQm4vC6bvNDg3DgNEbm3t89yjJXYVotEwUTDya-dr21BQj3Q>
    <xmx:3c3caIT5lJMN91gr0HIkVMw4aQxhh0ZeYklDiDJMGJYj4a4ld3S2SOMJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99C12700069; Wed,  1 Oct 2025 02:44:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Wed, 01 Oct 2025 08:44:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <7de25cf0-595e-4b8e-b0da-6e5a66ec1358@app.fastmail.com>
In-Reply-To: <60325e45-e4a7-d0cf-ba28-a1a811f9a890@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
 <60325e45-e4a7-d0cf-ba28-a1a811f9a890@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 1, 2025, at 03:03, Finn Thain wrote:
> On Tue, 30 Sep 2025, Arnd Bergmann wrote:

>> What is the alignment of stack variables on m68k? E.g. if you have a 
>> function with two local variables, would that still be able to trigger 
>> the check?
>> 
>> int f(atomic64_t *a)
>> {
>>      u16 pad;
>>      u64 old;
>>      
>>      g(&pad);
>>      atomic64_try_cmpxchg(a, &old, 0);
>> }
>> 
>
> I assume so:
>
> int foo(void) {
>     short s;
>     long long ll;
>     return alignof(ll);
> }
>
> # Compilation provided by Compiler Explorer at https://godbolt.org/
> foo():
>         link.w %fp,#0
>         moveq #2,%d0
>         unlk %fp
>         rts

This just returns the guaranteed alignment of the 'long long'
type based on -malign-int/-mno-align-int. Checking again I
find that gcc's m68k-linux target aligns stack allocations
to 4 bytes, though the m68k-unknown target apparently keeps
the 2 byte alignment:

https://gcc.gnu.org/legacy-ml/gcc-patches/2007-09/msg01572.html

https://godbolt.org/z/48fGMj56W

Surprisingly the godbolt.org link also shows a significant
overhead when building the same code with -malign-int
in the second tab. This is unrelated to the issue here,
but I wonder if that is something to report to the gcc
bug tracker if we ever get to building the kernel with
-malign-int. Similarly, I noticed that clang does not
support the -malign-int flag on m68k at all.

>> Since there is nothing telling the compiler that the 'old' argument to 
>> atomic*_try_cmpcxchg() needs to be naturally aligned, maybe that check 
>> should be changed to only test for the ABI-guaranteed alignment? I think 
>> that would still be needed on x86-32.
>>  
>
> I don't know why we would check the alignment of the 'old' quantity. It's 
> going to be loaded into a register before being used, right?

I was wondering about that as well, but checking for alignof(*old)
probably can't hurt. The only architectures that actually have
a custom arch_try_cmpxchg*() are s390 and x86 and those don't
care about alignmnent of 'old', but it's possible that another
architecture that can't handle unaligned load/store would add
an inline asm implementation in the future and break if an
alignment fixup happens in the middle of an ll/sc loop.

      Arnd

