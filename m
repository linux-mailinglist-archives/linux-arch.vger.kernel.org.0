Return-Path: <linux-arch+bounces-8649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14319B3261
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1075D1C21C81
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84721DC734;
	Mon, 28 Oct 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ea1ZHKin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hO0xGr3d"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E851D5CC5;
	Mon, 28 Oct 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124134; cv=none; b=Wf36Rv9u8E39VnvWEYJ7N/0222J2KuxgNVQMnBQqOMelif1cnXbKOExKcs9C3ZvQYsFUk3JY/foEgm0Y9V+wrlRmG55dGrWlM+6LN8+bHPBdJU57E2Fkmc3NmvFDVEerwrS1eiyd8NPBCe8x7BrYBlYj9Uat0MmYbzRZYjI2WT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124134; c=relaxed/simple;
	bh=pRzYsZTf/6WaLODzzERgIiPto/LwdVPBcgk0H488f7o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U9NHLwzWWYkfhCPodt7HE1HJ+fREzimqkQDPyyP4MAMrH5EDNiEUBuYwBl8rDpkPcOXdhH+1Yb6g0oxAzPByli5JMRutybXB1uEWPpAPQVC0DvVM96Zae0fKYrA+y6lKkmkK827P4QQtmIY4AvEJy86uzmWsc0Dt7DMps1yNAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ea1ZHKin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hO0xGr3d; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 005041380145;
	Mon, 28 Oct 2024 10:02:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 28 Oct 2024 10:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730124129;
	 x=1730210529; bh=r+OiIDFujfOkX27UX0KnwST8oK9dQeo/ifyz/Fg5BH4=; b=
	ea1ZHKinNqus8IGzLA0oTFE4P8eRvXz95Gu5TPOZKkfCwqi3o86yRLUeKd+xjsV/
	VAdxqjBHMU4mbZ1NNQIL+AkizkZFo7uPqB4Dhy0dzlTs7C2kOqkJDkkVqKYiTqRQ
	2sHm3uJd/fNIYWIKiHQpAxXr78IkZuLZf/teNibdYoCgWD/y2xBMWRwAWo7+2kXB
	mOz2QneV3wkZ9SVACHGRZaSpIuMORxksHPJQTpqREkvsZvMnLqmnqydFlnIE11Ar
	1zWCeU0jIcyS7FHjICFf9GIVaCcC7WOYoezrJ4p0Pv+VXd/jFCozyvCh+W95kFn5
	2OjJd4ndjB03ePJdylFrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730124129; x=
	1730210529; bh=r+OiIDFujfOkX27UX0KnwST8oK9dQeo/ifyz/Fg5BH4=; b=h
	O0xGr3doGLlUkgjlmoh7OqE6Go73AJPRNJ2+M0xnafE48wa5BDYmecI4VeFFd8wy
	1mR2cyj3hCZ7Vs7addrbq1jmRaWoyV6MWOcq/h/G//pspPLPYi6dbnPKR+GO8lZO
	exwodB+SzfiurYhUkZ1oEr3hG5WjoMRqCo1locWNOEbi2ww4RTzCyKOP6XJyjhqb
	UAbp68IQ028mACjJez/rn3Fx9hvzf5AU6cvXtsujM0b+JsjAmfqXkbn/swagzZWM
	jr8qhlNh5hpPqiNHDl3YQs3hBUBNB5Wdzu5viL726P4ZAdgQac9kcjF+KRExX+48
	uEbtRzMFWC1CCrC6GXZ2Q==
X-ME-Sender: <xms:X5kfZyu8FRLBspgYiFbjf8P-xpnCwI95vxq0l8upbbCjWMgcmc1z7w>
    <xme:X5kfZ3fc6UOl0mPo73rbzhtaeEyYJWp60srptDLhksqRQ00UFj5br5I_aosHE182S
    EGrJ-S29tHFEYG1EqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhlrghighhhthesrg
    gtuhhlrggsrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrd
    gtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehjvhgvthhtvghrsehkrghlrhgrhihinhgtrdgtohhmpdhrtghpthhtohephihsihhonh
    hnvggruheskhgrlhhrrgihihhntgdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:X5kfZ9wgum0vvTNY1_U0ODv_2hT3VzRXXqsoqGCFXJatAt-kYV9s-Q>
    <xmx:X5kfZ9MReUmx1MBBGvppBNMDflMti1A1ib7yK1lGTPUhGJaOsGjOmg>
    <xmx:X5kfZy_tV7OnRqQq6ThR68huUTWAZzMP9XA_XEIB-auxNDKldbHnvw>
    <xmx:X5kfZ1XTwkUgXd3mnM15tMHPPAFtGGOyXiRe_PgN1W2pD24wGcTU4g>
    <xmx:YZkfZ1e_9DtjsPEP3MRLaDDdRCCDjyFM2DBoRbPq0Elqbi-AM0p0ROSp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7E272220071; Mon, 28 Oct 2024 10:02:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 14:01:42 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Takashi Iwai" <tiwai@suse.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Christoph Hellwig" <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <52edd934-a1ca-427f-81f8-7d7dff2d626f@app.fastmail.com>
In-Reply-To: <20241028134227.4020894-1-jvetter@kalrayinc.com>
References: <20241028134227.4020894-1-jvetter@kalrayinc.com>
Subject: Re: [PATCH v11 0/4] Replace fallback for IO memcpy and IO memset
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2024, at 13:42, Julian Vetter wrote:
> Thank you Arnd for your feedback and no problem. I should have asked
> before, to clarify what you meant. I have now addressed what you
> proposed. I have kept the iomem_copy.c and only made the minimal changes
> to asm-generic/io.h and kept them in place just modifiying the content.
> Not sure though about the commit message of patch 1. Let me know if I
> should rephrase it.
>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v11:
> - Restored iomem_copy.c
> - Updated asm-generic/io.h to just contain the changes suggested by Arnd

I've applied it to the asm-generic tree now.

It's always possible to improve the commit messages, but I'll
call this good enough, as it's more important to give this some
time testing in linux-next.

Thanks for your work work on this!

     Arnd

