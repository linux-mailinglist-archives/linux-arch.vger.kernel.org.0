Return-Path: <linux-arch+bounces-13665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56DB7C614
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649BA189CF97
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569C21255E;
	Wed, 17 Sep 2025 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0xCSGtA"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FE1C3BF7;
	Wed, 17 Sep 2025 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072221; cv=none; b=f4lcMs6xnmF4B0+dhO8dwGLhy1kcx85pZeB2SbLjddxZRKQ5L9TVR8HywzYdWwk+Z3NwtRGQSIvPGXIlYhG+1yZBttiFzA536+8qEqlnadScbinls0E1QR8vonqXwloR/q5A7GVzbPBP7Gdxud96zBTDx0Oa0X72yTRUtPm3svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072221; c=relaxed/simple;
	bh=elZaye91e8qISip9VYwoJU9m/6hwt6xIdF0JhijRWZ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P5UL8QuklNT3qldJjAiwIUYlN9F/hP6fbBGnY/ddaJuKdMRewI8wfwCAzgjQoHL6WpdE0B+lvZxsFDR7KHZ5yO8bBwTumOCIRBE1nE0omuEDgOfTNB/1Z+kHYXcXOmioIlJVayn8sjHsa86cDdkF66K9qW17u8VjlOUQ6+u5rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0xCSGtA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1493EEC0113;
	Tue, 16 Sep 2025 21:23:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 21:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758072217; x=1758158617; bh=TSGB97yLofg2uIZKqJjxzc8sDNuHpNJb8zb
	UQ4lmQ5U=; b=b0xCSGtAwgZ0fajqkMKZeE3PrjQOZjfAY+IzPJ1ha4wFoEHoljG
	GvFSelvBkNo/GjI80CLbdonHKsltdBKSFBL5v9pfL3ecsqKzbF8a376LEimeUuLi
	IPlA1bJLCMBQsPIHALHRZbem3AfU82PM8Zx0a72WKn/MgZr30aGn2/3mlPX1eRuT
	3abwjCEY7fijSA8JHPlJ/gycI0lH6R9fSrHTsZcaZK/vlzvWd9krLrbOwc1gTqp4
	BoMemN5l4Q8h3mxUsdXvID5xNSCuqVEXQy3exXxVJ7+jym9TxFOT6Q7bwhIeaBcI
	zz0PJkm3+/sz8QKa+ScwjY+OfYQDvIsITCg==
X-ME-Sender: <xms:mA3KaJx_xTY3hizY0Gm2NF4Q9a6qmXyVTyMw6fzbUyJ4uG9ZiQibGg>
    <xme:mA3KaPOefStpnHwmP99bFE_Wv6hse7PrINnaXo8KXRKEprPV_tskA29IM0y3OAc9o
    zCo0F8xagGJD37Cy9s>
X-ME-Received: <xmr:mA3KaAefvAhQsrxuoPhKbKVOt6sMn_6R8ZjVAIW3TX0fifNCZq3j9SsCEXOHxeFsRXyJZsapfTeBELXhMztx3w5REVe8wsVKya8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mA3KaMQKjnR1EadNaU8hG0R9igcsu0dr-L_lXf6zT8r28cUdRRBZGQ>
    <xmx:mA3KaGf5gDAeZwLWIjluOA3ZoipWUfyNlUW7NlVQutXK-ZEddNW9ew>
    <xmx:mA3KaNud3j0z_SgU_993CsC3WR_jdmoSh7Am4PszIe_hM1EAGKc7Eg>
    <xmx:mA3KaKLrRWfaWDnQ26O-IW6duITAHV3fRbMu5ogQNdMeio54wn57KQ>
    <xmx:mQ3KaMRaLqmmAniuowPBLiCD2ebEfL-KK7RD8giCN42kXMuy_y5OsDHB>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 21:23:33 -0400 (EDT)
Date: Wed, 17 Sep 2025 11:23:28 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, 
    Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
Message-ID: <aeb17f15-de44-e46e-cb3a-0edc1551d3e1@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net> <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net> <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com> <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
 <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 16 Sep 2025, Geert Uytterhoeven wrote:

> On Tue, 16 Sept 2025 at 02:16, Finn Thain <fthain@linux-m68k.org> wrote:
> > On Mon, 15 Sep 2025, Arnd Bergmann wrote:
> > >
> > > Has there been any progress on building m68k kernels with 
> > > -mint-align?
> >
> > Not that I know of.
> >
> > > IIRC there are only a small number of uapi structures that need 
> > > __packed annotations to maintain the existing syscall ABI.
> >
> > Packing uapi structures (and adopting -malign-int) sounds easier than 
> > the alternative, which might be to align certain internal kernel 
> > struct members, on a case-by-case basis, where doing so could be shown 
> > to improve performance on some architecture or other (while keeping 
> > -mno-align-int).
> 
> indeed.
> 

Well, it "sounds easier". But I doubt that it really is easier.

> > Well, it's easy to find all the structs that belong to the uapi, but 
> > it's not easy to find all the internal kernel structs that describe 
> > MMIO registers. For -malign-int, both kinds of structs are a problem.
> 
> For structures under arch/m68k/include/asm/, just create a single C file 
> that calculates sizeof() of each structure, and compare the generated 
> code with and without -malign-int.  Any differences should be 
> investigated, and attributed when needed.
> 
> For structures inside m68k-specific drivers, do something similar inside 
> those drivers ('git grep "struct\s*[a-zA-Z0-9_]*\s*{"' is your friend).
> 

There's something to be said for adding static_assert() checks for the 
structs that belong to all fixed interfaces. The patches to actually pack 
of struct members could take place after that.

All of which is a lot of work, compared to specifying alignment for those 
core kernel data structures where doing so improves performance. This 
approach is platform neutral; it's not just m68k that benefits.

