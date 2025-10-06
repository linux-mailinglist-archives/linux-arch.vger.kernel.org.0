Return-Path: <linux-arch+bounces-13927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85435BBDD53
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33C18980EB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B823267B89;
	Mon,  6 Oct 2025 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L0W0W0zr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csGpiTI/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE25170A11;
	Mon,  6 Oct 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748972; cv=none; b=aaIVmFAlqOtvxngd9SIfQ8yrRXhFxkH4YZXApgQXR8XoJPwAViaJcQ4G8Bgzthit0H3RyfX0QpjCId58s3VwUTjec90SLYgB+Fh3CiHRP+fRqWbPvV5H0NUqmY2C4pNunBmuPQ0eItk/NsMWotS3wOjD4r0K+VsMtoDsILFE0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748972; c=relaxed/simple;
	bh=iiNffHnTx8Pb202eharTBuQvX3jDw0eC9DrGa8U6EQA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=loDOXuJk7WhoYfmKbGp4zcmt1jFP8GqCHOIr8bk59w6gcfhpBUWwIW434DQV4cesfJNx/PGTtSQa6wY/nBzaxKFp8QkD3CO/4MioHRtBoLHnI8KeQ5Zs0tTeOAb7hQWq1yMm//ZqyTbkELIP6mEk8i1ouwHzXsto2fRDsDj5la8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L0W0W0zr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=csGpiTI/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 93285EC00DE;
	Mon,  6 Oct 2025 07:09:28 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Mon, 06 Oct 2025 07:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759748968;
	 x=1759835368; bh=oQr2Z+5xhGdK3c4D5pXVny9a8KKlRowOFGyX0jHZkFk=; b=
	L0W0W0zrDIxkRpMNjsP0GpnYr49Zm7NbXvAr3HV4YnE/L1NQuSKvD/6o9bS6/0G+
	OTxSxNPQKiCQTS0jilYj/ug0+Tzejh/fEM+viQKDVE9Bf0JDFYWZ0AdwdrUZpCjr
	tYyY7dBZw5OReKhGRdPyB1/BcGAVwUfVa9dV8B+qoha7LC83dMphyoOkiJXSQm2h
	SOGm/uoQpP93QhcMi0K3IVbtrz24TuhqbPY4X2WGzvL+z+Frp2geDqmavLI1CHbU
	6vvkd7H3RZA/kURLGxpbIqyczcFH5eGVcvtDdk2qTYUkhDaMDpCxDULGrKxBCu+b
	dv3TgkErgUaay43QWw/jLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759748968; x=
	1759835368; bh=oQr2Z+5xhGdK3c4D5pXVny9a8KKlRowOFGyX0jHZkFk=; b=c
	sGpiTI/QyhntH9oqno6KaikRMNh64/fbq2nUe0r3iiQPpiht8ZstyHst0ctTGzOm
	Dbn/TwJcHL2tI8+FxO+dyU0M2Lh7nrJ6yC5L4jqdzEmOnfKTyBUkXO7OsBWz6Qfk
	ovubapVYBxxVcnxx80ZfbEhsFf76SwefyULb4m+BPY0c1DqqCIfOZ/NaiyAevInh
	MBuboA/2BvU1HhVUyunCLaIgSNEiMm4oG1ofbASLYCynQFpY/0ENmYXeK3J2E9/9
	KldBnmz+uREeipvmhuEOvgpfDxtpF69NTz7wlhC5EnrpoLJdGTGNrcdAjTRFLRst
	ykPmOvIpXhKqZA/FCtf1w==
X-ME-Sender: <xms:Z6PjaBSeap3uRzX5Hfxsbtc9YjxTnLko18CYpLvxnYeZhDkr277K9Q>
    <xme:Z6PjaCv90eZGDOM0u3pJNRH0JnN_kbmpEywY-cKHhVHUOSvhmY6cr0_UDXVPiTuen
    NZzdg7J7AeycJ-_hl7OrkJjde1b4OUDElK3OOfJwHjM0VqX7uDOog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Z6PjaBX0cBgZ2CgBOyBd1TwdSkWiBoruyUO9s2Oxz5LB3GQA-d106Q>
    <xmx:Z6PjaLStS_r5Errx1Qi3eBp4-QOpj97zD9y-2P-QDtT8L6KkYbppdQ>
    <xmx:Z6PjaMvumckM1omos56IlPrzbowiquwXXaL602ABw6FmKpE_MdOIFw>
    <xmx:Z6PjaMYsOmBqFct7xibtZ4Ln_DgNvjDzJwdIXQDrI9z1dGV5UKFXfQ>
    <xmx:aKPjaN4wUe5yun1MsuHEzALlD7APlgm3cCx-9X6w9gyiOdeIWKW1goi9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98D76700065; Mon,  6 Oct 2025 07:09:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Mon, 06 Oct 2025 13:09:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Finn Thain" <fthain@linux-m68k.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <92c5af4d-c6e9-43bf-ba2c-ce6627b8d962@app.fastmail.com>
In-Reply-To: <20251006102228.GT3245006@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
 <257a045a-f39d-8565-608f-f01f7914be21@linux-m68k.org>
 <d9e3f41e-d152-4382-bb99-7b134ff9f26f@app.fastmail.com>
 <20251006102228.GT3245006@noisy.programming.kicks-ass.net>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 12:22, Peter Zijlstra wrote:
> On Mon, Oct 06, 2025 at 12:07:24PM +0200, Arnd Bergmann wrote:
>
>> It looks like Mark Rutland fixed the try_cmpxchg() function this
>> way in commit ec570320b09f ("locking/atomic: Correct (cmp)xchg()
>> instrumentation"), but for some reason we still have the wrong
>> annotation on the atomic_try_cmpxchg() helpers.
>
>> Mark, I've tried to modify your script to produce that output,
>> the output looks correct to me, but it makes the script more
>> complex than I liked and I'm not sure that matching on
>> "${type}"="p" is the best way to check for this.
>
> I don't see anything wrong with this. The result looks good.

Thanks for having a look, I've sent it out as a proper patch now.

      Arnd

