Return-Path: <linux-arch+bounces-9428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79CE9F6B53
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19450166BDE
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198381F75BF;
	Wed, 18 Dec 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZBQAOqwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqJZWQVI"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0711F7570;
	Wed, 18 Dec 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539801; cv=none; b=NOUzGtVO1g4n481HtLImjmiuwrhrfGipot+ttMPP7vJF8090Yikz3XEBuiTIr+6PaVMvzSI4jPQyAOwM9ldwgQMshqO5XjsUdI7AW6Ho8ybvNrneCVWFKHBPNvlQ5ekSWGd12yCB9gU4nHJ6C/N7K72A9hVOrzf8Fn0X4XINPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539801; c=relaxed/simple;
	bh=ECU7a7g+Yd5ux9s9u8W1DLTzWcr6VeDcVb9iJT8TVAY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FTb1dAu8FqdA9hldCAivGIvxvjMkXVVS5bGoXVSy4b+jFyomSgvdccPFlM/f/f99e6Jz1aF/CjGHgfJtKD3voDQXK/zm3Ti9mkvvLnWll0Bz2UpSDPSrISwbmaI8RKAzSwPeQj3dzX3p1uhhbm6W6+FECBgN2qQXaQICONbbtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZBQAOqwW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqJZWQVI; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 604441D40442;
	Wed, 18 Dec 2024 11:36:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 18 Dec 2024 11:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734539796;
	 x=1734546996; bh=nfvIer0zFabb2CSH4FYG5+b3Q6Xz7yeeSWmQEgNJheM=; b=
	ZBQAOqwWg2K05L5uK2bYuwdACrxkLsoc2PIgD0cQgiEZ7YYzhpCxLlGgVZW3DVx6
	RnHtDGYZacvkFOApE5i8PpEKXJJGSLMPZi1/7zYeCxngLwFiuC9mIs0r1MfRf1d7
	ljvkEfr+wDzKKBBc+aurNSqkpq8ZRtQDdq0HUTxnfOR5XzEt97aJE7dwOdFVZ/hQ
	G7NwA6xY0dgZ+/xg4YILY7/7WbCEybiUYNzp0z8/igRlYf8NVwKiJsF4kOTG+iqu
	JyrXPLjrjW44Sllz4+cRSo0lIJniQhepEl9dIW9Ha7JzvHs7+IVaGL96wRRmTQVz
	/xIay+l60aHEAef4QHVc4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734539796; x=
	1734546996; bh=nfvIer0zFabb2CSH4FYG5+b3Q6Xz7yeeSWmQEgNJheM=; b=K
	qJZWQVI8dLKjsLZD5P9G0J1qUuKhEEsdqq+hKLVZma8PcO0rePXvzMeh3Gx+vBOD
	4nrPDtjhBHF33PiCb2oLKtLN8BuhIxgjeQHXotN9690yJVqb/PXCqLhFT2gY2knP
	SHOoAC5zDrv2o7AYcQSL9H9AgGMdlkVSHmV5ZjLFwBX52jgdNDzgyVppGNX1wod9
	7ttZ7ZLraiTYPJxQ1MR/SR1x3wO/EGPAqJ0WFhEdeVI7D2KnDKbbNvBechT+mDuz
	cpPDpxvu0YbekmHfrUlPuFeXsXgCSELupq6HK7beqkIp0QrURFeBQbSN0zMiN8me
	L7v+l+rQqTjKGKfPI+cXQ==
X-ME-Sender: <xms:EPpiZ2PhewnaDdeTezsY7UHZ-8MZHheQgg2o6m05zEshehzpenow1A>
    <xme:EPpiZ08FeD-PHv9DfxkMbyU44Z2agIt5ndVb5bJvAT7p7tClm27qKJ2TH4eLJ14WB
    FQJfPGZ_sMFiMW81M0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeej
    vdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtg
    hpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphht
    thhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepvh
    hinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgtphhtthhopehlihhn
    uhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtohhphh
    gvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehprghlmhgvrhesuggr
    sggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrd
    gvughupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghu
X-ME-Proxy: <xmx:EPpiZ9SUEzmB8m4BWTnSvNTtSXRoY8pckW1eK5W5rKnWC0lS5naOKQ>
    <xmx:EPpiZ2tCYDXsXEJFpJcBW2DlzBqmukOXYouat3DqxhmhFciRrpQLMQ>
    <xmx:EPpiZ-ctkHakbRRswX0-1x3fLnbcgCLh6ogHHQVM_Yz1HDnHdPdaLw>
    <xmx:EPpiZ62xeygOoJZVhzcxu1Lkfiip8AzfGhxGF4meBhl3PD_5MD0-1Q>
    <xmx:FPpiZ3eUuVl_kIXn3EabUXk14dEdg5IU1747WEAAdir6NevQA5VhmJtW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B4AC2220075; Wed, 18 Dec 2024 11:36:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 17:35:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Conor Dooley" <conor@kernel.org>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Russell King" <linux@armlinux.org.uk>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Nam Cao" <namcao@linutronix.de>
Message-Id: <137c0594-e178-4c91-bc8b-5f99b3ddb2f0@app.fastmail.com>
In-Reply-To: 
 <20241218162031-ee920684-db10-4f17-b1cb-50373d7ea954@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-7-f7aed1bdb3b2@linutronix.de>
 <20241218-action-matchbook-571b597b7f55@spud>
 <20241218162031-ee920684-db10-4f17-b1cb-50373d7ea954@linutronix.de>
Subject: Re: [PATCH 07/17] riscv: vdso: Switch to generic storage implementation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024, at 16:46, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Dec 18, 2024 at 03:08:28PM +0000, Conor Dooley wrote:
>> On Mon, Dec 16, 2024 at 03:10:03PM +0100, Thomas Wei=C3=9Fschuh wrote:

>> Might be a clang thing, allmodconfig with clang doesn't build either.
>
> The proposed generic storage infrastructure currently expects that all
> its users also use HAVE_GENERIC_VDSO.
> I missed rv32 when checking this assumption.
>
> I can add a bunch of ifdefs into the storage code to handle this.
>
> Or we re-add the time vDSO functions which were removed in commit
> d4c08b9776b3 ("riscv: Use latest system call ABI").
> Today there are upstream ports of musl and glibc which can use them.
> (currently musl even tries to use __vdso_clock_gettime() as 64-bit only
> on rv32 due to a copy-and-paste error from its rv64 code)

Adding back __vdso_clock_gettime() wouldn't work on rv32 because there
is no fallback syscall for it, and it wouldn't really help since
there is no existing userspace that uses time32 structures.

> There is precedence in providing 64bit only vDSO functions, for example
> __vdso_clock_gettime64() in arm.
> I do have a small, so far untested, proof-of-concept patch for it.
> This would even be less code than the ifdefs.
>
> What do you think about it?

Yes, simply exposing the normal time64 syscalls through vdso
should be fine. I think this currently works on everything except
rv32 and sparc32, probably because neither of them have actual
users that are able to test.

       Arnd

