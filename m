Return-Path: <linux-arch+bounces-5303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92C929984
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9257B280BEF
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5E5C8FC;
	Sun,  7 Jul 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V+upbhkY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjp1bY+H"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9A34545;
	Sun,  7 Jul 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720381103; cv=none; b=Qo3Zj31qgeKwjIiNBi7THzKANk57zMplxCCsB80CmO6YSPNVNF6Z3v+XLI72ENIhcMTTuxJ5qiONPLks1axbsfjAtk0YGlq8N/iMN/QBnzkO07wwwYuUxPpiOGn+0lTiwuJSJJqBX+irtbgZeOVSzZzS47iOyPiYUvz30P9w4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720381103; c=relaxed/simple;
	bh=a4kkbaTvFndhYJsUksQQjEEibO7NQHKBUX/1MXwtQLk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YHMvhBhs5kfMPoCcpOmJf0QnMGt/NEc3CU1GsvrYoZalPZzpqxDvq0GI3TcFAHD+N97ImS1ajVZFhK8H+hIhpZPbB2kviOpeEEJ8Kxm5W0Jg6H37DpjC1J8ZnL6En7+AMILWE2z0t5xd0UjRE7gqfU4RVC0hflR/XrDENbRa4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V+upbhkY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjp1bY+H; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DDE3F1140298;
	Sun,  7 Jul 2024 15:38:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 07 Jul 2024 15:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720381100; x=1720467500; bh=i3QTytn5Xr
	/5YqRfU9uxDP6T/PtFr8v+b1aNKyRVK+M=; b=V+upbhkYUfj9Sln81iDRm/HW83
	orKxf+tv8sgI2q9Ys/hhU1AACFXlfqW/9T4rbwLqA32LA0aTGEiBz4tzqUXGf8PW
	H1FadM+MCZBXSGo8yFe0hU9Aex6UjvNez3MvYcb9Lhuf9pyhwIiM8YZqUZCvJFE0
	khJl/m9l+O5hjI1rmlpau+79zyssn+OFaPTd6dhjHvohat9b9hABndJsAAKiafb6
	vQw/KrHY43y6YXCQf2+8Dyp3Fcf4ZcDytZiHPZU9YlhmolkQnGWq9YTbz8ItBDD+
	kmlWAB8nMLzZJmMFbvgSk9I375J16yIhkPgmHtsauB5pjYsuNk27zLELHYFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720381100; x=1720467500; bh=i3QTytn5Xr/5YqRfU9uxDP6T/PtF
	r8v+b1aNKyRVK+M=; b=jjp1bY+HjOWk6TTAgs8BEyJDgDH3+yj+8l39Oy/zTH6M
	qOtCe2O477XqtdzEAMmP+d3b6OdCdrauT9+HvT5yA3ZFUOfTiS1AeZbNgA9SCftA
	HCwCiWgvUYeNVDue5F4ipflSHKXM9HIdCxVxn8Jcd1MTfbNjKSxTkZ3OJYK86Brc
	INAv93WURylIPmu0Nk8zI2DHglk83dUfPxxq7U6Fbdv/h7ArbHRNkSC8dwV4ufOd
	/DmzonNUxGb+ZLY1MkWAqKAS4HzOKCja9IvOfLXjMF1D3YMwrvW4iyqQ2E1d9CJw
	y8oj43kRPu3qnu4cDnMDDHA4rv1AESfP5VpJiM9l3A==
X-ME-Sender: <xms:rO6KZq7k53c-coc1BqcGjBv9CQgZHog2awZIT8NsZr1Ts4c-T43QSg>
    <xme:rO6KZj7OjmEqUrjTzi8cQjVjA4zeLx0bJKaqwGqtBfRWaktcDga-1G64wyIGHUI2k
    _4KLCZs3sG0DMmwUEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:rO6KZpfcobOansTlsGPOBjMbQlQoJIboPqPaU_5PrwbQuAV6KixONw>
    <xmx:rO6KZnICMnqD14B7cBExndtkGSaixTvQxpN73ht_VroueZ2HBNh1kw>
    <xmx:rO6KZuI62U671tI_FtxJoYtRBeJbSJ_sW_ZYzSa-1DcrjZfyeHffXg>
    <xmx:rO6KZoy6o4IE53_Ysr7dOV6UjZb8heQri6YaY3c2Ca1G-qEpuZufTQ>
    <xmx:rO6KZq1l3FdM5KlfGifGiNAUzhgIARYF0dMLwlW7r5LIvksjxADZOf8R>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9B87DB6008D; Sun,  7 Jul 2024 15:38:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3dc8f89e-4525-4084-9d4a-facb6105239c@app.fastmail.com>
In-Reply-To: <8251045r-26sn-4674-p820-4qp6s5o322qq@syhkavp.arg>
References: <20240707171919.1951895-1-nico@fluxnic.net>
 <20240707171919.1951895-5-nico@fluxnic.net>
 <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com>
 <8251045r-26sn-4674-p820-4qp6s5o322qq@syhkavp.arg>
Date: Sun, 07 Jul 2024 21:37:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: "Russell King" <linux@armlinux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when optimizing for
 performance
Content-Type: text/plain

On Sun, Jul 7, 2024, at 21:14, Nicolas Pitre wrote:
> On Sun, 7 Jul 2024, Arnd Bergmann wrote:
>
>> On Sun, Jul 7, 2024, at 19:17, Nicolas Pitre wrote:
>> > From: Nicolas Pitre <npitre@baylibre.com>
>> >
>> > Recent gcc versions started not systematically inline __arch_xprod64()
>> > and that has performance implications. Give the compiler the freedom to
>> > decide only when optimizing for size.
>> >
>> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>> 
>> Seems reasonable. Just to make sure: do you know if the non-inline
>> version of xprod_64 ends up producing a more effecient division
>> result than the __do_div64() code path on arch/arm?
>
> __arch_xprod_64() is part of the __do_div64() code path. So I'm not sure 
> of your question.
>
> Obviously, having __arch_xprod_64() inlined is faster but it increases 
> binary size.

I meant whether calling __div64_const32->__arch_xprod_64() is
still faster for a constant base when the new __arch_xprod_64()
is out of line, compared to the __div64_32->__do_div64()
assembly code path we take for a non-constant base.

       Arnd

