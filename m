Return-Path: <linux-arch+bounces-15792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBDD1C4CF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 04:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 446F030127A1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903F2820A4;
	Wed, 14 Jan 2026 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPANe2H2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FA26A1AF;
	Wed, 14 Jan 2026 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362814; cv=none; b=duAsqK2MG/uzAi4zxVnaTACaTySCiy2CwTtPGW7XSyorF28OtccbLkfy7WXjPSJi774rNfF4RHJE2DSkO36IFXtAoAL8j6tx+o2lIpcd0bwJM3VN97lKGoeHk3q6Q0UIaY5IVkkTDkhGa3VfK12vM0Ijbv3cGLOgpV1lq4CYgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362814; c=relaxed/simple;
	bh=9jD2pa3Qh39LK1t4RNq2hkmi2e+bz3R2BHx5k9AOX0g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hz3D4veKV0BRNMbPqOLGtwbg7Z5p38n970As14yLd1QmQqi/g8bdJLmV86u3mFnILw9aD9kZWxr6G8A+U3/aQKWq3HzqWAwDUCFv9OOdbUDtbNHZ1NEkmwwSQ533Y4EBttbIW9rLiSxqPCIbKfQal0gfd+Oiv9/RLfsz4h99WhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPANe2H2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E6DF14000F0;
	Tue, 13 Jan 2026 22:53:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 22:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768362811; x=1768449211; bh=WUuCtgpOxCcYcFkLRGRB2D9hCZ191Vk5U91
	W6ymTiYM=; b=XPANe2H2nH7xYfHyfbsy/jUewlF8tDCh/ofS4fjlqKyYD4a2YU8
	Fo9ncNWIhn13iuPFg9sZTM7OY+CLiJip4O7Z0smNJePa+akxtrmQIJQDKHmlnT/c
	mz9s6yS/pJyDQJFCf4cqlF+YXgOKS8VPDFO7zmQVhUg3xOKEVeiBNuzFOWHI+p/Z
	wbUmbsyriMfa/xOr1bNCKLoO3xQOT2hcmOYz2KSMws84fkp21vCT9o87cqIOV3k6
	e2egyQ1b96vmJj2Y6w6Jr+cLceuwlFJDUPCkwvqggU94PC10FqzJCXXDp1LnSMlf
	uWNhQpWCpOP2GwaDHXRjP/3gc3Z7bVRrweA==
X-ME-Sender: <xms:ORNnaeWAlIggKqWmpCNfMfmY9OJARBZytjLwVE7SNJUQ11r1p-kV1w>
    <xme:ORNnaTU7TZnQa_53Fapxve27LR3nb8L-W-aVwMbe3f8LJhp-KWp2JT6bgKe6XG0W4
    f0FTYXY0PwWlx6sHyjBRNHM-YK7SYzLXKNh46IlBcQcm9j2UVES-A>
X-ME-Received: <xmr:ORNnaRHzjn6rfenBgsjgEBdPyhWw06eFEMcCNsd0JeDzyjg5pDoiYKewUQtJxq4ld0U9YzOXk578QEZ1RJI68EQ1U-w8n7NmreI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrd
    horhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggs
    rdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhu
    thhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ORNnaXtbBYWuWia3PqsQ-hhq2cmyP2nbK3OgmR4PDz4yRi5JafQ8CA>
    <xmx:ORNnacY0kw7o5nTug3bFSue5e1kRlLwwnRbFsBOa0-b38WQNx04c4w>
    <xmx:ORNnafUSltTMbg7s-_TpGmrdOMDrIKX7snT_5mCy2yEZfvePEJhL2A>
    <xmx:ORNnaeI5cF5E2B2HPI8fdW8xVUVqf2WD0XlwZWz-LMSaaU7rxx1k4w>
    <xmx:OxNnafei8b7GrwLvTpfejO8nhiDSZoN2NlpwwTEqgbZhB1QA1Pg3oVJ6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 22:53:26 -0500 (EST)
Date: Wed, 14 Jan 2026 14:53:33 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, 
    Gary Guo <gary@garyguo.net>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, Sasha Levin <sashal@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/4] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <CAMuHMdXSXcxzhgfFyc3sBdyoJ4vq9sMpzLBLcZskqtZXdAjH+g@mail.gmail.com>
Message-ID: <740c3d41-42d8-efa8-3ff0-a2f9cc7a2c49@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org> <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org> <CAMuHMdXSXcxzhgfFyc3sBdyoJ4vq9sMpzLBLcZskqtZXdAjH+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 13 Jan 2026, Geert Uytterhoeven wrote:

> >
> > ---
> > Checkpatch.pl says...
> > ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'
> 
> Alternatively, you can credit Peter using
> 
>     Suggested-by: Peter Zijlstra <peterz@infradead.org>
> 
> just before the Link-header pointing to his suggestion.
> 

I'll leave that up to Peter as he's both author and maintainer.

If there was to be another revision, perhaps I can add --

    Suggested-by-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

;-)

