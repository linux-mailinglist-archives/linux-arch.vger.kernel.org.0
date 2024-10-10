Return-Path: <linux-arch+bounces-7954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683C998007
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EFD1C241EF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6806206E64;
	Thu, 10 Oct 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qUwWDZgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKVFY9ru"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADC206972;
	Thu, 10 Oct 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547485; cv=none; b=EHyy9BYRpjToh3Qb59S5zew1d1qYdkRt/Ijr4LPgws+n5F8sMuKyekcCcg9rsKF/p74rz6WmmEpNluZOk1k0RngCH40jCt8nrTs7+ju59/TKDfYrYErRNYyvD+kk7asNoTMrDwU7hElHLPRjsjSk9gtgzE4F8lN7P7Qy4lRI9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547485; c=relaxed/simple;
	bh=NOnTXEDf/afk98+qld6jjp5+THx/CJ1WRioKL/FDWFo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MRVnYAoHoenjrfhIoAGrGBM4oe2ofBruaYZNILTXmFvBsEywcMgEFOa/y8zUJfT+69oYrdNLcgOAyZicwEOaCzvCWmeUMn1iB5lcx32GsGYs3G9xmiBwLrB8fIV9YxD5tSwqfBLUX908w7zzJ7jNGZWqxsDOqS+S1/6/lupc/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qUwWDZgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKVFY9ru; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36D3E11401D9;
	Thu, 10 Oct 2024 04:04:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 10 Oct 2024 04:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728547481;
	 x=1728633881; bh=NOnTXEDf/afk98+qld6jjp5+THx/CJ1WRioKL/FDWFo=; b=
	qUwWDZgmoFSc2bvCLEkOL58hDVYZTrXcWqA1r8Cm2RvEFx5gUkRYopFuSPQ3amGK
	A75AnB60O0tNSjpd6qb4sOHfavqwBuHErQVjVa8XNdYjdZheAewMWD81oqp5grVF
	OMyHEJ3EtyhTGHXEhPd56/rpTE8Os9ZcKFpOiuCDpJ0WFjtvtQv24Ut5jJoTHnYd
	aFsDvyOZRC8f1Zd8Ggv9tLbENlgXMnhXw4fjpTepep99VYTMAzRQ02ssu1RFUoY3
	g2Q/l1BksGyyAC49oDIHgf037BwdnufA/EmmDjUOvMxnh4dx4RBbboyuyOd840NT
	xuqFLD+Nws1CIVcuTITmHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728547481; x=
	1728633881; bh=NOnTXEDf/afk98+qld6jjp5+THx/CJ1WRioKL/FDWFo=; b=Y
	KVFY9ruZTwjCXaru75A1LYIRzB9hNonTtp+VnwOuUDc00DfM6Q58QBkP6xvTdp45
	5KRX9ad0rBSJypNyLeRiaImyE0+6VyqMZel3jXqgaXrTtoIYd8as+0tpJgI4+Rwy
	XFY3m+TuzIDj8+4xOE9H/ir6Bpc93KNZM9vqBvrYFGayrfXvHSClTBdE5Y51ymOD
	CBmzaZCAlBE7NBw0EKGEjQ/m7G/CH5ceK628BoC5sGH6eY/a3dskoTF5R7ilaei7
	0OZJ/HycrEwomf3gFDs9UzNX1vf9aG49RHy276/+i4YF/m+QWD5HGfVUe1MczrPH
	EnyTMmojm4/cNsD1aIH0Q==
X-ME-Sender: <xms:mIoHZ4klWhimXUj0T6QpcTwiYXJRsoU5LdDufDqDOomjiAXzPU1DeQ>
    <xme:mIoHZ30tXQyn4xrtPUssnTi-kdfuHuz3J0caWpTGpMt2leGiFPK0R6BThxrSwX69m
    nH-QCqJpajtXht5q6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrlhhphhgrsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghskhihsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmihhpshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmohguuhhlvghssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqohhpvghnrhhishgtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mIoHZ2oEJ0fbuiaD8xkujPJKuAgfTVFVgkQ1MaKFzQJpFSIpGzfDAg>
    <xmx:mIoHZ0mJL5zhDflICU5OnCxj5xD-lNh7hszg2y7w_jG0SosfB6v4TA>
    <xmx:mIoHZ23OJE-QCT7HdDHaNJq2YoxMQsePqKr1PpcugeuoE58nHC1iew>
    <xmx:mIoHZ7tuhBf_WSccVXoM3lkeeX0DDoNl6mMcyPN5JCQqsonWnM8tzw>
    <xmx:mYoHZ8NM8dSyfUFOSROsLFZvsdyCyDiUWAXTgcQSDhI-SDaU9fYoh5C4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D17622220071; Thu, 10 Oct 2024 04:04:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 08:04:19 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Andreas Larsson" <andreas@gaisler.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Brian Cain" <bcain@quicinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, guoren <guoren@kernel.org>,
 "Helge Deller" <deller@gmx.de>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Matt Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michal Simek" <monstr@monstr.eu>, "Oleg Nesterov" <oleg@redhat.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, "Song Liu" <song@kernel.org>,
 "Stafford Horne" <shorne@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Vineet Gupta" <vgupta@kernel.org>, "Will Deacon" <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
Message-Id: <e1ba5ab2-a7e2-4f2c-8e2d-4788656ef695@app.fastmail.com>
In-Reply-To: <20241009180816.83591-4-rppt@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-4-rppt@kernel.org>
Subject: Re: [PATCH v5 3/8] asm-generic: introduce text-patching.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 9, 2024, at 18:08, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Several architectures support text patching, but they name the header
> files that declare patching functions differently.
>
> Make all such headers consistently named text-patching.h and add an empty
> header in asm-generic for architectures that do not support text patching.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

