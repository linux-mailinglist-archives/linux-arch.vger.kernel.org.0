Return-Path: <linux-arch+bounces-12588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90565AFB67E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E98D189E44E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D92E2654;
	Mon,  7 Jul 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AFq0Z654";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7D8pwwM"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA22E1741;
	Mon,  7 Jul 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899743; cv=none; b=G6lRuyiwCoJgT2gebnAvLWzZT5SDgfsfWjVIqMWyds1TB82DTj+VEF4S3Q4ae3Kse8ybkTU64FchpdTnmqNUe+7u1ZDZ7gl6bx/LPtNlze9Fv+oNZtoIJibaJcFoNutxJghZEOhqeBKRrY7uLdHaZ3plypmvIGjaLMdMWUJOrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899743; c=relaxed/simple;
	bh=nHDeJUa5JJkBQKeN7rrgGKtd/lDZ/oLCQbdP++nLQHo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jGyDfRBt/B3xp1iF2YAgEKFjayvTgjMvj8uvu9xw6k/dZszcYYmpVK5of83oDflPXwtvkW6/Y0rh61Kg3TREV+P99T7tGhetv4FjVKKBkkL2sHpBZEXeYlfM5zndOH5gqHxyNJZUAvBVH0GhtUDee5FEdK8j64o3wovbJ4KkG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AFq0Z654; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7D8pwwM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BCEAEC0B59;
	Mon,  7 Jul 2025 10:49:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 10:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751899740;
	 x=1751986140; bh=WiYQwAAPf4n8hF54hQ9NPDuRPE4r9c35s3L/M8iusuA=; b=
	AFq0Z654EiBDvaOSnENNsaTPa/w78Svi+tzHaxWAAsrTKYEs9s+J2vLiuMmGaehO
	C6U0kIgEwRG+OtdYlPQLFuFBMVIT7M6LBDmYQVd1WrBtjyW7T6fnWqaBWztY6rNA
	qwNlc/K2cDGlq7ZDsk32ha5a0mYxa9VK9fe8rQUcBY691VL31ko430pnmTXOpy2P
	KgXyXaaDqwQspPET4qGtAFTOKXrrfchkGicQXBQ8mNVYwlGnfJsw58PvjbPDfchj
	a0Hrsmc3tdsBAtCDzYSuYKACVVAX260Oq0vb6Gn7zGPJmGFFhkapJxjTczaufiaO
	fV9JVG172rWriJe097Hs1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751899740; x=
	1751986140; bh=WiYQwAAPf4n8hF54hQ9NPDuRPE4r9c35s3L/M8iusuA=; b=c
	7D8pwwM8t3s4foMCtFifpLwBCI2KjTfkn+91iiliVmrPSDOuRpaCD9a2Wi0Cd99O
	T+4bP92w6YYw1N0KjQPYaIvUfoYLY3iWJAAsuAtNL1JWxvfFT6Z/AKkzx5JC2Ay1
	jPMDrLco9t+/A3iW9O91pVst58TX1FypMqBHkh3JzQMSto6LJfE7tsapvMk/OsE9
	dwarxiDeCv/6BM29IZtdBNKCPvlevTOVBLiujewe/KDSFoFw7LSMMrHGJDL4mRn/
	gpEv06hse4ZB/K0+DA5I8ocMBmY2cSu8jEWYlwZJBJDaFM5fFq/xiYPwYOZ0VfM+
	WBtXhkx34cfBMdWT8XF4A==
X-ME-Sender: <xms:W95raGpbaoMB8DtLvesrhMVxSKLk-WpQC_Gyo9nC260olR-gk8X5EQ>
    <xme:W95raEpEGPwpMR-xOe82f2UaixwPnYYlSIYHSN7j_fFZf8azAhCnFZ1rkT4N2Kdij
    yNfAVhkv2-Y79iYUeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthht
    oheprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepugifmhifvdesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopegthhhrihhsthhophhhvghrrdhsrdhhrghllh
    esihhnthgvlhdrtghomhdprhgtphhtthhopegrthgvnhgrrhhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhuthhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:W95raPvIVZLNK_8zD1nAcTSidp9ooCfasgURt4knNswRgdjekxuFCA>
    <xmx:W95raLMlqKqBb8K_8TZspRTf6QJFz2EO46nIRPnI68skm7DsC5pjKA>
    <xmx:W95raBqvHcMkz-lVpH6oEn5NOyTTligmyxoN9rB0OF878_p0Ch11vw>
    <xmx:W95raE9DNVOIg4qEdNgqUJJEsOJr5ULnaB0zQ6Kxpp63FjSnejeS9g>
    <xmx:XN5raMYsmCeNvI9rQ8qma2tHGWE-fzRfza7Kve99fsLvfbPUHFC2drMX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A88B6700065; Mon,  7 Jul 2025 10:48:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T22a9fd8a498db8e8
Date: Mon, 07 Jul 2025 16:48:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Christopher Hall" <christopher.s.hall@intel.com>,
 "Miroslav Lichvar" <mlichvar@redhat.com>,
 "Werner Abt" <werner.abt@meinberg-usa.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Kurt Kanzenbach" <kurt@linutronix.de>, "Nam Cao" <namcao@linutronix.de>,
 "Antoine Tenart" <atenart@kernel.org>
Message-Id: <fcaf7b51-a31e-4cf7-8065-db016d19d568@app.fastmail.com>
In-Reply-To: <874ivorvij.ffs@tglx>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
 <877c0ksd1p.ffs@tglx> <2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fastmail.com>
 <874ivorvij.ffs@tglx>
Subject: Re: [PATCH 11/14] vdso/vsyscall: Update auxiliary clock data in the datapage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 7, 2025, at 15:16, Thomas Gleixner wrote:
> On Mon, Jul 07 2025 at 13:34, Arnd Bergmann wrote:
>> On Mon, Jul 7, 2025, at 08:57, Thomas Gleixner wrote:

>> (the added lines here also fix the missing clock_gettime64,
>> which was equally blocked on the sparc64 oddities)
>
> I'm all for it.
>
> Can you post a patch to that effect?
>

Sent, plus a bonus patch to remove CONFIG_ARCH_CLOCKSOURCE_DATA.

      Arnd

