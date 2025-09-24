Return-Path: <linux-arch+bounces-13756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEBB9AC0C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA81162406
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A630DECF;
	Wed, 24 Sep 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="v/3IuU5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SslvYwfN"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BC22127E;
	Wed, 24 Sep 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728596; cv=none; b=u6+cMkYilBLhbQPwdxGYgVTn2SS44ga6Oa0VAzQqCcQYTIRrcNbSX97zL09vc9oG4Y5uQMVqnYF8iXcgAyMXXa6/f08XlmuZxXicYeodb/vIJm9p8qsD1XRdOc3ap8YBKwoPCmIAJ70GYFMzj/qypnkyyr8ei9Iutg1nyKX3YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728596; c=relaxed/simple;
	bh=euNi1ADwwd+uFgMFLWxcxJHfK9fVB5B7PwkOfhR7C7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N1e+eD5Lqogv0M1Xkc4kU6XNDomo9A47PSs3QcFr9enSmQKk4q0BlqsX6vCsuwr56P0aFM+Gknv36N24SvlzIz0ZcCCMffWZMC8/aS69bm97FcqxMV9YzazNbsmNqCGDs3YLa5Ve4J4DaTjrwYKiu0giLFVaWwhol0m8Nmxd8PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=v/3IuU5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SslvYwfN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D4E031D000E3;
	Wed, 24 Sep 2025 11:43:12 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 11:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758728592;
	 x=1758814992; bh=JsHZEsMXkjnsb1bbQltuF4dLLYqSINr5KSvPj/nUVX4=; b=
	v/3IuU5QwCLyonLjAMbCC4QovxzEOPB/yLo4a504Cc7rZiVCmgnoLtMS/B7THN+q
	nitzArqjm+TcSzeed63HFvN7mMe7bixA2uHam70OqXrSyyIxP/pnd6Hu0mIg8mNx
	lOpo5urLE4FRGXCt7D9zXw2Ye8K1AmllhGAiz/IspucpmhiuZdjmsuRO5bKrTPnV
	YFQx/g968eIxxXpuhT9NuYJPuFj/ndxMQSTWtGgTXUcIvOFcH6A0ehaeF27kxwPF
	fiBSy33EFiH+G2iiMI9x3LoGN+4ny+Y+7OZ2+b0Xv17uP1NPUZzGfz112BO+hfuJ
	sikWfF8nN54yK/myMjtSsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758728592; x=
	1758814992; bh=JsHZEsMXkjnsb1bbQltuF4dLLYqSINr5KSvPj/nUVX4=; b=S
	slvYwfN7eFNuRHK9fKToAv6lO9lk3lrrJ4XKvcXH6T5jhDpQ6vKAr5L2Tos7AUF3
	xynuwCDbevy4BwGE4cfWTN23q9Zcm2Gz1Kl81Eryzv9IBK9kOn7fHyjfUHpiRMzG
	ajGMk3Q63hCBfyq6hea+8HKx8J6ZfFtJEp3RNLYdUPNFXTMwlmTNO58k6EZ6mOQj
	9tUjBLrbIAgGY/SRlmIl9N4JM6sGTU5F6DGQ+xtBeC4HUcdTeDEXuPcBl+zoz/VC
	xrnl/xL9R9xou1xjtMmgyzZ/HTvZluXAlBBhDYVR8BEuR9Wn43uSDNttYLZIiqHz
	PWa26Ze3uOOrUj+fG+1+Q==
X-ME-Sender: <xms:jRHUaDSR82YrRNoH8mfw86ggowF7nOXpO68HWpplZMfVqV-rYdgDxg>
    <xme:jRHUaPleqHlBzdk9Z42MTGWmCpW5V3fSItlFjsJG4xFA_636Pwku-2sul0mCNPrEq
    vru_YRado0UbIPC3cnCeveNn1PqOgk4cLZSwiAhM0PuC6UGylq76j8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtg
    hpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnthgrrdhg
    uhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdrshhimh
    gvkhesrghmugdrtghomhdprhgtphhtthhopehrrgguhhgvhidrshhhhigrmhdrphgrnhgu
    vgihsegrmhgurdgtohhmpdhrtghpthhtohepshhhuhgshhhrrghjhihothhirdgurghtth
    grsegrmhgurdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhgohhuugesrghmugdr
    tghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomh
    dprhgtphhtthhopegsihhllhihpghtshgrihesrghsphgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:jRHUaOQr6QBuxylQkv86LWgGP-Glrvkkc4vM61Y4l-jmA7kPhBDDpg>
    <xmx:jRHUaGbH26Lp3ayWnxkqY8HNzXHSDxBd2bFDAwhL4S6uqeDFl87Clg>
    <xmx:jRHUaLU422y6Fkoc8NbG_jP61ZQV0HQ_XfWsQ7jPrnAD035yHAz3AQ>
    <xmx:jRHUaLW2qzpK7JHz1wP-AO59nsq_9Kojcf2J8r4CW0yYN08gryD_Og>
    <xmx:kBHUaL9PeYq5hk3ah1w9Ob7tORZa9N-cmd9Tch5ZzJtGiYCqe3fGgZdi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0DF2700069; Wed, 24 Sep 2025 11:43:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0nVfrWCY5as
Date: Wed, 24 Sep 2025 17:42:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>,
 "git (AMD-Xilinx)" <git@amd.com>, "Michal Simek" <michal.simek@amd.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Rob Herring" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
 "quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jarkko Nikula" <jarkko.nikula@linux.intel.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "Goud, Srinivas" <srinivas.goud@amd.com>,
 "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
 "manion05gk@gmail.com" <manion05gk@gmail.com>
Message-Id: <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
In-Reply-To: 
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo()
 and i3c_writel_fifo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 17:23, Guntupalli, Manikanta wrote:
>> Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo() and i3c_writel_fifo()
>> > }
>> >
>> > With this approach, both little-endian and big-endian cases works as expected.
>>
>> This version should fix the cases where you have a big-endian kernel with either
>> I3C_FIFO_BIG_ENDIAN or I3C_FIFO_LITTLE_ENDIAN, as neither combination
>> does any byte swaps.
>>
>> However I'm fairly sure it's still broken for little-endian kernels when a driver asks for
>> a I3C_FIFO_BIG_ENDIAN conversion, same as v7.
> We tested using the I3C_FIFO_BIG_ENDIAN flag from the driver on 
> little-endian kernels, and it works as expected.

Can you explain how that works? What I see is that your
readsl_be()/writesl_be() functions do a byteswap on
every four bytes, so the bytestream that gets copied
to/from the FIFO gets garbled, in particular the
final (unaligned) bytes of the kernel buffer end up
in the higher bytes of the FIFO register rather than
the first bytes as they do on a big-endian kernel.

Are both the big-endian and little-endian kernels in
your tests on microblaze, using the upstream version
of asm/io.h? Is there a hardware byteswap between the
CPU local bus and the i3c controller? If there is
one, is it set the same way for both kernels?

    Arnd

