Return-Path: <linux-arch+bounces-9973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A73A25B06
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526463A3589
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F8205510;
	Mon,  3 Feb 2025 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1PQsJVkj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csGwc5TE"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCB25A631;
	Mon,  3 Feb 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589675; cv=none; b=oGoNbJDIT2E4Ox7WRXlunB+DTmpbw1Q9PQNPBNEvGtGlPiBxQLLTig+u03rxukZKvejajkJCDh+yrjIJX0UE7MNtYnBeKw11+uzfW/6JQud7XT4y/aiZjaZfbevYITPIgM2PXhpb1Y1IMUw4ZcV5UGAP/tn8jKvs8yns9uDYBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589675; c=relaxed/simple;
	bh=r0hZ5fq1duFmlzayXas7DpbWhp5AXfRSXGgTfn+Lfuo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KXfCa88BFEy2ZB75bgDLMomQSwhaoE3NLE23dbV5MeAOEj7w4kzTk2e5LAe7kuMlH0JFFCH2ADx3e0xLTQmS9sM2jbWQbG600rSyU+7hvBJL6ZJ/tMJmap0TVnz2GDgHtMjO7QYxUKOTzD67iHQGjM8LP3Yj/Jvy1Pw19b5gf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=1PQsJVkj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=csGwc5TE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B8911140189;
	Mon,  3 Feb 2025 08:34:32 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 08:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738589672;
	 x=1738676072; bh=ZrVc2JucmoFodGbOW2lAg7Z/CHLc6zW+Iwg+fDL2gFA=; b=
	1PQsJVkjumWVb/PqSgWXzB+tpx8JVlmtuwoAwM1eGqP8K0l+ejAsPkicdv5pxDMd
	ajK7vHcs6YwjgOB13kZkAd3Ul41wgzwpLXLfayz2PJfGZjX43Ml464Ez+Ti70koc
	RNCr+ybboKPjDp5Up4dtN9Kv0w842vTT5tcFXhMKz93OCTB01+nNSsqrctLKZg7z
	SStYXi7FOWiNFnL8MeymdbCOuHJ5jZU/lMInrImYE3UNFVPGQ+9vvUrM+3/dJ8F0
	zbm60qTNpkL2fSL2NfEbWkzmTt0SPlprlTABSQyPrUbiAT+Bnqb/Ruu416hFpXoP
	uTKxxKgHh2PmoOeKzeT/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738589672; x=
	1738676072; bh=ZrVc2JucmoFodGbOW2lAg7Z/CHLc6zW+Iwg+fDL2gFA=; b=c
	sGwc5TE/dXxNqekc5A/6ca7vaWw0Y4DEYjBwXoy7gb4KQcD2lBEayCBw8XI0jsN/
	V8GR17i9GWQ68RrW8XNkmJDcfslMNVv9wtqhBmf1SyOc7UDsbBn3JSj7DsJY18v2
	ILHSxiLVsBMNd+8Y6xNJV9Iz8FvpR8n9d1u12geE2D3lBmAYuVtMW4m3KEAnI114
	T27D7TR3AEoVMGWXjOaPwa0MRgHNvq/l5qapRdQAVd46hDfPZ9/SSGfIZslYPpx+
	+jnWm8eO0gzPuzCVajOzcTrdIpg/D41sIXk1EfPt1yUbUuImnbgHqpjA1J2fOlZJ
	YgVyG5ZQrF6Nmo/j6Jytg==
X-ME-Sender: <xms:6MWgZypzsjEdsyk6SDqvn7h3PNNIrF4sO8bOT7usDu4ZgiHnJsrDDQ>
    <xme:6MWgZwrhIFumvE-IgQBRrWqudWk1ForeTm0RmHUWaFkY0pCWqJ79A8zYhGJlYUZsv
    GvR9yknduAyKF-eas8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehprghlmhgvrhesrhhivhhoshhinhgtrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6MWgZ3Mlx2-AWGlxR7I_dj6OzPipcBGjKr5wjJCXQMxHq6F-wMsNyA>
    <xmx:6MWgZx6wVwgNV1921zumBE61wfUDhXrx4F5GgsPlAnmH7Y5bB0HVug>
    <xmx:6MWgZx61fPGgcc3tTWX4xJiXuYIBeGa0gwIb48jCow2tUN_Bovu1OQ>
    <xmx:6MWgZxiuYFmtRPnX5mE9bo5wuPSf52YJTtBkV4GlrI_2EtMQVl0v3w>
    <xmx:6MWgZ8bBDBAXn_OG9c1SXBNZM6Ot8W1ScJIuZBJjVPjmAI7OEVDT41Bi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EBF182220072; Mon,  3 Feb 2025 08:34:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 14:34:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Kees Cook" <kees@kernel.org>, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Richard Cochran" <richardcochran@gmail.com>
Message-Id: <5f40c879-1430-45e8-aca2-d94706b8671c@app.fastmail.com>
In-Reply-To: <Z6DDQlhmzvNj-B7o@smile.fi.intel.com>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
 <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
 <Z6Cxan9WE38_x41e@smile.fi.intel.com>
 <96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com>
 <Z6DDQlhmzvNj-B7o@smile.fi.intel.com>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 3, 2025, at 14:23, Andy Shevchenko wrote:
> On Mon, Feb 03, 2025 at 02:08:35PM +0100, Arnd Bergmann wrote:
>
>> > I like the lib/* and include/* cleanup but PTP probably should stay as is.
>> > OTOH WWAN case most likely had been tested on 64-bit platforms only and
>> > proves that readq()/writeq() works there, so it's okay to unify.
>> 
>> Ok, I'll try to split it up into sensible patches then. For ptp
>> (both ixp46x and pch), these are the options I see:

Update: While splitting out the wwan patch, I see that this would
revert 7d5a7dd5a358 ("net: wwan: t7xx: Split 64bit accesses to fix
alignment issues"), so that driver also needs to keep using the
split accessors, at least for some of the registers. From what
I can tell, the problem here is that REG_CLDMA_UL_START_ADDRL_0
is not a multiple of 8, and arm64 CPUs require MMIO registers
to be naturally aligned.

If that is the cause of the problem, this means that on x86-64
the unaligned readq() is still used but happens to work.
Once I change linux/io-64-nonatomic-lo-hi.h, it will split
the access on x86-64 and other using GENERIC_IOMAP as well.

The accesses to ATR_PCIE_WIN0_T0_TRSL_ADDR and
ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR can probably use ioread64()
because they are on aligned addresses, but it should be safe
to just leave this driver alone and keep all the split
accesses.

>> - leave it unchanged since nobody cares any more
>> - add some comments about being racy and possibly broken on 64-bit
>
> Any combination of these two I would prefer.
>
>> - revert your pch patch d09adf61002f/8664d49a815e3 to make it have 32-
>>   bit accesses again and fix the theoretical 64-bit issue but not the
>>   race
>
> Definitely not this. I assume that _hi_lo and _lo_hi semantics of IO
> APIs implies non-atomicity access and hence always splits the IO in
> 64-bit case. These helpers make code much less verbose and actually
> (due to naming) clearer about the sequence of the reads or writes.
> I prefer to have them stay (in the drivers).

Right, after my change to the headers, it will at least behave
consistently according to the documentation, so there is no
additional problem if someone reuses that driver on (problem
nonexistent) 64-bit hardware.

       Arnd

