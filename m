Return-Path: <linux-arch+bounces-10967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF0A6974D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68BC1B60882
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848020B1FD;
	Wed, 19 Mar 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FbSGEu3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjaJZZc2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9120A5C2;
	Wed, 19 Mar 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407259; cv=none; b=epIl+KkgFjtvmZvtGdk9nD8sAlTTDj81BblUnQuf5EgKzulOTF/8Rv1tjgt44YKeQoins2xHxV+6LWEXaR6weUSBA/pgYIz9D4N/8S73p4hjfyOmxEVuwJqF2659jFsfjY0aEBc8WWK+8WkrIMMrHgngyhSeNf6gp2LM+V0fN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407259; c=relaxed/simple;
	bh=J24QPNiSvQjxqcpAoqe8HKp51xkqk4UeyMmzRsuvzBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pAJSvsZV8B9e6mAmpQjpxg8q03Vb4h7HV8sUrcrIanHdnXaWxnkuQIHfExMqoGitN0KT4WA10Lbmsi/oce+mPcSf2iHv8tSkvj4Ory8lHga32nAjx8asoSdx6Pp5DjSsSPPHaB+C04XsvTtU5sUQmXjPbSfq6+ke4pM9T9+F4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FbSGEu3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjaJZZc2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D0BF11401E0;
	Wed, 19 Mar 2025 14:00:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 19 Mar 2025 14:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742407255;
	 x=1742493655; bh=j99UzkzYeukgqfDcLgt4KhNLxDXupQ030jBL4aidb8o=; b=
	FbSGEu3CIQBpoEJoirAJ2MfRpG5rbf2zHGEoiCTAg31byGXw7+teD0TKvExK84ag
	oqTl1bt+hGDz8wgAgV+5QgxCJ+eJdDFY7fLz6S3yencZxQTlGD3N3Tg9rEFEEnIZ
	YRkoRD0RaoGOSQf+BwKIfERiFuJN7/yHoDHEyhcqL/NQiNehzLTZoapa2etxWSMS
	QgH84pf+krZkYMx5Lu/xZdepLAVEiGauPMuK0qkbZC3pc6JBZmIwgAEdBP+2FLay
	aV3G89q6WQZcE9EAzIXSBZXE6fzFpI+yiFKheR2slpakXkHaBaWGNsnAtdBCslKQ
	EfDLOjSEMsNAPtB5kbtoXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742407255; x=
	1742493655; bh=j99UzkzYeukgqfDcLgt4KhNLxDXupQ030jBL4aidb8o=; b=T
	jaJZZc2k7rC9S6YtmLq/HJuwIyHXcsvfEGuviA8nC/HiWTszI/dcqLUgF2jGnL2R
	aOrZSBRB4io+RYJcuzwdp56sCSEiW9eUK6LqxfcpRCMsjRurcwzirk9sygbAajlu
	Pt83RPpGd+2Px39LEHtUdL/nxfFEQawxU36tkTQ0dRhnUhNeq6ag2dsojzTCEwPL
	0zB6n4orCsxCuRfPSntaiQ6XD6bhhrqFcitFlo0c1rvPCt2DO9pE/3QlEShXJrme
	8zdDVFU64JF2fOZKCmMoLnBvYP0KRXARu641Y29LPuh0nVRnCHyGwmclxsv50hwW
	3zvcOv76yjY0i7txh+2/Q==
X-ME-Sender: <xms:UwbbZxP2v_SaigJNOEBSkT0dkBU4TiRBeD7eFVboRNfhxJ_uyrYd2w>
    <xme:UwbbZz_0Skhbp8ER6JcXggtH9DQteCBjUEhG0od4UVOMDG4GZgdpna6gA9MhBrit9
    xEhebv8IF1BLUClFPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlph
    hhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghr
    ohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrih
    gurdgruhdprhgtphhtthhopehmrghtthhsthekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrse
    hgmhigrdguvgdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrh
    hshhhiphdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UwbbZwTxzuKSvSyP8RM379AOft0Rk4Jy2WQ7ZMWRjRLwCUknj9sN5A>
    <xmx:UwbbZ9uiOWvUS1afndJibPBDe3wEilMotJE1tvKpBJ4uQ4fkHmw86w>
    <xmx:UwbbZ5fdArhPuVQ5nQoDvNxoUYMMRI2tSN-7JzvkCsS8570toN2aig>
    <xmx:UwbbZ52faKbdcNpcTKIV4DaxYpqTI51kcdj_27qn3FmZ3hJs1NWYag>
    <xmx:VwbbZ8zY-873YsqHPj8zmjcaXCvqPik0f9dGmrjFufKN6xZdOUEl9Kb5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE1882220072; Wed, 19 Mar 2025 14:00:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T334a9a9a7e89e162
Date: Wed, 19 Mar 2025 19:00:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Julian Vetter" <julian@outer-limits.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <d7ebdbf9-1385-44fc-8db4-2ce6c73e25de@app.fastmail.com>
In-Reply-To: <20250319173010.GA84652@ax162>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-6-arnd@kernel.org> <20250318203906.GA4089579@ax162>
 <5b2779f8-573d-401e-817e-979e02f811d3@app.fastmail.com>
 <20250319173010.GA84652@ax162>
Subject: Re: [PATCH 5/6] mips: drop GENERIC_IOMAP wrapper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 19, 2025, at 18:30, Nathan Chancellor wrote:
> On Tue, Mar 18, 2025 at 10:13:35PM +0100, Arnd Bergmann wrote:
>> Thanks for the report, I missed that the generic ioport_map() function
>> is missing the PCI_IOBASE macro, we should probably remove that from
>> the asm-generic/io.h header and require architectures to define it
>> themselves, since the NULL fallback is pretty much always wrong.
>> 
>> There is also a type mismatch between the MIPS
>> PCI_IOBASE/mips_io_port_base and the one that asm-generic/io.h
>> expects, so I had to add a couple of extra typecasts, which
>> makes it rather ugly, but the change below seems to work.
>
> Thanks, that does make the -Wnull-pointer-arithmetic warnings disappear.
> That build still fails in next-20250319 (which includes that change) at
> the end with:
>
>   $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- mrproper 
> malta_defconfig all
>   ERROR: modpost: "pci_iounmap" 
> [drivers/net/wireless/intel/ipw2x00/ipw2100.ko] undefined!
>
> which appears related to this original change.

Right, I had seen and fixed a problem like this in an earlier
version, but forgot the EXPORT_SYMBOL on the legacy host version.

Fixed it better now.

      Arnd

