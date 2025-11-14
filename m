Return-Path: <linux-arch+bounces-14752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58504C5D852
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 692123551A4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7331E0F2;
	Fri, 14 Nov 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Idm42L6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPDvuIss"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35511320CA9;
	Fri, 14 Nov 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129295; cv=none; b=RNLRyQWRl6Hhm4zRWHLnlWuJYRt+pz0OlA/UWkz0biolWcT5TyxKbvactasbJmTrQ+GI8J9o5Y98Z8n1oHC61uOIEHUR3iXndiuPjGxQaUrJq7l8JJh+DHQx9Rr7UPBVilU4P8sptcNbW7AQG2ZXMCJKerCF+UyzAKiFKTrPh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129295; c=relaxed/simple;
	bh=8kU6eT3O2cNbOiOHSzbrgdkAcwuBLHmLaJc8wrGadhU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D2gDL6X/03F1wB7gpHgNPwEeco5/KaLnCCDArasEQDMGqSk46WzChrtAxSMV0YXdvYceE1mCSCm0GKymZPoB1qbH/enfeTFtuYHRJN0KF8tn64b7OBOnvdX6ptMc2R2zCNfNdAYsz5oBasLNI5PG60bnq0Fvva3v6wKhUYXKUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Idm42L6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPDvuIss; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D53881D00175;
	Fri, 14 Nov 2025 09:08:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 09:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763129285;
	 x=1763215685; bh=iodSp6JgC3IsDPGboSdprZdWRAfsZYqpQHiFNrkabpA=; b=
	Idm42L6lYT6qztn2DtWHjkIF/PsI6EYRzGLlKuwcLpOzsctduJomAZ2WGn055T/1
	/SzsJLRUZqTSGxz3AIWIDegt0vZfOwXt1up0lsqba/gPgtU4ZU6xCA6Y3pZ3WHcl
	XqK7r2dwYRwGjbMA+cDcV3O7WFRH3RWGKtGlc7mk/eFGY7Da6XL/hfXrQj0g0CmO
	yoFNab3hsOfRR5tlin/6GV70VNRVglQcYOUCZk4TxoW/GCU1C22qs5IaFxyh/jOW
	Gue2IWbgAKaOpf6XfVFDX3iVyGVJ3xuVsx76rrNPHEclXkQGxXQXA9M+My5HZ5UN
	sq9yaez5MbcGHlZJk6X9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763129285; x=
	1763215685; bh=iodSp6JgC3IsDPGboSdprZdWRAfsZYqpQHiFNrkabpA=; b=q
	PDvuIssQOkZeLinqlA3HJdt/sFObO8+fWmRCmCMskaEiYETXnOBSLeLXGSu5tO5f
	n1+7AJ178gg0AoilpC2tBiicRUJBV+SWpXNXRMAF7aM3pLfgsR7rXFBhzawxI1Gh
	5R18DesXDO2OBF7kv+aLNWe4S2+3qXQMpqE17p1wW+2rQeER9jfEtbQ82z38gR+J
	PVz8AF+y1wSyRGt5TuqaPjeAt7kcZVZ6HVv9z67piTuvmkzNLfpzKPHuQ6xPPmtA
	KTEPDjDabxEu6sjZJ0YYOWigrlhzi+cqs5mkhNkUFW0SMUTxv4q3jp8xPtbFCeHu
	iJPGVWTdO1qbt1BUJTpkA==
X-ME-Sender: <xms:wzcXab0s0WwU5rJo0rZsFhRB0fTB84Ee1xdHpc22sHoDCENdmbv5dw>
    <xme:wzcXaU6uDENGsRfBbu6y2FWLFMleZy1YrGh0TBcq4U6LNUG14pUKW5_O8LKXdPP9t
    Zl1cZPME73tbL72YxWsXIk7zyX9PKn_cH8iImNOdQdy1MZHyfaJ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivg
    hnkedruggvpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtgho
    mhdprhgtphhtthhopehjrghmvghsrdhmohhrshgvsegrrhhmrdgtohhmpdhrtghpthhtoh
    epmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghlvgigrghn
    ughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjohhnrg
    hthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhu
    gigrrhhmsehhuhgrfigvihdrtghomhdprhgtphhtthhopeifrghnghihuhhshhgrnhduvd
    eshhhurgifvghirdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggu
    rdhorhhg
X-ME-Proxy: <xmx:wzcXaQfmOOPDp3_2pYo_j-dohnvtWxYq-lt_eldXmIJ0yLoHFXKALg>
    <xmx:wzcXaSUbYGz5OmI9ShPfgQRnHeC2mwd0fdpnABHsmt7W-E8Ic2pG7Q>
    <xmx:wzcXafUqQZRr4xMM7F5YFQWtlYo127YsUjVHq6tKXkowDY2PCK3tAw>
    <xmx:wzcXaaOnKFCxCQjGr4HLVXHo_NdGaKCCsNau9jefMD9SDcMY3r582A>
    <xmx:xTcXaaCY2J7kIm-Cn0_IaZAJeXcRkDXR1VaOugR2aGvhF6NU2l8fo2cA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9761C700054; Fri, 14 Nov 2025 09:08:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWJreI-smgpg
Date: Fri, 14 Nov 2025 15:07:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Conor Dooley" <conor@kernel.org>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
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
Message-Id: <02244119-d6b8-4ef4-833f-b8fba7a73f43@app.fastmail.com>
In-Reply-To: <20251114-juror-stiffness-046b47b8d9f7@spud>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
 <20251108-spearmint-contend-aa3dd8a0220e@spud>
 <20251114124958.00006a85@huawei.com>
 <20251114-juror-stiffness-046b47b8d9f7@spud>
Subject: Re: [PATCH v5 0/6]  Cache coherency management subsystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 14, 2025, at 13:52, Conor Dooley wrote:
> On Fri, Nov 14, 2025 at 12:49:58PM +0000, Jonathan Cameron wrote:
>> On Sat, 8 Nov 2025 20:02:52 +0000 Conor Dooley <conor@kernel.org> wrote:
>> > 
>> > On Fri, Oct 31, 2025 at 11:17:03AM +0000, Jonathan Cameron wrote:
>> > > Support system level interfaces for cache maintenance as found on some
>> > > ARM64 systems. It is expected that systems using other CPU architectures
>> > > (such as RiscV) that support CXL memory and allow for native OS flows
>> > > will also use this. This is needed for correct functionality during
>> > > various forms of memory hotplug (e.g. CXL). Typical hardware has MMIO
>> > > interface found via ACPI DSDT. A system will often contain multiple
>> > > hardware instances.
>> > > 
>> > > Includes parameter changes to cpu_cache_invalidate_memregion() but no
>> > > functional changes for architectures that already support this call.
>> > > 
>> > > How to merge?
>> > > - Current suggestion would be via Conor's drivers/cache tree which routes
>> > >   through the SoC tree.  
>> > 
>> > I was gonna put this in linux-next, but I'm not really sure that Arnd
>> > was satisfied with the discussion on the previous version about
>> > suitability of the directory: https://lore.kernel.org/all/20251028114348.000006ed@huawei.com/
>> > 
>> > Arnd, did that response satisfy you, or nah?
>> 
>> Seems Arnd is busy.  Conor, if you are happy doing so, maybe push it to a tree
>> linux-next picks up, but hold off on the pull request until Arnd has had a chance
>> to reply?
>
> Yeah, I did step one of that last night and will put it in linux-next
> from Monday. Ultimately the PR goes to Arnd, so he can judge it there
> anyway.

Sorry about the delay on my side. I've read up on it again and understand
better where we are with this now.

I think the implementation is fine, and placing it in drivers/cache/
is also ok, given that we don't have a better place for it.

However, this does feel sufficiently different from the three existing
drivers in drivers/cache that I think we should have separate
submenus in Kconfig and describe them differently:

- the arch/riscv drivers are specifically for managing coherency
  between the CPU and any device driver using the linux/dma-mapping.h
  interfaces to manage coherency using CPU specific interfaces.

- the new driver does not interface with linux/dma-mapping.h
  or a CPU specific register set, and as I understand that would
  make no sense here. The only similarities are that it manages
  coherency between multiple entities that access the same memory
  and have private caches for that.

If we can come up with better names for the two things, I'd
like them to have distinct submenus. Something like the draft
below for the existing drivers would work, in addition to
a new menu that only contains the one driver for now. I've
moved the 'depends on RISCV' into the 'menu' here, since that
is the only thing using it today (32-bit arm has the same thing
in arch/arm/mm/cache-*.S with a different interface, most others
only have an architected interface).

    Arnd

---
diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index db51386c663a..8a49086eb8af 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Cache Drivers"
+menu "Cache management for noncoherent DMA"
+       depends on RISCV
+       help
+         These drivers implement support for noncoherent DMA master devices
+         on platforms that lack the standard CPU interfaces for this.
 
 config AX45MP_L2_CACHE
        bool "Andes Technology AX45MP L2 Cache controller"
-       depends on RISCV
        select RISCV_NONSTANDARD_CACHE_OPS
        help
          Support for the L2 cache controller on Andes Technology AX45MP platforms.
@@ -16,7 +19,6 @@ config SIFIVE_CCACHE
 
 config STARFIVE_STARLINK_CACHE
        bool "StarFive StarLink Cache controller"
-       depends on RISCV
        depends on ARCH_STARFIVE
        depends on 64BIT
        select RISCV_DMA_NONCOHERENT

