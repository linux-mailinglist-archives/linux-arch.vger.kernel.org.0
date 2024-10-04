Return-Path: <linux-arch+bounces-7692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA599903A3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89041F24483
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2E20FA95;
	Fri,  4 Oct 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EUhO0cpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QTuyBj9i"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE179F3;
	Fri,  4 Oct 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047665; cv=none; b=uUtr68B4F/+JpN6hvIqQy1rLth/7OzRx+sq0ADF3rlV6DoA0qZVSWtYjlEBd4S4gF2jc527JHj/lC00baWB/x7gvPo8qgPGNbHW51c8mSVGloe7M74dg/OfEx52U4gb1jmLoEQ062our4CSuss3w2ISw1hCFMGM0zEbks2O0wMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047665; c=relaxed/simple;
	bh=3/g/1Y2zYOjkFBmhITmiEwPncGJVM5h7M9oEMInaeaI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XwiNQtYWCcP2eqAnewwe4+XLAKIzqAun9KGmzVxuQJPbttmZSfsmS8GhdgIUqUPZqpSc5ijtRnoM+VRbElyA32mgy1OnhY/tBq9YSwR4BrAPvBQCKrXu43o0K2qvTRHCxohmFUorGbUc35zmqKAeUWzyJuxkD154GKaIVYAyVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EUhO0cpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QTuyBj9i; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FF181380279;
	Fri,  4 Oct 2024 09:14:21 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 09:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728047661;
	 x=1728134061; bh=8kN5t+2aLHatwDnBUDj7f35725qTXfQc5j12nPWEaMY=; b=
	EUhO0cpybdFHco6SGBW+rSmWu6t89tMszlMlq/s3hzW+0gjHOu6imMWa5yVwGUZj
	EeH94i90VO5TTp7LnGyB3Y6WfyUeIj3wDColtuoEUhY55NvnjJR+JrPZzxVPnhmg
	iIytcouawzXA/P/st9PEbFPD30PdEAeUmVUx9XUQE0dk6hL4kL4SPnI+yYLBDpCL
	tUG7gO6TIvyKi2auAYMlO06wQujZWZuoyLzLK1S6DWcNNHCsoiry9hDpwHch0v/a
	9g0vGAN2QX7GafF+MtjehXcVL1osfWwQTxT/BwUp8LPHIjqYGF9PEvoGDBkvwYF5
	Z6MfW6DFaAhFTf0unXrnNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728047661; x=
	1728134061; bh=8kN5t+2aLHatwDnBUDj7f35725qTXfQc5j12nPWEaMY=; b=Q
	TuyBj9iVpeIWVEGMfZ9vFXUOQXFqZ4PFgsekgS+xf0ZOT2QWw7vG7dIG7bRc5KrA
	A+J8TNN/PdBYp0zfv+uXRMIPaTnSoDD3EPS2pAju0VsXzXGriJrTJxfLbvBQ2wd2
	Xg/qIXEa2M5VMWNs49AFgaa3yRsizOLCbekhflf3Npv9kt2bBgApfzUfwklwSjwn
	0kwHvzkor1mOS1IGCgfoAPg02FAlO6yNHowyiVjnGwovQbLMAlQ5vCEY863Iu/5t
	PwTlEEmosLl9wN+k2mwWO6+EYjFfkMVz2zkdqIs8qZogPFBfqJJLBMw5EIws4T9j
	Cvz7YwMS2f1qEDAvxhk6w==
X-ME-Sender: <xms:K-r_ZqiafOz2byjAglFafltiBnhxZzRF2XgTddQjz1jDNGLbR7Nu1Q>
    <xme:K-r_ZrDl1i41kj_31jrBjXKAdL2SpuObI2g8LCcdJv_UqV0K0FZEJxYiC_6ZlPAcC
    T6vmJZah-nIOvGz19I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K-r_ZiFEfFmELui_YbpxUkRzRfUalLYxmaZ12FH4GTTDVb9nYHmssg>
    <xmx:K-r_ZjQUbnBypxLQa0DVzjrK24doHxX0wNKKatOtx0_kW7bC5QcFlA>
    <xmx:K-r_ZnwWObmzm94T0p-5ZeISCqGOMfHG9gcyFvvsD4n0KRYMcQOusA>
    <xmx:K-r_Zh6XuOpQCGSWaF-gy6ydTaq8uGtC7RqkDvojotgmutqjvbVoSQ>
    <xmx:Ler_ZoGMLDscaglBmnMNl8uZbZNgh7ci9tNlKkouV3ZEUwOc7ZQahrnB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A18C2220071; Fri,  4 Oct 2024 09:14:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 13:13:46 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
In-Reply-To: <20241003152910.3287259-3-vincenzo.frascino@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
>
> Introduce vdso/page.h to make sure that the generic library
> uses only the allowed namespace.
>
> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
> it supports 64-bit phys_addr_t we might end up in situation in which the
> top 32 bit are cleared. To prevent this issue this patch provides
> separate macros for PAGE_MASK.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Looks good to me. I would apply this to the asm-generic
tree for 6.13, but there is one small detail I'm unsure
about:

> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
> +#else
> +#define PAGE_MASK	(~(PAGE_SIZE-1))
> +#endif

We only want the #if branch for 32-bit architectures, right?

On 64-bit ones, CONFIG_PHYS_ADDR_T_64BIT is always set, so
I think that is unnecessary change from the existing version,
even though it should be harmless.

     Arnd

