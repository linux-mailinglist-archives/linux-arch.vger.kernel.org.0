Return-Path: <linux-arch+bounces-13606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AFB571AA
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E055D3A833C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484142D6E67;
	Mon, 15 Sep 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="e/WY7yZk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="io8fvVYd"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8522D6630;
	Mon, 15 Sep 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921733; cv=none; b=erhTnNrBInRjHzdwLpsnDFQM8V8QONBY55Hntx2gj3kxhTZdgUlIeBPrMi6FDL30zujvKPZVjNzDz8WJ4Zy/Gcsdj3/PgSWs7UAB3Yki8ljUljwTtW9yJ+xWNP5ik3QIxthx8a/FDeFNc8GyPBusMaO6DVVU757gzPwj9eJzRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921733; c=relaxed/simple;
	bh=RuYRebl+HbUVt0zse4N6nxIR3wc0SJPxveq7cnkMuQY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u4TPENf5XdNNY5aKeHm4sYLUaqfCZzoUKCCfnMbzdM2KNS87iTaHLLsnfyN2D2bzUF1U06Q5srSbPsR+ePpDXnwXoTz0/tIpoCv/xKlHbPBgg9woFRiYfAyHGvkKPk1LQ94cb1B8RgrpECHBefoiQcRj9MAPOcenw7Mggg5iXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=e/WY7yZk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=io8fvVYd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B41C14001EB;
	Mon, 15 Sep 2025 03:35:29 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 03:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757921729;
	 x=1758008129; bh=fFh5zcL0Pgn2r4JIGJOuEdaPyHtQPb9OTIMUntGscWE=; b=
	e/WY7yZk+oi6sgHBOkGnVbdFzRM7RlUGTvJirnJupQ0QTzVhSq1GbfGEMIgCU1+d
	qocPk/TYsXpUiTg1aesivL/DbrG77RryIK/cACp26g1OYlKRDGruAbiOZn+jkKOZ
	HXu0fJj1/aeWN9dZO0flvv4V8NTKial7+5zerjtSLDu8PpL4RIXJdWdaNprwB88Z
	2KPiJ7ns9xIWK9fo0QTeUdwg2E6Mtsm2LYHhjt+CJMFqZNqdySyVUGBJJL+Uwkj+
	5sGLKtTp9Ye4hu5281d/3y2vZMtuyII4GMxeOQlmdkOSECdKKMeBYeUFnn1cCZuA
	P9ZB7UVtJYRFIezfPSoGoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757921729; x=
	1758008129; bh=fFh5zcL0Pgn2r4JIGJOuEdaPyHtQPb9OTIMUntGscWE=; b=i
	o8fvVYd/Z4P0NxWvFzmkCK9GRflvqwBjRzMmewVCIxFLWqvjOJXXxIBoCrcmjxMO
	ovPm9cpXpLCVg+Y1503X/DIlNitTHAHXnSm3PJAS575L+uKZgfK9maf9Wam72aRK
	tAbH+l4NjIfbL0z88fFc+ivw9F2q7RF6D0KO+4jFvlLxHOM4J76vidayad2Oh3bJ
	MBR+vQi/TQ4OADrvtqcR0m5OFx+XJ0PSpNLt3L6njsvJGykXIHgJZ8bWSD0Tzpi8
	qk4S4jjdmc45u2T5U0l1PlklfN5Vjm+kSdTdzKE0MsShZGGAeUFhcAxc2NXbCepI
	g/Q/eiOH608d/u36MWLJw==
X-ME-Sender: <xms:wcHHaF3KSi1DD8hVUkyMGkeXYekvY-ifWGKuqSHMUOje8MsBWEfMWg>
    <xme:wcHHaMHTWfbvBZl3VUSoe74tY6rqhDYiXCn8BZW5MEwBWj2-ybLGeJX3rHzaY5Hlz
    BGrQYdCIXBEeJOOSVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:wcHHaOlAJdtLoomW4wYDMK7BHOkdJhLFYghNEX3oKyZAbvEfaJylcw>
    <xmx:wcHHaLwa6igA3rro_CvfGamUYBF7LzSGmd2F0d26vwQCHGP3vgQdDw>
    <xmx:wcHHaJzpb9Jj6ejaH5QT0Y8HGKJpel3FKE5glhH4jRjbRecvmRYDig>
    <xmx:wcHHaDWqQmIF5hvbydUD2Fs2EMUo7b_KgyyM0rytBbLRh3RZi-3UGA>
    <xmx:wcHHaPexKUQGNL2eRO6D5m9KTUKjsUix5r3ESQBVxi3d5zVuMYTFikEs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E954370006A; Mon, 15 Sep 2025 03:35:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Mon, 15 Sep 2025 09:35:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>
In-Reply-To: 
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 14, 2025, at 02:45, Finn Thain wrote:
> index 100d24b02e52..7ae82ac17645 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -10,7 +10,7 @@
>  #include <linux/types.h>
> 
>  typedef struct {
> -	s64 counter;
> +	s64 counter __aligned(sizeof(long));
>  } atomic64_t;

Why is this not aligned to 8 bytes? I checked all supported architectures
and found that arc, csky, m68k, microblaze, openrisc, sh and x86-32
use a smaller alignment by default, but arc and x86-32 override it
to 8 bytes already. x86 changed it back in 2009 with commit
bbf2a330d92c ("x86: atomic64: The atomic64_t data type should be 8
bytes aligned on 32-bit too"), and arc uses the same one.

Changing csky, m68k, microblaze, openrisc and sh to use the same
alignment as all others is probably less risky in the long run in
case anything relies on that the same way that code expects native
alignment on atomic_t.

     Arnd

