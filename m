Return-Path: <linux-arch+bounces-14788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC37C5E8C3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE1CF3C85C5
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414F3314A4;
	Fri, 14 Nov 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iUuUK+Iq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EPmgzzJc"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB533122A;
	Fri, 14 Nov 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136248; cv=none; b=X+rrXKVF0tKXwMqLkv9KfziVDKqkR9/N+uRe2KYR9PTyeFSy0Qvs4WtHF1TINjvTZNDUaqG+pZDoguzLAwcCbvgjv6htyEtqbF65E5VOom51YjnmDKVzEScLKjlcPiA4K7fqFcTtUqwlsiwbiH2PEtxgkRqoTMYYo6ZpA94Q59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136248; c=relaxed/simple;
	bh=P9cGJ7zPlBYZv8kQOzQWIlRFIUZrgMvyo5+1wG6uoUM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p47+B5qH8JjXaB/cpkfCWpQAzOyRbPJ5G6WgcJYvLUDA0Aa5oO7jAXIgpOAp38+XASH2qXwKqgQEBn/OmC5UlHfSQy5rrxceuJTSzzYgYdQgc9IinGNy212s/OhdUl2Axy6AGJYJ3SY+r95ShyJUwlDpWbGzLV2iHDknR+zCmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iUuUK+Iq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EPmgzzJc; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E2337A01AE;
	Fri, 14 Nov 2025 11:04:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 11:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763136242;
	 x=1763222642; bh=M9f+1V/Gs5C5ClKhbfgT9um9exOzG9W9HnZ9J5MzYFY=; b=
	iUuUK+IqWqJXW16WpkpxRxPRAtrf6jqtV7WJneZ3XbpcXufA5YS7BhLcfFN3iKGY
	wVjrBvMkUBSaeOk9SVPhEh1CmfMmrDpdE2ogQ3sHiuidBHmYT82ymxj8Pm/g/Pea
	gJeWNvSxej3ucg9i89MEvdGDo5tFuWpSKmkzX5kBAKAalJPch9aE780StTAW5NFx
	Cmlbpi50BB2XPnhFURxMaI1Hg2WDObVPkE0uxWY/hKvxsjiJgtzpzTzyhgMibwPi
	JOP5y0ENCFAaaMokteMOyLWKENySsm/55Y1q8nVGAJkalDFY1CiipLPwPWHNRXzz
	Pf7LCQRkIHYGJB9bmpGdYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763136242; x=
	1763222642; bh=M9f+1V/Gs5C5ClKhbfgT9um9exOzG9W9HnZ9J5MzYFY=; b=E
	PmgzzJcrt+h0JC8NtWhi4UJRX9JSEuwVpcW9P6a4pCvY0SdhcCGIMF6xyQFbrC0G
	BOtT89f8YPJKbFNjWyvAXNY+1I/nW62tdg3sfFoEUhthpdYnbptmds2a0TaCpQFp
	96IC/ikXcG4TaiQ9TitSuG0vIJmE3/sD82Beh1LV023voCOJPXGvFUIlw0fEV5n/
	9sX7vQuB8+9cFSdG91otRe3+89cpyfjFrlWd+3azBdxXeGXipIhkFf5y623elKZL
	hWa3BFMOxipEnFpGZOXyFgIdtR1niCl/7Mi+dLC7+VqVKhoMN8Kov+EHxRGA2qDW
	BSNisJaMiHTUZPS/8y9GQ==
X-ME-Sender: <xms:8VIXaSQUTbGlNqoBm96asAebHCJLTwjAMNlPXbzGLJF4vrZcYX7zhw>
    <xme:8VIXaSm_qGICw4h1CKRHnPHP4ec_0wMH3rj0ydB-3a3qqTvG1luEEXgi3ZUCQIKN6
    6FvXdlGJZEkYEGxiV3PNVZSbxyKCOQFWYGELxzfm0ejHp0QQWCE_aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8VIXaaCQi_bM4GIEQ_jBunmYtmzlrZxFP7n5lAYiWyfa-4msWaS0iQ>
    <xmx:8VIXaVSysmvIwseAM0TznwvZ94MPNSpd_nqP7aY25ncwx8evwSv4_w>
    <xmx:8VIXaRalsjiiTdT-vQi9kNTQC_wzVzBavsjweVEQDrXnjhGzfpXXpg>
    <xmx:8VIXaaW8w0IjPS9W8wroo2kONi-pnHfHvtBzWdvJYt9D-V7aoy1gzQ>
    <xmx:8lIXaaNw9x_t5t-hIL3XLxZP43HBdfy0h65TDU0tI1Usk61Z7PgFp97w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 41EC1700065; Fri, 14 Nov 2025 11:04:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWJreI-smgpg
Date: Fri, 14 Nov 2025 17:03:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: "Conor Dooley" <conor@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
 "Dan Williams" <dan.j.williams@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Drew Fustini" <fustini@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "James Morse" <james.morse@arm.com>, "Will Deacon" <will@kernel.org>,
 "Davidlohr Bueso" <dave@stgolabs.net>, linuxarm@huawei.com,
 "Yushan Wang" <wangyushan12@huawei.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "Andy Lutomirski" <luto@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>
Message-Id: <93c1c6be-dae5-477e-8924-1b77f8567732@app.fastmail.com>
In-Reply-To: <20251114155746.00003719@huawei.com>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
 <20251108-spearmint-contend-aa3dd8a0220e@spud>
 <20251114124958.00006a85@huawei.com>
 <20251114-juror-stiffness-046b47b8d9f7@spud>
 <02244119-d6b8-4ef4-833f-b8fba7a73f43@app.fastmail.com>
 <20251114155746.00003719@huawei.com>
Subject: Re: [PATCH v5 0/6]  Cache coherency management subsystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 14, 2025, at 16:57, Jonathan Cameron wrote:
> On Fri, 14 Nov 2025 15:07:33 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
> Hi Arnd,
>
> Thanks for taking another look.
>
> Agreed splitting the menus reduces chance of confusion, so makes
> sense to me as well.
>
> Implementation wise I think we have to use menuconfig + bool if we want
> to have help and dependencies and then an if block under that.
> The syntax for Kconfig always leaves me finding an example to copy
> rather than finding it intuitive
>
> menuconfig CACHEMAINT_FOR_DMA
> 	bool "Cache management for noncoherent DMA"
> 	depends on RISCV
> 	help
> 	  These drivers implement support for noncoherent DMA master devices
> 	  on platforms that lack the standard CPU interfaces for this.
>
> if CACHEMAINT_FOR_DMA
> ... drivers here...
>
> endif #CACHEMAINT_FOR_DMA
>
> menuconfig CACHEMAINT_FOR_HOTPLUG
> 	bool "Cache management for hotplug like operations"
> 	depends on GENERIC_CPU_CACHE_MAINTENANCE
> 	help
> 	   These drivers implement support for cache management flows
> 	   as required for action such as memory hotplug on platforms
> 	   where this is done by platform specific interfaces.
>
> if CACHEMAINT_FOR_HOTPLUG
> ... drivers here
>
> endif #CACHEMAINT_FOR_HOTPLUG

Works for me.

> I'm not sure if the 'hotplug like' is close enough to all the cases
> for device drivers that provide the services needed to implement
> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMEGION

The _FOR_HOTPLUG does feel a little more specific than it should be,
but I haven't come up with a better name for it yet. We'll
probably figure that out if we ever get a second driver here.

> Alternative might be to phrase around pushing beyond the point of
> coherence, but that seems to be an ARM specific term and would
> seem to incorporate fine grained sharing where this interface might
> work but isn't a good solution.

Agreed.

     Arnd

