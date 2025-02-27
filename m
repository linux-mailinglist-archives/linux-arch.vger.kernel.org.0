Return-Path: <linux-arch+bounces-10429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E6A485BD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190823A73D9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DC1D63CE;
	Thu, 27 Feb 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TgAEzflL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaT8nWR3"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCF1CEAA3;
	Thu, 27 Feb 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675048; cv=none; b=BnW+pGSa0Ptwg2Jr9sTdj60R6KXNRouVZOIqXyNQUorrbUFONOfX31+OTQS2LUoQTvpzNQWPNjEcPqjOdtpBjFv9VN7iXAYo4mncGZZ7jmwsG2D++UzBqmE44qXcSUP92K9z3qvSrRihD0x8X5JBPwEwhk0B0ubRRfG5RrdNybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675048; c=relaxed/simple;
	bh=JUzvFr/L9hG2I9Kl/VtNPVSYTrIJ8DUb9rsWFBd3hUQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DNCvgeGUVc4FtfFXkpW6HU8Ns2Kc7/MTMWhOpYlOL5yTu/RZvpiUJurjPLT7gbnxmgWExN8EraAj7shlMRuCbQIygJ/02WY8WI/eypPzTdlx0tRCAklD/TINbzam96SJIVF/5QqQA/l9eebmj0bystuwLV9Lw2LUjpuj5CVulV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TgAEzflL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaT8nWR3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CA2925401FB;
	Thu, 27 Feb 2025 11:50:43 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 27 Feb 2025 11:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740675043;
	 x=1740761443; bh=RucrbLFK1Gj167AVqzf5zw6rBdv8KCHQV3OyIQOZ904=; b=
	TgAEzflLwsxJacoJb5txmx3U+Kb0DViF/QQ8kKIuQZZx8RGi3JxwatMuT0UcY5XI
	svxDR9zl4tuZ56o3MObNFrsh4bHq6n5WoxRW2xcW6j2olHYy2XcbbWWfHS9TB4eB
	bP83mfkRLyPJELGMuUbi1rsZr28JyZLXpT5eNhwQ5CkeFqnXN4w4jUYsbKAkKdK1
	aVlNUxOjGphW1DD63jQ426C7jJiKHgaP0Tm8Ndv9MfnSD3ad8byYVmvLU/9tmxLw
	V0dogT+8u1hG+vPVRs4FuM6D1jY3fvbSgXWDODQuH6wEOs9SWINTpjOksBSiIWlp
	vgvcEvO4Ug7Vqe6KlAmY/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740675043; x=
	1740761443; bh=RucrbLFK1Gj167AVqzf5zw6rBdv8KCHQV3OyIQOZ904=; b=S
	aT8nWR3z5G/0ASRqe11JADRpwqf1f9S4470CyYBIBjMTFTdwEZMer1RZDNb2xDYf
	kU8quHP0wLrLdvJCxQ3W84/OeYkAevoq4dFb5cAAeHzTZ9Imrq57L4vpOlsByVde
	/M083py+WT7BhfFk328FmzhsXYdlSXhzHXZ67uVpTJYhfpXE9OmVj/KDWPmU91Bb
	YYp/yUOOv72GNfKBvziwQeUIHg/9MG6rDp2ccl9IKwjv4JhxwPfMIMm6qhwOJHWW
	T4toYQbVXrjwYXh9GHjfcgkVExM3r2m4RVM+XKMeksBf9GBBYU2tOEUJrluwq4oD
	Y23gmirG1a9XMnQimjEPw==
X-ME-Sender: <xms:4pfAZ25EeT644YUSYiyIF4tfgF64VEFYxAGYysXSqoZ85HE9fEsR3w>
    <xme:4pfAZ_4Se06om99kiUyChlntbMNaWeSHGjMQ7_yHAfeBy7lfoWyhsHw-_7ne9NqYP
    rH2tD1t7zO_NmlzxPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrd
    horhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4pfAZ1ei_7quZLmd9VlKCZWzm5eRWRiJiRtjwFQG9c_fxKJbTC6U6Q>
    <xmx:4pfAZzK1yak04vjTsZd_3XeDHlwOaPgqhHKV-e7oZlifRbq-Ql8P2g>
    <xmx:4pfAZ6LWCCYfX8mK7BXC70FX41iHQWEAt2lfisks9K1HiZUEBAK2nA>
    <xmx:4pfAZ0yL1_yVkl1WxxwO6or0eN-KP969kEqsSpKSP3uz90KH-glkYg>
    <xmx:45fAZ8i_W--UPEoRbVKtGJra0LUcQQTZU3mN6rt2fketMh_S8LzG-TTy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CCB22220076; Thu, 27 Feb 2025 11:50:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 17:50:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-Id: <74c253e6-1433-42b2-aabe-f6a85aeca099@app.fastmail.com>
In-Reply-To: <Z8CCrqzCfwzIpJ-3@smile.fi.intel.com>
References: <20250227141910.3819351-1-arnd@kernel.org>
 <Z8CCrqzCfwzIpJ-3@smile.fi.intel.com>
Subject: Re: [PATCH] asm-generic/io.h: rework split ioread64/iowrite64 helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2025, at 16:20, Andy Shevchenko wrote:
> On Thu, Feb 27, 2025 at 03:19:01PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There are two incompatible sets of definitions of these eight functions:
>> On 64-bit architectures setting CONFIG_HAS_IOPORT, they turn into
>> either pair of 32-bit PIO (inl/outl) accesses or a single 64-bit MMIO
>> (readq/writeq). On other 64-bit architectures, they are always split
>> into 32-bit accesses.
>> 
>> Depending on which header gets included in a driver, there are
>> additionally definitions for ioread64()/iowrite64() that are
>> expected to produce a 64-bit register MMIO access on all 64-bit
>> architectures.
>> 
>> To separate the conflicting definitions, make the version in
>> include/linux/io-64-nonatomic-*.h visible on all architectures
>> but pick the one from lib/iomap.c on architectures that set
>> CONFIG_GENERIC_IOMAP in place of the default fallback.
>
> Thanks, this is good to go in my opinion,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, I've put it into my asm-generic tree now.

    Arnd

