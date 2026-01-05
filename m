Return-Path: <linux-arch+bounces-15662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D2CF5A75
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 22:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70218300BFA6
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EE32FBDE6;
	Mon,  5 Jan 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqdezFN1"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E042E8E07;
	Mon,  5 Jan 2026 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648156; cv=none; b=sE68d05ECm3cQ/Nlv24UUgCE78Uj2HtX44XUwdDuktrjgS0FhYnkLKF1KHx2gV3rS1pzedyaWNZ67frg4EDm0HdaHlaHEj2CPrLeHp2ci3bUAYJudNcQjSX6FNEMT3TkQj0GaXUh7UDT5TDl1I+Hiqp64Xeg8RoI6qH4ksanGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648156; c=relaxed/simple;
	bh=+WNAaoI8KsgV5YS5TesK8IFdo3fX5U3jSg4GO6PtS4g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LEtmsDFb91rsn0DQyQkSUjNhdm4jfFbsDh2p1Cp5LufVLMh5vNrbYaTWGVb/GkN50pd0AriLKbQb6FQm8FArA1IfaROCPTaSHqmr3N83qq1xJ0Fze+vzpUrJfJuSIkILC9tGpyA1tMXL7b4d/c2xgvXSDO4K8yJX+O6a7Ff8MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqdezFN1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23A451400032;
	Mon,  5 Jan 2026 16:22:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 16:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767648153; x=1767734553; bh=1oFLbJyX5go2BlHEUxj/VKfPiVdmEHtKl5G
	WuW0kFIE=; b=eqdezFN16Fss6rS/wPHGPIsFq0pelGmfkt/ukW2GV67pAKlsyru
	fU2KrcYiGz9lRFKAYKn5E7XqMI9wp643WQ4/sgfRtAlY/UaO3QQeke1YpQLwCZ9T
	1YShV8vYjGNPt3tK+v/NzSYYYp90rTiBRIOR/RRM9/HZdEh0KY8dSkd1yYG234My
	Sc1Vmex2hqoY4Wpao7xV00oip1yTy37nb9jEgm/QaRNMsm9YUHb3kW/5RDw25X41
	pABCS0pndEllLrjZ26PPF1noRpSmE0aEjbB+isbQ8FgveMemnM80EULCv5Ld64Tz
	Y7lEO7VnGoNcizPAlgfFHyBCU4dsp9I27bg==
X-ME-Sender: <xms:lytcaT1ganGq_1JSY179V2JrXj4Kun5nYZmIaAZA8u-G3TZUSlZSCA>
    <xme:lytcaRUAtJ81jeIkCVaL3uMSCIHVhxTZg-4797Yi67IEtjKJKMYUsn4qiS7eWYO6Z
    dbnPqhK8JctnFOVhtMKub20jMuRANp7YTyAb9CzIhlKc3ldKCl5Kw>
X-ME-Received: <xmr:lytcaWvbcRsGUpixZ-pwbEgBqlFQOZours-U9JekKWZC-HFLHGejNS1SaCD7ocYlpjkQEDYHWgJ7GzBW7qwJ8csgAYbJYN1q8uY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdtkeevvdeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifihhllheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthho
    pegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:lytcaQVmEogYXAZyUme2qxEo9qtLhZJK5ZxlHf-zsytFygzFz0d0lw>
    <xmx:lytcaaU2Zg07o4EuVTGdVLoA1RUkpIJHaKrYGgA8uNLM4yHjVGlRLA>
    <xmx:lytcaSfRvNtCG4W0SDoXjfUDUUt_Hi4HOk9rSTB3mxtdTkimsowLeg>
    <xmx:lytcaZ7-Vd7YFQu9qqSMLogDhuVICe_imL02aTQRNVrspcHQaJcINQ>
    <xmx:mStcaXSSILeYg-9ytee6l1Uss8S0VUCpZEOdzT_YZyY9QYWhHYXUfzm8>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 16:22:28 -0500 (EST)
Date: Tue, 6 Jan 2026 08:22:26 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
    Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, 
    Gary Guo <gary@garyguo.net>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, Sasha Levin <sashal@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
    "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 3/4] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <20260105160634.GA2393663@noisy.programming.kicks-ass.net>
Message-ID: <07b62c4e-d3e7-dcc6-8752-0780faaeec24@linux-m68k.org>
References: <cover.1767169542.git.fthain@linux-m68k.org> <f8cfe0d121be0849f5175495e73eafeeb85e1ad3.1767169542.git.fthain@linux-m68k.org> <20260105160634.GA2393663@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 5 Jan 2026, Peter Zijlstra wrote:

> On Wed, Dec 31, 2025 at 07:25:42PM +1100, Finn Thain wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Add a Kconfig option for debug builds which logs a warning when an
> > instrumented atomic operation takes place that's misaligned.
> > Some platforms don't trap for this.
> > 
> > [fthain: added __DISABLE_BUG_TABLE macro.]
> > 
> > Cc: Sasha Levin <sashal@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> > Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> > Checkpatch.pl says...
> > ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'
> > ---
> > Changed since v5:
> >  - Add new __DISABLE_BUG_TABLE macro to prevent a build failure on those
> > architectures which use atomics in pre-boot code like the EFI stub loader:
> > 
> > x86_64-linux-gnu-ld: error: unplaced orphan section `__bug_table' from `arch/x86/boot/compressed/sev-handle-vc.o'
> 
> Urgh, so why not simply use __DISABLE_EXPORTS, that's typically (ab)used
> for these things?
> 

OK, I'll change it back to __DISABLE_EXPORTS.

> Also, unless __DISABLE_BUG_TABLE goes live inside asm/bug.h and kills
> all __bug_table emissions, its a misnomer.
> 

Yes, __DISABLE_BUG_TABLE is certainly a misnomer, since what it actually 
does is to elide code that would emit bug table entries. I would argue 
that this distinction is splitting hairs but it's moot.

> Furthermore, that SEV thing is broken and needs to be fixed anyway, this 
> isn't helping it much. noinstr code should not be using instrumented 
> things to begin with.
> 

The problem is not confined to x86. I needed something that would work for 
loongarch, arm, riscv etc.

Anyway, thanks for your review. I will make the necessary changes.

