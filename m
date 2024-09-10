Return-Path: <linux-arch+bounces-7182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B9973AF5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754082835C2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8B194A43;
	Tue, 10 Sep 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TKIeRcGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5weAyxr"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FA1DFD1;
	Tue, 10 Sep 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980746; cv=none; b=SiTDDNdr/ePNJT1ge3r2X/BiJulz3XQoIYzbkSh4G0LYaMth8pgNSqaBNQb6PJwN0pVjRjm5x19KO3kARN9zaXtybP9dch3F9v6JKe9RjGgpcxuI65H6vdffwPzjFwQu/WDWmoAvvt2NvXWLwvyoc5oeMZfLFWLbbqF0HCvJ2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980746; c=relaxed/simple;
	bh=u5Cx3s38HlH36208jUX1PLJ0rUPHgoDcLUZoB36Irzw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hewZ7Vk7Fsv7lyyIZJeyOlspyClbUN1vCl4vUa5rFOpVO+rk7FSQPimGbqJEq0d6BmGyTfdK8FdtmyxdvKYoj25Mwd0l3w7nFsChoMBmRmD9L1e4t64cNKJlObTM0p+P2S4GzqdKmLNsZvFLrJQgnR+V+4m3Y3iIE1bK2TmEOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TKIeRcGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5weAyxr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 67FE71380176;
	Tue, 10 Sep 2024 11:05:43 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 10 Sep 2024 11:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725980743;
	 x=1726067143; bh=aIIu0Ly+LTke4nYzPkOGL+CoGg+fBzxtuvII4tt0pFA=; b=
	TKIeRcGxxxA5he/dnRdZ2te+hc5hNuBtTezAW1wsDFstqgzrqRzBZ+j8mVs3rr4Z
	KDMluqtZS+TdvbDXROzWloJBDniq/hvCl8b4JGFF6Jw4njH/K6Ov4l1ZQN6BMB+y
	jW7zu0CgYHTOJjfzxnFSpEOVNhW3Bifbw25iMAl9MthAuK17yVIVMvQC2zApQ8Sq
	bbCnKFmbsngz/Q/QS5l1XLnltk39wGT2RiIRzO10P1EZMCa8hIG/vaxTK32OF32j
	94j0+qhdMSDJBzaPF7FT/9j4ZENHSbCpvEjp9bG2WrrnR5FhkCcOAdN0jkEzlwtJ
	PmFp4M7Z1xxdMyFDo+soeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725980743; x=
	1726067143; bh=aIIu0Ly+LTke4nYzPkOGL+CoGg+fBzxtuvII4tt0pFA=; b=f
	5weAyxrqHFDeYpd9yydOntLn30r5UxkIx2/59Ft+qU0+C238PZ71DabjaCBE5qQz
	o0IzAHP6ZNhQCo/MMkqSHN/IEa2UV29Rq7nvy8ua7wL1aOgHl6eBwn5JGiMxg/kt
	Mmi2IGQCyL4B2eUfLynL/THTvBNvQIckjsfEBq5rkMV0MMyovslD9K4kuuleG8tl
	lpF0BR+VsFRkhVZj43f4rA8t/R9/O41sfizdgVNOlWdDP6SCUc/nTrYaooCw2fev
	L3Y2/tlLJY42Ucqz1oSHV9MVXvDZxZQou5zOA0Nhmsbm5QXpm8zrSGwFZ2ZSt3c6
	vx0Z5ydNskyzQlc7ToRVA==
X-ME-Sender: <xms:RmDgZvVgOiKowplK7X_sPYsUaBZig3whQrJpkClHJhBVxvgvKkISlw>
    <xme:RmDgZnmCySWJaCelT3Q-io7Ux-jkovqHrVnX9fXF2lIHOD7CPPN75E5lrtvA3cm1-
    JMD-RtKRoTttIDVMVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RmDgZrab8U5ZwXL7qyP_GzT_jOt8QoSSPmG1_rwdLK2radYHzRmXKQ>
    <xmx:RmDgZqU8cFNJ3llOMJn8tRLJprDxL0pUd5rRUVBHchq_nEMfPrHCGA>
    <xmx:RmDgZpnUpZd327NuQRsIAeY1Efn6zOncw9XDf8c2qijRK1Qh5CWmEQ>
    <xmx:RmDgZneXj7rZMt0wxao8ZopqdKt1lt1uMzKwp-dCo6ImPmfGOJQ9bw>
    <xmx:R2DgZjpvRSsXSOuIu2S6Ks3R-YwPqFc1P0LyAAv352pmEV1Ay3TtJ02v>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 22561222006F; Tue, 10 Sep 2024 11:05:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 15:05:16 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <98dc5b85-fdf4-4664-8cca-e6c9e1f8eb14@app.fastmail.com>
In-Reply-To: <2234a5e1-5926-4b2d-a8f2-c780bf374a27@csgroup.eu>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
 <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
 <11527a80-7453-4624-b406-e88c5692b015@app.fastmail.com>
 <ccaac82f-0c43-491e-ab8a-1da8bf8c7477@csgroup.eu>
 <8868ef2c-6bfb-4ab7-ac5e-640e05658ee1@app.fastmail.com>
 <2234a5e1-5926-4b2d-a8f2-c780bf374a27@csgroup.eu>
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, at 12:28, Christophe Leroy wrote:
> Le 08/09/2024 =C3=A0 22:48, Arnd Bergmann a =C3=A9crit=C2=A0:
>> On Fri, Sep 6, 2024, at 18:40, Christophe Leroy wrote:
>
> uiomem->addr is a phys_addr_t
> r->start is a ressource_size_t hence a phys_addr_t
>
> And phys_addr_t is defined as:
>
> 	#ifdef CONFIG_PHYS_ADDR_T_64BIT
> 	typedef u64 phys_addr_t;
> 	#else
> 	typedef u32 phys_addr_t;
> 	#endif
>
> On a 32 bits platform, UL is unsigned 32 bits, so the r->start &=20
> PAGE_MASK will and r->start with 0x00000000fffff000
>
> That is wrong.

Right, I see. So out of the five 32-bit architectures with a
64-bit phys_addr_t, arc seems to ignore this problem, x86 has
a separate PHYSICAL_PAGE_MASK for its internal uses and
the other three have the definition you mention as

> 	(~((1 << PAGE_SHIFT) - 1))

And this is only documented properly on powerpc.

How about making the common definition this?

#ifdef CONFIG_PHYS_ADDR_T_64BIT
#define PAGE_MASK (~((1 << PAGE_SHIFT) - 1))
#else
#define PAGE_MASK (~(PAGE_SIZE-1))
#endif

That keeps it unchanged for everything other than arc
and x86-32, and hopefully fixes the currently behavior
on those two.

     Arnd

