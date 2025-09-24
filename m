Return-Path: <linux-arch+bounces-13749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CADB994B4
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00038320D09
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7752DA769;
	Wed, 24 Sep 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HSQoFJI2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvMOkp9S"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611729E10B;
	Wed, 24 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708064; cv=none; b=rUl2hNOMib9Q7DXeV+HdSPp6qhSUddy+IIClC2rSaxEnwJ8LcD3VkHmfbjpsPEPgvoGaF0FqotLc6D/KTNgVSye+qi3a68NXugoak9eWH7lHIhn3ykMKl45IfFnWfeAT0aDlOTB0yl3h7kio90RhXvsboZ7znQl6ipaVb6/VwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708064; c=relaxed/simple;
	bh=glTtK9KagyyQpjrckNMZz58byKjaeY6veMrpcGEh9sk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=grqLzweRWhxxZMHG4BVrWKKNeb5YCdeOmHYlLrgWh2JrMlFwbKogca/MlHJNWmmqTKv73vXl9+suUBtd8zKmugpLu0QX7DWkQg+FCeeVKyC5Vs7/TFiNQmuFy80RVgl0djNKEqyV/rGLRa7mkOWdVzdtLGSPcqPp5qbXFDMM7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HSQoFJI2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvMOkp9S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C5B2A1D00105;
	Wed, 24 Sep 2025 06:01:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 06:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758708060;
	 x=1758794460; bh=T3ZHdKUDIfZ1GBfyH2K60XUuWXn/RU/s4ddNa0Ce6zo=; b=
	HSQoFJI2Wf9Jv4yGb8HeXT4W+ySS3xdhmuaFMrjIb+JA65YkGeDrcolwLUudToD6
	RTZaGqQGgvTogqOEBKbvM3TGh81s4HmqY8QigmPXVEiQ5miYkor7hKdS2zE5vQH8
	iR+V/W8LLZMwo96kBk2bJj/iO3oUtC6Z50L0HNqe1DLCi58fADwT3OMh6LFnTlk5
	yAVoCxuroSaH3VQkYad4Fm+CcM/LKUcOmCcs/ac3X+JljCgN+whdwLvs+HWNw06W
	VC5UD7oK9ho8r0AFCQ/kplKlwn+WSmcN6WheVYOIsfldI+r9nypTKEQPw32tvM0K
	sfn0+mNb0xpJ6nf0droCvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758708060; x=
	1758794460; bh=T3ZHdKUDIfZ1GBfyH2K60XUuWXn/RU/s4ddNa0Ce6zo=; b=g
	vMOkp9SGl4akq/TNbiNEYyT9BegGPH0YrYt74D2+LzQ8CECD/CUNz0wnwJzoIPeU
	J2OKPUTKF2xglfg/P2sHwv786Sc3zdLl3D6weiDfQr8/7GH0AMO2/BUlxDXsAiAS
	PwEfJ+HuI4/xn4UWXRsf3EAvs4W8bCUv0cwww5OIPa15aBHkff7PViQnObXPICtc
	LPSyeVnRXu9bEIRkoV88kxWEO+s6O4QmPnqC67IlLlQblRjdS+H0mzjL4MZ+l2KI
	NfT+5toyrk8a2u8cVEpSJWUNuEa2Hc+Vhx++CQCCgRDJzRD30aAddEAyUUj7UAAa
	gll4cAXjnlDEr0Jd2M/uw==
X-ME-Sender: <xms:W8HTaFkBV9OlYdbCtxKoftid08RapANjep28r_KXB7ihKe5LlCl19Q>
    <xme:W8HTaLpc3G5aJxOxabOiTWAOLV-hhTaMNTnlQlXZN62dIYIryDBHAPLH_ucfh45eS
    yQkvczLq7-eAlHphI3ilJt8vyHG8XWKbR8EYZJzP65A4taYdyZ74A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeefudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:W8HTaHH39wT-R18D4w1s5F6fVPSYGft8xfVngU2bEP1FA9vt06t0tg>
    <xmx:W8HTaG8gBZQVrWv496UFGg_NJf1IDbAZ4Ay3jjCUIeMvZh5jw6g8aw>
    <xmx:W8HTaIo3wCNsatHw913KTje_ySXgAPULh1L6rkH3FybXpZQjaE8y8g>
    <xmx:W8HTaGaVe3n66kPfd-A4rM0zVh3unyJlmN1yrqkxXw98IT_NzA-bwg>
    <xmx:XMHTaCCf7fxjnC9kMCxXMCH6Q-dCjQlYrMtwZmKAoQoPzkvS6h1Gka7n>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B8554700065; Wed, 24 Sep 2025 06:00:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0nVfrWCY5as
Date: Wed, 24 Sep 2025 12:00:06 +0200
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
Message-Id: <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
In-Reply-To: 
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo()
 and i3c_writel_fifo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 11:00, Guntupalli, Manikanta wrote:
>> >     if (nbytes & 3) {
>> >             u32 tmp = 0;
>> >
>> >             memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
>> > -           writel(tmp, addr);
>> > +
>> > +           if (endian)
>> > +                   writel_be(tmp, addr);
>> > +           else
>> > +                   writel(tmp, addr);
>>
>> This bit however seems to fix a bug, but does so in a confusing way. The way the
>> FIFO registers usually deal with excess bytes is to put them into the first bytes of the
>> FIFO register, so this should just be a
>>
>>        writesl(addr, &tmp, 1);
>>
>> to write one set of four bytes into the FIFO without endian-swapping.
>>
>> Could it be that you are just trying to use a normal i3c adapter with little-endian
>> registers on a normal big-endian machine but ran into this bug?
> The intention here is to enforce big-endian ordering for the trailing 
> bytes as well. By using __cpu_to_be32() for full words and writel_be() 
> for the leftover word, the FIFO is always accessed in big-endian 
> format, regardless of the CPU's native endianness. This ensures 
> consistent and correct data ordering from the device's perspective.

No, this makes no sense: The 'else' portion is incorrect in the
function, and prevents it from working on all big-endian CPUs because
'writel()' only works for little-endian 32-bit registers. If you just
fix the bug as I described above, this will work correctly on any
driver calling the current function. At that point, your hack becomes
a nop for big-endian systems, while calling the function with
'endian = true' on little-endian kernels is still wrong.

Please start by fixing the existing bug and test that again.

I know that endianess with FIFO registers is hard to understand,
and everyone has to spend the time once to actually wrap their
head around this. Even if you don't believe me, please try the
bugfix below (without your added argument) and think about how
FIFO registers that transfer byte streams are different of
fixed-endian 32-bit registers. Note that your driver uses
little-endian readl() for normal registers, and this is portable
to both LE and BE kernels.

See also the explanation in 41739ee355ab ("asm-generic: io:
don't perform swab during {in,out} string functions").

     Arnd

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5..0f8a25cb71e7 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
 		u32 tmp = 0;
 
 		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
-		writel(tmp, addr);
+		writesl(addr, &buf, 1);
 	}
 }
 
@@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
 	if (nbytes & 3) {
 		u32 tmp;
 
-		tmp = readl(addr);
+		readsl(addr, &tmp, 1);
 		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
 	}
 }

