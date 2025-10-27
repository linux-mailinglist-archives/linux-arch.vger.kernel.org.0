Return-Path: <linux-arch+bounces-14353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA3C0CBC7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 927354E0FEA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB711A2547;
	Mon, 27 Oct 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eeY3yaie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUUfqptB"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D921C84B9;
	Mon, 27 Oct 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558268; cv=none; b=oGPruv2HR7CnliyEwy22N8/muI0ylzPeYVcYLiJjf+ftOVZ/o6srCvrp/h7i7vWsliIZJ6+KujXxLdm6B2SbrRsuiwe2Ygy1rzdTACNKUXYG9rYEBPBIgGGCelnBEA6gyppDMo4ht+HKXB5kC3QC31rwHvftxYOXo2GQ8KkWNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558268; c=relaxed/simple;
	bh=9XTOvCuUtrVVOvQE5iew+LTvoban5zu0e+4ac+NEIps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fvrq/Wtv/3zv08bz0iH0+8NPLHkQecDmfEd5KvUAUpss8Vvs2dfH2FpqFBJ3XxVdAKgtDa0YnBDSLE6Cw8wC2wEpHaGW2hkU61Bvb6YXUVzw+lqidfqhqwr6Donw58YVWOBF5waTG35hJWiZe4AkirTKDpMlIzUL0jI6fpr8nbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eeY3yaie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUUfqptB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BF3481D0016B;
	Mon, 27 Oct 2025 05:44:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 05:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761558265;
	 x=1761644665; bh=KJvSA8YZX3AlZqgSb2OmKRc9R00iJ2ZMmXzo0lfwC+4=; b=
	eeY3yaieiEBumzryH7jLM/ghYrAibipO8peOhqtb8bfFMaTxJtEWmMtKNYAgCGm2
	94kVW8q94feZ4UDf9dy2WZwRKsAN5exIaoEWP3Q84MA1Olo5olZRBom/k8mW2DWQ
	kAp+KDnTvMnHNg3WVgqZQzITlfTu3Nmb2kUzC13QO6lpPMTMxSANzuMt1DHXyIAg
	ixPpMcQwQdZMXhy+UNbO5b7wM1g9XuDpaOOTJzefns8EWvSODVNkXdvs6M4E3dqm
	76l/gjzvk1CpdEM81uxcGYGm3zC0kXnt/ceOrFWv+8kwyVDZ3U9A3S7EHyIJAtLb
	UP23hcaCoQGFWUhrbiB9Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761558265; x=
	1761644665; bh=KJvSA8YZX3AlZqgSb2OmKRc9R00iJ2ZMmXzo0lfwC+4=; b=U
	UUfqptBz0CLlDAFrqFj4ffpuCDyU31b+r5lFDAIu6dzge23rw/riviHX/GPRYG4q
	LqOXGm8I7NfwzfG8k+FMnAJewolkRJA4H8mu+oONFbBCpvjx2wUcreKYlLhU2jFi
	XLeBppEmE6BwP5ED60rxwDh1HhWh953IA/L5NLc7Kii7bJLx5SJe1sF6ri5m1YrT
	Rv7T4tTWCT8tOy1uG2V1gDqXQfq7UgDozCD9WpJKvrDdCXTQApu6jM5zuejt9ux1
	0iSm1x4PE20xOnsaGbyc3pb+Z8bAveaRLzQ262amqBKRxbJXw4vIocrprykEKSaa
	oNzg18SFj0+/+s+w83GCw==
X-ME-Sender: <xms:-D7_aEovHD20lFstMNr2Zox0hzxEgh6Vw7Ha3expxITBZZnDYyCyIg>
    <xme:-D7_aFdyQ_eTlvlZG8CW8XCqFpsS4SH0sdJ9k8-TNGSFTGlJBeEzTObEjAPRD3a94
    -h-LdJuN28jqItIaKp8c5SpXjGarmfV_Ue-wrZSzZyceV_nsb5Wt50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegtrghtrghlih
    hnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepjhgrmhgvshdrmhhorhhs
    vgesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtg
    homhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhn
    rdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvih
    drtghomhdprhgtphhtthhopehlihhnuhigrghrmheshhhurgifvghirdgtohhmpdhrtghp
    thhtohepfigrnhhghihushhhrghnuddvsehhuhgrfigvihdrtghomhdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:-D7_aPQWpquGASXx6NTT05lR8G-iE52Vn8_1U2O848xtp-a7S6oyXQ>
    <xmx:-D7_aA7eTn11ifHMPUzl2oRGx8mgDp1q3eptoFPLfK4p9oAKgAnOQg>
    <xmx:-D7_aCp-0wlpKruYkQ9qZyZnzM6GI5JPml2lrT9Lc-flz_TGog4EHA>
    <xmx:-D7_aDSzE4Gtck2H-PagpOPmRP6nF8DgsBVQKcs6YP1M9hM-qhoHqQ>
    <xmx:-T7_aMVJ9PF8LVIjl1uGufn8MO16JMBrWkhK842OCrMPk4Yb_-H7sE0X>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E81B700054; Mon, 27 Oct 2025 05:44:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1uCXwKauNWg
Date: Mon, 27 Oct 2025 10:44:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Conor Dooley" <conor@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
 "Dan Williams" <dan.j.williams@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "James Morse" <james.morse@arm.com>, "Will Deacon" <will@kernel.org>,
 "Davidlohr Bueso" <dave@stgolabs.net>, linuxarm@huawei.com,
 "Yushan Wang" <wangyushan12@huawei.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "Andy Lutomirski" <luto@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Drew Fustini" <fustini@kernel.org>
Message-Id: <fe57097b-1817-4428-9940-477c3f36cafb@app.fastmail.com>
In-Reply-To: <20251023174026.00005b42@huawei.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
 <20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
 <20251022-harsh-juggling-2d4778b0649e@spud>
 <20251023174026.00005b42@huawei.com>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 23, 2025, at 18:40, Jonathan Cameron wrote:
> On Wed, 22 Oct 2025 21:47:21 +0100 Conor Dooley <conor@kernel.org> wrote:

> On CXL discord, some reasonable doubts were expressed about justifying
> this to Linus via CXL. Which is fair given tiny overlap from a 'where
> the code is' point of view and also it seems I went too far in trying to
> avoid people interpreting this as affecting x86 systems (see earlier
> versions for how my badly scoped cover letter distracted from what this
> was doing) and focus in on what was specifically being enabled rather
> than the generic bit. Hence it mentions arm64 only right now and right
> at the top of the cover letter.
>
> Given it's not Arm architecture (hence just one Kconfig line in Arm
> specific code) I guess alternative is back to drivers/cache and Conor which
> I see goes via SoC (so +CC SoC tree maintainers).

I tried to understand the driver from the cover letter and the
implementation, but I think I still have some fundamental questions
about which parts of the system require this for coherency with
one another.

drivers/cache/* is about keeping coherency between DMA masters
that lack support for snooping the CPU caches on low-end SoCs.
Does the new code fit into the same category?
Or is this about flushing cacheable mappings on CXL devices
that are mapped as MMIO into the CPU physical address space,
which sounds like it would be out of scope for drivers/cache?

If it's the first of those two scenarios, we may want to
generalize the existing riscv_nonstd_cache_ops structure into
something that can be used across architectures.

     Arnd

